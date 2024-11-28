<cfif structKeyExists(form,"submit")>


	 <cfset variables.validationResult =application.dbObj.validateForm(
							fullName=form.fullName,
							userEmail=form.userEmail,
							username=form.username,
							password=form.password,
							passwordConf=form.passwordConf
						)
	>


	 <cfif arrayLen(validationResult) EQ 0>
		<cfset variables.regUser=application.dbObj.registerUser(
								fullName=form.fullName,
								emailId=form.userEmail,
								userName=form.username,
								password=form.password							
							)
		>
	</cfif> 
	<cfif structKeyExists(variables,"regUser")>
		<cfdump var="#regUser#">
	</cfif>
</cfif>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Address Book</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<link href="./css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-							Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" 
		referrerpolicy="no-referrer"/>	
	</head>
	<body>
		<sectioin class="reg-page">
			<header class="header">
				<div class="container">
					<nav class="navigation">
						<div class="logo">
							<i class="fa-solid fa-address-book"></i>	
						</div>
						<div class="reg-buttons">
							<button class="btn sign-up"><i class="fa-solid fa-user"></i><a href="signup.cfm">SignUp</a></button>
							<button class="btn log-in"><i class="fa-solid fa-right-to-bracket"></i><a href="logIn.cfm">LogIn</a></button>
						</div>
					</nav>
				</div>			
			</header>
			<section class="form-section">
				<div class="container">
					<div class="user-registration">
						<div class="card">
							<div class="contact-form">
								<div class="contact-logo">
									<div class="contact-icon"><i class="fa-solid fa-address-book"></i></div>
								</div>
								<div class="reg-form pb-3">
									<form name="registration-form" action="" method="post" class="signIn-form" 												>
										<div class="form-head">
											<h2 id="formHead">SignUp</h2>
										</div>
										<div class="user-inputs mb-1">
											<input type="text" id="fullname" name="fullName" placeholder="Full Name" 
											class="form-control" required>			
										</div>
										<div class="user-inputs mb-1">
											<input type="email" id="email" name="userEmail" placeholder="Email" 
											class="form-control" required>			
										</div>
										<div class="user-inputs mb-1">
											<input type="text" id="username" name="username" placeholder="Username" 
											class="form-control" required>		
										</div>
										<div class="user-inputs mb-1">
											<input type="password" id="password" name="password"
											 	placeholder="Password" class="form-control" 
												required>				
										</div>
										<div class="user-inputs mb-1">
											<input type="password" id="conf-password" name="passwordConf"
											 placeholder="Confirm Password" class="form-control" 
											 required>		
										</div>
										<div class="user-inputs">
											<button type="submit" class="sign" id="signUp" name="submit">																SignUp
											</button>		
										</div>
										<cfif structKeyExists(variables,"validationResult") AND
										 arrayLen(validationResult) GT 0>
											<cfoutput>
												<cfloop array="#validationResult#" index="error">
													<span class="validation-error">#error#</span><br>
												</cfloop>
											</cfoutput>
										</cfif>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</section>

	</body>
</html>