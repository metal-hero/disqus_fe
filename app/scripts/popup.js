// Generated by CoffeeScript 1.9.2
(function() {
  'use strict';
  var User, authenticated, cleanData, cur_domain, email, loadData, log_out, name, password, tab_check;

  User = {
    email: "",
    name: ""
  };

  email = document.getElementById('inputEmail');

  name = document.getElementById('inputName');

  password = document.getElementById('inputPassword');

  tab_check = false;

  ({
    cur_domain: null
  });

  if (localStorage.getItem("get-domain")) {
    cur_domain = JSON.parse(localStorage.getItem("get-domain"));
  }

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
      $('#user-info_label').html("Name: " + User.name + " <br> Email: " + User.email);
      return $('body').css('height', 600);
    };
  })(this);

  log_out = (function(_this) {
    return function() {
      $('#user-form').removeClass('hidden');
      $('#comments').addClass('hidden');
      $('#user-info_label').html("");
      return $('body').css('height', 300);
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

  cleanData = function() {
    $('.list-group-item').remove();
    $('.list-group-separator').remove();
    return location.reload();
  };

  loadData = function() {
    var firstVariable, url_str;
    firstVariable = false;
    url_str = 'http://127.0.0.1:8000/api/v1/comment/?site_url=' + cur_domain + '&format=json';
    return $.ajax({
      url: url_str,
      success: function(result) {
        var email;
        var contDiv, day, globalDiv, gravatar, hh, i, img, imgDiv, mesDiv, min, month, nameUser, newDiv, sec, sep, time, timeDiv, year;
        i = result.objects.length;
        i--;
        while (i >= 0) {
          globalDiv = $('#comments');
          if (firstVariable === false) {
            sep = $('<div></div>');
            sep.addClass('list-group-separator');
            globalDiv.append(sep);
          }
          newDiv = $('<div></div>');
          newDiv.addClass('list-group-item');
          globalDiv.append(newDiv);
          imgDiv = $('<div></div>');
          imgDiv.addClass('row-action-primary');
          newDiv.append(imgDiv);
          img = $('<img>');
          img.addClass('circle');
          gravatar = result.objects[i].image;
          img.attr('src', gravatar);
          imgDiv.append(img);
          contDiv = $('<div></div>');
          contDiv.addClass('row-content');
          newDiv.append(contDiv);
          timeDiv = $('<div></div>');
          timeDiv.addClass('least-content');
          time = result.objects[i].pub_time;
          time = time.substring(0, 20);
          day = time.substring(8, 10);
          month = time.substring(5, 7);
          year = time.substring(2, 4);
          hh = time.substring(11, 13);
          min = time.substring(14, 16);
          sec = time.substring(17, 19);
          timeDiv.append(day + '.' + month + '.' + year + '  ' + hh + ':' + min + ':' + sec);
          contDiv.append(timeDiv);
          nameUser = $('<h4></h4>');
          nameUser.addClass('list-group-item-heading');
          nameUser.append(result.objects[i].author_title);
          contDiv.append(nameUser);
          mesDiv = $('<p></p>');
          mesDiv.addClass('list-group-item-text');
          mesDiv.append(result.objects[i].text);
          contDiv.append(mesDiv);
          firstVariable = true;
          i--;
        }
      }
    });
  };

  loadData();

  $('#enteredInput').keyup(function() {
    var empty;
    empty = void 0;
    empty = false;
    if ($(this).val() === '') {
      empty = true;
    }
    if (empty) {
      $('#enteredInput').addClass('empty');
    } else {
      $('#enteredInput').removeClass('empty');
    }
  });

  $('#enteredInput').keyup(function(event) {
    var data;
    if (document.getElementById('enteredInput').value !== '') {
      if (event.keyCode === 13) {
        data = JSON.stringify({
          'text': document.getElementById('enteredInput').value,
          'site_url': cur_domain,
          'author_title': User.name,
          'image': 'http://www.gravatar.com/avatar/' + CryptoJS.MD5(User.email)
        });
        $.ajax({
          url: 'http://127.0.0.1:8000/api/v1/comment/',
          type: 'POST',
          contentType: 'application/json',
          data: data,
          dataType: 'json',
          processData: false
        });
        cleanData();
      }
    }
  });

  return;

}).call(this);
