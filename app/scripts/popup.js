(function() {
  'use strict';
  var User, authenticated, email, log_out, name, password, tab_check;

  User = {
    email: "",
    name: ""
  };

  email = document.getElementById('inputEmail');

  name = document.getElementById('inputName');

  password = document.getElementById('inputPassword');

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

  authenticated = (function(_this) {
    return function() {
      $('#user-form').addClass('hidden');
      $('#comments').removeClass('hidden');
      return $('#user-info_label').html(User.name + "  " + User.email);
    };
  })(this);

  log_out = (function(_this) {
    return function() {
      $('#user-form').removeClass('hidden');
      $('#comments').addClass('hidden');
      return $('#user-info_label').html("");
    };
  })(this);

  if (localStorage.getItem("user-info")) {
    User = JSON.parse(localStorage.getItem("user-info"));
    authenticated();
  }

  $('#submitSignIn').click(function() {
    if ($('#sign_in')[0].checkValidity()) {
      email = $('#sign_inEmail').val();
      name = 'Roman';
      User.email = email;
      User.name = name;
      authenticated();
      return localStorage.setItem("user-info", JSON.stringify(User));
    }
  });

  $('#sign_out').click(function() {
    localStorage.removeItem("user-info");
    return log_out();
  });

  return;

}).call(this);
