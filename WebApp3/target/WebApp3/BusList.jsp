<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ввод данных</title>
</head>
<body>
    <h2>Настройка страницы списка автобусов</h2>
    
    <!-- Форма отправляет GET-запрос на сервлет BusProcessor -->
    <form METHOD="GET" action="BusProcessor">
        <p>
            <label>Введите ваше имя (ФИО):</label><br>
            <% 
                // Автозаполнение поля имени из Cookie
                String savedName = "";
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (int i = 0; i < cookies.length; i++) {
                        if ("userName".equals(cookies[i].getName())) {
                            savedName = java.net.URLDecoder.decode(cookies[i].getValue(), "UTF-8");
                            break;
                        }
                    }
                }
            %>
            <input type="text" name="userName" value="<%= savedName %>" required>
        </p>
        
        <p>
            <label>Выберите цвет фона страницы:</label><br>
            <select name="color">
                <option value="white">Белый</option>
                <option value="lightblue">Голубой</option>
                <option value="lightgreen">Салатовый</option>
                <option value="pink">Розовый</option>
                <option value="yellow">Желтый</option>
            </select>
        </p>
        
        <p>
            <label>Введите название автопарка:</label><br>
            <input type="text" name="depot" value="Автопарк №1" required>
        </p>
        
        <input type="submit" value="Перейти к списку">
    </form>
</body>
</html>