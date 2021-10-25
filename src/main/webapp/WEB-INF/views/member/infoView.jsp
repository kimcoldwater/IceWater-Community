<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">


<%@include file="../includes/header.jsp"%>

<script>


 $(documenct).ready(function(){
	
});

 function duplicate(){
		var memberName=$("#memberName").val();

		var submitObj = new Object();
		submitObj.memberName=memberName;
		
		$.ajax({
			url : "/member/nameCheck",
			type : "POST",
			contentType : "application/json; charset-utf-8",
			data : JSON.stringify(submitObj),
			dataType : "json"
			}).done(function(resMap) {
			if (resMap.res == "ok") {
			if (resMap.nameCnt == 0) {
			alert("사용할 수 있는 닉네임입니다.");
			$("#memberName_yn").val("Y");
			} else {
			alert("중복된 닉네임입니다.");
			$("#memberName_yn").val("N");
			}
			}
			
			}).fail(function(e) {
			alert("등록 시도에 실패하였습니다." + e);
			}).always(function() {
			pass = false;
			});
			
			}
 
function fnSubmit(){
	var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if ($("#memberName").val() == null || $("#memberName").val() == "") {
		alert("닉네임을 입력해주세요.");
		$("#memberName").focus();
		 
		return false;
		}
		 
		if ($("#memberEmail").val() == null || $("#memberEmail").val() == "") {
		alert("이메일을 입력해주세요.");
		$("#memberEmail").focus();
		 
		return false;
		}
		
		if(!email_rule.test($("#memberEmail").val())){
			alert("이메일을 형식에 맞게 입력해주세요. ex) 1234@naver.com");
			$("#memberEmail").focus();
			return false;
			}
		
		if ($("#memberName_yn").val() != 'Y') {
			alert("닉네임 중복체크를 눌러주세요.");
			$("#memberName_yn").focus();
			 
			return false;
			}
		
		if (confirm("수정하시겠습니까?")) {
			 
			$("#infoView").submit();
			 
			return false;
			}
}
 
</script>
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">회원 정보 수정</h1>

                    <div class="row">

                        <div class="col-lg-6">

                            <!-- Circle Buttons -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">ID , Email</h6>
                                </div>
                                <div class="card-body">
                                    
                                         <form id="infoView" action="/member/infoUpdate" method="POST" class="form-signup form-user panel-body"  autocomplete="off">
                            <input type="hidden" id="memberName_yn" name="memberName_yn" value="N"/>
                                         
                <fieldset>
                    <div class="form-group">
                        <label class="control-label" for="fullName">ID</label>
                        <input type="text" name="memberId" class="form-control input-sm"  value="${login.memberId}" id="memberId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="nickname">닉네임</label>
                         
       						 <a href="#" class="btn btn-outline-dark btn-icon-split" style="text-align:center;" onclick="duplicate(); return false;">
           				 <span class="icon text-white-30">
            		    <i class="fas fa-check"></i>
            		   
           				 </span>
           				 <span class="text">중복체크</span>
        				</a>
        				
                        <input type="text" name="memberName" class="form-control input-sm" placeholder="닉네임"  value="${login.memberName}" id="memberName">
                   
                    </div>
                    
                    <div class="form-group">
                    	<label class="control-label" for="nickname">이메일</label>
	       				 <input type="email" name="memberEmail" value="${login.memberEmail}" placeholder="이메일" class="form-control input-sm" id="memberEmail">
	               	</div>
                   
                </fieldset>
                <button class="btn btn-primary btn-block" type="button" onclick="fnSubmit(); return false;">정보 수정</button>
            </form>
                                  
                                </div>
                            </div>

                            <!-- Brand Buttons -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">PassWord , Delete</h6>
                                
                                </div>
                                <div class="card-body">
                                     <a href="/member/pwUpdateView" class="btn btn-info btn-block">비밀번호 변경</a>
               						 <a href="/member/deleteView" class="btn btn-dark btn-block">회원 탈퇴</a>
                                    
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-6">

                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">프로필 사진 변경</h6>
                                    
                                </div>
                                <div class="card-body" style="text-align:center;">
                                   
                               <img src="/image/${login.memberImg}" style=" max-width: 50%;  height: auto; border: 0px; border-radius:50%;"> <br />	  
                               <div class="card">           
                               <form action="/member/updateImg" method="post" enctype="multipart/form-data">
                               <input type="file" name="file">
                               <input type="hidden" name="memberId" id="memberId" value="${login.memberId}">
                                 <button type="submit" class="btn btn-primary">사진변경</button>
                               </form>
                             </div>
                              </div>
                              
                            </div>

                        </div>

                    </div>

                </div>
                <!-- /.container-fluid -->
<%@include file="../includes/footer.jsp"%>