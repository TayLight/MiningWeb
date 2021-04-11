<%@ page import="main.java.DAO" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="main.java.VideoCard" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="main.java.Farm" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
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
<link rel="stylesheet" href="./css/button.css" type="text/css" />
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<h1> Добавление новой видеокарты </h1>
<%
    DAO dao = new DAO();
    VideoCard videocard;
    ArrayList<VideoCard> list;
    if (request.getParameter("action") != null) {
        list = dao.getAllVideoCards();
        int id = Integer.parseInt(request.getParameter("action"));
        videocard = (VideoCard) dao.getVideocardById(id);
    } else {
        videocard = null;
    }
%>
<form id="t" method='POST' action='videocard.jsp'>
    <input type="hidden" readonly name="videocardId" value="<%if(videocard!=null)out.print(videocard.getIdVideoCard());%>"/>
    Название: <input required value="<%if(videocard!=null) out.print(videocard.getTitle()); %>" name="title"/>
    <br><br>
    Mb: <input required type="number" min="0" value="<%if(videocard!=null) out.print(videocard.getCountMB()); %>" name="mb"/>
    <br><br>
    Производитель: <input required value="<%if(videocard!=null) out.print(videocard.getMaker()); %>" name="maker"/>
    <br><br>
    Частота: <input required type="number" min="0" value="<%if(videocard!=null) out.print(videocard.getFrequency()); %>" name="frequence"/>
    <br><br>
    Процент износа:<input required type="number" min="0" max="100" value="<%if(videocard!=null) out.print(videocard.getPercent()); %>"  name="percent">
    <br><br>
    <%
        ArrayList<Farm> list2 = dao.getAllFarms();
        if(videocard!=null) {
            out.print("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
            out.print("<tr><th></th><th>Номер фермы</th><th>Эффективность</th></tr>");
            boolean join;
            ArrayList<Farm> farms = dao.getAllFarmsByIdVideoCard(videocard.getIdVideoCard());
            for (int i = 0; i < list2.size(); i++) {
                join = false;
                Farm o = list2.get(i);
                for(int j=0; j<farms.size();j++){
                    if(list2.get(i).getIdFarm()==farms.get(j).getIdFarm() && farms.get(j).getIdFarm() == videocard.getIdFarm()){
                        join=true;
                    }
                }
                if (join) {
                    out.print("<tr><td><input form=\"t\" type=\"checkBox\" name=\"checkBox" + i + "\"  value=\"" + o.getIdFarm() + "\"checked >" +
                            "</td><td>" + o.getIdFarm() +
                            "</td><td>" + o.getExpProfit() +
                            "</td>");
                }else {
                    out.print("<tr><td><input form=\"t\" type=\"checkBox\" name=\"checkBox" + i + "\"  value=\"" + o.getIdFarm() + "\" >" +
                            "</td><td>" + o.getIdFarm() +
                            "</td><td>" + o.getExpProfit() +
                            "</td>");
                }
            }
            out.print("</tbody></table>");
        }
    %>
    <br><br>
    <div style="padding: 5px;">
        <button class="button7" type="submit" name="action" value="Add">Добавить</button>
        <button class="button7" type="submit" >Назад</button>
    </div>
    <br><br>
</form>
<jsp:include page="_footer.jsp"/>
</body>
</html>
