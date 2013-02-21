var slug = function(str) {
    str = str.replace(/^\s+|\s+$/g, ''); // trim
    str = str.toLowerCase();

    // remove accents, swap ñ for n, etc
    var from = "ąãàáäâęẽèéëêìíïîõòóöôùúüûńñçćżźśł·/_,:;";
    var to   = "aaaaaaeeeeeeiiiiooooouuuunncczzsl------";
    for (var i=0, l=from.length ; i<l ; i++) {
        str = str.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
    }

    str = str.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
        .replace(/\s+/g, '-') // collapse whitespace and replace by -
        .replace(/-+/g, '-'); // collapse dashes

    return str;
};

function delete_asset(page_id, asset_id) {
    $.ajax({
        url: '/admin/assets/' + asset_id + '.js',
        type: 'DELETE'
    }).error(function(){
        alert('Could not delete attachment');
    });
}

function delete_related(page_id, related_item_id) {
    $.ajax({
        url: '/admin/related_items/' + related_item_id + '.js',
        type: 'DELETE'
    }).error(function(){
        alert('Could not delete related item');
    });
}

function update_positions(pagesArray) {
    $('.update-positions-button').attr('disabled', true).attr('value', 'Saving...')
    $.ajax({
        url: '/admin/pages/update_positions.js',
        data: { 'page_ids': pagesArray },
        type: 'PUT'
    });
}

$(function(){
    $('#translations.index input').blur(function(evt){
        $.ajax({
            url: $(evt.target).data('route') + '.js',
            type: 'PUT',
            data: { 'value': $(evt.target).val(), 'locale': $(evt.target).data('locale'), 'key': $(evt.target).data('key') }
        })
    });

    $('input[type="checkbox"][data-route]').change(function(){
        _data = {}
        _data[$(this).data('resource')] = {};
        _data[$(this).data('resource')][$(this).data('attribute')] = $(this).is(':checked');

        that = this;

        $.ajax({
            url: $(this).data('route') + '.js',
            type: 'PUT',
            data: _data
        }).success(function(){
            $(that).closest('td').effect('highlight');
        });
    });

    $(document).ready(function(){
        $('input.ui-datetimepicker').datetimepicker({
            dateFormat: 'yy-mm-dd',
            timeFormat: 'HH:mm:ss'
        });
    });

    $('i.fold').click(function(){
        var form = $(this).closest('fieldset').find('ol');
        if (form.is(':visible')){
            $(this).text('Show');
        } else {
            $(this).text('Hide');
        }
      $(this).closest('fieldset').find('ol').toggle();
    });

//    $('i.folded').click();

    $('input[multiple]').each(function(){
        $(this).attr('name', $(this).attr('name').replace(/\[\]$/, '') );
    });

    $( ".sortable" ).sortable();
    $( ".sortable" ).disableSelection();

});