<%@page import="cn.test.connection.DbCon"%>
<%@page import="cn.test.models.dao.ProductDao"%>
<%@page import="cn.test.models.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
    ProductDao pDao = new ProductDao(DbCon.getConnection());
    cartProduct = pDao.getCartProducts(cart_list);
    double total = pDao.getTotalCartPrice(cart_list);
    request.setAttribute("total", total);
    request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>webTech</title>
   <style>
        .full-width {
            width: 100vw; /* 100% of viewport width */
            max-width: 100%; /* Ensure the width doesn't exceed the viewport */
            margin-left: calc(-50vw + 50%);
            margin-right: calc(-40vw + 40%);
            /* Center the element using negative margins and calc */
            /* You can adjust the height as needed */
            height: 550px;
            /* Other styles */
            /* Add any other styles you need */
            margin-left: 0;
            margin-right: 0;
        }
        /* Additional styling for the image */
        .full-width img {
            width: 100%; /* Make the image fill its container */
            height: 100%; /* Adjust the height to maintain aspect ratio */
            object-fit: cover; /* Ensure the image covers the entire container */
        }
    </style>
</head>
<body>
    <%@include file="/includes/navbar.jsp"%>

    <div class="container my-3">
       
        <table class="min-w-full divide-y divide-gray-200">
            <thead>
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"></th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Cancel order</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                <%
                if (cart_list != null) {
                    for (Cart c : cartProduct) {
                %>
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap"><%=c.getName()%></td>
                    <td class="px-6 py-4 whitespace-nowrap"><%=c.getCategory()%></td>
                    <td class="px-6 py-4 whitespace-nowrap"><%= dcf.format(c.getPrice())%></td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <form action="order-now" method="post" class="flex items-center">
                            <input type="hidden" name="id" value="<%= c.getId()%>" class="form-input">
                            <div class="flex items-center space-x-2">
                                <a href="quantity-inc-dec?action=inc&id=<%=c.getId()%>" class="text-gray-500 hover:text-gray-700 transition duration-300">
                                    <i class="fas fa-plus-square text-xl"></i>
                                </a>
                                <input type="text" name="quantity" class="border border-gray-300 rounded px-3 py-1 text-sm" value="<%=c.getQuantity()%>" readonly>
                                <a href="quantity-inc-dec?action=dec&id=<%=c.getId()%>" class="text-gray-500 hover:text-gray-700 transition duration-300">
                                    <i class="fas fa-minus-square text-xl"></i>
                                </a>
                            </div>
                            <button type="submit" class="ml-2 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition duration-300">Buy</button>
                        </form>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap"><a href="remove-from-cart?id=<%=c.getId()%>" class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600 transition duration-300">Remove</a></td>
                </tr>
                <%
                    }
                }
                %>
            </tbody>
        </table>
     <div class="container my-3 flex justify-center">
    <div class="w-full max-w-3xl">
        <div class="flex justify-between items-center py-3 bg-white shadow-md rounded-md">
            <h3 class="text-lg font-semibold mr-2">Total Price: $ <span class="font-normal">${(total > 0) ? dcf.format(total) : 0}</span></h3>
            <a href="cart-check-out" class="inline-block px-6 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition duration-300 flex items-center mr-2">Check Out</a>
        </div>
    </div>
</div>



    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
