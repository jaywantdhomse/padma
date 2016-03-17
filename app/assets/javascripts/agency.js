/*!
 * Start Bootstrap - Agency Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

// Highlight the top nav as scrolling occurs
$('body').scrollspy({
    target: '.navbar-fixed-top'
})

function get_label(ctrl) {
    var this_ctrl = $(ctrl);
    var label_text = this_ctrl.attr("data-lable");
    return $.trim(label_text);
}

function valid_email(x) {
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
      return false;
    }
    return true;
}

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});

$(".login").click(function() {
    $("#loginModal").modal("show");
});
$(".category").click(function() {
    $("#categoryModal").modal("show");
});
$(".add_product").click(function() {
    $("#add_productModal").modal("show");
});
$(".check_all_category").click(function() {
    $("#check_all_categoryModal").modal("show");
});
$(".vacancy").click(function() {
    $("#vacancyModal").modal("show");
});

$("form#user_signup").submit(function() {
    var empty_textboxes = [];
    var invalid_emails = [];
    var invalid_numeric_fields = [];
    var non_numeric_fields = [];
    var password_not_matched = [];
    var user_form = $("form#user_signup");
    var form_valid = true;
    
    $("input[type=text], input[type=password]", user_form).each(function(){
       var value = $.trim($(this).val());
       if(value == "") {
            var label = get_label(this);
            form_valid = false;
            empty_textboxes.push(label);
       }
    });
    
    //phone number
    $('input#mob_no', user_form).each(function() {
        var value = $.trim($(this).val());
        var label = get_label(this);
        if(value.length > 0 && !value.match(/^[0-9]+$/)) {
            form_valid = false;
            non_numeric_fields.push(label);
        }else{
            if(value.length != 10){
                form_valid = false;
                invalid_numeric_fields.push(label);
            }
        }
    });
    
    $("input#user_email", user_form).each(function(){       
        var value = $(this).val();
        var label = get_label(this);
        if(!valid_email(value)) {
            form_valid = false;
            invalid_emails.push(label); 
        }
    });  
    var password = $("input#password", user_form).val();
    var confirm_password = $("input#confirm_password", user_form).val();
    if(password != confirm_password){
    	form_valid = false;
        password_not_matched.push("\n\nPassword and confirm password does not match.");
    }  
    
    if(form_valid == true){
        $.ajax({
             type: "POST",
             url: $("form#user_signup").attr("action"),
             data: $("form#user_signup").serialize(),
             beforeSend: function(){

             },
             complete: function() {           

             },
             success: function(data){
                if(data["response"] == "0"){
                    if(data["error"]["password"] != "" && data["error"]["password"] != undefined && data["error"]["password"] != null){
                        alert("Password " +data["error"]["password"]);
                    }else{
                        alert($("form#user_signup #user_email").val() + " " +data["error"]["email"]);
                    }
                }else{
                    $("#signup_success").text("Signup Successful");
                }
             }
         });        
    }else{
        $(".error_msg").text("");
        var new_msg = "Could not proceed with Sign Up.";
        if (empty_textboxes.length > 0) {
            new_msg += "\n\nPlease provide value for following fields:\n" + empty_textboxes.join(", ") + ".";
        }
        if(invalid_numeric_fields.length > 0){
            new_msg += "\n\nPlease provide valid values for " + invalid_numeric_fields.join(" and ") + ".";
        }
        if (non_numeric_fields.length > 0) {
            new_msg += "\n\nPlease provide a valid number for " + non_numeric_fields.join(", ") + ".";
        }         
        if (invalid_emails.length > 0) {
            new_msg += "\n\nPlease provide a valid address for " + invalid_emails.join(" and ") + ".";
        }
        if (password_not_matched.length > 0) {
        	new_msg += password_not_matched[0];
        }
        
        alert(new_msg);
    }
    return false;
});

$("form#user_login").submit(function() {
    var username = $(this).find('#user_email').val();
    var password = $(this).find('#user_password').val();
    if(username == "" || password == ""){
        alert("Incorrect username or password");
    }else{
        $.ajax({
            type: "POST",
            url: $(this).attr('action'),
            data: $(this).serialize(),
            beforeSend: function(){                
            },
            complete: function() {             
            },
            error: function (xhr, ajaxOptions, thrownError) {
				//alert(xhr.status);
				alert(thrownError);
			  },
            success: function(data){
                console.log(data);
                if(data['success'] == true){
                    parent.location.replace(root_url);
                }else{ 
                    if(data["errors"] != undefined && data["errors"] != null){
                        alert(data["errors"]);
                    }else{
                        alert("Account not activated.");
                    }
                }
            }
        });        
    }
    return false;
});

