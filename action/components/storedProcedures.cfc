<cfcomponent>
    <cffunction name = "filterFunction" access="public" returntype="query">
        <cfargument name="brand" > 
        <cfargument name="color" >
        <cfargument name="colorTableId" >
        <cfargument name="product" > 
        <cfargument name="minimumPrice" > 
        <cfargument name="maximumPrice" >  
        <cfstoredproc  procedure="filterResults">
            <cfset local.bNull = "NO">
            <cfset local.cNull = "NO">
            <cfset local.colorNull = "NO">
            <cfset local.pNull = "NO">
            <cfset local.minNull = "NO">
            <cfset local.maxNull = "NO">
            <cfif brand EQ  "" OR brand EQ "NULL">
                <cfset local.bNull="yes">
            </cfif>
            <cfif color EQ  "" OR color EQ "NULL">
                <cfset local.cNull="yes">
            </cfif>
            <cfif colorTableId EQ  "" OR colorTableId EQ "NULL">
                <cfset local.colorNull="yes">
            </cfif>
            <cfif product EQ  "" OR product EQ "NULL">
                <cfset local.pNull="yes">
            </cfif>
             <cfif minimumPrice EQ  "" OR minimumPrice EQ "NULL">
                <cfset local.minNull="yes">
            </cfif>
            <cfif maximumPrice EQ  "" OR maximumPrice EQ "NULL">
                <cfset local.maxNull="yes">
            </cfif>
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#brand#" null=#local.bNull#>
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#color#" null=#local.cNull#>
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#colorTableId#" null=#local.colorNull#>
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#product#" null=#local.pNull#>
            <cfprocparam  cfsqltype="CF_SQL_INTEGER"  value=#minimumPrice# null=#local.minNull#> 
            <cfprocparam  cfsqltype="CF_SQL_INTEGER" value=#maximumPrice# null=#local.maxNull#>
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

   <cffunction name = "productPage" access="public" returntype="query">
        <cfargument  name="colorId">
        <cfstoredproc  procedure="productPage">       
            <cfprocparam  cfsqltype="CF_SQL_INTEGER"  value=#colorId# >
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfset session.productId = result.pk_productId>
        <cfset session.amount = result.productprice>
        <cfset session.shippingCharge = result.shippingcharges>
        <cfreturn result>
    </cffunction>

    <cffunction name = "getAllBrands" access="public" returntype="query">    
        <cfstoredproc  procedure="getbrand()"> 
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

    <cffunction name = "getAllVariant" access="public" returntype="query"> 
        <cfargument  name="model">   
        <cfstoredproc  procedure="getBrandVariant(#model#)"> 
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

    <cffunction name = "getAllColors" access="public" returntype="query">    
        <cfstoredproc  procedure="getAllColors()"> 
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

    <cffunction name = "logout" access="remote">    
        <cfset structClear(session)>
        <cflocation url="../../login.cfm" addtoken="no">
    </cffunction>

    <cffunction name = "newfilter" access="public" returntype="query">    
        <cfstoredproc  procedure="newfilter()"> 
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

    <cffunction  name="loginCheck" access="remote">
        <cfstoredproc  procedure="loginAction">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value=#form.username#>
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value=#form.pwd#>
            <cfprocresult name="qloginResult">
        </cfstoredproc>
        <cfif qloginResult.recordcount GT 0>
            <cfset session.loginFlag=0>
            <cfset session.privilege=qloginResult.roles>
            <cfset session.uid = qloginResult.pk_userid>
            <cflocation url="../../shoppingCart.cfm" addToken="no">
        <cfelse>
            <cfset session.loginFlag=1>
            <cflocation url="../../login.cfm" addToken="no">
        </cfif>
    </cffunction>

    <cffunction name = "pListView" access="public" returntype="query"> 
        <cfstoredproc  procedure="pListFilter"  > 
            <cfset local.bNull = "NO">
            <cfset local.cNull = "NO">
            <cfset local.colNull = "NO">
            <cfset local.pNull = "NO">
            <cfset local.minNull = "NO">
            <cfset local.maxNull = "NO">
            <cfif !structKeyExists(form, "brand") OR form.brand EQ  "" OR form.brand EQ "NULL">
                <cfset local.bNull="yes">
                <cfset form.brand = "">
            </cfif>
            <cfif !structKeyExists(form, "color") OR form.color EQ  "" OR form.color EQ "NULL">
                <cfset local.cNull="yes">
                <cfset form.color = "">
            </cfif>
            <cfif !structKeyExists(form, "allproducts") OR form.allproducts EQ  "" OR form.allproducts EQ "NULL">
                <cfset local.colNull="yes">
                <cfset form.allproducts = "">
            <cfelse>

            </cfif>
            <cfif  !structKeyExists(form, "product") OR form.product EQ  "" OR form.product EQ "NULL" >
                <cfset local.pNull="yes">
                <cfset form.product = "">
            </cfif>
             <cfif !structKeyExists(form, "minimumPrice") OR form.minimumPrice EQ  "" OR form.minimumPrice EQ "NULL">
                <cfset local.minNull="yes">
                <cfset form.minimumPrice = "">
            </cfif>
            <cfif !structKeyExists(form, "maximumPrice") OR form.maximumPrice EQ  "" OR form.maximumPrice EQ "NULL">
                <cfset local.maxNull="yes">
                <cfset form.maximumPrice = "">
            </cfif>

         <cfprocparam  cfsqltype="CF_SQL_INTEGER"  value=#session.uid#>
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value=#form.brand# null="#local.bNull#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value=#form.color# null="#local.cNull#">
            <cfprocparam  cfsqltype="CF_SQL_INTEGER" value=#form.allproducts# null="#local.colNull#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value=#form.product# null="#local.pNull#">
            <cfprocparam  cfsqltype="CF_SQL_INTEGER"  value=#form.minimumPrice# null="#local.minNull#"> 
            <cfprocparam  cfsqltype="CF_SQL_INTEGER" value=#form.maximumPrice# null="#local.maxNull#">
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

    <cffunction  name="getFilterItems">
        <cfstoredproc  procedure="getAllBrands" datasource = "shopping">  
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uid#">
            <cfprocresult  name="getAllBrands">
        </cfstoredproc>
        <cfreturn getAllBrands>
    </cffunction>

    <cffunction name = "cart" access="public" returntype="query">
        <cfstoredproc  procedure="cartList">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uid#"> 
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

    <cffunction name = "cartAdd" access="public" >
        <cfstoredproc  procedure="cartAdd"> 
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.productid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.colorId#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.quantity#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.imageId#">
        </cfstoredproc>
        <cfreturn "Added">
    </cffunction>

    <cffunction name = "remove" access="remote">
        <cfargument name="uid">
        <cfstoredproc  procedure="prodDelete"  > 
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.removeCId#">
        </cfstoredproc>
        <cflocation url="../../dashboard.cfm" addToken="No">
        <cfreturn>
    </cffunction>

    <cffunction name = "productPageAction" access="remote" >
        <cfif structkeyExists(form,"addtocart")>
            <cfset filteredQuery=cartAdd()> 
            <cflocation url="../../cart.cfm" addToken="No">
        </cfif>

        <cfif structKeyExists(form, 'buynow')>
            <cfset session.uuid = createUUID()> 
            <cfset cartUpdater()>
            <cfset cartdetails=idtaker(session.uuid)>
            <cfset variables.idd= cartdetails.pk_cartId>
            <cfset session.cartId=[variables.idd]>
            <cflocation url = "../../cartbilling.cfm" addtoken="no">
        </cfif>
    </cffunction>

    

    <cffunction name = "cartUpdater" access="public">  
        <cfstoredproc  procedure="cartupdater"> 
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uuid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.productid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value=5>            
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.shippingCharge#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="cod">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.quantity#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.colorid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.amount#">
        </cfstoredproc>
        <cfreturn "success">
    </cffunction>
        
    <cffunction name = "idtaker" access="public">
        <cfargument  name="orderId">
        <cfstoredproc  procedure="selectCartId"> 
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.orderId#">
            <cfprocresult name="selectProduct">
        </cfstoredproc>
        <cfreturn selectProduct>
    </cffunction>

    <cffunction name = "cartIdFetcher" access="public" returntype="query">    
        <cfstoredproc  procedure="cartIdFetcher()"> 
            <cfprocresult  name="result">
        </cfstoredproc>
        <cfreturn result>
    </cffunction>

</cfcomponent>