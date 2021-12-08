<html>
    <link rel="icon" href="./images/cartLogo.png">
    <title>Order Placed</title>
    <link rel="stylesheet" href="./styles/billing.css">       
    <body>
        <div class="header">
            <div class="header_left">
                <img src="./images/mainLogo.png">
                <a href="./shoppingcart.cfm"><h3>ONLINE PEEDIKA</h3></a>
            </div>        
            <div class="header_right">
                <img src="./images/cartLogo.png">
                <a href="./cart.cfm"><h3>Cart</h3></a>
            </div>
        </div>
        <div class="orderplaced">
            <img  src="./images/orderplaced.jpg">
        </div>        
        <cfset ArrayClear(session.cartId)>
    </body>
</html>