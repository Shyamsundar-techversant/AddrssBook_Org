<cfset variables.getContacts=application.dbObj.getContacts()>
<cfset session.allContacts=variables.getContacts>
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
		<section class="reg-page  no-print">
			<header class="header">
				<div class="container">
					<nav class="navigation">
						<div class="logo">
							<i class="fa-solid fa-address-book"></i>
							ADDRESS BOOK	
						</div>
						<div class="reg-buttons">
							<button class="btn sign-up">
								<a href="logIn.cfm?logOut=1">
									<i class="fa-solid fa-arrow-left"></i>LogOut
								</a>
							</button>
						</div>
					</nav>
				</div>			
			</header>
		</section>
		<section class="user-details">
			<div class="container">
				<div class="user-options  no-print">
					<div class="options">
						<button media="print" onclick="window.print();" >PRINT</button>
						<button onclick="window.location.href='pdf.cfm';">PDF</button>
						<button onclick="window.location.href='spreadSheet.cfm';">EXCEL</button>
					</div>
				</div>
			</div>
			<div class="container">
				
					<div class="users">
						<div class="create-profile">
							<div class="user-img-logo">
								<i class="fa-solid fa-user"></i>
							</div>
							<cfoutput><h4>#session.username#</h4></cfoutput>
							<button type="button" class="btn btn-primary user-creation" data-bs-toggle="modal" 
								data-bs-target="#staticBackdrop" id="create-cont">
 								 CREATE CONTACT
							</button>
						</div>
						<div class="user-profiles">
							<table class="table">
								<thead>
									<tr>	
										<th scope="col">Profile Photo</th>																<th scope="col">Name</th>
										<th scope="col">Email Id</th>
										<th scope="col">Phone Number</th>
										<th scope="col" class="no-print">VIEW</th>
										<th scope="col" class="no-print">EDIT</th>
										<th scope="col" class="no-print">DELETE</th>
									</tr>
								</thead>
								<tbody>
									<cfif structKeyExists(variables,"getContacts")>
										<cfoutput>
											<cfloop query="getContacts">
												<cfset encryptedId = encrypt(
																	getContacts.id, 																		application.encryptionKey, 																	"AES", 
																	"Hex"
																)
												>
												<tr>
		
													<td>
														<img src="./Uploads/#getContacts.IMAGEPATH#"  																alt="logo" width="30" height="30"
														>
													</td>
 													<td>#getContacts.firstName &getContacts.lastName#</td>
													<td>#getContacts.email#</td>
													<td>#getContacts.phone#</td>
													<td class="no-print">
														<button type="button" 
															class="btn btn-primary contact-view-btn" 
															data-bs-toggle="modal"
															data-bs-target="##viewContact"
															data-id="#encryptedId#"
														>
															VIEW
														</button>
													</td>
													<td class="no-print">
														
															<button class="edit-cont-details"
																data-bs-toggle="modal"
																data-bs-target="##staticBackdrop"
																data-id="#encryptedId#"
															>
																EDIT
															</button>
														
													</td>
													<td class="no-print">
														<button class="delete-contact-details"
															data-bs-toggle="modal"
															data-bs-target="##deleteContact"
															data-id="#encryptedId#"
														>
															Delete
														</button>
													</td>
												</tr>
											</cfloop>
										</cfoutput>
									</cfif>
								</tbody>
							</table>
						</div>
					</div>
				
			</div>
		</section>

		<!--- Modal ADD/EDIT --->
		<div	class="modal" 
			id="staticBackdrop" 
		>
			<div class="modal-dialog add-edit-contact">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">CREATE CONTACT</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div>
							<div class="container">			
									<form action="" method="post" enctype="multipart/form-data" id="contacts-form">
										<div class="row mb-3">
											<div class="col">
												<label for="title" class="form-label">Title</label>
												<cfset titleValues=application.dbObj.getTitle()>
												<select name="title" class="form-select" id="title">
													<option value="">Select</option>
													<cfoutput>
														<cfloop query="titleValues">
															<option value="#titleValues.id#">
																#titleValues.titles#
															</option>
														</cfloop>
													</cfoutput>
												</select>
											</div>
											<div class="col">
												<label for="firstname" class="form-label">Firstname : </label>
												<input type="text" class="form-control" id="firstname" name="firstname" 												required>
											</div>
											<div class="col">
												<label for="lastname" class="form-label">Lastname : </label>
												<input type="text" class="form-control" id="lastname" name="lastname" 												required>
											</div>
										</div>
										<div class="row mb-3">
											<div class="col">
												<label for="gender" class="form-label">Gender</label>
												<cfset genderValues=application.dbObj.getGender()>
												<select name="gender" class="form-select" id="gender">
													<option value="">Select</option>
													<cfoutput>
														<cfloop query="genderValues">
															<option value="#genderValues.id#">
																#genderValues.gender_values#
															</option>
														</cfloop>	
													</cfoutput>
												</select>
											</div>
											<div class="col">
												<label for="dob" class="form-label">Date Of Birth</label>
												<input type="date" class="form-control" id="dob" name="dob" required>
											</div>
										</div>
										<div class="row mb-3">
											<div class="col">
												<label for="upload-img" class="form-label">Upload Photo </label>
												<input type="file" class="form-control" id="upload-img" 													name="uploadImg" required>
											</div>
										</div>
										<div class="form-head">
											<h4>CONTACT DETAILS</h4>
										</div>
										<div class="row mb-3">
											<div class="col">
												<label for="email" class="form-label">Email</label>
												<input type="email" class="form-control" id="email" name="email" 												required>
											</div>
											<div class="col">
												<label for="phone" class="form-label">Phone</label>
												<input type="tel" class="form-control" id="phone" name="phone" required 												maxlength="10">
											</div>
										</div>
										<div class="row mb-3">
											<div class="col">
												<label for="address" class="form-label">Address</label>
												<textarea class="form-control" id="address" name="address" rows="4" 												cols="7" required>
												</textarea>
											</div>
										</div>
										<div class="row mb-3">
											<div class="col">
												<label for="street" class="form-label">Street</label>
												<input type="text" class="form-control" id="street" name="street" 												required>
											</div>
											<div class="col">
												<label for="pincode" class="form-label">Pincode</label>
												<input type="text" class="form-control" id="pincode" name="pincode" 												required>
											</div>
										</div>
										<div class="row mb-3">
											<div class="col">
												<label for="hobby" class="form-label">Hobbies</label>
												<cfset hobbyValues=application.dbObj.getHobbies()>
												<select name="hobby" class="form-select" id="hobby" multiple required>
													<cfoutput query="hobbyValues">
														<option value="#hobbyValues.id#">
															#hobbyValues.hobby_name#
														</option>
													</cfoutput>
												</select>
											</div>
										</div>
										<div class="row">
											<div class="col">
												<div class="user-form-buttons">
													<button class="edit-details user-btn"  																name="edit-user" id="edit-cont">
														Edit Contact
													</button>
													<button class="add-details user-btn" type="submit" 														name="submit" id="add-cont">
														Add Contact
													</button>
												</div>
											</div>
										</div>
										<div class="row">
											<ul id="error-data">

											</ul>
										</div>
									</form>
							</div>
						</div>						

					</div>
				</div>
			</div>
		</div>
		
		<!--- Modal view --->
		<div	class="modal" 
			id="viewContact" 
		>
			<div class="modal-dialog view-contact">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">CONTACT DETAILS</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body view-contact-body">
						<div>
							<div class="container">			
									<div class="profile-image">
										<img id="profile-picture">
									</div>
									Name:<span id="contact-name" class="cont-info"></span><br>
									Gender:<span id="contact-gender" class="cont-info"></span><br>
									DOB:<span id="contact-dob" class="cont-info"></span><br>
									ADDRESS:<span id="contact-address" class="cont-info"></span><br>
									PINCODE:<span id="contact-pincode" class="cont-info"></span><br>
									EMAIL-ID:<span id="contact-email" class="cont-info"></span><br>
									PHONE:<span id="contact-phone" class="cont-info"></span><br>
									HOBBIES:<span id="user-hobbies" class="cont-info"></span>
							</div>
						</div>						

					</div>
				</div>
			</div>
		</div>
		
		<!---Modal Delete--->
		<div	class="modal" 
			id="deleteContact"     		
		>
			<div class="modal-dialog delete-contact">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">DELETE CONTACT</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div>
							<div class="container">			
										<div class="row p-3">
											<div class="col">
												<div class="user-form-buttons">
													<button class="cancel-user-form user-btn" 
													data-bs-dismiss="modal" >
														Cancel
													</button>
													<button  class="delete-details user-btn"  																name="edit-user" id="delete-cont">
														Delete Contact
													</button>
												</div>
											</div>
										</div>
							</div>
						</div>						

					</div>
				</div>
			</div>
		</div>		



		<script src="./js/bootstrap.bundle.min.js"></script>
		<script src="./js/jquery-3.7.1.min.js"></script>
		<script src="./js/script.js"></script>
	</body>
</html>


