<%@ page import="main.java.DAO" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="main.java.Farm" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<h1> Добавление новой личности </h1>
<%
    DAO dao = new DAO();
    Farm farm;
    ArrayList<Farm> list;
    if (request.getParameter("action") != null) {
        list = dao.getAllFarms();
        int id = Integer.parseInt(request.getParameter("action"));
        farm = (Farm) dao.getFarmById(id);
    } else {
        farm = null;
    }
%>
<form method='POST' action='farm.jsp'>
    <input required type="hidden" readonly name="farmId" value="<%if(farm!=null)out.print(farm.getIdFarm());%>"/>
    Эффективность: <input required type="number" max="100" min="0"  value="<%if(farm!=null) out.print(farm.getExpProfit()); %>" name="expprofit"/>
    <br><br>

    <div style="padding: 5px;">
        <button type="submit" name="action" value="Add">Добавить</button>
        <button type="submit" >Назад</button>
    </div>
</form>
<jsp:include page="_footer.jsp"/>
</body>
</html>
