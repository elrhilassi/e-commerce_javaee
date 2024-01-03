package cn.test.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import cn.test.connection.DbCon;
import cn.test.models.Cart;
import cn.test.models.Order;
import cn.test.models.User;
import cn.test.models.dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



public class CheckOutOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String redirectURL = null; // Variable to store the redirect URL
	    
	    try {
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	        Date date = new Date();
	        ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
	        User auth = (User) request.getSession().getAttribute("auth");

	        if (cart_list != null && auth != null) {
	            boolean insertionFailed = false;
	            OrderDao oDao = new OrderDao(DbCon.getConnection());

	            for (Cart c : cart_list) {
	                Order order = new Order();
	                order.setId(c.getId());
	                order.setUid(auth.getId());
	                order.setQunatity(c.getQuantity());
	                order.setDate(formatter.format(date));

	                boolean result = oDao.insertOrder(order);
	                if (!result) {
	                    insertionFailed = true;
	                    break;
	                }
	            }

	            if (!insertionFailed) {
	                cart_list.clear();
	                redirectURL = "orders.jsp";
	            } else {
	                redirectURL = "carte.jsp";
	            }
	        } else {
	            if (auth == null) {
	                redirectURL = "login.jsp";
	            } else {
	                redirectURL = "carte.jsp";
	            }
	        }

	        if (redirectURL != null) {
	            response.sendRedirect(redirectURL);
	        }
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
