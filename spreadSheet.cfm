	<cfset variables.fileName="contactData.xlsx">
	<cfset spreadsheetObj = SpreadsheetNew("AddressBook", true)>
	<cfset myFormat=StructNew()>
	<cfset myFormat.bold="true">
	<cfset myFormat.alignV="center">
	<cfset data={color="white",fgcolor="grey_50_percent",alignV="center"}>
	<cfset dataHead={color="white",fgcolor="grey_50_percent",bold="true",alignV="center"}>
	<cfset contactList=session.allContacts>

	<cfset spreadsheetSetCellValue(spreadsheetObj, "TITLE", 1, 1)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "FIRSTNAME", 1, 2)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "LASTNAME", 1, 3)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "GENDER", 1, 4)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "DOB", 1, 5)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "EMAIL", 1, 6)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "PHONE", 1, 7)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "STREET",1,8)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "ADDRESS",1,9)>
	<cfset spreadsheetSetCellValue(spreadsheetObj, "PINCODE",1,10)>

	<cfset SpreadsheetFormatRow (spreadsheetObj, dataHead, 1)>	
		<cfoutput query="contactList">
			<cfset fullName = #contactList.FIRSTNAME#& " " &#contactList.LASTNAME#>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.TITLES#", currentRow+1, 1)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.FIRSTNAME#", currentRow+1, 2)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.LASTNAME#",currentRow+1, 3)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.GENDER_VALUES#", currentRow+1, 4)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.DOB#",currentRow+1, 5)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.EMAIL#", currentRow+1, 6)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.PHONE#", currentRow+1, 7)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.STREET#",currentRow+1, 8)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.ADDRESS#", currentRow+1, 9)>
			<cfset spreadsheetSetCellValue(spreadsheetObj, "#contactList.PINCODE#",currentRow+1, 10)>
			<cfset SpreadsheetSetRowHeight(spreadsheetObj,currentRow+1,20)>
		</cfoutput>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,1,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,2,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,3,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,4,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,5,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,6,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,7,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,8,35)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,9,25)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,10,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,11,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,12,20)>
	<cfset SpreadSheetSetColumnWidth(spreadsheetobj,13,20)>

	<cfset binary = SpreadsheetReadBinary(spreadsheetObj)>

	<cfheader name="Content-Disposition" value="attachment; filename=#variables.fileName#">
	<!--- Serve the file and delete it after download --->
	<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binary#" >
