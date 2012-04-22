<?php


$name=$_POST['name'];
$email=$_POST['email'];
$message=$_POST['message'];

$to='yourname@mail.com';

$headers = 'From: '.$name."\r\n" .
	'Reply-To: '.$email."\r\n" .
	'X-Mailer: PHP/' . phpversion();
$subject = 'Xcelense landing page mail';
$body='You have got a new message from the contact form on your website.'."\n\n";
$body.='Name: '.$name."\n";
$body.='Email: '.$email."\n";
$body.='Message: '."\n".$message."\n";
	
if(mail($to, $subject, $body, $headers)) {
	die('Message sent');
} else {
	die('Error: Mail failed');
}

?>