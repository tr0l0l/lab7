<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Импортируем класс Cookie из библиотеки Jakarta (для Tomcat 11) --%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%-- Импортируем URLDecoder для декодирования русских букв из Cookie --%>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Список автобусов</title>
    
    <% 
        // Значения по умолчанию, если Cookie еще не установлены
        String bgColor = "white";
        String userName = "Гость";
        String depot = "Автопарк №1";
        
        // Получаем массив всех Cookie от браузера
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("pageColor".equals(c.getName())) {
                    bgColor = URLDecoder.decode(c.getValue(), "UTF-8");
                }
                if ("userName".equals(c.getName())) {
                    userName = URLDecoder.decode(c.getValue(), "UTF-8");
                }
                if ("depot".equals(c.getName())) {
                    depot = URLDecoder.decode(c.getValue(), "UTF-8");
                }
            }
        }
        
        // Данные из сессии: счетчик посещений и дата последнего визита
        Integer visitCount = (Integer) session.getAttribute("visitCount");
        String lastVisitDate = (String) session.getAttribute("lastVisitDate");
    %>
    <style>
        body { background-color: <%= bgColor %>; font-family: Arial, sans-serif; }
    </style>
</head>
<body>

    <h1>Список автобусов автопарка: <%= depot %></h1>
    
    <!-- Блок для вывода данных пользователя и сессии -->
    <div style="border: 1px solid black; padding: 10px; margin-bottom: 20px; background: white; width: fit-content;">
        <p><b>Пользователь:</b> <%= userName %></p>
        <p><b>Количество обращений в сессии:</b> <%= (visitCount != null) ? visitCount : 1 %></p>
        <p><b>Дата последнего обращения:</b> <%= (lastVisitDate != null) ? lastVisitDate : "Только что" %></p>
    </div>

    <!-- Таблица со списком автобусов -->
    <table border="1" cellpadding="5" cellspacing="0" style="background-color: white;">
        <tr>
            <th>Автобус</th>
            <th>Водитель</th>
            <th>Работал</th>
        </tr>
        <tr>
            <td>123</td>
            <td>Иван Иванович</td>
            <td>Да</td>
        </tr>
        <tr>
            <td>321</td>
            <td>Олег Иванович</td>
            <td>Нет</td>
        </tr>
    </table>
    
    <br>
    <!-- Ссылка для возврата на страницу ввода -->
    <a href="BusList.jsp" style="background: #ddd; padding: 5px; text-decoration: none; color: black; border: 1px solid black;">Вернуться к вводу</a>

</body>
</html>