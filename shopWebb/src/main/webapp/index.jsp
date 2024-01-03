<%@page import="cn.test.connection.DbCon"%>
<%@page import="cn.test.models.*"%>
<%@page import="cn.test.models.dao.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("auth",auth);
}

ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> book = pd.getAllProducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

if (cart_list != null) {
    request.setAttribute("cart_list", cart_list);
}   
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head.jsp"%>
    <title>TechWebsite</title>
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
<body >
    <%@include file="/includes/navbar.jsp"%>
   <div class="full-width"><a href="#">
        <img src="product-images/cover.jpg" alt="Your Image"></a>
    </div>
    <div class="container mx-auto my-8 px-4">
    <div>
       <div class="flex items-center justify-center h-32"> <!-- Centered heading -->
            <h1 class="text-3xl font-semibold">All Products</h1>
        </div class="bg-gray-300">
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <% 
            if (!book.isEmpty()) {
                for (Product p : book) {
            %>
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <img class="w-full h-48 object-cover" src="<%=p.getImage() %>" alt="Product Image">
                        <div class="p-4">
                            <h2 class="text-lg font-semibold mb-2"><%= p.getName()%></h2>
                            <p class="text-gray-600 mb-2">Price: $<%=p.getPrice() %></p>
                            <p class="text-gray-600 mb-2">Category: <%= p.getCategory() %></p>
                          
                            <div class="flex justify-between">
                                <a href="add-to-cart?id=<%=p.getId()%>" class="px-4 py-2 bg-gray-800 text-white rounded-md hover:bg-gray-700">Add to Cart</a>
                                <a href="order-now?quantity=1&id=<%= p.getId() %>" class="px-4 py-2 bg-green-500 text-white rounded-md hover:bg-blue-600">Buy Now</a>
                            </div>
                        </div>
                    </div>
            <% 
                }
            }
            %>
        </div>
    </div>
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
