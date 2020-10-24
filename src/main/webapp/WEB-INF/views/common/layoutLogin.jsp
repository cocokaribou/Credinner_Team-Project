<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
  <head>
    <jsp:include page="/WEB-INF/views/common/headerLogin.jsp"></jsp:include>
  </head>
  <body class="text-center">
  <jsp:include page="${contentPage}"></jsp:include>
  <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>   
    
</body>
</html>
