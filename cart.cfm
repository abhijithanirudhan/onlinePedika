<cfset dashObj = createObject("component","action/components/storedProcedures")>
<cfset filteredQuery=dashObj.cart(session.uid)> 
<cfset session.cartId = arrayNew(1)>
<cfset variables.totalPrice = 0>
<cfset variables.totalshippingCharge = 0>
<cfset  variables.totalDiscount = 0>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Online Pedika</title>
		<link rel="icon" href="img/mainLogo.png">
		<link rel="stylesheet" type="text/css" href="css/cart.css">
		<script src="js/cart.js"></script>
	</head>
	<body>
        <cfoutput>   
			<div class="header">
                <div class="header_left">
                    <img src="img/mainLogo.png">
                    <a href="./shoppingcart.cfm"><h3>ONLINE PEEDIKA</h3></a>
                </div>
                
                <div class="header_right">
                    <img src="img/cartLogo.png">
                    <form action="./action/components/storedProcedures.cfc?method=logout" method="post">
                        <input type="submit" name="logout" value="LOGOUT" class="logoutBtn">
                    </form>
                </div>
            </div>
            <div class="details">
                <div class="cartList">
                    <cfloop query = "filteredQuery" >
                        <div class="right-body">
                            <form method="post" action=" ">
                            <cfset arrayAppend(session.cartId,pk_cartId)>
                                <div class="right-bodyCol">
                                    <div class="productDetails flex">
                                        <div class="productImg">
                                            <img src="./photos/#filteredQuery.imageLocation#.jpg" class="productImage" height=90px>
                                        </div>
                                        <div class="productDesc">
                                            <p class="productHead">
                                                #productName# #colorName# Color Version 
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
                                                    <p class="productDescLine">- Quantity:#Quantity# </p>
                                                    <p class="productDescLine">- Price : ₹#productPrice#</p>
                                                    <p class="productDescLine">- Discount :#discountrate#%</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <cfset variables.totalPrice = variables.totalPrice + (productPrice*quantity)>
                        <cfset variables.totalshippingCharge = variables.totalshippingCharge + (shippingCharges)>
                        <cfset variables.totalDiscount = variables.totalDiscount + ((productPrice* (specialDiscounts/100)) +  ((productPrice* (discountrate/100))*quantity))>
                    </cfloop>
                    <cfset variables.currentPrice = variables.totalPrice - variables.totalDiscount + variables.totalshippingCharge>
				</div>
                <div class="priceDetails">
                    <div class="Price">
                        <h2>PRICE DETAILS</h2>
                        <div class="P1">
                            <h4>Total MRP</h4>
                            <div class="P1_P">
                                <h6>₹ #variables.totalPrice#</h6>
                            </div>
                        </div>
                        <div class="P2">
                            <h4>Discount on MRP</h4>
                            <div class="P2_P">
                                <h6>₹ #variables.totalDiscount#</h6>
                            </div>
                        </div>
                        <div class="P3">
                            <h4>Shipping Charges</h4>
                            <div class="P3_P">
                                <h6>₹ #variables.totalshippingCharge#</h6>
                            </div>
                        </div>
                    </div>
        
                    <div class="Total-P">
                        <h3>Total Amount</h3>
                        <div class="TP_P">
                            <h3>₹ #variables.currentPrice#</h3>
                        </div>
                    </div>
                    <form action="cartbilling.cfm" method="post" autocomplete="off">
                        <input type="submit"  name="buynow" value="BUY NOW" class="buyButton">
                    </form>
                </div>
			</div>
        </cfoutput>
    </body>
</html>        



       