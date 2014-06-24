<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Filemanager extends MX_Controller {

    public function index() {
        $this->load->view('index');
    }

}
