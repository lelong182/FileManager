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
        $this->render_list_folder($this->folder->as_array()->get_all(), 0, $tree);
        $data['tree'] = '<ul>' . $tree . '</ul>';
        $this->load->view('includes/template', $data);
    }

    function create_folder() {
        $message = "";
        $folder_name = $this->input->post('folder_name');
        $parent_id = $this->input->post('parent_id');
        $slug = changeTitle($folder_name);
        $path = $_SERVER["DOCUMENT_ROOT"] . "/filemanager/files/" . $slug;
        if (!is_dir($path)) {
            if (mkdir($path)) {
                $this->folder->insert(array(
                    'folder_name' => $folder_name,
                    'slug' => $slug,
                    'parent_id' => $parent_id,
                    'created_date' => date("Y-m-d H:i:s")
                ));
                $message = 'Create folder successfully.';
            } else {
                $message = 'Create folder failed.';
            }
        } else {
            $message = 'Directory is exist.';
        }
        echo $message;
    }
    
    function render_tree() {
        $this->render_list_folder($this->folder->as_array()->get_all(), 0, $tree);
        echo '<ul>' . $tree . '</ul>';
    }

    function render_list_folder($list, $parent_id, &$str) {
        foreach ($list as $key => $val) {
            if ($val['parent_id'] == $parent_id) {
                unset($list[$key]);
                $str .= '<li><span><i class="glyphicon glyphicon-folder-open"></i> <a href="#" data-id="' . $val['folder_id'] . '">' . $val['folder_name'] . '</a></span>';
                $str .= '<ul>';
                $this->render_list_folder($list, $val['folder_id'], $str);
                $str .= '</ul>';
                $str .= '</li>';
            } else {
                $str = preg_replace('~<ul>\s*<\/ul>~i', '', $str);
            }
        }
    }

    function get_list_file() {
        $folder_id = $this->input->post('id');
        echo $this->folder->get($folder_id)->folder_name;
    }

    function drive() {
        $data['main_content'] = 'drive';
        $data['current_nav'] = 'drive';
        $this->load->view('includes/template', $data);
    }

}
