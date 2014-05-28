//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap
//= require rails.validations
//= require rails.validations.simple_form
//= require_tree ../../../vendor/assets/javascripts/
//= require_tree .

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".field").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
}
