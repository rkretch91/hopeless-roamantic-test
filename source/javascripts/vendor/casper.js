/**
 * Main JS file for Casper behaviours
 */

/* globals jQuery, document */
(function ($, undefined) {
    "use strict";

    var $document = $(document);

    $document.ready(function () {

        $(".scroll-down").arctic_scroll();

        $(".menu-button, .nav-cover, .nav-close").on("click", function(e){
            e.preventDefault();
            $("body").toggleClass("nav-opened nav-closed");
        });

    });

    // Arctic Scroll by Paul Adam Davis
    // https://github.com/PaulAdamDavis/Arctic-Scroll
    $.fn.arctic_scroll = function (options) {

        var defaults = {
            elem: $(this),
            speed: 500
        },

        allOptions = $.extend(defaults, options);

        allOptions.elem.click(function (event) {
            event.preventDefault();
            var $this = $(this),
                $htmlBody = $('html, body'),
                offset = ($this.attr('data-offset')) ? $this.attr('data-offset') : false,
                position = ($this.attr('data-position')) ? $this.attr('data-position') : false,
                toMove;

            if (offset) {
                toMove = parseInt(offset);
                $htmlBody.stop(true, false).animate({scrollTop: ($(this.hash).offset().top + toMove) }, allOptions.speed);
            } else if (position) {
                toMove = parseInt(position);
                $htmlBody.stop(true, false).animate({scrollTop: toMove }, allOptions.speed);
            } else {
                $htmlBody.stop(true, false).animate({scrollTop: ($(this.hash).offset().top) }, allOptions.speed);
            }
        });

    };
})(jQuery);

// document.getElementById("email-form").addEventListener('submit',function(e) {

//     document.getElementById('success-message').innerHTML = "<p style='font-size: 15px;'><em>Thank you for subscribing!</em></p>"
//     e.target.style.display = "none";
// });


function changeAction() {
    let type = document.getElementById("travel-form");
    let random = document.getElementById("travel-type");
    switch (random.selectedIndex) {
    case 1:
      createDestinationForm();
      break;
    case 2:
      type.action = "/tag/inspiration/";
      type.submit();
      break;
    case 3:
      console.log("hi");
      type.action = "/tag/stories/";
      type.submit();
      break;
    case 4:
      type.action = "/tag/tips/";
      type.submit();
      break;
    }
  }

  function createDestinationForm() {
    let destForm = `<h4>Which Country?</h4><form action="/" method="get" name="destination" id="dest-picker">
      <select name="countries" id="select-countries" onchange="countryPick()" class="travel-style">
        <option value="" disabled selected>Select Here</option>
        <option value="armenia">Armenia</option>
        <option value="china">China</option>
        <option value="czech">Czech Republic</option>
        <option value="georgia">Georgia</option>
        <option value="germany">Germany</option>
        <option value="hungary">Hungary</option>
        <option value="india">India</option>
        <option value="israel">Israel</option>
        <option value="kazakhstan">Kazakhstan</option>
        <option value="kyrgyzstan">Kyrgyzstan</option>
        <option value="poland">Poland</option>
        <option value="turkey">Turkey</option>
        <option value="usa">United States</option>
      </select>
      <input type="submit" value="Explore" class="btn-submit" style="margin-top: 20px;"></input>
    </form>`;
    document.querySelector(".country-form").innerHTML = destForm;
  }

  function countryPick(event) {
    let type = document.getElementById("dest-picker");
    let random = document.getElementById("select-countries");
    if (random.value != "") {
      type.action = `/tag/${random.value}/`;
    } else {
      event.preventDefault();
    }
    return false;
  }




//Validate that form has proper email
function validateEmail(email) {
  const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}


function validate(event) {
  const result = document.getElementById('success-message');
  const email = document.getElementById('email-entry').value;
  const form = document.getElementById('email-form');

  if (validateEmail(email)) {
    result.innerHTML = email + " is valid! Thanks for signing up.";
    result.style.color = "#3fc8fd";
    setTimeout(function(){form.submit()}, 1000);
  } else {
    result.innerHTML = email + " is not valid. Please re-enter.";
    result.style.color = "red";
    event.preventDefault();
    return false
  }
}

document.getElementById("email-form").addEventListener('submit', validate)
// document.getElementById("contact-form").addEventListener('submit', validate)

