<%@page import="java.text.DecimalFormat"%>
<%@page import="cn.test.models.dao.OrderDao"%>
<%@page import="cn.test.connection.DbCon"%>
<%@page import="cn.test.models.dao.ProductDao"%>
<%@page import="cn.test.models.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
List<Order> orders = null;
if (auth != null) {
    request.setAttribute("person", auth);
    OrderDao orderDao  = new OrderDao(DbCon.getConnection());
    orders = orderDao.userOrders(auth.getId());
}else{
    response.sendRedirect("login.jsp");
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
    request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>webTech</title>
</head>
<body>
<%@include file="/includes/navbar.jsp"%>
<div class="container mx-auto p-4">
    <div class="my-6">
        <h1 class="text-2xl font-semibold">All Orders :</h1>
        <table class="min-w-full bg-white shadow-md rounded-md overflow-hidden">
            <thead class="bg-gray-200">
                <tr>
                    <th class="py-2 px-4">Date</th>
                    <th class="py-2 px-4">Name</th>
                    <th class="py-2 px-4">Category</th>
                    <th class="py-2 px-4">Quantity</th>
                    <th class="py-2 px-4">Price</th>
                    <th class="py-2 px-4">Cancel</th>
                </tr>
            </thead>
            <tbody>
            <% if(orders != null){
                for(Order o:orders){ %>
                    <tr>
                        <td class="py-2 px-4"><%=o.getDate() %></td>
                        <td class="py-2 px-4"><%=o.getName() %></td>
                        <td class="py-2 px-4"><%=o.getCategory() %></td>
                        <td class="py-2 px-4"><%=o.getQunatity() %></td>
                        <td class="py-2 px-4"><%=dcf.format(o.getPrice()) %> $</td>
                        <td class="py-2 px-4"><a class="bg-red-500 hover:bg-red-600 text-white py-1 px-2 rounded" href="cancel-order?id=<%=o.getOrderId()%>">Cancel Order</a></td>
                        
                    </tr>
                    
                <%}  
            }
            %>
            </tbody>
           
        </table>
    </div>
   <% if (orders != null && !orders.isEmpty()) { %>
    <div class="flex justify-center">
        <a class="bg-blue-500 hover:bg-blue-600 text-white py-1 px-2 rounded" href="thanks-for-purchase.jsp">Confirm Purchase</a>
    </div>
<% } %>
</div>
<%@include file="/includes/footer.jsp"%>
</body>
</html>
