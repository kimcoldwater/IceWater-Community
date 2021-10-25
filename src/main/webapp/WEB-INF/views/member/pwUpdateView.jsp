<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script type="text/javascript">
		$(document).ready(function(){
		
			$("#pwUpdate").on("click", function(){
			
				if($("#memberPw").val()==""){
					alert("현재비밀번호를 입력해주세요");
					$("#memberPw").focus();
					return false
				}
				if($("#memberPw1").val()==""){
					alert("새 비밀번호를 입력해주세요");
					$("#memberPw1").focus();
					return false
				}
				if($("#memberPw2").val()==""){
					alert("새 비밀번호 확인을 입력해주세요");
					$("#memberPw2").focus();
					return false
				}
				if ($("#memberPw1").val() != $("#memberPw2").val()) {
					alert("변경비밀번호가 일치하지 않습니다.");
					$("#memberPw1").focus();
					 
					return false;
					}
			
				
				$.ajax({
					url : "/member/pwCheck",
					type : "POST",
					dataType : "json",
					data : $("#pwUpdateForm").serializeArray(),
					success: function(data){
						
						if(data==0){
							alert("현재비밀번호가 틀렸습니다.");
							return;
						}else{
							if(confirm("변경하시겠습니까?")){
								$("#pwUpdateForm").submit();
							}
							
						}
					}
				})
				
			});
			
				
			
		})
	</script>
<%@include file="../includes/header.jsp"%>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">비밀번호 변경</h1>

                    <div class="row">

                        <div class="col-sm-8 col-sm-offset-2">

                            <!-- Circle Buttons -->
                            <div class="card shadow mb-4">
                                
                                <div class="card-body">
                                    
                       <form action="/member/pwUpdate" method="post" id="pwUpdateForm" name="pwUpdateForm">
                       <input type="hidden" id="memberId" name="memberId" value="${login.memberId}">
    <div class="col-sm-8 col-sm-offset-2">
        <div class="panel panel-default panel-margin-10">
            <div class="panel-body panel-body-content text-center">
                <p class="lead">변경하실 비밀번호를 입력해 주세요.</p>
                <div class="form-group">
                    <input type="password" name="memberPw" id="memberPw" class="form-control form-control-inline text-center" placeholder="현재 비밀번호" />
                </div>
                <div class="form-group">
                    <input type="password" name="memberPw1" id="memberPw1" class="form-control form-control-inline text-center" placeholder="새 비밀번호" />
                </div>
                <div class="form-group">
                    <input type="password" name="memberPw2" id="memberPw2" class="form-control form-control-inline text-center" placeholder="새 비밀번호 확인" />
                </div>
                <button type="button" id="pwUpdate" name="pwUpdate" class="btn btn-primary">비밀번호 변경</button> <a href="/member/infoView" class="btn btn-dark">취소</a>
            </div>
        </div>
    </div>
    </form>
                                  
                                </div>
                            </div>
                            </div>
                            </div></div>
                        

                    
                <!-- /.container-fluid -->
<%@include file="../includes/footer.jsp"%>