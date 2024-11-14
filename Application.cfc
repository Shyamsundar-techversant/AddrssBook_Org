<cfcomponent>
	<cfset this.name="Address book">
	<cfset this.sessionManagement="true">
	<cfset this.sessionTimeOut=createTimespan(0,0,30,0)>
	<cffunction name="onApplicationStart" returntype="void">
		<cfset application.encryptionKey = generateSecretKey("AES")>
		<cfset application.imageSavePath="C:\ColdFusion2021\cfusion\wwwroot\CF_Tasks\Address_Book_1\Uploads">
		<cfset application.dbObj=createObject("component","Components.main")>
	</cffunction>	
	<cffunction name="onRequestStart" returnType="void">
		<cfargument name="requestname" required="true">
		<cfif structKeyExists(url,"reload") AND url.reload EQ 1>
            		<cfset onApplicationStart()>
        	</cfif>
		<cfset local.pages = ["signup.cfm","logIn.cfm"]>
        	<cfif 
			NOT structKeyExists(session,"username") 
			AND NOT structKeyExists(session,"userId") 
			AND NOT arrayFindNoCase(local.pages, ListLast(CGI.SCRIPT_NAME,'/'))
		>
		    <cflocation url="login.cfm" addToken="no">
	    	</cfif>
	</cffunction>
</cfcomponent>
