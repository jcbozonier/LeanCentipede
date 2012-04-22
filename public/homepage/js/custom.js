// JavaScript Document

// cufon font replacement class/id
Cufon.replace('h1,h2,h3',{textShadow: '0px 1px 0px #f8f8f8'});   
Cufon.replace('.button_1 a,.button_2 a,form.contact_form label');    
  
$(document).ready(function(){

//List animation
$('ul.list li').hover(function() { //mouse in
    $(this).animate({ marginLeft: '5px' }, 200);
  }, function() { //mouse out
    $(this).animate({ marginLeft: 0 }, 200);
});

//Cycle plugin for testimonial
$('.testimonial').cycle({
		fx: 'fade', // choose your transition type, ex: fade, scrollUp, shuffle, etc...
		speed:   1000,
		timeout: 4000,  // milliseconds between slide transitions (0 to disable auto advance)
		pager:   '#pager',  // selector for element to use as pager container            
		pause:   1,	  // true to enable "pause on hover"
		cleartypeNoBg:   true // set to true to disable extra cleartype fixing (leave false to force background color setting on slides)
});	
			
//Contact form
$(function() {
		var v = $("#form").validate({
			submitHandler: function(form) {
				$(form).ajaxSubmit({
					target: "#result",
					clearForm: true
				});
			}
		});
		
});	
$('#form #message').val('');

//Subscribe form
$(function() {
		var v = $("#subform").validate({
			submitHandler: function(form) {
				$(form).ajaxSubmit({
					target: "#result_sub",
					clearForm: true
				});
			}
		});
		
});	
$('#subform #email').val('');

//Fancybox for image gallery
$("a[rel=next]").fancybox({
		'opacity'		: true,
		'overlayShow'	       : true,
		'overlayColor': '#000000',
		'overlayOpacity'     : 0.9,
		'titleShow':true,
		'transitionIn'	: 'elastic',
		'transitionOut'	: 'elastic'
});

//Gallery - On Hover Event 
	$('ul.gallery li a').mouseenter(function(e) {
            $(this).children('img').animate(300);
            $(this).children('span').fadeIn(400);
        }).mouseleave(function(e) {
            $(this).children('img').animate(300);
            $(this).children('span').fadeOut(400);
});

//Tipsy plugin
$('.tipsy_hover').tipsy({fade: true, gravity: 's'});

}); // close document.ready

