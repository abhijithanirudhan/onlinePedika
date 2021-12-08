<cfcomponent>
    <cffunction  name="invoicedetails" access="public">
        <cfargument  name="invoiceid">
        <cfstoredproc  procedure="invoicetaker" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.invoiceid#">
            <cfprocresult name="invoicedetails">
        </cfstoredproc>
        <cfreturn invoicedetails >
    </cffunction>

    <cffunction  name="userdetails" access="public">
        <cfargument  name="userid">
        <cfstoredproc  procedure="userpincode" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.userid#">
            <cfprocresult name="userdetails">
        </cfstoredproc>
        <cfreturn userdetails >
    </cffunction>

    <cffunction  name="sellerdetails" access="public">
        <cfstoredproc  procedure="sellerpincode" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value=1>
            <cfprocresult name="sellerdetails">
        </cfstoredproc>
        <cfreturn userdetails >
    </cffunction>

    <cffunction  name="selectorder" access="public">
        <cfargument  name="id">
        <cfstoredproc  procedure="selectProduct" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#">
            <cfprocresult name="selectProduct">
        </cfstoredproc>
        <cfreturn selectProduct >
    </cffunction>

    <cffunction  name="makeOrder" access="public">
        <cfargument  name="orderId">
        <cfargument  name="address">
        <cfstoredproc  procedure="insertaddressandorder" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.orderId#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.userId#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.address#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.paymentOptions#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.amount#">        
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>

    <cffunction  name="insertOrder" access="public">
        <cfargument  name="curentOrderID">
        <cfstoredproc  procedure="insertorderdescription" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentOrderID#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.productId#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.quantity#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.colorId#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="10">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.amount#">        
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>

    <cffunction  name="insertOrderid" access="public">
        <cfargument  name="curentOrder">
        <cfargument  name="curentuserId">
        <cfstoredproc  procedure="cartInsertaddressandorder">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentOrder#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentuserId#">
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>

    <cffunction  name="statusSetter" access="public">
        <cfargument  name="cartidd">
        <cfstoredproc  procedure="CartstatusSetter">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.cartidd#">
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>

    <cffunction  name="colorStatusSetter" access="public">
        <cfargument  name="coloridd">
        <cfstoredproc  procedure="colordescriptionStatusSetter" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.coloridd#">
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>

    <cffunction  name="insertCurrentOrder" access="public">
        <cfargument  name="curentOrderID">
        <cfargument  name="curentproductID">
        <cfargument  name="curentQuantity">
        <cfargument  name="curentcolorID">
        <cfargument  name="curentamount">
        <cfstoredproc  procedure="insertorderdescription" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentOrderID#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentproductID#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentQuantity#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentcolorID#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="10">     
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentamount#">
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>

    <cffunction  name="insertaddress" access="public">
        <cfargument  name="curentaddress">
        <cfstoredproc  procedure="cartUpdateaddressandorder" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.orderId#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.curentaddress#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.paymentOptions#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.grantTotal#">
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>

    <cffunction  name="productCounter" access="public">
        <cfargument  name="colorIDD">
        <cfstoredproc  procedure="productCountTaker" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.colorIDD#">
            <cfprocresult name="productCounting">
        </cfstoredproc>
        <cfreturn productCounting >
    </cffunction>

    <cffunction  name="productCounterUpdater" access="public">
        <cfargument  name="colorIDdd">
        <cfargument  name="colorRemaining">
        <cfstoredproc  procedure="productCounterUpdate" >
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.colorIDdd#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#arguments.colorRemaining#">
        </cfstoredproc>
        <cfreturn "success" >
    </cffunction>
    
    <cffunction name = "orderSubmit" access="remote" >       
        
       <cfif form.address EQ "nochange">
            <cfset form.address=form.current>
            <cfelse>
            <cfset form.address=form.newAddress>
        </cfif>
        <cfset local.insert = insertaddress(form.address)>
        <cfset local.details = invoicedetails(form.orderId)>
        <cfset local.usrdetails = userdetails(form.buyerId)>
        <cfset local.total =0>
        <cfloop query="details">
            <cfset local.total = local.total+local.details.amount>
        </cfloop>
        <cfset local.dateOfOrder=dateFormat(Now(),"dd-mm-yyyy")>   
        <cfdocument name="myPDF" format="PDF"   filename="latest.pdf"  overwrite="Yes">
            <table style="padding:1px">
                <cfoutput>
                    Invoice ID:#orderID#
                    <tr>
                        <th >OrderDate</th>
                        <th>  </th>
                        <th>Sold By</th>
                        <th>  </th>
                        <th>User Address</th>
                        <th>  </th>
                        <th>Shipping Address</th>
                    </tr>
                    <tr>     
                        
                        <td>#local.dateOfOrder#</td>
                        <td>  </td>
                        <td>OnlinePedika</td>
                        <td>  </td>
                        <td>#local.usrdetails.userName#</td>
                        <td>  </td>
                        <td>#local.usrdetails.userName#</td>
                    </tr>
                    <tr>          
                        <td> </td>
                        <td>  </td>
                        <td>address</td>
                        <td>  </td>
                        <td>#local.usrdetails.userAddress#</td>
                        <td>  </td>
                        <td>#local.details.deliveryAddress#</td>
                    </tr>
                </cfoutput>
            </table>

            <table class="detailsTable" border="1">
                <tr class="tableHeading"  style="background-color:#08FF08" >
                    <th >ProductName</th>
                    <th >Color</th>
                    <th >DeliveryAddress</th>          
                    <th >PaymentMethod</th>
                    <th >taxRate</th>
                    <th >PaymentAmount</th>
                </tr>    
                <cfoutput query="details">
                    <tr>
                        <td class="nameCol">#local.details.productName#</td>
                        <td class="phoneCol">#local.details.colorName#</td>
                        <td class="phoneCol">#local.details.deliveryAddress#</td>
                        <td class="phoneCol">#local.details.paymentMethod#</td>
                        <td class="phoneCol">#local.details.taxRate#</td>
                        <td class="emailCol">#local.details.amount#</td>
                    </tr>
                </cfoutput>
            </table> 
            <cfoutput>
                Total amount= #local.total#
            </cfoutput>
        </cfdocument>
          <cfset myfile = "#expandpath('../reports/#local.dateOfOrder#-#form.orderId#.pdf')#">
          <cffile action = "copy" destination="#myfile#" source = "#expandpath('./latest.pdf')#" >
        <cfmail
            from="abhijithanirudhan10@gmail.com"
            to="#usrdetails.emailId#"
            subject="OrderPlaced">
            Your order has been placed succesfully and the mobile will reach you soon..

            Thank You😍!.....
            <cfmailparam file="../reports/#local.dateOfOrder#-#form.orderId#.pdf">
            (This is an auto-generated mail.)

        </cfmail>

        <cflocation  url="../orderplaced.cfm" addtoken="no">
    </cffunction>
</cfcomponent>