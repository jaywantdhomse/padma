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



$(document).on('ready page:load', function () {
   console.log("Loaded....");
   $(".login").click(function() {
	  $("#loginModal").modal("show");
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
                    $("#signup_success").text("You have Signup Successfully.");
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
		                    alert("Account not activated, please activate using your email account.");
		                }
		            }
		        }
		    });        
		}
		return false;
	});


	$("form#applicantForm").submit(function() {
		var empty_textboxes = [];
		var invalid_emails = [];
		var invalid_numeric_fields = [];
		var non_numeric_fields = [];
		var applicant_form = $("form#applicantForm");
		var form_valid = true;
		
		$("input[type=text]", applicant_form).each(function(){
		   var value = $.trim($(this).val());
		   if(value == "") {
		        var label = get_label(this);
		        form_valid = false;
		        empty_textboxes.push(label);
		   }
		});
		//phone number
		$('input#phone', applicant_form).each(function() {
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
		
		$("input#email", applicant_form).each(function(){       
		    var value = $(this).val();
		    var label = get_label(this);
		    if(!valid_email(value)) {
		        form_valid = false;
		        invalid_emails.push(label); 
		    }
		});  

		if(form_valid == true){
			$input = $('#applicant_avatar');
		    $("form#applicantForm").ajaxSubmit({
		         type: "POST",
		         dataType: "json",
		         url: $("form#applicantForm").attr("action"),
		         data: $("form#applicantForm").serialize()+"&applicant['avatar']"+$input[0].files[0],
		         beforeSend: function(){

		         },
		         complete: function() {           

		         },
		         success: function(data){
		            applicant_form.find("div#success").text("Application send successfully.")
		         }
		     });        
		}else{
		    $(".error_msg").text("");
		    var new_msg = "Could not proceed with Application.";
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
		    
		    alert(new_msg);
		}
		return false;
	});

	$("form#contactForm").submit(function() {
		var empty_textboxes = [];
		var invalid_emails = [];
		var invalid_numeric_fields = [];
		var non_numeric_fields = [];
		var contact_us_form = $("form#contactForm");
		var form_valid = true;
		
		$("input[type=text]", contact_us_form).each(function(){
		   var value = $.trim($(this).val());
		   if(value == "") {
		        var label = get_label(this);
		        form_valid = false;
		        empty_textboxes.push(label);
		   }
		});
		//phone number
		$('input#phone', contact_us_form).each(function() {
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
		
		$("input#email", contact_us_form).each(function(){       
		    var value = $(this).val();
		    var label = get_label(this);
		    if(!valid_email(value)) {
		        form_valid = false;
		        invalid_emails.push(label); 
		    }
		});  
		if(form_valid == true){
		    $.ajax({
		         type: "POST",
		         url: $("form#contactForm").attr("action"),
		         data: $("form#contactForm").serialize(),
		         beforeSend: function(){

		         },
		         complete: function() {           

		         },
		         success: function(data){
		            contact_us_form.find("div#success").text("Contact Us Message send successfully.")
		         }
		     });        
		}else{
		    $(".error_msg").text("");
		    var new_msg = "Could not proceed with Contact us.";
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
		    
		    alert(new_msg);
		}
		return false;
	});


	$("form#distributorForm").submit(function() {
		var empty_textboxes = [];
		var invalid_emails = [];
		var invalid_numeric_fields = [];
		var non_numeric_fields = [];
		var distributor_complaint_form = $("form#distributorForm");
		var form_valid = true;
		
		$("input[type=text]", distributor_complaint_form).each(function(){
		   var value = $.trim($(this).val());
		   if(value == "") {
		        var label = get_label(this);
		        form_valid = false;
		        empty_textboxes.push(label);
		   }
		});
		//phone number
		$('input#phone', distributor_complaint_form).each(function() {
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
		
		$("input#email", distributor_complaint_form).each(function(){       
		    var value = $(this).val();
		    var label = get_label(this);
		    if(!valid_email(value)) {
		        form_valid = false;
		        invalid_emails.push(label); 
		    }
		});  
		if(form_valid == true){
		    $.ajax({
		         type: "POST",
		         url: $("form#distributorForm").attr("action"),
		         data: $("form#distributorForm").serialize(),
		         beforeSend: function(){

		         },
		         complete: function() {           

		         },
		         success: function(data){
		            distributor_complaint_form.find("div#success").text("Complaint send successfully.")
		         }
		     });        
		}else{
		    $(".error_msg").text("");
		    var new_msg = "Could not proceed with Complaint.";
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
		    
		    alert(new_msg);
		}
		return false;
	});
	
    
	$("form#updateProfileForm").submit(function() {
		var update_profile_form = $("form#updateProfileForm"); 
        var empty_textboxes = [];
        var non_numeric_fields = [];
        var invalid_numeric_fields = [];
        
		var form_valid = true;
		
		$("input[type=text]", update_profile_form).each(function(){
		   var value = $.trim($(this).val());
		   if(value == "") {
		        var label = get_label(this);
		        form_valid = false;
		        empty_textboxes.push(label);
		   }
		});
		//phone number
		$('input#contact_no', update_profile_form).each(function() {
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
		 
		if(form_valid == true){
		    $.ajax({
		         type: "POST",
		         url: $("form#updateProfileForm").attr("action"),
		         data: $("form#updateProfileForm").serialize(),
		         beforeSend: function(){

		         },
		         complete: function() {           

		         },
		         success: function(data){
		            update_profile_form.find("div#success").text("Profile updated successfully.")
		         }
		     });        
		}else{
		    $(".error_msg").text("");
		    var new_msg = "Could not proceed with Complaint.";
		    if (empty_textboxes.length > 0) {
		        new_msg += "\n\nPlease provide value for following fields:\n" + empty_textboxes.join(", ") + ".";
		    }
		    if(invalid_numeric_fields.length > 0){
		        new_msg += "\n\nPlease provide valid values for " + invalid_numeric_fields.join(" and ") + ".";
		    }
		    if (non_numeric_fields.length > 0) {
		        new_msg += "\n\nPlease provide a valid number for " + non_numeric_fields.join(", ") + ".";
		    }         
		    
		    alert(new_msg);
		}
		return false;
	});    
    

	$(".forgotpassword").click(function() {
		$("#loginModal").modal("hide");
		$("#forgotModal").modal("show");
	});
	$(".category").click(function() {
    $("#categoryModal").modal("show");
	});
	$(".sub_category").click(function() {
    $("#subCategoryModal").modal("show");
	});    
	$(".add_product").click(function() {
		$("#add_productModal").modal("show");
	});
	$(".details_product").click(function() {
		$("#details_productModal").modal("show");
	});
	
	//Forgot password form submit
    $("form#forgot-password-form").submit(function() {
        var ctrl = $(this);
        var user_email = ctrl.find('#user_email').val();
        if(user_email == ""){
            ctrl.find("input#user_email").css({'border' : '1px solid red'});
            return false;
        }else{
            $.ajax({
                type: "POST",
                url: ctrl.attr('action'),
                data: ctrl.serialize(),
                beforeSend: function(){                
                },
                complete: function() {              
                },
                success: function(data){
                    if(data['response'] == "1"){
                        window.parent.$('#reset_password_confirmation_popup').trigger('click');
                        $("#send_mail_success").text("Reset password link has sent to your registered email account.");
                    }else{ 
                        $("#forgot_password_text").html("<b>We didn't recognize that email, please try again</b>").css("color", "red");
                    }
                }
            });
            return false;
        }

    });
	
	$(".check_all_category").click(function() {
		$("#portfolioModal4").modal("show");
		var category_id = $(this).attr("data-id");
		var category_name = $(this).attr("data-name");
		$.ajax({
		         type: "POST",
		         url: "show_category_products",
		         dataType: "json",
		         data: {
		         	category_id: category_id
		         },
		         beforeSend: function(){
					$("#portfolioModal4").find("div.modal-body").html("<img src='/assets/loading.gif'>");
		         },
		         complete: function() {
				
		         },
		         success: function(data){
		         	console.log(data);
		         	var html = "";
		         	var is_closed = false;
		         	for(var i=0; i<data["products"].length; i++){
		         		if(i % 4 == 0){
		         			html += "<div class='row'>";
		         		}
				     	html += "<div class='col-md-3 col-sm-6'>"+
				                    	"<img class='img-responsive' src='/assets/startup-framework.png' />"+
				                    	"<div>Name:"+data["products"][i]["name"]+"</div>"+
				                    	"<div>Category:"+category_name+"</div>"+
				                    	"<div>Model:"+data["products"][i]["model"]+"</div>"+
				                    	"<div>Price:"+data["products"][i]["price"]+"</div>"+
				                    	"<div>Description:"+data["products"][i]["description"]+"</div>"+
				                    	"<button onclick='order_now(this)' data-id='"+data["products"][i]["id"]+"' class='btn btn-primary'>Order Online</button>"+
				                    	"<div class='order_msg' style='color:green;'></div>"+
		                    	"</div>";
				        if(i != 0 && i % 3 == 0){
							html += "</div>";
							is_closed = true;
		         		}
		            } 
		            if(!is_closed){
		            	html += "</div>";
		            }
		            $("#portfolioModal4").find("div.modal-body").html(html);
		         }
		     });
		     
	});


}); 
// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});

	function applyFunction(ctrl){
		var post = $(ctrl).attr("data-post");
		$("select#appl_apply_for").val(post);
	}
	
	function pro_details(ctrl){
		var product_id = $(ctrl).attr("data-id");
		$.ajax({
		         type: "POST",
		         url: "get_product_details",
		         dataType: "json",
		         data: {
		         	product_id: product_id
		         },
		         beforeSend: function(){
					$("#details_productModal").find("div.modal-body").html("<img src='/assets/loading.gif'>");
		         },
		         complete: function() {
				
		         },
		         success: function(data){
		         	console.log(data);
		         	var button_html = '';
		         	if(data["is_user_login"]){
		         		button_html += '<div><button data-id="'+ data["product"]["id"]+'" class="portfolio-link order_online btn btn-primary" style="padding: 6px 4px 6px 5px; margin: 4px 4px 7px 110px;">Order Online</button><div style="color: green; font-size: 16px; text-align: center;" class="order_msg"></div></div>';
		         	}else{
		         		button_html += '<button class="portfolio-link login btn btn-primary" data-toggle="modal" style="padding: 6px 4px 6px 5px; margin: 4px 4px 7px 110px;">Order Online</button>';
		         	}
		         	
		         	var html = '<div class="row">'+
                    '<div class="col-lg-12">'+
                    	'<div>'+
                    		'<div class="col-lg-6" style="border: 3px solid grey; border-radius: 21px;">'+
								'<div style="height: 300px; background: lightskyblue;">'+
									'<img alt="Blue 0.5w" src="'+data["product"]["avatar"]["url"]+'" style="width: 100%; height: 300px;">'+
								'</div>'+
							'</div>'+
							'<div class="col-lg-6" style="">'+
								'<div style="height: auto;">'+
									'<span style="font-size: 19px; font-weight: bold; padding: 0px 4px 3px 6px; margin: 0px 3px 4px 4px;">Name: </span>'+
									'<span style="font-size: 17px; color: teal;">'+data["product"]["name"]+'</span><br>'+
									'<span style="font-size: 19px; font-weight: bold; padding: 0px 4px 3px 6px; margin: 0px 3px 4px 4px;">Of Category: </span>'+
									'<span style="font-size: 17px; color: teal;">'+data["category_name"]+'</span><br>'+
									'<span style="font-size: 19px; font-weight: bold; padding: 0px 4px 3px 6px; margin: 0px 3px 4px 4px;">Model: </span>'+
									'<span style="font-size: 17px; color: teal;">'+data["product"]["model"]+'</span><br>'+
									'<span style="font-size: 19px; font-weight: bold; padding: 0px 4px 3px 6px; margin: 0px 3px 4px 4px;">Price: </span>'+
									'<span style="font-size: 17px; color: teal;">'+data["product"]["price"]+'</span><br>'+
									'<span style="font-size: 19px; font-weight: bold; padding: 0px 4px 3px 6px; margin: 0px 3px 4px 4px;">Description: </span>'+
									'<span style="font-size: 17px; color: teal;">'+data["product"]["description"]+'</span><br>'+
								'</div>'+
								'</div>'+
								button_html +
						'</div>'+
                    '</div>'+
                '</div>';
		            $("#details_productModal").find("div.modal-body").html(html);
		            $(".login").click(function() {
					  $("#loginModal").modal("show");
				   });
				   
						$(".order_online").click(function() {
							var ctrl = $(this);
							var product_id = ctrl.attr("data-id");
							$.ajax({
									 type: "POST",
									 url: "order_product",
									 dataType: "json",
									 data: {
									 	product_id: product_id
									 },
									 beforeSend: function(){

									 },
									 complete: function() {
				
									 },
									 success: function(data){
                                        if (data["update_profile"]) {
                                            parent.location.replace(my_profile_url);
                                        }else{
                                            ctrl.closest("div").find("div.order_msg").text("Order Placed Successfully.");
                                        }
									 }
								 });
						});				   
				  
				   
		         }
		     });
	}
