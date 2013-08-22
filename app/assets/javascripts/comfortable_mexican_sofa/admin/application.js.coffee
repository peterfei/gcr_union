#= require tinymce
window.CMS.wysiwyg = ->
  tinymce.init
    selector: 'textarea[data-rich-text]',
    mode: 'textareas',
    theme: 'advanced',
    width: 300,
    height: 300,
    style_formats: [
        {title: 'Bold text', inline: 'b'},
        {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
        {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
        {title: 'Example 1', inline: 'span', classes: 'example1'},
        {title: 'Example 2', inline: 'span', classes: 'example2'},
        {title: 'Table styles'},
        {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
    ]
    # any additional tinymce configuration can go here
