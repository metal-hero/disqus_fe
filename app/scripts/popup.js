(function() {
  'use strict';
  var email, foo, name, password, retrievedObject, tab_check, user;

  user = {
    email: null,
    nameString: null
  };

  email = document.getElementById('inputEmail');

  name = document.getElementById('inputName');

  password = document.getElementById('inputPassword');

  retrievedObject;

  foo;

  if (localStorage.getItem('memory', user) !== null) {
    retrievedObject = localStorage.getItem('memory', user);
    foo = JSON.parse(retrievedObject);
    name.setAttribute('value', foo.nameString);
    email.setAttribute('value', foo.email);
  }

  tab_check = false;

  $('#changer').click(function() {
    if (tab_check === false) {
      $('#sign_up').addClass('hidden');
      $('#sign_in').removeClass('hidden');
      $('#changer').html('Sign Up');
      return tab_check = true;
    } else {
      $('#sign_up').removeClass('hidden');
      $('#sign_in').addClass('hidden');
      $('#changer').html('Sign In');
      return tab_check = false;
    }
  });

  $('#submitSignUp').click(function() {
    if ($('#sign_up')[0].checkValidity()) {
      alert('SMTH');
      return $.ajax({
        url: 'http://127.0.0.1:8000/api/v1/my_user/',
        type: 'POST',
        data: JSON.stringify({
          email: $('#sign_upEmail').val(),
          name: $('#sign_upName').val(),
          password: $('#sign_upPassword').val()
        }),
        contentType: 'application/json',
        success: function(msg) {
          return alert("Registrated");
        }
      });
    }
  });

  $('#submitSignIn').click(function() {
    var list;
    if ($('#sign_in')[0].checkValidity()) {
      alert('SMTH ' + $('#sign_inEmail').val());
      list = {
        'email': $('#sign_inEmail').val(),
        'password': $('#sign_inPassword').val()
      };
      alert(list['email']);
      return $.ajax({
        url: 'http://127.0.0.1:8000/login/',
        type: 'POST',
        data: JSON.stringify({
          'list': JSON.stringify(list)
        }),
        contentType: 'application/json',
        success: function(msg) {
          return alert("Sign In");
        }
      });
    }
  });

  return;

}).call(this);
