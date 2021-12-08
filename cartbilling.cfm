<cfparam name="variables.total" default="0">
<cfparam name="variables.remainingcount" default="0">
<html>
    <head>
        <link rel="icon" href="./images/cartLogo.png">
        <title>OnlinePedika</title>
        <link rel="stylesheet" href="./styles/billing.css">       
    </head>
    <body>
        <cfoutput>
            <cfset variables.userObject = createObject("component", "components/billing")>  
            <cfset variables.usr = userObject.userdetails(session.uid)>        
            <div class="header">
                <div class="header_left">
                    <img src="./images/mainLogo.png">
                    <a href="./shoppingcart.cfm"><h3>ONLINE PEEDIKA</h3></a>
                </div>
            </div>    
            <div class="user_details">
                <div>
                    <h4>LOGIN</h4>
                    <div class="user_details_credentials">
                        <h6>#variables.usr.userName#</h6>
                        <p>#variables.usr.emailId#</p>
                    </div>            
                </div>        
            </div>   
            <form action="components/billing.cfc?method=orderSubmit" method="post">
                <!--- <form action="cartOrderAction.cfm" method="post">--->
                <div class="user_address">
                    <h4>DELIVERY ADDRESS</h4>     
                    <input type="hidden" name="current" value="#usr.userAddress#">       
                    <input type="radio" id="permanentAddress" name="address" value="noChange">
                    <label for="permanentAddress">#variables.usr.userAddress#</label><br>
                    <p>Add a new Address</p>
                    <input type="radio" id="currentAddress" name="address" value="addressChange">
                    <textarea name="newAddress"></textarea>                            
                </div>   
                <div class="user_order_summary">
                    <h4>ORDER SUMMARY</h4>
                    <cfset variables.orderID = CreateUUID()>  
                    <cfset variables.adding = userObject.insertOrderid(orderID, usr.pk_userId)>                
                    <cfloop from="1" to="#ArrayLen(session.cartId)#" index="i">
                        <cfset counter=userObject.statusSetter(session.cartId[i])>
                        <cfset product = userObject.selectorder(session.cartId[i])>                         
                        <table class="productTable">   
                            <tr>  
                                <div class="order_summary_product_list">                                            
                                    <td>#variables.product.brandName#</td>
                                    <td>  </td>
                                    <td>#variables.product.productName#</td>
                                    <td>  </td>
                                    <td>#variables.product.colorName#</td>
                                    <td>  </td>
                                    <td>RS #variables.product.amount#</td>
                                    <cfset variables.productCnt = variables.userObject.productCounter(product.colorId)> 
                                    <cfset variables.currentUserId=variables.product.fk_userId>
                                    <cfset variables.productamount=variables.product.quantity*variables.product.amount>
                                    <cfset variables.total=total+product.amount>
                                    <cfset variables.remainingcount=variables.productCnt.productCount-variables.product.quantity>  
                                    <cfif  variables.remainingcount LT 1>
                                        <cfset variables.remainingcount=0> 
                                        <cfset variables.colorCountt=variables.userObject.colorStatusSetter(product.colorId)>
                                    </cfif>                      
                                    <cfset variables.productCntUpdate = variables.userObject.productCounterUpdater(variables.product.colorId, variables.remainingcount)> 
                                    <cfset variables.products = userObject.insertCurrentOrder(variables.orderID, variables.product.pk_productId, variables.product.quantity, variables.product.colorId, variables.productamount)> 
                                </div>
                            </tr>
                        </table>              
                    </cfloop>    
                                    
                </div>    
                <input type="hidden" name="orderId" value="#orderID#">  
                <input type="hidden" name="grantTotal" value="#total#">  
                <input type="hidden" name="buyerId" value="#variables.currentUserId#">  
                <div class="user_order_payment_details">
                    <h4>PAYMENT OPTIONS</h4>            
                    <input type="radio" id="UPI" name="paymentOptions" value="UPI">
                    <label for="UPI">PhonePe/BHIM UPI</label><br>
                    <input type="radio" id="CARD" name="paymentOptions" value="CARD">
                    <label for="css">CREDIT CARD / DEBIT CARD / ATM CARD</label><br>
                    <input type="radio" id="EMI" name="paymentOptions" value="EMI">
                    <label for="javascript">EMI</label><br>
                    <input type="radio" id="ONLINE TRANSFER" name="paymentOptions" value="NET">
                    <label for="javascript">NET BANKING</label><br>
                    <input type="radio" id="COD" name="paymentOptions" value="COD">
                    <label for="javascript">CASH ON DELIVERY</label><br>       
                </div>  
                <input type="submit"  value="PLACE ORDER">
            </form>  
        </cfoutput>
    </body>
</html>
