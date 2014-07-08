<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Filemanager extends MX_Controller {

    var $url_img;
    var $url_img_thumbs;

    function __construct() {
        parent::__construct();
        $this->load->model('folder_model', 'folder');
        $this->load->model('file_model', 'file');
    }

    function upload() {
        $folder_id = $this->input->post('folder_id');
        $this->render_path_folder($folder_id, $str);
        $path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $str;
        $path_thumb = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/thumbs/" . $str;

        $this->load->library('upload');
        $config_upload['upload_path'] = $path;
        $config_upload['allowed_types'] = 'doc|pdf|xlsx|ppt|jpg|jpeg|gif|png|xls|docx|pptx|txt';
        $config_upload['max_size'] = '0';
        $config_upload['overwrite'] = FALSE;
        $this->upload->initialize($config_upload);

        $config_image_lib['image_library'] = 'gd2';
        $config_image_lib['create_thumb'] = TRUE;
        $config_image_lib['maintain_ratio'] = TRUE;
        $config_image_lib['width'] = 100;
        $config_image_lib['height'] = 100;
        $this->load->library('image_lib', $config_image_lib);

        if ($this->upload->do_multi_upload("userfile")) {
            $data = $this->upload->get_multi_upload_data();
            foreach ($data as $value) {
                if ($value['is_image']) {
                    $size = $value['image_width'] . 'x' . $value['image_height'];
                } else {
                    $size = "";
                }
                $this->file->insert(array(
                    'folder_id' => $folder_id,
                    'file_name' => $value['file_name'],
                    'raw_name' => $value['raw_name'],
                    'file_type' => $value['file_type'],
                    'file_ext' => $value['file_ext'],
                    'size' => $size,
                    'capacity' => $value['file_size'],
                    'date_upload' => date('Y-m-d H:i:s'),
                    'date_update' => date('Y-m-d H:i:s')
                ));

                $config_image_lib['source_image'] = $path . '/' . $value['file_name'];
                $config_image_lib['new_image'] = $path_thumb . '/' . $value['file_name'];
                $this->image_lib->initialize($config_image_lib);
                if (!$this->image_lib->resize()) {
                    echo $this->image_lib->display_errors();
                    exit;
                }
            }
            redirect('filemanager');
        } else {
            $this->index();
        }
    }

    function imageResize($file_name) {
        $config['source_image'] = $this->url_img . $file_name;
        $config['new_image'] = $this->url_img_thumbs . $file_name;
        $this->image_lib->initialize($config);
        $this->image_lib->resize();
    }

    function index() {
        $data['main_content'] = 'index';
        $data['current_nav'] = 'local';
        $this->db->where('is_trash', 0);
        $this->render_list_folder($this->folder->as_array()->get_all(), 0, $tree);
        $tree = preg_replace('~<ul>\s*<\/ul>~i', '', $tree);
        $data['tree'] = '<ul>' . $tree . '</ul>';
        $this->load->view('includes/template', $data);
    }

    function create_folder() {
        $message = array();
        $folder_name = $this->input->post('folder_name');
        $parent_id = $this->input->post('parent_id');
        $slug = changeTitle($folder_name);
        if ($parent_id != 0) {
            $this->render_path_folder($parent_id, $str);
            $path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $str . $slug;
            $path_thumb = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/thumbs/" . $str . $slug;
        } else {
            $path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $slug;
            $path_thumb = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/thumbs/" . $slug;
        }
        if (!is_dir($path)) {
            if (mkdir($path)) {
                mkdir($path_thumb);
                $this->folder->insert(array(
                    'folder_name' => $folder_name,
                    'slug' => $slug,
                    'parent_id' => $parent_id,
                    'created_date' => date("Y-m-d H:i:s")
                ));
                $message['status'] = 'OK';
                $message['message'] = 'Create folder successfully.';
            } else {
                $message['status'] = 'ERROR';
                $message['message'] = 'Create folder failed.';
            }
        } else {
            $message['status'] = 'ERROR';
            $message['message'] = 'Folder is exist.';
        }
        echo json_encode($message);
    }

    function rename_folder() {
        $message = array();
        $folder_name = $this->input->post('folder_name');
        $folder_id = $this->input->post('folder_id');
        $new_slug = changeTitle($folder_name);
        $folder = $this->folder->get($folder_id);
        $old_slug = $folder->slug;
        $parent_id = $folder->parent_id;
        if ($parent_id != 0) {
            $this->render_path_folder($parent_id, $str);
            $old_path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $str . $old_slug;
            $new_path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $str . $new_slug;
        } else {
            $old_path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $old_slug;
            $new_path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $new_slug;
        }
        if (!is_dir($new_path)) {
            if (rename($old_path, $new_path)) {
                $this->folder->update($folder_id, array(
                    'folder_name' => $folder_name,
                    'slug' => $new_slug,
                    'created_date' => date("Y-m-d H:i:s")
                ));
                $message['status'] = 'OK';
                $message['message'] = 'Rename folder successfully.';
            } else {
                $message['status'] = 'ERROR';
                $message['message'] = 'Rename folder failed.';
            }
        } else {
            $message['status'] = 'ERROR';
            $message['message'] = 'Folder name is already.';
        }
        echo json_encode($message);
    }

    function render_tree() {
        $this->db->where('is_trash', 0);
        $this->render_list_folder($this->folder->as_array()->get_all(), 0, $tree);
        $tree = preg_replace('~<ul>\s*<\/ul>~i', '', $tree);
        echo '<ul>' . $tree . '</ul>';
    }

    function render_list_folder($list, $parent_id, &$str) {
        foreach ($list as $key => $val) {
            if ($val['parent_id'] == $parent_id) {
                unset($list[$key]);
                $str .= '<li><span><i class="glyphicon glyphicon-folder-open"></i> <a data-placement="right" title="' . $val['slug'] . '" href="#" data-id="' . $val['folder_id'] . '">' . $val['folder_name'] . '</a></span>';
                $str .= '<ul>';
                $this->render_list_folder($list, $val['folder_id'], $str);
                $str .= '</ul>';
                $str .= '</li>';
            }
        }
    }

    function render_path_folder($folder_id, &$str) {
        $folder = $this->folder->get($folder_id);
        $slug = $folder->slug;
        $parent_id = $folder->parent_id;
        $str = $slug . '/' . $str;
        if ($parent_id != 0) {
            $this->render_path_folder($parent_id, $str);
        }
    }

    function get_path_folder($folder_id) {
        $this->render_path_folder($folder_id, $str);
        $arr = array_filter(explode('/', $str));
        array_pop($arr);
        echo 'root/' . implode('/', $arr);
    }

    function get_list_file() {
        $folder_id = $this->input->post('id');
        $list_file = $this->file->get_many_by('folder_id', $folder_id);
        if (isset($list_file[0])) {
            $tmpl = array('table_open' => '<table class="table table-striped table-hover">');
            $this->table->set_template($tmpl);
            $this->table->set_heading('File name', 'File type', 'Size', 'Date updated');
            foreach ($list_file as $value) {
                $this->table->add_row($value->file_name, $value->file_type, $value->capacity . 'KB', date('H:i:s d-m-Y', strtotime($value->date_update)));
            }
            $this->table->set_footer('File name', 'File type', 'Size', 'Date updated');
            echo $this->table->generate();
        } else {
            echo 'The folder is empty.';
        }
    }

    function trash($folder_id) {
        $update_id = $this->folder->update($folder_id, array(
            'is_trash' => 1
        ));
        if ($update_id) {
            echo 'Folder has been moved to the trash';
        }
    }

    function recursive_remove_directory($directory, &$status) {
        foreach (glob("{$directory}/*") as $file) {
            if (is_dir($file)) {
                $this->recursive_remove_directory($file, $status);
            } else {
                unlink($file);
            }
        }
        if (rmdir($directory)) {
            $status = true;
        } else {
            $status = false;
            return;
        }
    }

    function get_list_children_id($folder_id, &$tmp) {
        $arr = $this->folder->as_array()->get_many_by('parent_id', $folder_id);
        $tmp = array_merge($arr, $tmp);
        foreach ($arr as $value) {
            $this->get_list_children_id($value['folder_id'], $tmp);
        }
    }

    function delete() {
        $folder_id = $this->input->post('id');
        $folder = $this->folder->get($folder_id);
        $slug = $folder->slug;
        $parent_id = $folder->parent_id;
        if ($parent_id != 0) {
            $this->render_path_folder($parent_id, $str);
            $path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $str . $slug;
        } else {
            $path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $slug;
        }
        $this->recursive_remove_directory($path, $status);
        if ($status) {
            $this->folder->delete($folder_id);
            $tmp = array();
            $this->get_list_children_id($folder_id, $tmp);
            foreach ($tmp as $value) {
                $this->folder->delete($value['folder_id']);
            }
            echo 'Delete folder successfully.';
        } else {
            echo 'Delete folder failed.';
        }
    }

    function drive() {
        $data['main_content'] = 'drive';
        $data['current_nav'] = 'drive';
        $this->load->view('includes/template', $data);
    }

}
