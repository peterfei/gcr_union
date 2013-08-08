# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  btn_html = ''
  $("#compstatus_btn").live 'mouseover', ->
    btn_html = $(@).html()
    if btn_html=='启用'
      $(@).html('停用')
      $(@).attr('tip','停用')
    
    if btn_html=='停用'
      $(@).html('启用')
      $(@).attr('tip','启用')
      
    if btn_html=='审核'
      $(@).html('审核通过')
      $(@).attr('tip','审核通过')
    $(@).css("color","red")
    
  $("#compstatus_btn").live 'mouseout', ->
    $(@).css("color","#333333")
    $(@).html(btn_html)
  
  #保存按钮事件,校验开始
  $("#companyOfSaveBtn").live 'click', ->
    issub = true
    ccname = $("#company_company_name")
    ccfname = $("#company_company_full_name")
    ctcode = $("#company_taxpayer_code")
    crmoney = $("#company_reg_money")
    company_link_man = $("#company_link_man")
    emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
    company_email = $("#company_email")
    company_link_man_phone = $("#company_link_man_phone")
    company_phone = $("#company_phone")
    telreg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/
    company_fax = $("#company_fax")
    regmoney = /^[0-9][0-9]{0,2}(?:,?[0-9]{3})*(?:\.[0-9]{1,2})?$/
   
    if ccname.val()=='' or !isNaN(ccname.val())
      changeInputStyle(ccname,1)
      issub =  false
    else
      changeInputStyle(ccname,0)
    if ccfname.val()=='' or !isNaN(ccfname.val())
      changeInputStyle(ccfname,1)
      issub = false
    else
      changeInputStyle(ccfname,0)
    if ctcode.val()=='' or !isNaN(ctcode.val())
      changeInputStyle(ctcode,1)
      issub = false
    else
      changeInputStyle(ctcode,0)
    if crmoney.val()=='' or !regmoney.test(crmoney.val())
      changeInputStyle(crmoney,1)
      issub = false
    else
      changeInputStyle(crmoney,0)
      
    if company_link_man.val()!=''
      if !isNaN(company_link_man.val())
        changeInputStyle(company_link_man,1)
        issub = false
      else
        changeInputStyle(company_link_man,0)
    
    if company_email.val()!=""
     if !emailreg.test(company_email.val())
       changeInputStyle(company_email,1)
       issub = false
     else
       changeInputStyle(company_email,0)
       
    if company_link_man_phone.val()!=''
      if company_link_man_phone.val().length<11
        changeInputStyle(company_link_man_phone,1)
        issub = false
      else
        changeInputStyle(company_link_man_phone,0)
    if company_phone.val()!=''
      if !telreg.test(company_phone.val())
        changeInputStyle(company_phone,1)
        issub = false
      else
        changeInputStyle(company_phone,0)
        
    if company_fax.val()!=''
      if !telreg.test(company_fax.val())
        changeInputStyle(company_fax,1)
        issub = false
      else
        changeInputStyle(company_fax,0)
    if issub
      $("#company_form").submit()
  changeInputStyle = (obj,o) ->
    if o==1
      obj.css('border','2px solid #E9322D')
      obj.css('box-shadow','0 0 6px #F8B9B7')
      obj.css('color','#B94A48')
    else
      obj.css('border','1px solid #CCCCCC')
      obj.css('box-shadow','0 1px 1px rgba(0, 0, 0, 0.075) inset')
      obj.css('color','#555555')

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
