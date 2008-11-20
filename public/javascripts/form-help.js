/*
This file was originally taken from http://pownce.com/js/register.js
Written by Leah Culver, April 2007

The code has been modified for my purposes.
*/

// Show help messages in forms
function showHelp(message) {
    $(message).style.display="block";
}

// hide help messages in forms
function hideHelp(message) {
    $(message).style.display="none";
}

function loadFormHelp() {
	// Show help message actions
    Event.observe('user_email', 'focus', function(e){ showHelp('help_email') });
	Event.observe('user_login', 'focus', function(e){ showHelp('help_login') });
	Event.observe('user_password', 'focus', function(e){ showHelp('help_password') });
	Event.observe('user_password_confirmation', 'focus', function(e){ showHelp('help_password_confirmation') });
	Event.observe('user_password_confirmation', 'focus', function(e){ showHelp('help_password_confirmation') });
	
	Event.observe('business_tag_list', 'focus', function(e){ showHelp('help_tag_list') });

    // Hide help message actions
    Event.observe('user_email', 'blur', function(e){ hideHelp('help_email')  });
	Event.observe('user_login', 'blur', function(e){ hideHelp('help_login') });
	Event.observe('user_password', 'blur', function(e){ hideHelp('help_password') });
	Event.observe('user_password_confirmation', 'blur', function(e){ hideHelp('help_password_confirmation') });
	
	Event.observe('business_tag_list', 'blur', function(e){ hideHelp('help_tag_list') });
}