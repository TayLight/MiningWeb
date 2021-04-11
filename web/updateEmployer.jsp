<%@ page import="com.filmlibrary.DAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-16" pageEncoding="EUC-KR" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"></jsp:include>
<jsp:include page="_menu.jsp"></jsp:include>
<jsp:useBean id="person" class="com.filmlibrary.Person" scope="request"/>
<jsp:useBean id="formatDate" class="java.lang.String" scope="request"/>
<input type="hidden" name="update" value="update">
<%
    DAO dao = new DAO();
    int id = Integer.parseInt(request.getParameter("personId"));
    person = dao.getPersonById(id);
    LocalDate date = person.getBirthday();
    formatDate = date.getYear()+"-"+date.getMonthValue()+"-"+date.getDayOfMonth();
%>
<h1> ¬²¬Ö¬Õ¬Ñ¬Ü¬ä¬Ú¬â¬à¬Ó¬Ñ¬ß¬Ú¬Ö ¬Ý¬Ú¬é¬ß¬à¬ã¬ä¬Ú </h1>
<form method='POST' action='jsp1.jsp'>
    ¬ª¬Õ¬Ö¬ß¬ä¬Ú¬æ¬Ú¬Ü¬Ñ¬ä¬à¬â: <input readonly name="id" value="<% out.println(person.getIdPerson());%>"/>
    ¬ª¬Þ¬ñ: <input name="firstName" value="<% out.println(person.getFirstName());%>"/>
    <br><br>
    ¬¶¬Ñ¬Þ¬Ú¬Ý¬Ú¬ñ: <input name="lastName" value="<% out.println(person.getLastName());%>"/>
    <br><br>
    ¬³¬ä¬â¬Ñ¬ß¬Ñ: <input name="country" value="<% out.println(person.getCountry());%>"/>
    <br><br>
    ¬¥¬Ñ¬ä¬Ñ ¬â¬à¬Ø¬Õ¬Ö¬ß¬Ú¬ñ:<input type="date" id="b" name="birtday" value="2017-12-12">
    <script type="text/javascript">
        document.getElementById("b").valueAsDate = new Date().setFullYear(<%out.println(date.getYear());%>,<%out.println(date.getMonthValue());%>,<%out.println(date.getDayOfMonth());%>);
    </script>
    <br><br>
    <input type="submit" value="¬²¬Ö¬Õ¬Ñ¬Ü¬ä¬Ú¬â¬à¬Ó¬Ñ¬ä¬î"/>
</form>
<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>
