<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>FilmFinder</title>
</head>
<body>
<link rel="stylesheet" href="./css/index.css" type="text/css" />

<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
 <br><br>
<div style="margin-left:20px;">
<b>База данных Miner содержит:</b>
<ol class="rounded">
    <li><a href="videocard.jsp">Видеокарты</a></li>
    <li><a href="employer.jsp">Сотрудники</a></li>
    <li><a href="farm.jsp">Фермы</a></li>
</ol>
</div>
<jsp:include page="_footer.jsp"/>
</body>
</html>
