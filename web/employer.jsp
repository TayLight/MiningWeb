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
<%@ page import="main.java.Employer" %>
<jsp:useBean id="list" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="listPosition" class="java.util.ArrayList" scope="application"/>
<%
    request.setCharacterEncoding("UTF-8");
%>
<form id="checkedForm" action="employer.jsp" method="post">
    <%
        DAO dao = new DAO();
        list = dao.getAllEmployers();
        if (request.getParameter("action")!=null) {
            if(request.getParameter("action").equals("Delete")){
                for (int i = 0; i < list.size() + 1; i++) {
                    if (request.getParameter("checkBox" + i) != null) {
                        try {
                            dao.deleteEmployer(Integer.parseInt(request.getParameter("checkBox" + i)));
                        } catch (NumberFormatException e) {
                            out.println("Ошибка перевода строки в число");
                        }
                        }
                    }
                }
            else if (request.getParameter("employerId").equals("") ) {
                System.out.println("Я тут");
                String fio = request.getParameter("fio");
                Boolean gender;
                if(request.getParameter("gender").equals("Мужчина")) {
                    gender = true;
                } else {
                    gender = false;
                }
                String birtdate = request.getParameter("birtdate");
                dao.addEmployer(new Employer(fio, gender, LocalDate.parse(birtdate)));
            } else if (request.getParameter("employerId")!= null) {
                String fio = request.getParameter("fio");
                Boolean gender;
                if(request.getParameter("gender").equals("Мужчина")) {
                    gender = true;
                } else {
                    gender = false;
                }
                String birtdate = request.getParameter("birtdate");
                Employer employer = new Employer(Integer.parseInt(request.getParameter("employerId")),fio, gender, LocalDate.parse(birtdate));
                dao.updateEmployer(employer);
                ArrayList<Farm> farms = dao.getAllFarms();
                System.out.println("Я тут farms:" + farms.size());
                for (int i = 0; i < farms.size() + 1; i++) {
                    if (request.getParameter("checkBox" + i) != null) {
                        int id  = Integer.parseInt(request.getParameter("checkBox" + i));
                        System.out.println(id);
                        dao.addFarmEmployer(employer.getIdEmployer(), id);
                    }
                }
            }
        }
        list = dao.getAllEmployers();
    %>
    <div style="padding: 5px;">
        <button class="button7" type="button" name="action" onclick="location.href ='inputEmployer.jsp'" value="Add">Добавить нового сотрудника
        </button>
        <button  class="button7"  type="submit" name="action" value="Delete">Удалить</button>
    </div>
</form>
<%
    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
    out.print("<body>");
    out.print("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
    out.print("<tr><th></th><th>ФИО</th><th>Пол</th><th>Дата рождения</th><th></th></tr>");
    for (int i = 0; i < list.size(); i++) {
        Object o = list.get(i);
        Employer employer = (Employer) o;
        out.print("<tr><td><input form=\"checkedForm\" type=\"checkBox\" name=\"checkBox" + i + "\"  value=\"" + employer.getIdEmployer() + "\" >" +
                "</td><td>" + employer.getFio() +
                "</td><td>" + employer.getBirthDate() +
                "</td><td>" + employer.getGender() +
                "</td><td> <form action=\"inputEmployer.jsp\" method=\"post\"><button  class=\"button7\"  type=\"submit\" name=\"action\" value=\"" + employer.getIdEmployer() + "\">Редактировать</button></form>" +
                "<form action=\"employerInfo.jsp\" method=\"post\"></form>");
    }
    out.print("</tbody></table></body>");
    out.print("</html>");
%>
<br><br>
<jsp:include page="_footer.jsp"/>
</body>
</html>