	<cfset variables.fileName="contactData.pdf">
	<cfheader name="Content-Disposition" value="attachment; filename=#variables.fileName#">
	<cfheader name="Content-Type" value="application/pdf">
	<cfset contactList=session.allContacts>
	<cfcontent type="application/pdf" reset="true">


	<cfdocument format="PDF" orientation="portrait">
		<h1 style="text-align: center;">Address Book</h1>
		<table border="1" cellpadding="5" cellspacing="0">	
			<thead>
				<tr>
					<th>Name</th>
					<th>Email</th>
					<th>Phone</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="contactList">
					<tr>
						<td>#contactList.FIRSTNAME# #contactList.LASTNAME#</td>
						<td>#contactList.email#</td>
						<td>#contactList.phone#</td>
					</tr>
				</cfoutput>
			</tbody>
		</table>
	</cfdocument>
