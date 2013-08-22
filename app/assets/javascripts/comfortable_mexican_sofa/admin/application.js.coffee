#= require tinymce
window.CMS.wysiwyg = ->
  tinymce.init
    selector: 'textarea[data-rich-text]'
    
