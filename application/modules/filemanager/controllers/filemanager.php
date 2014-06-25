<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Filemanager extends MX_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('folder_model', 'folder');
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
        } else {
            $path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $slug;
        }
        if (!is_dir($path)) {
            if (mkdir($path)) {
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
        echo $this->folder->get($folder_id)->folder_name;
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
