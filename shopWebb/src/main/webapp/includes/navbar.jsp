<%@page import="cn.test.models.*"%>
<nav class="bg-white-500 shadow-lg">
    <div class="container mx-auto px-4">
        <div class="flex items-center justify-between py-4">
            <!-- Replace "TechWebsite" with your logo -->
            <a href="index.jsp">
                <img src="product-images/razer-logo.png" alt="Your Logo" class="h-12">
                
            </a>
            <button class="lg:hidden focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M4 6h16M4 12h16m-7 6h7"></path>
                </svg>
            </button>
            <div class="hidden lg:flex lg:items-center lg:space-x-6">
                <ul class="flex space-x-4">
                    <li><a class="text-black hover:text-gray-800" href="index.jsp">Home</a></li>
                    <li><a class="text-black hover:text-gray-800" href="carte.jsp">Cart <span class="bg-white text-red-500 rounded-full px-2">${cart_list.size()}</span></a></li>
                    <% 
                    User auuth = (User) request.getSession().getAttribute("auth");
                    if (auuth != null) {
                    %>
                        <li><a class="text-black hover:text-gray-800" href="orders.jsp">Orders</a></li>
                        <li><a class="text-black hover:text-gray-800" href="log-out">Logout</a></li>
                    <% 
                    } else {
                    %>
                        <li><a class="text-black hover:text-gray-800" href="login.jsp">Login</a></li>
                    <% 
                    }
                    %>
                </ul>
            </div>
        </div>
    </div>
</nav>

    
</nav>
