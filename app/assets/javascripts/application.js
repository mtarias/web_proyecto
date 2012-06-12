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
// GO AFTER THE REQUIRES BELOW. // require_tree .
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require i18n
//= require i18n/translations


$(function() {
	$("#notice").delay(10000).fadeOut("slow");

	$("div").hover(function (){
			$(this).delay(500).children("#right").fadeIn();
		},
		function (){
			$(this).delay(500).children("#right").fadeOut("fast");
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

});