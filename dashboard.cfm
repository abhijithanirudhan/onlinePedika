<!DOCTYPE html>
<cfset obj = createObject("component","action/components/storedProcedures")>
<cfset variables.brands=obj.getFilterItems()> 
<cfset checkColor= arrayNew(1)>
<cfset filteredQuery=obj.pListView()> 
<cfset variables.colorFilterArray=listToArray(form.color,",")>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="./css/dashboard.css">
    <script src="./js/listingPage.js"></script>
</head>
<body>
    <div class="header">
        <div class="header-left">
            <img src="img/mainLogo.png" alt="mainLogo">
            <a href="./shoppingcart.cfm"><p>ONLINE PEEDIKA</p></a>
        </div>
        <div class="header-right">
            <form action="reportSection.cfm" method="post" autocomplete="off">
                <input type="submit" value="REPORTS" name="reports" class="reportButton">
            </form>
            <a href="cart.cfm"><img src="./img/cartLogo.png" alt="cartLogo"></a>
            <form action="./action/components/storedProcedures.cfc?method=logout" method="post">
                <input type="submit" name="logout" value="LOGOUT" class="logoutBtn">
            </form>
        </div>
    </div>
    <div class="main-body flex">
        <div class="left-body ">
            <div class="filter-column ">
                <form method="post" action="">
                    <input type="button" class="filter-heading" value="Filters">            
                    <p class="filter-option">Brand</p>
                    <div class="brand-options" id="brand-options">
                        <cfoutput>
                            <cfloop query="variables.brands" group="brandName">
                                <div class="form-check" id="bfilters">
                                    <input type="checkbox" class="form-check-input" name="brand" value="#brandId#" <cfif listcontains(form.brand,brandId) NEQ 0>Checked</cfif> id="#brandName#">
                                    <label class="form-check-label" for="flexCheckDefault">
                                        #brandName#
                                    </label><br>
                                </div>
                                <div class="variant">
                                    <cfloop group="productName">
                                        <div class="form-check"  id="pfilters">
                                            <input type="checkbox" class="form-check-input" name="product" value="#pk_productId#" <cfif listcontains(form.product,variables.brands.pk_productId) NEQ 0>Checked</cfif> id="#productName#">
                                            <label class="form-check-label" for="flexCheckDefault">
                                                #productName#
                                            </label><br>
                                        </div>
                                        <cfloop>
                                            <div class="brandColorContainer" id="brand-options-color">
                                                <input type="checkbox" value="#pk_colorid#" name="color" <cfif arraycontains(variables.colorFilterArray,pk_colorid)  NEQ 0>Checked</cfif>>
                                                <label class="colorName">#colorName#</label>
                                            </div>
                                        </cfloop>
                                    </cfloop>
                                </div>
                            </cfloop>
                            <div style="margin-top:25px">
                                <h5>Select All Products of color:</h5>
                                <cfloop query="brands" group="pk_colortableid">
                                    <cfif !arrayContains(checkColor, colorName) >
                                        <cfset arrayAppend(checkColor,colorName)>
                                        <div class="form-check" id="cfilters">
                                            <input  type="checkbox" class="form-check-input" name="allproducts" <cfif listcontains(form.allproducts,variables.brands.pk_colorTableId) NEQ 0>Checked</cfif> value="#pk_colorTableId#" id="#colorName#">
                                            <label class="form-check-label" for="flexCheckDefault">
                                                #colorName#
                                            </label>
                                        </div>
                                    </cfif>
                                </cfloop>
                            </div>
                            <cfset ArrayClear(checkColor)>
                        </cfoutput>
                    </div>
                    <cfoutput>
                        <p class="filter-option">Price</p>
                        <div class="priceRanges"  id="priceRanges">
                            <label for="filterMinPrice" class="priceRange">Minimum price Rs</label>
                            <select class="priceRange" id="filterMinPrice" name="minimumPrice">
                                <cfif form.minimumPrice NEQ 'NULL'>
                                    <option value="#form.minimumPrice#">#form.minimumPrice# </option>
                                </cfif>
                                <option value="null">Select value </option>
                                <option value="20000">20000 </option>
                                <option value="25000">25000</option>
                                <option value="30000">30000</option>
                                <option value="35000">35000</option>
                            </select>
                            <label class="priceRange" for="filterMaxPrice">Maximum price Rs</label>
                            <select class="priceRange"  id="filterMaxPrice" name="maximumPrice">
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
                    </cfoutput>
                    <input type="submit" name="filter" value="FILTER" class="filterButton">
                </form>
            </div>
        </div>
        <div class="block">
        <cfoutput query = "filteredQuery" >
            <div class="right-body">
                <form method="post" action=" ">
                    <div class="right-bodyCol">
                        <div class="productDetails flex">
                            <div class="productImg">
                                <img src="./photos/#filteredQuery.imageLocation#.jpg" class="productImage" height=90px>
                                
                            </div>
                            <div class="productDesc">
                                <p class="productHead">
                                    #productName# #ram#GB #colorName# Color Version 
                                </p>
                                <div class="productDescription flex">
                                    <div>
                                        <cfif filteredQuery.rating NEQ '' >
                                            <div>
                                                <input type="button" value="#filteredQuery.rating#" class="productRating">
                                            </div>
                                        </cfif>
                                    </div>
                                    <div class="productDescLineCol">
                                        <p class="productDescLine">- Processor : #processor#</p>
                                        <p class="productDescLine">- Display: #display#</p>
                                        <p class="productDescLine">- RAM : #ram#</p>
                                        <p class="productDescLine">- Battery #Battery#</p>
                                        <p class="productDescLine">- #rearCamera# Rear Camera and #frontCamera# FrontCamera</p>
                                        <input type="hidden" name="colorId" value=#pk_colorId#>
                                    </div>
                                    <div>
                                        <p class="priceDet">Rs: #productPrice#</p>
                                        <input type="button" id="#pk_colorId#" value="REMOVE" onclick="remove(this.id)">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </cfoutput>
    </div>
    <div class="remove-item" id="remove">
        <div class="remove">
            <form action="./action/components/storedProcedures.cfc?method=remove" method="post" autocomplete="off">
                <h5>Are you sure you want to remove this item?</h5>
                <input type="hidden" id="removeCId" name="removeCId">
                <input type="button" value="CANCEL" name="cancel" class="removeButton" onclick="closeRemove()">
                <input type="submit" value="REMOVE" name="remove" class="removeButton">
            </form>
        </div>
    </div>    
</body>

</html>


<script>
    function remove(deleteCID) {
        document.getElementById("remove").style.display = "block";
        document.getElementById("removeCId").value=deleteCID;
        document.getElementById("remove").focus();
    }
    function closeRemove() {
        document.getElementById("remove").style.display = "none";
    }
</script>
