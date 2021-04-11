<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String message = pageContext.getException().getMessage();
    String exception = pageContext.getException().getClass().toString();
%>
<head>
    <link rel="stylesheet" href="./css/button.css" type="text/css" />
    <title>Ошибка!</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
</head>
<body style="">
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<h2 style="font-size: 20px">Ошибка!</h2>
<p>Тип ошибки: <%= exception%>
</p>
<p><%out.print(message);%>/p>
</body><div>
    <jsp:include page="_footer.jsp"/></div>
</html>

