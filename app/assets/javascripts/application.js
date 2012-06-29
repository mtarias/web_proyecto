// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.

// require_tree .
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.validate
//= require i18n
//= require i18n/translations
//= require jquery.tokeninput


$(function() {

	$("#new_user").validate({
		debug: true,
		rules: {
			"user[name]": { required: true },
			"user[email]": { required: true, email: true },
			"user[password]": { required: true, minlength: 6 },
			"user[password_confirmation]": { required: true, equalTo: "#user_password" }
		}
	});

	$("#notice").delay(20000).fadeOut("slow");

	$("div").hover(function (){
			$(this).children("#right").show();
		},
		function (){
			$(this).children("#right").hide();
		}
	);

	$("a#attending").hover(function (){
			$(this).text(I18n.t('to_not_attend'));
		},
		function (){
			$(this).text(I18n.t('attending'));
		}
	);

	$("a#not_decided").hover(function (){
			$(this).text(I18n.t('to_attend'));
		},
		function (){
			$(this).text(I18n.t('not_decided'));
		}
	);

	$("a#not_invited").hover(function (){
			$(this).text(I18n.t('to_attend'));
		},
		function (){
			$(this).text(I18n.t('not_invited'));
		}
	);

	$("a#to_not_attend").hover(function (){
			$(this).text(I18n.t('to_attend'));
		},
		function (){
			$(this).text(I18n.t('to_not_attend'));
		}
	);

	$("input#invitations").tokenInput(function() {
		return "/users/search?event_id=" + $("#event_id").val()
	}, {
		theme: "facebook",
		preventDuplicates: true,
		searchDelay: 600,
		minChars: 2,
		tokenValue: "email",
		hintText: function() { return I18n.t('hintText') },
		noResultsText: function() { return I18n.t('noResultsText') },
		searchingText: function() { return I18n.t('searchingText') }
	});

});