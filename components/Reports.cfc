<cfcomponent>

    <cffunction  name="displaySR">
        <cfargument  name="query">
        <cfloop query="arguments.query">
            <cfset fk_orderId = encodeForHTML(fk_orderId)> 
            <cfset productName = encodeForHTML(productName)>                          
            <cfset colorName = encodeForHTML(colorName)>                             
            <cfset BrandName = encodeForHTML(BrandName)>                           
            <cfset buyerName = encodeForHTML(buyerName)>                            
            <cfset orderDate = encodeForHTML(orderDate)>                             
            <cfset productCount = encodeForHTML(productCount)>                           
            <cfset quantity = encodeForHTML(quantity)>                             
            <cfset amount = encodeForHTML(amount)>  
            <cfset UserName = encodeForHTML(UserName)>                             
            <cfset emailId = encodeForHTML(emailId)>                           
            <cfset phoneNumber = encodeForHTML(phoneNumber)>                                                       
        </cfloop>
        <cfreturn arguments.query>
    </cffunction>

    <cffunction  name="displayIR">
        <cfargument  name="query">
        <cfloop query="arguments.query">
            <cfset productName = encodeForHTML(productName)>                          
            <cfset colorName = encodeForHTML(colorName)>                             
            <cfset BrandName = encodeForHTML(BrandName)>                                                       
            <cfset productCount = encodeForHTML(productCount)>                           
            <cfset productPrice = encodeForHTML(productPrice)>  
            <cfset UserName = encodeForHTML(UserName)>                             
            <cfset emailId = encodeForHTML(emailId)>                           
            <cfset phoneNumber = encodeForHTML(phoneNumber)>                                               
        </cfloop>
        <cfreturn arguments.query>
    </cffunction>
    
    <cffunction  name="reports" access="remote"> 
        <cfif form.startDate EQ "" > 
            <cfset session.error = "Please select a start Date">
            <cflocation  url="../reportSection.cfm">
        </cfif>
        <cfif  form.startDate GT now() or form.endDate GT now()> 
            <cfset session.error = "Date should not greater than Today">
            <cflocation  url="../reportSection.cfm">
        </cfif>
        <cfif !(structKeyExists(form, "color") && structKeyExists(form, "product") && structKeyExists(form, "brand"))>
            <cfset session.error = "Please Select The required Fields">
            <cflocation  url="../reportSection.cfm">
        </cfif>
        <cfif form.enddate EQ "">
            <cfset local.endDate = dateFormat(now(), "yyyy-mm-dd")>
        <cfelse>
            <cfset local.endDate = form.endDate>
        </cfif>
        <cfset local.dateNew = now()>
        <cfset local.currentYear = year(local.dateNew)>
        <cfset local.startDate   = dateTimeFormat(form.startDate,"yyyy-mm-dd HH:nn:ss")>
        <cfset local.monthEnd = daysInMonth(local.startDate)>
        <cfset local.endDate = dateTimeFormat( local.endDate ,"yyyy-mm-dd HH:nn:ss")>
        <cfstoredproc  procedure="MonthlysalesReport">  
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#local.startDate#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#local.endDate#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.brand#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.product#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.color#">
            <cfprocresult  name="monthlysalesReport">
        </cfstoredproc>

        <cfstoredproc  procedure="monthlyInventoryReport">  
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#local.startDate#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#local.endDate#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uid#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.brand#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.product#">
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#form.color#">
            <cfprocresult  name="monthlyInventoryReport">
        </cfstoredproc>
   
        <cfset local.monthlysalesReport = displaySR(monthlysalesReport)>
        <cfset local.currentDate = dateFormat(now(),"yyyy-mm-dd")>
        <cfset local.totalSales = 0>
        <cfset local.totalUnits = 0>
        <cfset local.index = 0>
        <cfif form.reportType EQ "salesReport">
            <cfif monthlysalesReport.recordCount LT 1>
                <cfset session.error = "No sales During that period">
                <cflocation  url="../reportSection.cfm" addtoken="no">
            </cfif>
        </cfif>
        <cfif form.reportType EQ "inventoryReport">
            <cfif monthlyInventoryReport.recordCount LT 1>
                <cfset session.error = "Empty Records ">
                <cflocation  url="../reportSection.cfm" addtoken="no">
            </cfif>
        </cfif>

        <cfoutput>
            <cfif structKeyExists(form, "pdf") && form.reportType EQ "salesReport">
                <div class="container">                
                    <cfdocument format="PDF" orientation = "landscape" pagetype="B4"  filename="salesReport.pdf" overwrite="Yes">
                        <div class="head">
                            <h3>Monthly Sales Report</h3>
                            <p>This is an monthly sales report from #form.startDate# to #local.endDate#</p>
                        </div>
                        <div class="SellerDetails">
                            <h4>#monthlysalesReport.UserName#</h4>
                            <h4>#monthlysalesReport.emailId#</h4>
                            <h4>#monthlysalesReport.phoneNumber#</h4>
                            <h4>#local.currentDate#</h4>
                        </div>
                        <table class="table" style="border:1px solid black;">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col" style="border:1px solid black;">Order ID</th>
                                    <th scope="col" style="border:1px solid black;">Product Name</th>
                                    <th scope="col" style="border:1px solid black;">Product Varient</th>
                                    <th scope="col" style="border:1px solid black;">Company Name</th>
                                    <th scope="col" style="border:1px solid black;">Buyer Name</th>
                                    <th scope="col" style="border:1px solid black;">Ordered Date</th>
                                    <th scope="col" style="border:1px solid black;">Total Stock</th>
                                    <th scope="col" style="border:1px solid black;">Units Sold</th>
                                    <th scope="col" style="border:1px solid black;">Gross Sales</th>
                                </tr>
                            </thead>
                            <tbody>
                                <cfloop query="monthlysalesReport">           
                                    <tr>
                                        <th scope="col" style="border:1px solid black; width:150px">#fk_orderId#</th>
                                        <td style="border:1px solid black;">#productName#</td>
                                        <td style="border:1px solid black;">#colorName#</td>
                                        <td style="border:1px solid black;">#BrandName#</td>
                                        <td style="border:1px solid black;">#buyerName#</td>
                                        <td style="border:1px solid black;">#orderDate#</td>
                                        <td style="border:1px solid black;">#productCount#</td>
                                        <td style="border:1px solid black;">#quantity#</td>
                                        <td style="border:1px solid black;">#amount#</td>
                                    </tr>
                                    <cfset local.totalSales = local.totalsales + amount> 
                                    <cfset local.totalunits = local.totalunits + quantity> 
                                </cfloop>
                            </tbody>
                        </table> 
                        <h3 class="grossSales">Total Gross Sales : #local.totalSales#</h3>
                        <h3 class="unitsSold">Total Units Sold : #local.totalUnits#</h3>     
                    </cfdocument>
                    <cfheader name="Content-Disposition" value="attachment;filename=salesReport.pdf">
                    <cfcontent type="application/octet-stream" file="#expandPath('.')#\salesReport.pdf" deletefile="Yes">
                </div> 
            </cfif> 
            <cfif structKeyExists(form, "pdf") && form.reportType EQ "inventoryReport">
                <div class="container">
                    <cfdocument format="PDF" orientation = "landscape"  filename="inventoryReport.pdf" overwrite="Yes">
                        <div class="head">
                            <h3>Inventory  Report</h3>
                            <p>This is an monthly Inventory report from #local.startDate# to #local.endDate#</p>
                        </div>
                        <div class="SellerDetails">
                            <h4>#monthlyInventoryReport.UserName#</h4>
                            <h4>#monthlyInventoryReport.emailId#</h4>
                            <h4>#monthlyInventoryReport.phoneNumber#</h4>
                            <h4>#local.currentDate#</h4>
                        </div>
                        <table class="table" style="border:1px solid black;">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col" style="border:1px solid black;">Product ID</th>
                                    <th scope="col" style="border:1px solid black;">Product Name</th>
                                    <th scope="col" style="border:1px solid black;">Product Varient</th>
                                    <th scope="col" style="border:1px solid black;">Company Name</th>
                                    <th scope="col" style="border:1px solid black;">Quantity Left</th>
                                    <th scope="col" style="border:1px solid black;">Price Per Unit</th>
                                    <th scope="col" style="border:1px solid black;">Total Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <cfloop query="monthlyInventoryReport" group="productName">
                                    <tr>
                                        <cfset local.totalAmount = productCount * productPrice>
                                        <th scope="col" style="border:1px solid black;">#local.index#</th>
                                        <td style="border:1px solid black;">#productName#</td>
                                        <td style="border:1px solid black;">#colorName#</td>
                                        <td style="border:1px solid black;">#BrandName#</td>
                                        <td style="border:1px solid black;">#productCount#</td>
                                        <td style="border:1px solid black;">#productPrice#</td>
                                        <td style="border:1px solid black;">#local.totalAmount#</td>
                                        <cfset local.totalAmount = 0>
                                        <cfset local.index = local.index + 1>
                                    </tr>
                                </cfloop>  
                                <cfset local.index = 0>
                            </tbody>
                        </table> 
                    </cfdocument>
                    <cfheader name="Content-Disposition" value="attachment;filename=inventoryReport.pdf">
                    <cfcontent type="application/octet-stream" file="#expandPath('.')#\inventoryReport.pdf" deletefile="Yes">
                </div>   
            </cfif>
            <cfif structKeyExists(form, "excel") && form.reportType EQ "inventoryReport">
                <cfspreadsheet action="write" fileName=#expandPath( 'inventoryReport.xls' )# query="monthlyInventoryReport" overwrite=true >
                <cfheader name="Content-Disposition" value="attachment; filename=inventoryReport.xls">
                <cfcontent type="application/msword" file="#expandPath( 'inventoryReport.xls' )#" deletefile="yes">
            </cfif>
            <cfif structKeyExists(form, "excel") &&  form.reportType EQ "salesReport">
                <cfspreadsheet action="write" fileName=#expandPath( 'salesReport.xls' )# query="monthlysalesReport" overwrite=true >
                <cfheader name="Content-Disposition" value="attachment; filename=salesReport.xls">
                <cfcontent type="application/msword" file="#expandPath( 'salesReport.xls' )#" deletefile="yes">
            </cfif>   
            <cfif structKeyExists(form, "csv") && form.reportType EQ "inventoryReport">
                <cfset myfile = "#expandpath('../csvFiles/csvFile.csv')#">
                <cffile action="write" file="#myFile#" output="""ProductId"",""productName"",""productVarient"",""companyName"",""RemainingProducts"",,""ProductPrice""">
                <cfloop query="monthlyInventoryReport">
                    <cffile action="append" file="#myFile#" output="""#pk_productId#"",""#productName#"",""#color#"",""#brandName#"",""#productCount#"",""#productPrice#""">
                </cfloop> 
                <cflocation url="../csvFiles/csvFile.csv"addtoken="false"/>
            </cfif>
            <cfif structKeyExists(form, "csv") && form.reportType EQ "salesReport">
                <cfset myfile = "#expandpath('../csvFiles/csvFile.csv')#">
                <cffile action="write" file="#myFile#" output="""orderID"",""productName"",""productVarient"",""companyName"",""totalStock"",""unitsSold"",""grossSales""">
                <cfloop query="monthlysalesReport">
                    <cffile action="append" file="#myFile#" output="""#pk_orderDesp#"",""#productName#"",""#color#"",""#brandName#"",""#productCount#"",""#quantity#"",""#amount#""">
                </cfloop> 
                <cflocation url="../csvFiles/csvFile.csv"addtoken="false"/>
            </cfif>
        </cfoutput>
    </cffunction>

    <cffunction  name="getFilterItems">
        <cfstoredproc  procedure="getAllBrands">  
            <cfprocparam  cfsqltype="CF_SQL_VARCHAR" value="#session.uid#">
            <cfprocresult  name="getAllBrands">
        </cfstoredproc>
        <cfloop query="getAllBrands">
           <cfset productName = encodeForHTML(productName)>
           <cfset brandName = encodeForHTML(brandName)>
           <cfset colorName = encodeForHTML(colorName)>
           <cfset pk_productId = encodeForHTML(pk_productId)>
           <cfset pk_colorTableId = encodeForHTML(pk_colorTableId)>
           <cfset brandId = encodeForHTML(brandId)>
        </cfloop>
        <cfreturn getAllBrands>
    </cffunction>
 
<!--- <cffunction  name="getAllColors">
        <cfstoredproc  procedure="getAllColors"> 
            <cfprocresult  name="getAllColors">
        </cfstoredproc>
        <cfreturn getAllColors>
    </cffunction> --->

</cfcomponent>
