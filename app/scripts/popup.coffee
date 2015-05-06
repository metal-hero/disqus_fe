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
  $('#user-info_label').html(User.name+"  "+User.email)

log_out = =>
  $('#user-form').removeClass('hidden')
  $('#comments').addClass('hidden')
  $('#user-info_label').html("")

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

# if User
#     $('user-form').addClass('hidden')
#     $('comments').removeClass('hidden')

# $('#submitSignIn').click ->
#   if $('#sign_in')[0].checkValidity()
#     alert('SMTH '+$('#sign_inEmail').val())
#     list = {'email': $('#sign_inEmail').val(), 'password': $('#sign_inPassword').val()}
#     alert(list['email'])
#     $.ajax 
#       url: 'http://127.0.0.1:8000/login/',
#       type: 'POST',
#       data: JSON.stringify
#         'list' : JSON.stringify(list)
#       contentType: 'application/json',
#       success: (msg) ->
#         return alert("Sign In")


# loadData = ->
#   $.ajax
#     url: 'http://127.0.0.1:8000/api/v1/comment/'
#     success: (result) ->
#       `var email`
#       if counter < result.objects.length
#         i = counter + 1
#         while i < result.objects.length
#           contDiv = undefined
#           dd = undefined
#           email = undefined
#           globalDiv = undefined
#           gravatar = undefined
#           img = undefined
#           imgDiv = undefined
#           mesDiv = undefined
#           mesString = undefined
#           mm = undefined
#           nameString = undefined
#           nameUser = undefined
#           newDiv = undefined
#           sep = undefined
#           timeDiv = undefined
#           today = undefined
#           yyyy = undefined
#           mesString = document.getElementById('focusedInput').value
#           globalDiv = document.getElementById('omg')
#           if yourGlobalVariable > 0
#             sep = document.createElement('div')
#             sep.setAttribute 'class', 'list-group-separator'
#             globalDiv.appendChild sep
#           newDiv = document.createElement('div')
#           newDiv.setAttribute 'class', 'list-group-item'
#           globalDiv.appendChild newDiv
#           imgDiv = document.createElement('div')
#           imgDiv.setAttribute 'class', 'row-action-primary'
#           newDiv.appendChild imgDiv
#           img = document.createElement('img')
#           img.setAttribute 'class', 'circle'
#           gravatar = result.objects[i].image
#           img.setAttribute 'src', gravatar
#           imgDiv.appendChild img
#           contDiv = document.createElement('div')
#           contDiv.setAttribute 'class', 'row-content'
#           newDiv.appendChild contDiv
#           timeDiv = document.createElement('div')
#           timeDiv.setAttribute 'class', 'least-content'
#           time = result.objects[i].pub_time
#           time = time.substring(0, 10)
#           day = time.substring(8, 10)
#           month = time.substring(5, 7)
#           year = time.substring(2, 4)
#           timeDiv.appendChild document.createTextNode(day + '.' + month + '.' + year)
#           contDiv.appendChild timeDiv
#           nameUser = document.createElement('h4')
#           nameUser.setAttribute 'class', 'list-group-item-heading'
#           nameUser.appendChild document.createTextNode(result.objects[i].author_title)
#           contDiv.appendChild nameUser
#           mesDiv = document.createElement('p')
#           mesDiv.setAttribute 'class', 'list-group-item-text'
#           mesDiv.appendChild document.createTextNode(result.objects[i].text)
#           contDiv.appendChild mesDiv
#           yourGlobalVariable++
#           counter = i
#           localStorage.setItem 'counter', counter
#           console.log counter + ' ' + i
#           i++
#       return

# loadData()
# $('.col-lg-10 > input').keyup ->
#   user.email = document.getElementById('inputEmail').value
#   user.nameString = document.getElementById('nameInput').value
#   localStorage.setItem 'memory', JSON.stringify(user)
#   empty = undefined
#   empty = checkEmpty()
#   $('.col-lg-10 > input').each ->
#     if $(this).val() == ''
#       empty = true
#     return
#   if empty
#     $('#focusedInput').attr 'disabled', 'disabled'
#   else
#     $('#focusedInput').removeAttr 'disabled'
#   return
# $('#focusedInput').keyup ->
#   empty = undefined
#   empty = false
#   if $(this).val() == ''
#     empty = true
#   if empty
#     document.getElementById('focusedInput').className = 'form-control empty'
#   else
#     document.getElementById('focusedInput').className = 'form-control'
#   return
return



# ---
# generated by js2coffee 2.0.3
# this script is used in popup.html
