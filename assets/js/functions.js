(function($) {
    $(document).ready(function() {

        function render_tree() {
            $('.tree').html('<center><img src="http://localhost/filemanager/assets/images/loading.gif" alt="loading" /></center>');
            $.get('filemanager/render_tree', function(data) {
                $('.tree').html(data);
                $('.tree li:has(ul)').addClass('parent_li');
                $('.tree li.parent_li > span').parent('li.parent_li').find(' > ul > li').hide();
            });
        }

        $(window).bind('beforeunload', function() {
            $('#create-folder-form').find('input[name="parent_id"]').val(0);
        });

        $(".taskbar").on("click", "#create-folder", function() {
            $('#create-folder-form div.message').html("");
            $('#create-folder-form').trigger("reset");
            $('#create-folder-form').parsley().reset();
        });

        $(".taskbar").on("click", "#rename-folder", function() {
            $('#rename-folder-form div.message').html("");
            $('#rename-folder-form').parsley().reset();
        });

        $(".taskbar").on("click", "#trash", function() {
            $.get('filemanager/trash/' + $(this).attr('data-id'), function(data) {
                render_tree();
                bootbox.alert(data);
            });
        });

        $(".taskbar").on("click", "#delete-folder", function() {
            var delete_btn = $(this);
            bootbox.confirm("Are you sure?", function(result) {
                if (result) {
                    var id = delete_btn.attr('data-id');
                    var params = 'id=' + id;
                    var data_toke_name = $('.tree').attr('data-token-name');
                    var data_toke_value = $('.tree').attr('data-token-value');
                    params += '&' + data_toke_name + '=' + data_toke_value;
                    $.ajax({
                        type: "POST",
                        url: 'filemanager/delete',
                        data: params,
                        success: function(data) {
                            render_tree();
                            bootbox.alert(data);
                        }
                    });
                } else {
                    console.log(0);
                }
            });
        });

        $(".taskbar").on("change", "#folder_name", function() {
            $('.folder-form div.message').html("");
            $('.folder-form div.message').removeClass('filled');
            $('.folder-form #folder_name').removeClass('parsley-error');
        });

        $(".modal").on("submit", ".folder-form", function() {
            $.ajax({
                type: "POST",
                url: $(this).attr('action'),
                data: $(this).serialize(),
                dataType: 'json',
                success: function(data) {
                    if (data.status === 'ERROR') {
                        $('.folder-form div.message').html('<h5>' + data.message + '</h5>');
                        $('.folder-form div.message').addClass('filled');
                        $('.folder-form #folder_name').addClass('parsley-error');
                    } else {
                        $('.modal').modal('hide');
                        render_tree();
                        bootbox.alert(data.message);
                    }
                }
            });
            return false;
        });

        $(".file-toolbar").on("submit", "#upload-file-form", function() {
            var formData = new FormData(document.getElementById("upload-file-form"));
            $('.file-toolbar .wrap-progress').removeClass('hide');
            $.ajax({
                xhr: function() {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function(evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            percentComplete = parseInt(percentComplete * 100);
                            $('.file-toolbar .progress-bar').css('width', percentComplete + '%');
                            if (percentComplete === 100) {
                                $('.file-toolbar .wrap-progress').html('<div class=\"alert alert-dismissable alert-success\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button><strong>Upload successfully!</strong></div>').hide().fadeIn('slow');
                            }
                        }
                    }, false);
                    return xhr;
                },
                type: "POST",
                url: $(this).attr('action'),
                processData: false,
                contentType: false,
                data: formData,
                success: function() {
                    $('.main-content').html('<center><img src="http://localhost/filemanager/assets/images/loading.gif" alt="loading" /></center>');
                    var params = 'id=' + $("#upload-file-form").find('input[name="folder_id"]').val();
                    var data_toke_name = $('.main-content').attr('data-token-name');
                    var data_toke_value = $('.main-content').attr('data-token-value');
                    params += '&' + data_toke_name + '=' + data_toke_value;
                    $.post('filemanager/get_list_file', params, function(data) {
                        $('.main-content').html(data);
                        $('#upload-file-form').trigger("reset");
                    });
                }
            });
            return false;
        });

        $('.tree li:has(ul)').addClass('parent_li');
        $('.tree li.parent_li > span').parent('li.parent_li').find(' > ul > li').hide();
        $('.tree').on('click', 'li.parent_li > span i', function(e) {
            var children = $(this).parent().parent('li.parent_li').find(' > ul > li');
            if (children.is(":visible")) {
                children.hide('fast');
            } else {
                children.show('fast');
            }
            e.stopPropagation();
        });

        $(".tree a").tooltip();
        $(document).ajaxComplete(function() {
            $(".tree a").tooltip();
        });

        $(".tree").on("click", "a", function() {
            $('.file-toolbar').addClass('hide');
            $('#rename-folder').addClass('hide');
            $('#trash').addClass('hide');
            $('#delete-folder').addClass('hide');
            $('.main-content').html('<center><img src="http://localhost/filemanager/assets/images/loading.gif" alt="loading" /></center>');
            var url = 'filemanager/get_list_file';
            var id = $(this).attr('data-id');
            var params = 'id=' + id;
            var data_toke_name = $('.tree').attr('data-token-name');
            var data_toke_value = $('.tree').attr('data-token-value');
            params += '&' + data_toke_name + '=' + data_toke_value;
            $.ajax({
                type: "POST",
                url: url,
                data: params,
                success: function(data) {
                    $('#create-folder-form').find('input[name="parent_id"]').val(id);
                    $('#rename-folder-form').find('input[name="folder_id"]').val(id);
                    $('#rename-folder-form').find('input[name="folder_name"]').val(data);
                    $('#upload-file-form').find('input[name="folder_id"]').val(id);
                    $('.file-toolbar').removeClass('hide');
                    $('.main-content').html(data);
                    $('#trash').attr('data-id', id);
                    $('#delete-folder').attr('data-id', id);
                    $('#rename-folder').removeClass('hide');
                    $('#trash').removeClass('hide');
                    $('#delete-folder').removeClass('hide');
                }
            });
            return false;
        });
    });
})(window.jQuery);