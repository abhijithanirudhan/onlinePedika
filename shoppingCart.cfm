<!DOCTYPE html>
<cfset variables.storedProceduresObj = createObject("component","action/components/storedProcedures")>
<cfparam name="form.brand" default="">
<cfparam name="form.color" default="">
<cfparam name="form.colortableid" default="">
<cfparam name="form.product" default="">
<cfparam name="form.minimumPrice" default="">
<cfparam name="form.maximumPrice" default="">
<cfparam name="form.colorId" default="">
<cfparam name="variables.brandfilter" default="">
<cfset checkColor= arrayNew(1)>
<cfset variables.filterer=variables.storedProceduresObj.newfilter()>
<cfset variables.colorFilterArray=listToArray(form.color,",")>
<cfset variables.filteredQuery=variables.storedProceduresObj.filterFunction(form.brand,form.color,form.colortableid,form.product,minimumPrice,maximumPrice)> 
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>OnlinePeedika</title>
        <link rel="stylesheet" type="text/css" href="./css/listingPage.css">
        <link rel="icon"  href="./img/mainLogo.png">
        <script src="./js/index.js"></script>
    </head>
    <cfoutput>
        <body>
            <div class="header">
                <div class="header-left">
                    <img src="./img/mainLogo.png" alt="mainLogo">
                    <a href="./shoppingcart.cfm"><p>ONLINE PEEDIKA</p></a>
                </div>
                <div class="header-right">
                    <a href="cart.cfm"><img src="./img/cartLogo.png" alt="cartLogo"></a>
                    <form action="./action/components/storedProcedures.cfc?method=logout" method="post">
                        <input type="submit" name="logout" value="LOGOUT" class="logoutBtn">
                    </form>
                    <cfif session.privilege EQ "seller">
                        <div class="adminBoard">
                            <a href="./dashboard.cfm" class="set">ADMIN DASHBOARD</a>
                        </div>
                    </cfif>
                </div>
            </div>
            <div class="main-body flex">
                <div class="left-body ">
                    <div class="filter-column ">
                        <form method="post" action="">
                            <input type="button" class="filter-heading" value="Filters">            
                            <h5 class="filter-option">Brand</h5>
                            
                            <cfloop query="variables.filterer" group="pk_productid">
                                <div class="brand-options " id="brand-options">
                                    <cfif variables.brandfilter NEQ  fk_brandid>
                                        <input type="checkbox" value="#variables.filterer.fk_brandId#"  name="brand" <cfif listcontains(form.brand,fk_brandId) NEQ 0>Checked</cfif>>
                                        <label class="brandName">#brandname#</label>
                                        <cfset variables.brandfilter = "#fk_brandid#">
                                    </cfif>
                                </div>
                                
                                <div class="brandNameContainer">
                                    <input type="checkbox" value="#pk_productid#"   name="product" <cfif listcontains(form.product,variables.filterer.pk_productId) NEQ 0>Checked</cfif>>
                                    <label class="productName">#productname#</label>
                                </div>
                                <cfloop >
                                    <div class="brandColorContainer" id="brand-options-color">
                                        <input type="checkbox" value="#pk_colorid#" name="color" <cfif arraycontains(variables.colorFilterArray,pk_colorid)   NEQ 0>Checked</cfif>>
                                        <label class="colorName">#colorName#</label>
                                    </div>
                                </cfloop>
                            </cfloop>
                            <h5 class="filter-option">Price</h5>
                            <div class="priceRanges"  id="priceRanges">
                                <label for="cars" class="priceRange">Minimum price Rs</label>
                                <select class="priceRange" id="filterMinPrice1" name="minimumPrice">
                                    <cfif form.minimumPrice NEQ 'NULL'>
                                        <option value="#form.minimumPrice#">#form.minimumPrice# </option>
                                    </cfif>
                                    <option value="null">Select value </option>
                                    <option value="20000">20000 </option>
                                    <option value="25000">25000</option>
                                    <option value="30000">30000</option>
                                    <option value="35000">35000</option>
                                </select>
                            </div>
                            <div>
                                <label class="priceRange" for="filterPrice">Maximum price Rs</label>
                                <select class="priceRange"  id="filterMaxPrice2" name="maximumPrice">
                                    <cfif form.maximumPrice NEQ 'NULL'>
                                        <option value="#form.maximumPrice#">#form.maximumPrice# </option>
                                    </cfif>
                                    <option value="null">Select value </option>
                                    <option value="40000">40000 </option>
                                    <option value="55000">55000</option>
                                    <option value="70000">70000</option>
                                    <option value="105000">105000</option>
                                </select>
                            </div>
                            <h5 class="filter-option">COLOR</h5>
                            <cfloop query='filterer'>
                                <div class="brand-options" id="brand-options-color">
                                    <cfif !arrayContains(checkColor, colorName) >
                                        <cfset arrayAppend(checkColor,colorName)>
                                        <div class="form-check" id="cfilters">
                                            <input  type="checkbox" class="form-check-input" name="colortableid" <cfif listcontains(form.colortableid,#fk_colortableid#) NEQ 0>Checked</cfif> value="#fk_colortableid#" >
                                            <label class="form-check-label" for="flexCheckDefault">
                                                #colorName#
                                            </label>
                                        </div>
                                    </cfif>
                                </div>
                            </cfloop>
                            <input type="submit" name="filter" value="FILTER" class="filterButton">
                            <input type="submit" name="reset" value="RESET" class="filterButton">
                        </form>
                    </div>
                </div>
                <div class="block">
                    <cfloop query = "variables.filteredQuery" >
                        <div class="right-body">
                            <form method="post" action="./productpage.cfm">
                                <div class="right-bodyCol">
                                    <div class="productDetails flex">
                                        <div class="productImg">
                                            <img src="./photos/#variables.filteredQuery.imageLocation#.jpg" class="productImage" height=90px>
                                        </div>
                                        <div class="productDesc">
                                            <p class="productHead">
                                                #productName# #ram#GB #colorName# Color Version 
                                            </p>
                                            <div class="productDescription flex">
                                                <div class="flex productDescriptionSub">
                                                    <cfif rating NEQ '' >
                                                        <div>
                                                            <input type="button" value="#rating#" class="productRating">
                                                        </div>
                                                    </cfif>
                                                    <div class="productDescLineCol">
                                                        <p class="productDescLine">- Processor : #processor#</p>
                                                        <p class="productDescLine">- Display: #display#</p>
                                                        <p class="productDescLine">- RAM : #ram#</p>
                                                        <p class="productDescLine">- Battery #Battery#</p>
                                                        <p class="productDescLine">- #rearCamera#MP Rear Camera and #frontCamera#MP FrontCamera</p>
                                                        <input type="hidden" name="colorId" value=#pk_colorId#>
                                                    </div>
                                                </div>
                                                <div class="productPricing">
                                                    <p class="priceDet">Rs. #productPrice#</p>
                                                </div>
                                            </div>
                                            <input type="submit" name="view" value="view" class="viewButton">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </cfloop>
                </div>
            </div>
        </body>
    </cfoutput>
</html>
 
 