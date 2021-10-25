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

    <title>IceWaterJoin</title>

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


<script>
var path = "${pageContext.request.contextPath }";

$(document).ready(function(){
	

});
function duplicate(){
	var memberId=$("#memberId").val();

	var submitObj = new Object();
	submitObj.memberId=memberId;
	
	$.ajax({
		url : "/member/idCnt",
		type : "POST",
		contentType : "application/json; charset-utf-8",
		data : JSON.stringify(submitObj),
		dataType : "json"
		}).done(function(resMap) {
		if (resMap.res == "ok") {
		if (resMap.idCnt == 0) {
		alert("사용할 수 있는 아이디입니다.");
		$("#memberId_yn").val("Y");
		} else {
		alert("중복된 아이디 입니다.");
		$("#memberId_yn").val("N");
		}
		}
		
		}).fail(function(e) {
		alert("등록 시도에 실패하였습니다." + e);
		}).always(function() {
		pass = false;
		});
		
		}

function fnSubmit() {
	 
	var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	// var tel_rule = /^\d{2,3}-\d{3,4}-\d{4}$/; 전화번호용
	 
	if ($("#memberName").val() == null || $("#memberName").val() == "") {
	alert("이름을 입력해주세요.");
	$("#memberName").focus();
	 
	return false;
	}
	 
	if ($("#memberId").val() == null || $("#memberId").val() == "") {
	alert("아이디를 입력해주세요.");
	$("#memberId").focus();
	 
	return false;
	}
	 
	if ($("#memberId_yn").val() != 'Y') {
	alert("아이디 중복체크를 눌러주세요.");
	$("#memberId_yn").focus();
	 
	return false;
	}
	 
	 
	if ($("#memberEmail").val() == null || $("#memberEmail").val() == "") {
	alert("이메일을 입력해주세요.");
	$("#memberEmail").focus();
	 
	return false;
	}
	 
	 
	if ($("#memberPw").val() == null || $("#memberPw").val() == "") {
	alert("비밀번호를 입력해주세요.");
	$("#memberPw").focus();
	 
	return false;
	}
	 
	if ($("#memberPw2").val() == null || $("#memberPw2").val() == "") {
	alert("비밀번호 확인을 입력해주세요.");
	$("#memberPw2").focus();
	 
	return false;
	}
	 
	if ($("#memberPw").val() != $("#memberPw2").val()) {
	alert("비밀번호가 일치하지 않습니다.");
	$("#memberPw2").focus();
	 
	return false;
	}
	 
	if(!email_rule.test($("#memberEmail").val())){
		alert("이메일을 형식에 맞게 입력해주세요. ex) 1234@naver.com");
		$("#memberEmail").focus();
		return false;
		}
	
	if (confirm("회원가입하시겠습니까?")) {
	 
	$("#join").submit();
	 
	return false;
	}
	}
	 


</script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Welcome to IceWater</h1>
                            </div>
                            <form  class="user" id="join" method="post" action="/member/register">
                            <input type="hidden" id="memberId_yn" name="memberId_yn" value="N"/>
                      
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" name="memberId"
                                            placeholder="아이디를 입력하세요" id="memberId">
                                    </div>
                               <div class="col-sm-4 mb-3 mb-sm-0">
       						 <a href="#" class="btn btn-success btn-icon-split" style="text-align:center;" onclick="duplicate(); return false;">
           				 <span class="icon text-white-30">
            		    <i class="fas fa-check"></i>
            		   
           				 </span>
           				 <span class="text">중복체크</span>
        				</a>
        				</div>
                                   
                                </div>    
                                
                                    <div class=" mb-4 ">
                                        <input type="text" class="form-control form-control-user" name="memberPw"
                                            placeholder="비밀번호를 입력하세요" id="memberPw">
                                    </div>
                                	   <div class=" mb-4 ">
                                        <input type="text" class="form-control form-control-user" name="memberPw2"
                                            placeholder="비밀번호 확인" id="memberPw2">
                                    </div>
                                	
                                     <div class="form-group">
                                    <input type="text" class="form-control form-control-user" name ="memberName"
                                        placeholder="닉네임을 입력하세요" id="memberName">
                                </div>
                                
                                <div class="form-group">   
                                
                                    <input type="email" class="form-control form-control-user" name="memberEmail"
                                        placeholder="이메일을 입력하세요(이메일 인증)" id="memberEmail">
                                      
                                </div>
                                
                                   <div class="checkbox icheck">
                        <label>
                            <input type="checkbox">  <a href="#">약관</a>에 동의
                        </label>
                    </div>
                           
                                <button class="btn btn-primary btn-user btn-block" type="button" onclick="fnSubmit(); return false;">
                                   가입
                                </button>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgot-password.html">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="login.html">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>