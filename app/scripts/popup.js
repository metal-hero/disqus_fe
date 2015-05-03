(function() {
  'use strict';
  (function() {
    var checkEmpty, counter, deleteAllData, email, emailInput, foo, loadData, name, nameInput, retrievedObject, user, yourGlobalVariable;
    checkEmpty = void 0;
    email = void 0;
    foo = void 0;
    name = void 0;
    retrievedObject = void 0;
    user = void 0;
    yourGlobalVariable = void 0;
    loadData = void 0;
    deleteAllData = void 0;
    counter = void 0;
    counter = localStorage.getItem('counter');
    counter = 0;
    console.log(counter);
    yourGlobalVariable = 0;
    user = {
      email: null,
      nameString: null
    };
    retrievedObject = localStorage.getItem('memory', user);
    foo = JSON.parse(retrievedObject);
    email = document.getElementById('inputEmail');
    name = document.getElementById('nameInput');
    name.setAttribute('value', foo.nameString);
    email.setAttribute('value', foo.email);
    emailInput = void 0;
    nameInput = void 0;
    emailInput = document.getElementById('inputEmail').value;
    nameInput = document.getElementById('nameInput').value;
    if (emailInput.length === 0 || nameInput.length === 0) {
      $('#focusedInput').attr('disabled', 'disabled');
    } else {
      $('#focusedInput').removeAttr('disabled');
    }
    checkEmpty = function() {
      if (emailInput.length === 0 || nameInput.length === 0) {
        return true;
      } else {
        return false;
      }
    };
    loadData = function() {
      $.ajax({
        url: 'http://127.0.0.1:8000/api/v1/comment/',
        success: function(result) {
          var email;
          var contDiv, day, dd, globalDiv, gravatar, i, img, imgDiv, mesDiv, mesString, mm, month, nameString, nameUser, newDiv, sep, time, timeDiv, today, year, yyyy;
          if (counter < result.objects.length) {
            i = counter + 1;
            while (i < result.objects.length) {
              contDiv = void 0;
              dd = void 0;
              email = void 0;
              globalDiv = void 0;
              gravatar = void 0;
              img = void 0;
              imgDiv = void 0;
              mesDiv = void 0;
              mesString = void 0;
              mm = void 0;
              nameString = void 0;
              nameUser = void 0;
              newDiv = void 0;
              sep = void 0;
              timeDiv = void 0;
              today = void 0;
              yyyy = void 0;
              mesString = document.getElementById('focusedInput').value;
              globalDiv = document.getElementById('omg');
              if (yourGlobalVariable > 0) {
                sep = document.createElement('div');
                sep.setAttribute('class', 'list-group-separator');
                globalDiv.appendChild(sep);
              }
              newDiv = document.createElement('div');
              newDiv.setAttribute('class', 'list-group-item');
              globalDiv.appendChild(newDiv);
              imgDiv = document.createElement('div');
              imgDiv.setAttribute('class', 'row-action-primary');
              newDiv.appendChild(imgDiv);
              img = document.createElement('img');
              img.setAttribute('class', 'circle');
              gravatar = result.objects[i].image;
              img.setAttribute('src', gravatar);
              imgDiv.appendChild(img);
              contDiv = document.createElement('div');
              contDiv.setAttribute('class', 'row-content');
              newDiv.appendChild(contDiv);
              timeDiv = document.createElement('div');
              timeDiv.setAttribute('class', 'least-content');
              time = result.objects[i].pub_time;
              time = time.substring(0, 10);
              day = time.substring(8, 10);
              month = time.substring(5, 7);
              year = time.substring(2, 4);
              timeDiv.appendChild(document.createTextNode(day + '.' + month + '.' + year));
              contDiv.appendChild(timeDiv);
              nameUser = document.createElement('h4');
              nameUser.setAttribute('class', 'list-group-item-heading');
              nameUser.appendChild(document.createTextNode(result.objects[i].author_title));
              contDiv.appendChild(nameUser);
              mesDiv = document.createElement('p');
              mesDiv.setAttribute('class', 'list-group-item-text');
              mesDiv.appendChild(document.createTextNode(result.objects[i].text));
              contDiv.appendChild(mesDiv);
              yourGlobalVariable++;
              counter = i;
              localStorage.setItem('counter', counter);
              console.log(counter + ' ' + i);
              i++;
            }
          }
        }
      });
    };
    loadData();
    $('.col-lg-10 > input').keyup(function() {
      var empty;
      user.email = document.getElementById('inputEmail').value;
      user.nameString = document.getElementById('nameInput').value;
      localStorage.setItem('memory', JSON.stringify(user));
      empty = void 0;
      empty = checkEmpty();
      $('.col-lg-10 > input').each(function() {
        if ($(this).val() === '') {
          empty = true;
        }
      });
      if (empty) {
        $('#focusedInput').attr('disabled', 'disabled');
      } else {
        $('#focusedInput').removeAttr('disabled');
      }
    });
    $('#focusedInput').keyup(function() {
      var empty;
      empty = void 0;
      empty = false;
      if ($(this).val() === '') {
        empty = true;
      }
      if (empty) {
        document.getElementById('focusedInput').className = 'form-control empty';
      } else {
        document.getElementById('focusedInput').className = 'form-control';
      }
    });
    $('#focusedInput').keyup(function(event) {
      var data;
      if (document.getElementById('focusedInput').value !== '') {
        if (event.keyCode === 13) {
          data = JSON.stringify({
            'text': document.getElementById('focusedInput').value,
            'author_title': nameInput,
            'image': 'http://www.gravatar.com/avatar/' + CryptoJS.MD5(emailInput)
          });
          $.ajax({
            url: 'http://127.0.0.1:8000/api/v1/comment/',
            type: 'POST',
            contentType: 'application/json',
            data: data,
            dataType: 'json',
            processData: false
          });
          loadData();
        }
      }
    });
  }).call(this);

}).call(this);
