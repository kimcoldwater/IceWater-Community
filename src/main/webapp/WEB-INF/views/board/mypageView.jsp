<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> 

<%@include file="../includes/header.jsp"%>

<div class="card shadow mb-4 ml-4 col-9">
<article id="top" class="wrapper style1">
				<div class="container">
					<div class="row">
						<div class="col-2 col-5-large col-12-medium mt-2  mr-2">
							<span class="image fit">
							
							<img src="/image/${info.memberImg}" style=" max-width: 140px;  height: 140px; border: 0px; border-radius:50%; "> 
							</span>
						</div>
						<div class="col-8 col-7-large col-12-medium ml-4">
							<header>
								<h1>${info.memberName} </h1>
							</header>
							
							<div class="row col-8">
							<span style="font-size: 25px"><i class="fas fa-heart mr-2 ml-1" style="color:red"></i>${info.memberPoint}</span>
							</div>
							<div class="row col-8 ">
							<span style="font-size: 25px" class="ml-2"><i class="fa fa-bolt mr-2" style="color:blue" aria-hidden="true"></i>${info.memberDevPoint}</span>
							</div>
							<div class="row col-8 ">
							 채택받은 수 : ${memberDevCount}
							</div>
						</div>
					</div>
				</div>
			</article>
			</div>

		
		<button type="button" class="btn btn-dark ml-3" onclick="location.href='/board/mypageView?select=log&memberId=${memberId}'">활동기록</button>
		<button type="button" class="btn btn-dark" onclick="location.href='/board/mypageView?select=write&memberId=${memberId}'">작성한 게시글</button>
		<button type="button" class="btn btn-dark" onclick="location.href='/board/mypageView?select=reply&memberId=${memberId}'">작성한 댓글</button>
		<button type="button" class="btn btn-dark" onclick="location.href='/board/mypageView?select=scrap&memberId=${memberId}'">스크랩</button>
		
	<c:forEach items="${log}" var="log">
	
	
	<div class="col-sm-9">
   	<div class="card shadow mt-2 mb-1">
<!--   <i class="fa fa-comment-o"></i>    -->
                  <div class="row ml-1">
					
                <span>
                <span style="font-size: 20px">
                 <c:if test="${log.categori == 1 }">
                   <i class="fas fa-edit mr-2" style="color:blue"></i>
            	#${log.bno} 게시글을 작성 했습니다.
					</c:if>	
					
					 <c:if test="${log.categori == 2 }">
                  <i class="far fa-thumbs-up mr-2" style="color:red"></i>
            	#${log.bno} &nbsp; 게시글을 추천 했습니다.
					</c:if>		
					
					 <c:if test="${log.categori == 3 }">
                  <i class="far fa-thumbs-down mr-2" style="color:dark"></i>
            	#${log.bno} &nbsp; 게시글을 반대 했습니다.
					</c:if>
					
					 <c:if test="${log.categori == 4 }">
                  <i class="fa fa-bolt mr-3" style="color:yellow"></i>
            	#${log.bno} &nbsp; 게시글을 DEV 했습니다.
					</c:if>		   	
					
					<c:if test="${log.categori == 5 }">
                  <i class="fas fa-check-double mr-2" style="color:green"></i>
            	#${log.bno} &nbsp; 게시글을 스크랩 했습니다.
					</c:if>	
					
					<c:if test="${log.categori == 6 }">
                  <i class="fa fa-comment-o mr-2" style="color:blue"></i>
            	#${log.bno} &nbsp;게시글에 #${log.rno} 댓글을 작성 했습니다.
					</c:if>
					
					<c:if test="${log.categori == 7 }">
                  <i class="far fa-thumbs-up mr-2" style="color:red"></i>
            	#${log.bno} &nbsp;게시글에 #${log.rno} 댓글을 추천 했습니다.
					</c:if>
					
					<c:if test="${log.categori == 8 }">
                  <i class="far fa-thumbs-down mr-2" style="color:dark"></i>
            	#${log.bno} &nbsp;게시글에 #${log.rno} 댓글을 반대 했습니다.
					</c:if>
					
					<c:if test="${log.categori == 9 }">
                  <i class="fa fa-bolt mr-3" style="color:yellow"></i>
            	#${log.bno} &nbsp;게시글에 #${log.rno} 댓글을 DEV 했습니다.
					</c:if>
					
					<c:if test="${log.categori == 10 }">
                  <i class="fa fa-bolt mr-3" style="color:red"></i>
            	#${log.bno} &nbsp;질문글에 #${log.rno} 댓글 답변자 ${log.questionId}님을 채택 했습니다.
					</c:if>
					
					<c:if test="${log.categori == 11 }">
                  <i class="fa fa-bolt mr-3" style="color:red"></i>
            	#${log.bno} &nbsp;질문글에 #${log.rno} 댓글이 채택 되었습니다.
					</c:if>
					
					
				
                          </span>
                    
                  <span style="font-size: 13px"><fmt:formatDate value="${log.logdate}" pattern="YY-MM-dd  hh:mm:ss" /> </span>
                 </span>
                      </div>
                      <div class="ml-5">
                      <h5>
                      	  <a href="/board/readView?bno=${log.bno}&bgno=${log.boardVO.bgno}">${log.boardVO.title}</a>
						
				<span style="font-size: 15px"> ${log.boardVO.writer} </span>
                     </h5>
                     </div>
	
