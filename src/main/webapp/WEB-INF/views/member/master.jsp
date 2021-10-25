<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">



<%@include file="../includes/header.jsp"%>


                <!-- Begin Page Content -->
                <div class="container-fluid">
					<div class="card shadow mb-4">
				<form role="form" method="get" >
					
							<table class="table table-hover" width="100%" cellspacing="0"     >
					
						<thead class="thead-dark">
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>가입일</th>
								<th>Point</th>
								<th>DEV</th>
								<th>권한레벨</th>
								<th>정지기간</th>
							</tr>
						</thead>
						
			<c:forEach items="${list}" var="list">
			
						<tr>
						<td>
					
						${list.memberId}
						</td>
						<td>
						${list.memberName}
						</td>
						<td>
						${list.memberEmail}
						</td>
						<td>
						<fmt:formatDate value="${list.memberJoinDate}"
										pattern="yy-MM-dd  hh:mm" />
						</td>
						<td>
						${list.memberPoint}
						</td>
						<td>
						${list.memberDevPoint}
						</td>
						<td>
						${list.memberRank}
						</td>
						<td>
						<fmt:formatDate value="${list.memberSanctionTime}"
										pattern="yy-MM-dd  hh:mm" />
					
						</td>
						</tr>

						</c:forEach>
						</tbody>
					</table>
					
				
				
						<ul class="pagination">

					<c:if test="${pageMaker.prev}">
						<li class="page-item"><a class="page-link"
							href="/member/master${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="idx">
						<li
							class="page-item ${pageMaker.cri.page == idx ? 'active' : ''  }"><a
							class="page-link" href="/member/master${pageMaker.makeSearch(idx)}">${idx}
						</a></li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li class="page-item"><a class="page-link"
							href="/member/master${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
					</c:if>
				</ul>
				
				<hr>
					<div class="input-group" style="width:700px">
					<div class="search" >
						
						<input type="text" name="keyword" id="keywordInput"
						class="form-control"
						placeholder="닉네임 검색" value="${scri.keyword}" />
						
						
						<button class ="btn btn-dark" id="searchBtn" type="button">	<i class="fas fa-search fa-sm mr-3"></i>검색</button>
						
						</div>
						</div>
					
						<script>
							$(function() {
								$('#searchBtn')
										.click(
												function() {
													self.location = "master"
															+ '${pageMaker.makeQuery(1)}'
															
															+ "&keyword="
															+ encodeURIComponent($(
																	'#keywordInput')
																	.val());
															
												});
							});
						</script>
		
				</form>
					
					
					
					
					</div>
                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">회원 정보 수정</h1>

                    <div class="row">

                        <div class="col-lg-6">

                            <!-- Circle Buttons -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">회원정지</h6>
                                </div>
                                <div class="card-body">
                                    
                                         <form id="memberSanction" action="/member/memberSanction" method="POST" class="form-signup form-user panel-body"  autocomplete="off">                                         
                
                    <div class="form-group">
                        <label class="control-label" for="fullName">ID입력</label>
                        <input type="text" name="memberName" class="form-control input-sm" >
                        <select name="sanctionTime">
                        <option value="1">1일</option>
                        <option value="7">7일</option>
                        <option value="30">30일</option>
                        <option value="90">90일</option>
                        <option value="300">300일</option>
                        </select>
                    </div>
                    
                <button class="btn btn-primary btn-block" type="submit" >정지</button>
            </form>
                                  
                                </div>
                            </div>
</div>

<!--  -->

