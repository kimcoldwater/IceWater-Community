<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
		

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">


<title>IceWater</title>
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
	
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">


<script src="https://kit.fontawesome.com/97877a2398.js" crossorigin="anonymous"></script>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>



</head>

<body id="page-top">

<script type="text/javascript">
var socket = null;
$(document).ready(function(){
if(${login != null}){
connectWs();
alramCount();
alramList();
}
})

//알람목록
function alramList(){
	console.log("alramList")
	var memberId = "${login.memberId}";
	 $.ajax({
	        url : '/board/alramList',
	        type : 'get',
	        data : {'memberId' : memberId },
	        dataType : "json", 
	        success : function(data){
	         	var a='';
	         	 $.each(data, function(key, value){ 
	         		var categori = value.categori ;
	         		a += '<div>';
					a += '<div class="small text-gray-500">'+value.alramDate+'</div>';
					if(categori == "reply"){
					a += '<span class="font-weight-bold"><a href="#"  onclick="alramClick('+value.bgno+','+value.bno+',\''+value.fromId+'\');">'+value.toId+'님이 '+value.title+' 에 댓글을 달았습니다</a></span>';
					}else if(categori == "questionCheck"){
					a += '<span class="font-weight-bold"><a href="#" onclick="alramClick('+value.bgno+','+value.bno+',\''+value.fromId+'\');">'+value.toId+'님이 '+value.title+' 에 답변을 채택했습니다</a></span>';

					}
					a += '</div><hr/>';	
					
	         		 
	         		 
	         	 });
	         	 
	         	 $("#alramList").html(a);
	         	 
	        }
	        
	    
	    });
	 }
//목록끝

//목록클릭
function alramClick(bgno,bno,formId){
	console.log("alramClick")
	 $.ajax({
	        url : '/board/alramClick',
	        type : 'post',
	        data : {'memberId' : formId , 'bno':bno},
	        dataType : "json", 
	        success : function(){
	        
	        }
	        
	    
	    });
	location.href="/board/readView?bno="+bno+"&bgno="+bgno;
	
}



//알람
function alramCount(){
	console.log("alram")
	var memberId = "${login.memberId}";
	 $.ajax({
	        url : '/board/alramCount',
	        type : 'get',
	        data : {'memberId' : memberId },
	        dataType : "json", 
	        success : function(alram){
	         	console.log(alram);
	         	console.log("알람성공");
	       $('#alramCount').text(alram);
	        }
	    
	    });
}
//

//소켓


function connectWs(){
console.log("tttttt")
var ws = new SockJS("/alram");
socket = ws;

	ws.onopen = function() {
 console.log('open');
 
 };

	ws.onmessage = function(event) {
		console.log("onmessage"+event.data);
		let $socketAlert = $('div#socketAlert');
		$socketAlert.html(event.data)
		$socketAlert.css('display', 'block');
		
		setTimeout(function(){
			$socketAlert.css('display','none');
			
		}, 5000);
};

	ws.onclose = function() {
	    console.log('close');
 };
 
 
 

};

function getContextPath() {
    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
}; 
//소켓끝
</script>
	<!-- Page Wrapper -->
	<div id="wrapper" >

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-dark sidebar sidebar-dark accordion "
			id="accordionSidebar" >

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="/board/">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					IceWater
				</div>
			</a>
			
			<!-- Divider -->
			<hr class="sidebar-divider my-0">
			
			<!-- Nav Item - Dashboard -->
			<c:if test="${login.memberRank == 3 }">
			
			<li class="nav-item"><strong><a class="nav-link" href="/member/master">
			관리자페이지</a></strong></li>
			
				<hr class="sidebar-divider">
			
			</c:if>
			
			<c:if test="${empty login}">
			<li class="nav-item"><strong><a class="nav-link" href="/member/loginView">
					<i class="fas fa-sign-in-alt mr-2" style="color:green"></i>
			로그인</a></strong></li>
			</c:if>
			<c:if test="${not empty login}">
			<li class="nav-item"><strong><a class="nav-link" href="/board/mypageView?select=log&memberId=${login.memberId}">
					<i class="far fa-address-card mr-2" style="color:green"></i> <span>프로필</span>
			</a></strong></li>
			</c:if>
			<hr class="sidebar-divider">
			
			
			
			<li class="nav-item "><strong><a class="nav-link" href="/board/list?bgno=2">
					<i class="far fa-clipboard mr-3"></i><span>Notice</span>
			</a></strong></li>
			
			<li class="nav-item "><strong><a class="nav-link" href="/board/popular">
					<i class="fas fa-fire mr-3" style="color:red"></i><span>Populer</span>
			</a></strong></li>
			<!-- Divider -->
			<hr class="sidebar-divider">

		

			
			<!-- 사이드바 -->
			<!-- 커뮤니티 목록 -->
			
			<%@include file="../includes/communityList.jsp"%>
			
			
		<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
			
			
			
			
			
			
			
			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<form class="form-inline">
						<button id="sidebarToggleTop"
							class="btn btn-link d-md-none rounded-circle mr-3">
							<i class="fa fa-bars"></i>
						</button>
					</form>

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" 
						action ="https://www.google.com/"
						>
						
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small"
								placeholder="Google 검색" aria-label="Search" name="qt"
								>
							<input type="hidden" name = "q">
								<span class="input-group-btn">
								<button class="btn btn-primary" type="submit">
									<i class="fas fa-search fa-sm"></i>
								</button>
								</span>
							
						</div>
						
					</form>
					<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
					
					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						
						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
							
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>
							<c:if test="${empty login}">
							<li>
							<a href="/member/loginView" class="btn btn-success btn-icon-split mb-2 mr-1" style="width:auto; height:50px; margin-top:10px; margin-right:5px; text-align:center;">
    
    <i class="fas fa-sign-in-alt mr-1 mb-1"></i>
    <span class="text">로그인</span>
</a>

				<a href="/member/registerView" class="btn btn-success btn-icon-split mb-2 mr-3" style="width:auto; height:50px; margin-top:10px; margin-right:5px; text-align:center;">
    <i class="fas fa-id-card mr-1 mb-1"></i>
    <span class="text">회원가입</span>
</a>

							
							</li>
							</c:if>
							
						 <c:if test="${not empty login}">
						   <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                      <img src="/image/${login.memberImg}" style=" max-width: 100px;  height: 65px; border: 0px; border-radius:50%;">
                        <span class="hidden-xs">${login.memberName} 님 환영합니다!</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="user-header">
                            <p>${login.memberName}
                                <small>
                                    가입일자 : <fmt:formatDate value="${login.memberJoinDate}" pattern="yyyy-MM-dd"/>
                                </small>
                            </p>
                        </li>
                      
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="/member/infoView" class="btn btn-success btn-flat"><i
                                        class="fa fa-info-circle"></i><b> 정보수정 </b></a>
                            
                            
                                <a href="/member/logout" class="btn btn-danger btn-flat"><i
                                        class="glyphicon glyphicon-log-out"></i><b> 로그아웃</b></a>
                            </div>
                        </li>
                    </ul>
                </li>
						 	
							
							
						
							
						<!-- Nav Item - Alerts -->
						
						<li class="nav-item dropdown no-arrow mx-1">
						
						<a
							class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
								<span class="badge badge-danger badge-counter" id="alramCount"></span>
								
						</a>
												
						 <!-- Dropdown - Alerts -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="alertsDropdown">
								<h6 class="dropdown-header">알림</h6>
								
									
									
									<div id="alramList">
									
									</div>
									
									
								
							</div></li>


					
</c:if>
					
					</ul>

				</nav>
				<!-- End of Topbar -->
