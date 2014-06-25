(function($) {
    $(document).ready(function() {
        $(".taskbar").on("click", "#create-folder", function() {
            $('#create-folder-form span.message').html("");
            $('#create-folder-form').trigger("reset");
            $('#create-folder-form').parsley().reset();
        });
        $("#create-folder-form").on("change", "#folder_name", function() {
            $('#create-folder-form div.message').html("");
            $('#create-folder-form div.message').removeClass('filled');
            $('#create-folder-form #folder_name').removeClass('parsley-error');
        });
        $(".modal").on("submit", "#create-folder-form", function() {
            $.ajax({
                type: "POST",
                url: $(this).attr('action'),
                data: $(this).serialize(),
                success: function(data) {
                    if (data === 'Directory is exist.') {
                        $('#create-folder-form div.message').html('<h5>' + data + '</h5>');
                        $('#create-folder-form div.message').addClass('filled');
                        $('#create-folder-form #folder_name').addClass('parsley-error');
                    } else {
                        $('.tree').html('<center><img src="assets/images/loading.gif" alt="loading" /></center>');
                        $('.modal').modal('hide');
                        $.get('filemanager/render_tree', function(data) {
                            $('.tree').html(data);
                            $('.tree li:has(ul)').addClass('parent_li');
                            $('.tree li.parent_li > span').parent('li.parent_li').find(' > ul > li').hide();
                        });
                        bootbox.alert(data);
                    }
                },
                error: function(data) {
                    $('.modal').modal('hide');
                    bootbox.alert(data);
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

        $(".tree").on("click", "a", function() {
            $('.main-content').html('<center><img src="assets/images/loading.gif" alt="loading" /></center>');
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
                    $('#create-folder-modal').find('input[name="parent_id"]').val(id);
                    $('.main-content').html(data);
                }
            });
            return false;
        });
    });
})(window.jQuery);