</div>	
</div>
	</c:forEach>
	
	
	
	<c:forEach items="${write}" var="write">
	<div class="col-sm-8">
   	<div class="card shadow mt-1 mb-1">
<!--   <i class="fa fa-comment-o"></i>    -->
                  <div class="row ml-1">
					
                <span>
                <span style="font-size: 20px">
                
                   <i class="fas fa-edit mr-2" style="color:blue"></i>
            	#${write.bno} 게시글을 작성 했습니다.
					
					
				
                          </span>
                    
                  <span style="font-size: 13px"><fmt:formatDate value="${write.regdate}" pattern="YY-MM-dd  hh:mm:ss" /> </span>
                 </span>
                      </div>
                      <div class="ml-5">
                      <h5>
                      	  <a href="/board/readView?bno=${write.bno}&bgno=${write.bgno}">${write.title}</a>
						
				<span style="font-size: 15px"> ${write.writer} </span>
                     </h5>
                     </div>
	
</div>	
</div>
	</c:forEach>
	
	<c:forEach items="${scrap}" var="scrap">
	<div class="col-sm-8">
   	<div class="card shadow mt-1 mb-1">
<!--   <i class="fa fa-comment-o"></i>    -->
                  <div class="row ml-1">
					
                <span>
                <span style="font-size: 20px">
                
                   <i class="fas fa-check-double mr-2" style="color:green"></i>
            	#${scrap.bno} 게시글을 스크랩 했습니다.
					
					
				
                          </span>
                    
                  <span style="font-size: 13px"><fmt:formatDate value="${scrap.scrapdate}" pattern="YY-MM-dd  hh:mm:ss" /> </span>
                 </span>
                      </div>
                      <div class="ml-5">
                      <h5>
                      	  <a href="/board/readView?bno=${scrap.bno}&bgno=${scrap.bgno}">${scrap.title}</a> 
						
				<span style="font-size: 15px"> ${scrap.writer} </span>
                     </h5>
                     </div>
	
</div>	
</div>
	</c:forEach>
	
		<c:forEach items="${reply}" var="reply">
	<div class="col-sm-8">
   	<div class="card shadow mt-1 mb-1">
<!--   <i class="fa fa-comment-o"></i>    -->
                  <div class="row ml-1">
					
                <span>
                <span style="font-size: 20px">
                
                   <i class="fa fa-comment-o mr-2" style="color:blue"></i>
            	#${reply.boardVO.bno} 게시글에 #${reply.rno} 댓글을 작성 했습니다.
					
					
				
                          </span>
                    
                  <span style="font-size: 13px"><fmt:formatDate value="${reply.regdate}" pattern="YY-MM-dd  hh:mm:ss" /> </span>
                 </span>
                      </div>
                      <div class="ml-5">
                      <h5>
                      	  <a href="/board/readView?bno=${reply.boardVO.bno}&bgno=${reply.boardVO.bgno}">${reply.boardVO.title}</a>
						
				<span style="font-size: 15px"> ${reply.boardVO.writer} </span>
                     </h5>
                     </div>
	
</div>	
</div>
	</c:forEach>
	

<!-- /.container-fluid -->


<%@include file="../includes/footer.jsp"%>