<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="./css/button.css" type="text/css" />
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>IMining:список сотрудников</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 20px ;
        }

        td, th {
            padding: 4px;
            border: 1px solid #000080;
        }

        th {
            background: #000080;
            color: #ffe;
            text-align: left;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<%@page import="main.java.DAO" %>
<%@page import="main.java.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="main.java.Farm" %>
<jsp:useBean id="list" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="listPosition" class="java.util.ArrayList" scope="application"/>
<%
    request.setCharacterEncoding("UTF-8");
%>
<form id="checkedForm" action="farm.jsp" method="post">
    <%
        DAO dao = new DAO();
        list = dao.getAllFarms();
        if (request.getParameter("action") != null) {
            if(request.getParameter("action").equals("Delete")){
                System.out.println("Я готов удалять");
                for (int i = 0; i < list.size() + 1; i++) {
                    System.out.println("Я 321тут");
                    if (request.getParameter("checkBox" + i) != null) {
                        switch (request.getParameter("action")) {
                            case "Delete":
                                System.out.println("Ща будет крошево");
                                try {
                                    dao.deleteFarm(Integer.parseInt(request.getParameter("checkBox" + i)));
                                } catch (NumberFormatException e) {
                                    out.println("Ошибка перевода строки в число");
                                }
                                break;
                            case "Add":
                                String expprofit = request.getParameter("expprofit");
                                dao.addFarm(new Farm(Integer.parseInt(expprofit)));
                                break;
                            case "Edit":
                                RequestDispatcher dispatcher = request.getRequestDispatcher("web/updateFarm.jsp");
                                dispatcher.forward(request, response);
                                break;
                        }
                    }
                }
            }
            else if (request.getParameter("farmId").equals("")) {
                System.out.println("Я добавляю");
                String expprofit = request.getParameter("expprofit");
                dao.addFarm(new Farm(Integer.parseInt(expprofit)));
            } else if (request.getParameter("farmId") != null) {
                System.out.println("Я редактирую");
                String expprofit = request.getParameter("expprofit");
                dao.updateFarm(new Farm(Integer.parseInt(request.getParameter("farmId")), Integer.parseInt(expprofit)));
            }
        }
        list = dao.getAllFarms();
    %>
    <div style="padding: 5px;">
        <button class="button7" type="button" name="action" onclick="location.href ='inputFarm.jsp'" value="Add">Добавить новую ферму
        </button>
        <button  class="button7"  type="submit" name="action" value="Delete">Удалить</button>
    </div>
</form>
<%
    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
    out.print("<body>");
    out.print("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
    out.print("<tr><th></th><th>Номер фермы</th><th>Эффективность</th><th></th></tr>");
    for (int i = 0; i < list.size(); i++) {
        Object o = list.get(i);
        Farm farm = (Farm) o;
        out.print("<tr><td><input form=\"checkedForm\" type=\"checkBox\" name=\"checkBox" + i + "\"  value=\"" + farm.getIdFarm() + "\" >" +
                "</td><td>" + farm.getIdFarm() +
                "</td><td>" + farm.getExpProfit() +
                "</td><td> <form action=\"inputFarm.jsp\" method=\"post\"><button  class=\"button7\"  type=\"submit\" name=\"action\" value=\"" + farm.getIdFarm() + "\">Редактировать</button></form>" +
                "<form action=\"farmInfo.jsp\" method=\"post\"></form>");
    }
    out.print("</tbody></table></body>");
    out.print("</html>");
%>
<br><br>
<jsp:include page="_footer.jsp"/>
</body>
</html>