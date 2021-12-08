<cfparam  name="session.error" default="">
<cfset variables.Filter = createObject("component", "components/reports")>
<cfset variables.FilterResult = variables.Filter.getFilterItems()>
<cfset variables.colorCheck = arrayNew(1)>
<cfoutput>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="./css/style.css">
            <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet" >
            <script src="./bootstrap/js/bootstrap.bundle.min.js"></script>
            <title>Report Section</title>
        </head>
        <body>
            <div class="header">
                <div class="header-left">
                    <img src="img/mainLogo.png" alt="mainLogo">
                    <p>ONLINE PEEDIKA</p>
                </div>
                <div class="header-right">
                    <img src="img/cartLogo.png" alt="cartLogo">
                    <h6>CART</h6>
                    <a href="login.cfm"><h6>LOGOUT</h6></a>
                </div>
            </div>
            <div class="mainContainer">
                <div class="container">
                    <form action="components/reports.cfc" method="post">
                        <input type="Hidden" name="method" value="reports">
                        <h3>Report Section</h3>
                        <p class = "errorMsg">#session.error#</p>
                        <div class="form-outline datepicker" id="formOutine" data-mdb-inline="true">
                            <input type="date" name="startDate" class="form-control" id="exampleDatepicker2">
                            <label for="exampleDatepicker2" class="form-label">Start Date</label>
                        </div>
                        <div class="form-outline datepicker" id="formOutine" data-mdb-inline="true">
                            <input type="date" name="endDate" class="form-control" id="exampleDatepicker2">
                            <label for="exampleDatepicker2" class="form-label">End Date</label>
                        </div>                       
                        <cfloop query="variables.FilterResult" group="brandName">
                            <div class="form-check">
                                <input class="form-check-input" name="brand" value="#brandId#" type="checkbox"  id="#brandName#" checked>
                                <label class="form-check-label" for="flexCheckDefault">
                                    #uCase(brandName)#
                                </label>
                            </div>
                            <div class="flex">
                                <cfloop group="productName">
                                    <div class="form-check">
                                        <input class="form-check-input" name="product" value="#pk_productId#" type="checkbox"  id="#productName#" checked>
                                        <label class="form-check-label" for="flexCheckDefault">
                                            #uCase(productName)#
                                        </label>
                                    </div>
                                </cfloop>
                            </div>
                        </cfloop>
                        <div class="flex">
                            <div class="colorSelect">Select a Color:</div>
                            <cfloop query="FilterResult">
                                <cfif !arrayContains(variables.colorCheck, colorName)>
                                    <cfset arrayAppend(variables.colorCheck,colorName)>
                                    <div class="form-check" id="marginLeft">
                                        <input class="form-check-input" name="color" value="#pk_colorTableId#" type="checkbox"  id="#colorName#" checked>
                                        <label class="form-check-label" for="flexCheckDefault">
                                            #uCase(colorName)#
                                        </label>
                                    </div>
                                </cfif>
                            </cfloop>
                        </div>
                        <div class="form-check">
                            <input type="radio" class="form-check-input" id="radio1" name="reportType" value="salesReport" checked>Sales Report
                            <label class="form-check-label" for="radio1"></label>
                        </div>
                        <div class="form-check">
                            <input type="radio" class="form-check-input" id="radio2" name="reportType" value="inventoryReport">Inventory Report
                            <label class="form-check-label" for="radio2"></label>
                        </div>
                        <div class="form-check">
                            <input class="btn btn-primary" type="submit" name = "pdf" value="pdf">
                            <input class="btn btn-primary" type="submit" name = "excel" value="excel">
                            <input class="btn btn-primary" type="submit" name = "csv" value="csv">
                        </div>
                    </form>
                </div>
            </div>
            <div class="returnToPage">
                <a href="dashboard.cfm" class="returnLink">RETURN TO DASHBORAD</a>
            </div>
        </body>
    </html>
</cfoutput>
<cfset session.error = "">