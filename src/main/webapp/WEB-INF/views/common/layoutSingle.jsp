<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" class="h-100">
  <head>
    <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    
  </head>
  <body>
  	 <jsp:include page="${contentPage}"></jsp:include>
  	 <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
  </body>
</html>