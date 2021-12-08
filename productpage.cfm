<cfset obj = createObject("component","action/components/storedProcedures")>
<cfparam name="form.quantity" default="1">
<cfparam name="session.uuid" default=null>
<cfparam name="form.colorId" default=null>
<cfset filteredQuery=obj.productPage(form.colorId)> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><cfoutput>#filteredQuery.PRODUCTNAME#</cfoutput></title>
        <link rel="icon"  href="./img/mainLogo.png">
        <link rel="stylesheet" type="text/css" href="./css/listingPage.css">
    </head>
    <body>
        <cfoutput>
            <div class="header">
                <div class="header-left">
                    <img src="./img/mainLogo.png" alt="mainLogo">
                    <a href="./shoppingcart.cfm"><p>ONLINE PEEDIKA</p></a>
                </div>
                <div class="header-right">
                    <img src="./img/cartLogo.png" alt="cartLogo">
                    <a href="./cart.cfm"><h6>CART</h6></a>
                    <form action="./action/components/storedProcedures.cfc?method=logout" method="post">
                        <input type="submit" name="logout" value="LOGOUT" class="logoutBtn">
                    </form>
                </div>
            </div>
            <form action = "./action/components/storedProcedures.cfc?method=productPageAction" method ="POST">
                <div class="main-body flex">
                    <div class="left-body ">
                        <cfloop query="filteredQuery" >
                            <div class="productImage">
                                <img src="./photos/#imageLocation#.jpg" height="100px">
                            </div>
                        </cfloop>
                    </div>
                    <div class="right-body">
                        <div class="right-bodyCol ">
                            <div class="productDetails flex">
                                <div class="productImg">
                                    <img src="./photos/#filteredQuery.imageLocation#.jpg" class="productImage" height=60px>
                                    <input type="hidden" name="imageId" value="#filteredQuery.imageLocation#">
                                </div>
                                <div class="productDesc">
                                    <p class="productHead">
                                        #filteredQuery.brandname# #filteredQuery.PRODUCTNAME# (#filteredQuery.colorName#,#filteredQuery.INTERNALSTORAGE# GB ) (#filteredQuery.RAM#GB RAM)
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
                                            <p class="productDescLine">- Processor : #filteredQuery.processor#</p>
                                            <p class="productDescLine">- Display: #filteredQuery.display#</p>
                                            <p class="productDescLine">- RAM : #filteredQuery.ram#</p>
                                            <p class="productDescLine">- Battery #filteredQuery.Battery#</p>
                                            <p class="productDescLine">- #filteredQuery.rearCamera# Rear Camera and #filteredQuery.frontCamera# FrontCamera</p>
                                        </div>
                                        <div>
                                            <p class="priceDet">₹#filteredQuery.PRODUCTPRICE#</p>
                                        </div>
                                    </div>
                                    <div class="offerDetails">
                                        <p class="offerDet">Bank Offer #filteredQuery.discountrate#% Unlimited Cashback on Flipkart Axis Bank Credit CardT&C</p> 
                                    </div>
                                </div>
                            </div>                   
                            <div class="quantityContainer">
                                <label for="quantity">Quantity</label>
                                <input type="number" name="quantity" value="1" max="#filteredQuery.productCount#"  min="1" class="quantity" >
                            </div>
                            <input type="hidden" name="colorId" value="#form.colorId#">
                            <input type="submit" name="buynow" value="BUY NOW" class="transactionButton transactionButtonclass">
                            <input type="submit" name="addtocart" value="ADD TO CART" class="transactionButton">
                        </div>
                    </div>
                </div>
            </form>
        </cfoutput>
    </body>
</html>