<div class="col-lg-6">
                            <!-- Brand Buttons -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">회원 정지해제</h6>
                                
                                </div>
                                <div class="card-body">
                                <form id="memberDelete" action="/member/memberSanctionCancel" method="POST" class="form-signup form-user panel-body"  autocomplete="off">                                         
                
                    <div class="form-group">
                        <label class="control-label" for="fullName">ID 입력</label>
                        <input type="text" name="memberId" class="form-control input-sm" id="memberId">
                    </div>
                    
                <button class="btn btn-primary btn-block" type="submit" >정지해제</button>
            </form>
                                    
                                </div>
                            </div>

                        </div>
                        <!--  -->





                        <div class="col-lg-6">

                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">좋아요 포인트 주기</h6>
                                    
                                </div>
                                <div class="card-body" style="text-align:center;">
                                   
                               <div class="card">           
                               <form action="/member/insertPoint" method="post">
                           
                               <input type="text" name="memberId" id="memberId" class="form-control input-sm" placeholder="ID">
                               <br/>
                               <input type="text" name="memberPoint" id="memberPoint" class="form-control input-sm" placeholder="포인트">
                               
                                 <button type="submit" class="btn btn-primary">포인트주기</button>
                               </form>
                             </div>
                              </div>
                              
                            </div>

                        </div>
                        
                                     <div class="col-lg-6">

                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">DEV 포인트 주기</h6>
                                    
                                </div>
                                <div class="card-body" style="text-align:center;">
                                   
                               <div class="card">           
                               <form action="/member/insertDevPoint" method="post">
                           
                               <input type="text" name="memberId" id="memberId" class="form-control input-sm" placeholder="ID">
                               <br/>
                               <input type="text" name="memberPoint" id="memberPoint" class="form-control input-sm" placeholder="포인트">
                               
                                 <button type="submit" class="btn btn-primary">DEV포인트주기</button>
                               </form>
                             </div>
                              </div>
                              
                            </div>

                        </div>
 
                <!--  -->
                   <div class="col-lg-6">
                            <!-- Brand Buttons -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">관리자 지정</h6>
                                
                                </div>
                                <div class="card-body">
                                <form id="memberDelete" action="/member/memberMaster" method="POST" class="form-signup form-user panel-body"  autocomplete="off">                                         
                
                    <div class="form-group">
                        <label class="control-label" for="fullName">ID 입력</label>
                        <input type="text" name="memberId" class="form-control input-sm" id="memberId">
                    </div>
                    
                <button class="btn btn-primary btn-block" type="submit" >관리자 지정</button>
            </form>
                                    
                                </div>
                            </div>

                        </div>     
                        <!--  -->
                                               <!--  -->
                   <div class="col-lg-6">
                            <!-- Brand Buttons -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">관리자 해제</h6>
                                
                                </div>
                                <div class="card-body">
                                <form id="memberDelete" action="/member/memberMasterCancel" method="POST" class="form-signup form-user panel-body"  autocomplete="off">                                         
                
                    <div class="form-group">
                        <label class="control-label" for="fullName">ID 입력</label>
                        <input type="text" name="memberId" class="form-control input-sm" id="memberId">
                    </div>
                    
                <button class="btn btn-primary btn-block" type="submit" >관리자 해제</button>
            </form>
                                    
                                </div>
                            </div>

                        </div>     
                        <!--  -->
                        
                                               <!--  -->
                   <div class="col-lg-6">
                            <!-- Brand Buttons -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">회원 삭제</h6>
                                
                                </div>
                                <div class="card-body">
                                <form id="memberDelete" action="/member/memberDelete" method="POST" class="form-signup form-user panel-body"  autocomplete="off">                                         
                
                    <div class="form-group">
                        <label class="control-label" for="fullName">ID 입력</label>
                        <input type="text" name="memberId" class="form-control input-sm" id="memberId">
                    </div>
                    
                <button class="btn btn-primary btn-block" type="submit" >삭제</button>
            </form>
                                    
                                </div>
                            </div>

                        </div>     
                        <!--  -->
                        
                        
                        <div class="card shadow mb-4 ml-4 mr-2">
                        <div class="card-header py-3">
			<h6 class="m-0 font-weight-bold ">
			공지사항 (공지사항 카테고리의 글만 지정 가능합니다)
			</h6>
			</div>
                        <table class="table table-hover" width="100%" cellspacing="0"     >
					
						<thead class="thead-dark">
							<tr>
								<th>게시글번호</th>
								<th>제목</th>
								<th>작성일</th>
								
							</tr>
						</thead>
						
			<c:forEach items="${notice}" var="list">
			
						<tr>
					
						<td>
						${list.bno}
						</td>
						<td>
						${list.title}
						</td>
						<td>
						<fmt:formatDate value="${list.regdate}"
										pattern="yy-MM-dd  hh:mm" />
						</td>
						
						</tr>

						</c:forEach>
						</tbody>
					</table>
                        </div>
                          <div class="col-lg-6">

                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">공지사항 등록</h6>
                                    
                                </div>
                                <div class="card-body" style="text-align:center;">
                                   
                               <div class="card">           
                               <form action="/member/insertNotice" method="post">
                           
                               <input type="text" name="bno" id="bno" class="form-control input-sm" placeholder="게시글번호입력">
                               <br/>
                              
                               
                                 <button type="submit" class="btn btn-primary">공지사항 등록</button>
                               </form>
                             </div>
                              </div>
                              
                            </div>

                        </div>
                        
                                     <div class="col-lg-6">

                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">공지사항 해제</h6>
                                    
                                </div>
                                <div class="card-body" style="text-align:center;">
                                   
                               <div class="card">           
                               <form action="/member/deleteNotice" method="post">
                           
                               <input type="text" name="bno" id="bno" class="form-control input-sm" placeholder="게시글 번호 입력">
                               <br/>
                               
                                 <button type="submit" class="btn btn-primary">공지사항 해제</button>
                               </form>
                             </div>
                              </div>
                              
                            </div>

                        </div>
						
                   
                    
                       
                        

                    </div>

                </div>
                <!-- /.container-fluid -->
<%@include file="../includes/footer.jsp"%>