#= require comfortable_mexican_sofa/lib/redactor

window.CMS.wysiwyg = ->
  csrf_token = $('meta[name=csrf-token]').attr('content');
  csrf_param = $('meta[name=csrf-param]').attr('content');
  if (csrf_param != undefined && csrf_token != undefined)
    params = csrf_param + "=" + encodeURIComponent(csrf_token)
  
  $('textarea[data-rich-text]').redactor
    minHeight: 400
    buttons: ['formatting', '|', 'bold', 'italic', '|', 'unorderedlist', 'orderedlist', '|', 'image', 'link']
    imageUpload: "#{CMS.file_upload_path}?ajax=1&#{params}"
    imageGetJson: "#{CMS.file_upload_path}?ajax=1"
    formattingTags: ['p', 'h1', 'h2', 'h3', 'h4']
