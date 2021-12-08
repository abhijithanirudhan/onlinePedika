<cfcomponent>
  <cfset this.name  = "login">
  <cfset this.datasource = "shopping">
  <cfset this.sessionStorage  = true>
  <cfset this.sessionmanagement = true>
  <cfset this.sessionTimeout  = createTimeSpan( 0, 0, 30, 0 )>
  <cffunction name="onSessionStart" returnType="void">
      <cfset session.error = 0>
      <cfset session.login = 0>
      <cfset session.cartId =ArrayNew(1) > 
  </cffunction>
  <cfset this.loginPage = '/onlinepedika(ver.4.4)/login.cfm'>
  <cfset this.cartpage = './shoppingcart.cfm'>
  <cfset this.billingpage = '/onlinepedika(ver.4.4)/shoppingcart.cfm'>
  <cfset this.component1 = '/onlinepedika(ver.4.4)/action/components/storedProcedures.cfc'>
  <cfset this.component2 = '/onlinepedika(ver.4.4)/components/storedProcedures.cfc'>
  <cfset this.component3 = '/onlinepedika(ver.4.4)/components/billing.cfc'>

  <!---<cffunction name="onError" returnType="void" output="true">
    <cfargument name="exception" required="true">
    <cfargument name="eventname" type="string" required="true">
    We are so sorry. Something went wrong. We are working on it now.
    <form action="./login.cfm" method="post">
      <input type="SUBMIT" value="Go Back to the main page" style="curser:pointer">
    </form>
  
    <cflog file="myapperrorlog" text="#exception.message#">
  
    <cfsavecontent variable="errortext">
      <cfoutput>
        An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
        Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#<br />
      </cfoutput>
    </cfsavecontent>
  </cffunction>--->

  <cffunction name="onRequestStart"> 
		<cfargument name="targetPage" type="string"/>  
		<cfif not structKeyExists(session,'uid')>
      <cfif not ((targetPage eq this.loginPage) or (targetPage eq this.component1) or (targetPage eq this.cartpage) or (targetPage eq this.component2) or (targetPage eq this.component3))>
          <cflocation  url="#this.loginPage#" addtoken="no">
      </cfif>
		</cfif>
    <cfif structKeyExists(form,'reset')>
      <cfset structClear(form)>
    </cfif>
    </cffunction>
</cfcomponent>