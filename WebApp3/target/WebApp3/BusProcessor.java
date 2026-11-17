package lab7;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BusProcessor")
public class BusProcessor extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String userName = request.getParameter("userName");
        String color = request.getParameter("color");
        String depot = request.getParameter("depot");

        if (userName == null || userName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Имя пользователя не задано!");
            return;
        }

        Cookie nameCookie = new Cookie("userName", URLEncoder.encode(userName, "UTF-8"));
        Cookie colorCookie = new Cookie("pageColor", URLEncoder.encode(color, "UTF-8"));
        Cookie depotCookie = new Cookie("depot", URLEncoder.encode(depot, "UTF-8"));

        nameCookie.setMaxAge(100);
        colorCookie.setMaxAge(100);
        depotCookie.setMaxAge(100);

        response.addCookie(nameCookie);
        response.addCookie(colorCookie);
        response.addCookie(depotCookie);

        HttpSession session = request.getSession(true);

        Integer visitCount = (Integer) session.getAttribute("visitCount");
        if (visitCount == null) {
            visitCount = 1;
        } else {
            visitCount++;
        }
        session.setAttribute("visitCount", visitCount);

        SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
        String lastVisitDate = formatter.format(new Date());
        session.setAttribute("lastVisitDate", lastVisitDate);

        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/AskBusList.jsp"));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}