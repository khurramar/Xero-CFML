<!--- Example Endpoints from Xero
----------------------------------------------------------------------------
1) Hit some Xero endpoints and show the response
--->
<cfif NOT StructKeyExists(session, "stToken")>
	<cflocation url="index.cfm">
</cfif>

<html>
<head>
	<title>CFML Xero Public Application - Callback</title>
	<cfinclude template="/common/header.cfm" >
	<cfinclude template="config.cfm" >
</head>
<body>
	<cfinclude template="/common/resource.cfm">

	<cfset sRequestToken = session.stToken["oauth_token"]> <!--- returned after an access token call --->
	<cfset sRequestTokenSecret = session.stToken["oauth_token_secret"]> <!--- returned after an access token call --->
	<cfset sResourceEndpoint = "#sApiEndpoint##form.endpoint#">
	
	<cfset stParameters = structNew()>
	<cfif len(trim(form.isCustomer)) GT 0>
		<cfset stParameters.where = "(isCustomer=#form.isCustomer#)">
	</cfif>
	<cfif len(trim(form.page)) GT 0>
		<cfset stParameters.page = form.page>
	</cfif>
	
	
	<!--- Build and Call API, return new structure of XML results --->
	<cfset oRequestResult = CreateObject("component", "cfc.xero").requestData(
		sXeroAppType = sXeroAppType,
		sConsumerKey = sConsumerKey, 
		sConsumerSecret = sConsumerSecret,
		sResourceEndpoint = sResourceEndpoint,
		sRequestToken = sRequestToken,
		sRequestTokenSecret= sRequestTokenSecret,
		stParameters = stParameters)>

	<div class="container">
		<div class="row">
	  		<div class="col-md-6">
				<cfdump var="#oRequestResult#" >
	  		</div>
		</div>
	</div>

</body>
</html>

