<div class="col-fixed">
    <div class="tree" data-token-name="<?= $this->security->get_csrf_token_name(); ?>" data-token-value="<?= $this->security->get_csrf_hash(); ?>">
        <?= $tree ?>
    </div>
</div>
<div class="row-fluid">
    <div class="taskbar">
        <button id="create-folder" class="btn btn-warning" data-toggle="modal" data-target="#create-folder-modal">Create folder</button>

        <div class="modal fade" id="create-folder-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <?php echo form_open("filemanager/create_folder", "data-parsley-validate method='post' id='create-folder-form'"); ?>
                    <input type="hidden" name="parent_id" value="0" />
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Create folder</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="folder_name" class="req">Folder name:</label>
                            <input type="text" name="folder_name" id="folder_name" class="form-control" required data-parsley-trigger="change">
                            <div class="message"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-success">Save</button>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
    <div class="main-content">
        <h4>List files.</h4>
    </div>
</div>