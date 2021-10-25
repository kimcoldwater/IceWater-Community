<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

  <!-- Custom fonts for this template -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
	
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>    
<script type="text/javascript">

$(document).ready(function() {
	
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);	
	}
	
});
</script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
        
               
                    
                       
                           <div class="jumbotron">
  <h3>${memberId}님 ICEWATER에 회원가입 해주셔서 감사합니다! </h3><br/>
  		
  <h1>${memberEmail}</h1> <br/> 
  <h3>으로 메일을 보냈습니다.</h3>
  <h2>메일 확인 후 인증버튼을 눌러주세요!</h2>
  <h3>메일 인증버튼을 누르면 로그인페이지로 연결됩니다.</h3>
  
  <button type="button" class="btn btn-primary" onclick="location.href='/member/loginView'">로그인</button>
  <button type="button" class="btn btn-success" onclick="location.href='/board/list'">메인</button>
  
</div>
                           
                        
                       
                    
               
          
        </div>

    </div>

   

</body>

</html>