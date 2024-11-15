$(document).ready(function(){
	if(window.history.replaceState){
		window.history.replaceState(null,null,window.location.href);
	}
	let contactId;
	let	contTitle=$('#title'),
		contFirstname=$('#firstname'),
		contLastname=$('#lastname'),
		contGender=$('#gender'),
		contDob=$('#dob'),
		contImg=$('#upload-img'),
		contEmail=$('#email'),
		contPhone=$('#phone'),
		contAddress=$('#address'),
		contPincode=$('#pincode'),
		contStreet=$('#street'),
		contHobby=$('#hobby');
		
	let publicContact=document.getElementById('publicUser');
	


	let	fullName=$('#contact-name'),
		gender=$('#contact-gender'),
		dob=$('#contact-dob'),
		address=$('#contact-address'),
		pincode=$('#contact-pincode'),
		email=$('#contact-email'),
		phone=$('#contact-phone');
	
	//ADD
	$('#create-cont').on('click',function(){
		$('#contacts-form').trigger('reset');
		$('#add-cont').show();
		$('#edit-cont').hide();	
		if($("#error-data li").length > 0){
			$('#error-data li').remove();
		}
	});
	
	$('#add-cont').on('click',function(event){
		event.preventDefault();
		var fileInput = $('#upload-img')[0];
		var file=fileInput.files[0];
		let publicData=publicContact.checked? 1:0 ; 

		let formData = new FormData();
		formData.append('title', contTitle.val());
		formData.append('firstname', contFirstname.val());
		formData.append('lastname', contLastname.val());
		formData.append('gender', contGender.val());
		formData.append('dob', contDob.val());
		formData.append('file', file);
		formData.append('email', contEmail.val());
		formData.append('phone', contPhone.val());
		formData.append('address', contAddress.val());
		formData.append('street', contStreet.val());
		formData.append('pincode', contPincode.val());
		formData.append('hobbies',contHobby.val());
		formData.append('public',publicData);
		
		$.ajax({
			url:'Components/main.cfc?method=validateFormAndCreateOrUpdateUser',
			type:'POST',
			data:formData,
			processData:false,
			contentType:false,
			success:function(response){
				console.log(response);
				let data = JSON.parse(response);
				console.log(data);	
				if(data.length === 0){
					$('#contacts-form').closest('.modal').modal('hide');
					location.reload();
				}
				else{
					addError(data);
				}
				
			},
			error:function(){
				console.log("Request Failed");
			}
		});
	});
	
	//Error Data

	function addError(data){
		const errorList = document.getElementById("error-data");
		errorList.innerHTML="";
		
		data.forEach((msg)=>{
			let li= document.createElement('li');
			li.textContent=msg;
			errorList.appendChild(li);
		});

	}

	//VIEW
		
    	$('.contact-view-btn').on('click', function() {
		// Get the contact ID from data-id attribute
		contactId = $(this).data('id');
		$.ajax({
			url:'Components/main.cfc?method=getDataById',
			type:'POST',
			data:{
				id:contactId
			},
			success:function(response){
				const data=JSON.parse(response);
				console.log(data);
				const hobbies=	data.DATA.map(row=>row[data.COLUMNS.indexOf("HOBBY_NAME")]);
				console.log(hobbies);
				const dataRow = data.DATA[0];
				$('#profile-picture').attr('src',`./Uploads/${dataRow[7]}`);
				fullName.text(`${dataRow[13]}${dataRow[3]}${dataRow[4]}`);
				gender.text(`${dataRow[14]}`);
				dob.text(`${dataRow[6]}`);
				address.text(`${dataRow[8]}`);
				pincode.text(`${dataRow[10]}`);
				email.text(`${dataRow[11]}`);
				phone.text(`${dataRow[12]}`);	
				$('#user-hobbies').text(hobbies.join(","));	
			},
			error:function(){
				console.log("Request Failed");
			}
		});
	});

	//EDIT
	$('.edit-cont-details').on('click',function(){
		document.getElementById('add-cont').style.display="none";
		document.getElementById('edit-cont').style.display="block";
		if($("#error-data li").length > 0){
			$('#error-data li').remove();
		}
		contactId=$(this).data('id');	
		$.ajax({
			url:'Components/main.cfc?method=getDataById',
			type:'POST',
			data:{
				id:contactId
			},
			success:function(response){
				const data= JSON.parse(response);
				console.log(data);
				const contactData=data.DATA[0];

				let public = contactData[data.COLUMNS.indexOf("PUBLIC")];
				if(public){
					publicContact.checked=true;
				}
				else{
					publicContact.checked=false;
				}
				const hobbies=	data.DATA.map(row=>row[data.COLUMNS.indexOf("HOBBY_ID")]);
				contTitle.val(contactData[data.COLUMNS.indexOf("TITLEID")]);
				contFirstname.val(contactData[data.COLUMNS.indexOf("FIRSTNAME")]);
				contLastname.val(contactData[data.COLUMNS.indexOf("LASTNAME")]);
				contGender.val(contactData[data.COLUMNS.indexOf("GENDERID")]);
				contDob.val(contactData[data.COLUMNS.indexOf("DOB")]);
				contEmail.val(contactData[data.COLUMNS.indexOf("EMAIL")]);
				contPhone.val(contactData[data.COLUMNS.indexOf("PHONE")]);
				contAddress.val(contactData[data.COLUMNS.indexOf("ADDRESS")]);
				contPincode.val(contactData[data.COLUMNS.indexOf("PINCODE")]);
				contStreet.val(contactData[data.COLUMNS.indexOf("STREET")]);			
				contHobby.val(hobbies[0].split(","));	
			},
			error:function(){
				console.log("Request Failed");
			}
		});

	});

	$('#edit-cont').on('click',function(event){	
		event.preventDefault();
		var fileInput = $('#upload-img')[0];
		var file=fileInput.files[0];

		if(file){
			let formData = new FormData();
			let publicData=publicContact.checked? 1:0 ;
			formData.append('title', contTitle.val());
			formData.append('firstname', contFirstname.val());
			formData.append('lastname', contLastname.val());
			formData.append('gender', contGender.val());
			formData.append('dob', contDob.val());
			formData.append('file', file);
			formData.append('email', contEmail.val());
			formData.append('phone', contPhone.val());
			formData.append('address', contAddress.val());
			formData.append('street', contStreet.val());
			formData.append('pincode', contPincode.val());
			formData.append('hobbies',contHobby.val());
			formData.append('id',contactId);
			formData.append('public',publicData);
			console.log(formData);
			$.ajax({
				url:'Components/main.cfc?method=validateFormAndCreateOrUpdateUser',
				type:'POST',
				data:formData,
				processData:false,
				contentType:false,
				success:function(response){
					let data = JSON.parse(response);
					console.log(data);	
					if(data.length === 0){
						$('#contacts-form').closest('.modal').modal('hide');
						location.reload();
					}
					else{
						addError(data);
					}
					
				},
				error:function(){
					console.log("Request Failed");
				}
			});
		}
		else{
			const errorList = document.getElementById("error-data");
			errorList.innerHTML="";
			let li= document.createElement('li');
			li.textContent="Photo is required";
			errorList.appendChild(li);
		}

	});

	//DELETE CONTACT
    	$('.delete-contact-details').on('click', function() {		
		// Get the contact ID from data-id attribute
		contactId = $(this).data('id');
		$('.modal-backdrop').show();
	});
	$('#delete-cont').on('click',function(){
		$.ajax({
			url:'Components/main.cfc?method=deleteCont',
			type:'POST',
			data:{
				id:contactId
			},
			success:function(response){
				let data=JSON.parse(response);
				if( data === "Success"){					
					$('button.delete-contact-details[data-id="' + contactId + '"]').closest('tr').remove();
					alert("contact deleted successfully");
					
				}
				else{
					console.log("error;;");
				}
				
			},
			error:function(){
				console.log("Request failed");
			}
		});
		
		$('#deleteContact').hide();
		$('.modal-backdrop').hide();

	});	
});

