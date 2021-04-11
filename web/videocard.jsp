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
<%@ page import="main.java.VideoCard" %>
<jsp:useBean id="list" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="listPosition" class="java.util.ArrayList" scope="application"/>
<%
    request.setCharacterEncoding("UTF-8");
%>
<form id="checkedForm" action="videocard.jsp" method="post">
    <%
        DAO dao = new DAO();
        list = dao.getAllVideoCards();
        if (request.getParameter("action")!=null) {
            if (request.getParameter("action").equals("Delete")) {
                for (int i = 0; i < list.size() + 1; i++) {
                    if (request.getParameter("checkBox" + i) != null) {
                        try {
                            dao.deleteVideoCard(Integer.parseInt(request.getParameter("checkBox" + i)));
                        } catch (NumberFormatException e) {
                            out.println("Ошибка перевода строки в число");
                        }
                    }
                }
            } else if (request.getParameter("videocardId").equals("")) {
                String title = request.getParameter("title");
                String mb = request.getParameter("mb");
                String maker = request.getParameter("maker");
                String frequence = request.getParameter("frequence");
                String percent = request.getParameter("percent");
                dao.addVideoCard(new VideoCard(title, Integer.parseInt(mb), maker, Integer.parseInt(frequence), Integer.parseInt(percent)));
            } else if (request.getParameter("videocardId") != null) {
                int id = Integer.parseInt(request.getParameter("videocardId"));
                String title = request.getParameter("title");
                String mb = request.getParameter("mb");
                String maker = request.getParameter("maker");
                String frequence = request.getParameter("frequence");
                String percent = request.getParameter("percent");
                VideoCard videoCard = new VideoCard(id, title, Integer.parseInt(mb), maker, Integer.parseInt(frequence), Integer.parseInt(percent));
                dao.updateVideoCard(videoCard);
                ArrayList<Farm> farms = dao.getAllFarms();
                System.out.println("Я тут farms:" + farms.size());
                for (int i = 0; i < farms.size() + 1; i++) {
                    if (request.getParameter("checkBox" + i) != null) {
                        int idFarm = Integer.parseInt(request.getParameter("checkBox" + i));
                        System.out.println(idFarm);
                        dao.setVideocardForFarm(videoCard.getIdVideoCard(), idFarm);
                    }
                }
            }
        }
        list = dao.getAllVideoCards();
    %>
    <div style="padding: 5px;">
        <button class="button7" type="button" name="action" onclick="location.href ='inputVideoCard.jsp'" value="Add">Добавить новую видеокарта
        </button>
        <button  class="button7"  type="submit" name="action" value="Delete">Удалить</button>
    </div>
</form>
<%
    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
    out.print("<body>");
    out.print("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
    out.print("<tr><th></th><th>Название</th><th>Mb</th><th>Производитель</th><th>Частота</th><th>Процент износа</th><th></th></tr>");
    for (int i = 0; i < list.size(); i++) {
        Object o = list.get(i);
        VideoCard videocard = (VideoCard) o;
        out.print("<tr><td><input form=\"checkedForm\" type=\"checkBox\" name=\"checkBox" + i + "\"  value=\"" + videocard.getIdVideoCard() + "\" >" +
                "</td><td>" + videocard.getTitle() +
                "</td><td>" + videocard.getCountMB() +
                "</td><td>" + videocard.getMaker() +
                "</td><td>" + videocard.getFrequency() +
                "</td><td>" + videocard.getPercent() +
                "%</td><td> <form action=\"inputVideoCard.jsp\" method=\"post\"><button  class=\"button7\"  type=\"submit\" name=\"action\" value=\"" + videocard.getIdVideoCard() + "\">Редактировать</button></form>" +
                "<form action=\"videocardInfo.jsp\" method=\"post\"></form>");
    }
    out.print("</tbody></table></body>");
    out.print("</html>");
%>
<br><br>
<jsp:include page="_footer.jsp"/>
</body>
</html>