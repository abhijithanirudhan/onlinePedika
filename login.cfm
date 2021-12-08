<cfparam name="session.loginFlag" default="">
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Login</title>
		<link rel="icon"  href="./img/mainLogo.png">
		<link rel="stylesheet" type="text/css" href="./css/login.css">
		<script src="./js/login.js"></script> 
	</head>
	<body id="body">
		<cfoutput>
			<div class="header" id="header">
				<div class="header-left">
					<img src="./img/mainLogo.png" alt="mainLogo">
					<p>ONLINE PEEDIKA</p>
				</div>
			</div>
			<div class="box">
				<div class="box-left">
					<img src="./img/mainLogo.png" alt="mainLogo">
					<p>ONLINE PEEDIKA</p>
				</div>
				<div class="box-right">
					<form action="./action/components/storedProcedures.cfc?method=loginCheck" method="post" autocomplete="off" id="myform">
						<h3>LOGIN</h3>
						<input type="text" placeholder="Username" id="username" name="username">
						<input type="password" placeholder="Password" id="pwd" name="pwd">
						<div class="button">
							<input type="submit" value="LOGIN" id="subButton" name="submit" onclick="loginClick()">
							<div id="loader"></div>
						</div>
						<div id="pageloader">
							<img src="./img/tea.gif" alt="processing..." />
						 </div>
					</form>					
					<cfif session.loginFlag EQ 1>
						<div class="error">
							<p>Incorrect username and password!</p>
						</div>
					</cfif>
				</div>
			</div>
		</cfoutput>
	</body>
<html>
