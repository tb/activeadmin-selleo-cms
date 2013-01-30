/*
 Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config )
{
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';

    /* Filebrowser routes */
    // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
    config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
    config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

    // The location of a script that handles file uploads in the Flash dialog.
    config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
    config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
    config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads in the Image dialog.
    config.filebrowserImageUploadUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads.
    config.filebrowserUploadUrl = "/ckeditor/attachment_files";

    // Rails CSRF token
    config.filebrowserParams = function(){
        var csrf_token, csrf_param, meta,
            metas = document.getElementsByTagName('meta'),
            params = new Object();

        for ( var i = 0 ; i < metas.length ; i++ ){
            meta = metas[i];

            switch(meta.name) {
                case "csrf-token":
                    csrf_token = meta.content;
                    break;
                case "csrf-param":
                    csrf_param = meta.content;
                    break;
                default:
                    continue;
            }
        }

        if (csrf_param !== undefined && csrf_token !== undefined) {
            params[csrf_param] = csrf_token;
        }

        return params;
    };

    config.addQueryString = function( url, params ){
        var queryString = [];

        if ( !params ) {
            return url;
        } else {
            for ( var i in params )
                queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
        }

        return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
    };

    // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
    CKEDITOR.on( 'dialogDefinition', function( ev ){
        // Take the dialog name and its definition from the event data.
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
        var content, upload;

        if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
            content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
            upload = (content == null ? null : content.get('upload'));

            if (upload && upload.filebrowser['params'] == null) {
                upload.filebrowser['params'] = config.filebrowserParams();
                upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
            }
        }

        if (dialogName == 'link') {
            var linkInfoTab = dialogDefinition.getContents('info');
            var pageField = linkInfoTab.get('page');

            if (!pageField) {
                $.ajax({
                    url: '/en.json',
                    type: 'GET',
                    async: false
                }).success(function(resp){
                        linkInfoTab.add( {
                            type : 'select',
                            label : 'Page',
                            id : 'page',
                            name : 'page',
                            items: resp,
                            onChange: function(ev){
                                var diag = CKEDITOR.dialog.getCurrent();
                                var url = diag.getContentElement('info','url');
                                var locale = $('[id*="lang"]:visible').find('input[name*="locale"]:hidden').val();
                                url.setValue(ev.data.value.replace(':locale', locale));
                            }
                        });
                    });
            }
        }
    });

    config.height = '200px';
    config.width = '800px';

    config.toolbar = 'Lite';

    config.forcePasteAsPlainText = true;
    config.fontSize_sizes = '12/12px;14/14px;18/18px;24/24px;30/30px;';

    /* Extra plugins */
    // works only with en, ru, uk locales
    config.extraPlugins = "embed,attachment";

    /* Toolbars */
    config.toolbar = 'Lite';

    config.toolbar_Easy =
        [
            ['Source','-','Preview'],
            ['Cut','Copy','Paste','PasteText','PasteFromWord',],
            ['Undo','Redo','-','SelectAll','RemoveFormat'],
            ['Styles','Format'], ['Subscript', 'Superscript', 'TextColor'], ['Maximize','-','About'], '/',
            ['Bold','Italic','Underline','Strike'], ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
            ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
            ['Link','Unlink','Anchor'], ['Image', 'Attachment', 'Flash', 'Embed'],
            ['Table','HorizontalRule','Smiley','SpecialChar','PageBreak']
        ];

    config.toolbar_All =
        [
            ['Source', '-', 'Preview', 'Templates'],
            ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord'],
            ['Maximize', '-', 'About'],
            ['Undo', 'Redo', '-', 'Find', 'Replace', '-', 'SelectAll', 'RemoveFormat'],
            ['Styles', 'Format'],
            ['Bold', 'Italic', 'Underline', 'Strike', '-', 'Subscript', 'Superscript', 'TextColor'],
            ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', 'Blockquote'],
            ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
            ['Link', 'Unlink', 'Anchor'],
            ['Image', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak']
        ];

    config.toolbar_Lite =
        [
            ['Cut', 'Copy', 'Paste'],
            ['Bold', 'Italic', 'Underline', 'StrikeThrough'],
            ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyFull'],
            ['Link', 'Unlink'],
            ['BulletedList', 'HorizontalRule']
        ];

    config.toolbar_Minimal =
        [
            ['Cut', 'Copy', 'Paste'],
            ['Bold', 'Italic', 'Underline', 'StrikeThrough'],
            ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyFull']
        ];

    config.toolbar_Header =
        [
            ['Bold'],
        ];

};