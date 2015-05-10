'use strict';

User =
  email: ""
  name: ""

email = document.getElementById('inputEmail')
name = document.getElementById('inputName')
password = document.getElementById('inputPassword')

tab_check = false

$('#changer').click -> 
  if tab_check == false
    $('#sign_up').addClass('hidden')
    $('#sign_in').removeClass('hidden')
    $('#changer').html('Sign Up')
    tab_check = true
  else 
    $('#sign_up').removeClass('hidden')
    $('#sign_in').addClass('hidden')
    $('#changer').html('Sign In')    
    tab_check = false

$('#submitSignUp').click ->
  if $('#sign_up')[0].checkValidity()
    alert('SMTH')
    $.ajax 
      url: 'http://127.0.0.1:8000/api/v1/my_user/',
      type: 'POST',
      data: JSON.stringify
        email: $('#sign_upEmail').val(),
        name: $('#sign_upName').val(),
        password: $('#sign_upPassword').val(),
      contentType: 'application/json',
      success: (msg) ->
        return alert("Registrated")

authenticated = =>
  $('#user-form').addClass('hidden')
  $('#comments').removeClass('hidden')
  $('#user-info_label').html("Name: "+User.name+" <br> Email: "+User.email)
  $('body').css('height',600)

log_out = =>
  $('#user-form').removeClass('hidden')
  $('#comments').addClass('hidden')
  $('#user-info_label').html("")
  $('body').css('height',300)

if localStorage.getItem("user-info")
  User = JSON.parse(localStorage.getItem("user-info"))
  # alert(JSON.stringify(User))
  authenticated()


$('#submitSignIn').click ->
  if $('#sign_in')[0].checkValidity()
    email = $('#sign_inEmail').val()
    name = 'Roman' 
    # I wrote this because I couldn't make authentication from tastypie
    User.email = email
    # alert $('#sign_inEmail') 
    # User.email = 'bla'
    User.name = name
    # alert(JSON.stringify(User))
    authenticated()
    localStorage.setItem("user-info", JSON.stringify(User))
    

$('#sign_out').click ->
  localStorage.removeItem("user-info")
  log_out()

cleanData = ->
  $('.list-group-item').remove()
  $('.list-group-separator').remove()
  location.reload()


loadData = ->
  firstVariable = false
  $.ajax
    url: 'http://127.0.0.1:8000/api/v1/comment/'
    success: (result) ->
      `var email`
      i = result.objects.length
      i--
      while i >= 0
        globalDiv = $('#comments')
        # globalDiv.html('')
        if firstVariable == false
          sep = $ '<div></div>' 
          sep.addClass 'list-group-separator'
          globalDiv.append sep
        newDiv = $ '<div></div>'
        newDiv.addClass 'list-group-item'
        globalDiv.append newDiv
        imgDiv = $ '<div></div>'
        imgDiv.addClass 'row-action-primary'
        newDiv.append imgDiv
        img = $ '<img>'
        img.addClass  'circle'
        gravatar = result.objects[i].image
        img.attr('src',gravatar)
        imgDiv.append img
        contDiv = $ '<div></div>'
        contDiv.addClass  'row-content'
        newDiv.append contDiv
        timeDiv = $ '<div></div>'
        timeDiv.addClass  'least-content'
        time = result.objects[i].pub_time
        time = time.substring(0, 20)
        # alert(time)
        day = time.substring(8, 10)
        month = time.substring(5, 7)
        year = time.substring(2, 4)
        hh = time.substring(11,13)
        min = time.substring(14,16)
        sec = time.substring(17,19)
        # alert(hh)
        timeDiv.append (day + '.' + month + '.' + year+ '  ' + hh+':'+min+':'+sec)
        contDiv.append timeDiv
        nameUser = $ '<h4></h4>'
        nameUser.addClass  'list-group-item-heading'
        nameUser.append result.objects[i].author_title
        contDiv.append nameUser
        mesDiv = $ '<p></p>'
        mesDiv.addClass  'list-group-item-text'
        mesDiv.append result.objects[i].text
        contDiv.append mesDiv
        firstVariable = true
        i--
      return

loadData()

$('#enteredInput').keyup ->
  empty = undefined
  empty = false
  if $(this).val() == ''
    empty = true
  if empty
    $('#enteredInput').addClass('empty')
  else
    $('#enteredInput').removeClass('empty')
  return

$('#enteredInput').keyup (event) ->
  if document.getElementById('enteredInput').value != ''
    if event.keyCode == 13
      # alert("Entered")
      data = JSON.stringify
        'text': document.getElementById('enteredInput').value
        'author_title': User.name
        'image': 'http://www.gravatar.com/avatar/' + CryptoJS.MD5(User.email)
      $.ajax
        url: 'http://127.0.0.1:8000/api/v1/comment/'
        type: 'POST'
        contentType: 'application/json'
        data: data
        dataType: 'json'
        processData: false
      cleanData()
  return
return

