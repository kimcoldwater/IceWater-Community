<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>







<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
		
			// 수정 
			$("#update_btn").on("click", function(){
				formObj.attr("action", "/board/updateView");
				formObj.attr("method", "get");
				formObj.submit();
				

				location.href = "/board/updateView?bno=${read.bno}"
					+"&bgno=${scri.bgno}"	
					+"&page=${scri.page}"
					+"&perPageNum=${scri.perPageNum}"
					+"&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort}";
			})
			
			// 삭제
			
			$("#delete_btn").on("click", function(){
				
				var deleteYN = confirm("삭제하시겠습니까?")
				if(deleteYN == true){
				formObj.attr("action", "/board/delete");
				formObj.attr("method", "post");
				formObj.submit();
				}else{
					return false;
				}
				
				
			
			
			})
			
			// 목록
			$("#list_btn").on("click", function(){
				
				location.href = "/board/list?page=${scri.page}"
					+"&bgno=${scri.bgno}"
				+"&perPageNum=${scri.perPageNum}"
				+"&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort}";
			})
			
			

			
		})
		
		
		//소켓
	
		
		
		
		
		
		
		
		
		function fn_fileDown(fileNo){
			var formObj = $("form[name='readForm']");
			$("#FILE_NO").attr("value", fileNo);
			formObj.attr("action", "/board/fileDown");
			formObj.submit();
		};
		
		var bno = ${read.bno};
		var bgno = ${read.bgno};
		var readTitle = "${read.title}";
		var memberId = "${login.memberId}";
		var writerId = "${read.id}";
		
		
		
		
		 function updateLike(){ 
		     $.ajax({
		            type : "POST",  
		            url : "/board/updateLike",       
		            dataType : "json",   
		            data : {'bno' : bno, 'memberId' : memberId , 'writerId' : writerId },
		            error : function(request, status, error){
		            	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            	alert("bno"+ bno +"//memberId"+memberId+"//writerId"+writerId);
		            },
		            success : function(likeCheck) {
		                
		                    if(likeCheck == 0){
		                    	alert("추천완료.");
		                    	location.reload();
		                    	
		                    	//소켓
								if(memberId != writerId){

		                    	if(socket){
		                    		let socketMsg = "like,"+memberId+","+writerId+","+bno+","+readTitle+","+bgno;
		                    		console.log(socketMsg);
		                    		socket.send(socketMsg);
		                    	}
								}
		                    //소켓끝   
		                    
		                    }
		                    else if (likeCheck == 1){
		                     alert("추천취소");
		                    	location.reload();

		                    
		                }else if(likeCheck == 2){
		                	alert("이미 반대하셨습니다");
		                }
		            }
		        });
		 }
		 
		 function updateHate(){ 
		     $.ajax({
		            type : "POST",  
		            url : "/board/updateHate",       
		            dataType : "json",   
		            data : {'bno' : bno, 'memberId' : memberId , 'writerId' : writerId},
		            error : function(){
		               alert("통신 에러","error","확인",function(){});
		            },
		            success : function(hateCheck) {
		                
		                    if(hateCheck == 0){
		                    	alert("반대완료.");
		                    	location.reload();
		                    }
		                    else if (hateCheck == 1){
		                     alert("반대취소");
		                    	location.reload();
		                }else if(hateCheck == 2){
		                	alert("이미 추천하셨습니다.");
		                }
		            }
		        });
		 }
		 
		 function updateDev(){ 
		     $.ajax({
		            type : "POST",  
		            url : "/board/updateDev",       
		            dataType : "json",   
		            data : {'bno' : bno, 'memberId' : memberId , 'writerId' : writerId},
		            error : function(){
		               alert("통신 에러","error","확인",function(){});
		            },
		            success : function(devCheck) {
		                
		                    if(devCheck == 0){
		                    	alert("DEV 완료.");
		                    	location.reload();
		                    	
		                    	//소켓
		                    if(memberId != writerId){
		                    	if(socket){
		                    		let socketMsg = "Dev,"+memberId+","+writerId+","+bno+","+readTitle+","+bgno;
		                    		console.log(socketMsg);
		                    		socket.send(socketMsg);
		                    	}
		                    }	
		                    //소켓끝   
		                 }
		                    else if (devCheck == 1){
		                     alert("DEV 취소");
		                    	location.reload();
		                }else if(devCheck == 2){
		                	alert("이미 추천하셨습니다.");
		                }
		            }
		        });
		 }
		 
		 
		 function scrap(){ 
		     $.ajax({
		            type : "POST",  
		            url : "/board/scrap",       
		            dataType : "json",   
		            data : {'bno' : bno, 'Id' : memberId },
		            error : function(){
		               alert("통신 에러","error","확인",function(){});
		            },
		            success : function(scrap) {
		                
		                     if(scrap == 0){
		                    	alert("스크랩완료");
		                    	location.reload();
		                    	
		                     	
		                        //소켓
		                       
		                    	if(socket){
		                    		let socketMsg = "scrap,"+memberId+","+writerId+","+bno+","+readTitle+","+bgno;
		                    		console.log(socketMsg);
		                    		socket.send(socketMsg);
		                    	}
		                    //소켓끝   
		                    	
		                     }else if(scrap == 1){
		                    	 alert("스크랩취소");
		                    	 location.reload();
		                     }
		                    
		            }
		        });
		 }
	

	</script>
<%@include file="../includes/header.jsp"%>


<div class="container-fluid" style="padding-top: 10px;">
<div class="row">
<div class="my-3 p-3 ml-4 mr-2 bg-white rounded shadow " style=" padding-left:10px; width:980px" >
<div class="col-lg-10">
<h2 class="page-header">${read.title}</h2>

</div>
<hr/>
<section id="container">
	<form name="readForm" role="form" method="post" >
  <input type="hidden" id="bno" name="bno" value="${read.bno}" />
   <input type="hidden" id="bgno" name="bgno" value="${scri.bgno}"> 
   <input type="hidden" id="page" name="page" value="${scri.page}"> 
  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
  <input type="hidden" id="sort" name="sort" value="${scri.sort}">
  <input type="hidden" id="bgnoinsert" name="bgnoinsert" value="${read.bno }">
  <input type="hidden" id="memberId" name="memberId" value="${login.memberId}">
  <input type="hidden" id="id" name="id" value="${read.id}">
  
 
  
  <input type="hidden" id="FILE_NO" name="FILE_NO" value="">
 
</form>
</section>
<div  style="padding-top: 5px ;width=920px;">
<div id="contAreaBox">
<div class="panel">
<div class="panel-body">
<div class="table-responsive" style="text-align:center;">

<table id="datatable-scroller"
	class="table table-borderless">
	<caption></caption>
	<colgroup>
		<col width="170px" />
		<col width="150px"/>
		<col width="280px"/>
		<col width="70px" style="text-align:right;"/>
		<col width="70px" style="text-align:right;"/>
		<col width="70px" style="text-align:right;"/>
		<col width="70px" style="text-align:right;"/>
		
	</colgroup>
	
	<tbody>
		<tr>
			<th class="table-dark" ><%@include file="../includes/readCategory.jsp"%> # ${read.bno}</th>
			<td >
			<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd   hh:mm"/>
			</td>
		</tr>
		<tr class="table-secondary">
		
							<th>
							<a href="/board/mypageView?select=log&memberId=${read.memberVO.memberId}" style="color: black">
								 <img src="/image/${read.memberVO.memberImg}" style=" max-width: 30px;  height: 30px; border: 0px; border-radius:50%;"> 
							
							<span style="font-size: 20px"> ${read.memberVO.memberName}</span></a><span style="font-size: 10px"><i class="fas fa-heart ml-1" style="color:red"></i>${read.memberVO.memberPoint}</span>
<span style="font-size: 12px"><i class="fa fa-bolt" style="color:blue" aria-hidden="true"></i>${read.memberVO.memberDevPoint}</span></th>
							<td > 님 </td>
							<td></td>
							<td > <i class="fas fa-check-double mr-1"></i> ${scrap}</td>
							<c:if test="${read.bgno == 19 or read.bgno == 20 or read.bgno == 21 or read.bgno == 22 or
							read.bgno == 23 or read.bgno == 24 or read.bgno == 25 or read.bgno == 26 or read.bgno == 27 or
							read.bgno == 28 or read.bgno == 32 }"><td>
							 <i class="fab fa-dev mr-1"></i>${read.devhit}
							
							</td></c:if>
							
							<td ><i class="far fa-eye mr-1"></i>${read.hit}</td>
						
							<td> <i class="fas fa-thumbs-up mr-1"></i>${read.likehit}</td>
							<td ><i class="fas fa-thumbs-down mr-1"></i>${read.hatehit}</td>
						</tr>

		
		
		</tbody>
</table>




</div>

<!-- 내용 -->
<div class="ml-3 mr-3" style="padding-top: 50px; padding-bottom:100px; width:100%;">
${read.content}
</div>

<!-- 추천 -->
<div class="my-3 p-3 bg-white rounded shadow-sm row" style="width: 20%; float:none; margin:0 auto" >
<div  style="margin-right:1px; padding-top: 5px;">
<c:if test="${not empty login}">
					<button type="button" class="btn btn-warning " id="like_btn" onclick="updateLike(); return false;">${read.likehit} <i class="fas fa-thumbs-up ml-3"></i></button>
					<button type="button" class="btn btn-danger" id="hate_btn" onclick="updateHate(); return false;">${read.hatehit} <i class="fas fa-thumbs-down ml-3"></i></button>
					<button type="button" class="btn btn-suceess"></button>
<c:if test="${read.bgno == 19 or read.bgno == 20 or read.bgno == 21 or read.bgno == 22 or read.bgno == 23 or read.bgno == 24 or read.bgno == 25 or read.bgno == 26 or read.bgno == 27 or read.bgno == 28 or read.bgno == 32}">
					<button type="button" class="btn btn-primary ml-5 mt-1" id="dev_btn" onclick="updateDev(); return false;">${read.devhit} <i class="fab fa-dev ml-3"></i></button>

</c:if>
</c:if>
<c:if test="${empty login}">
<button type="button" class="btn btn-warning " onclick="location.href='/member/loginView'">${read.likehit} <i class="fas fa-thumbs-up ml-3"></i></button>
	<button type="button" class="btn btn-danger" onclick="location.href='/member/loginView'">${read.hatehit} <i class="fas fa-thumbs-down ml-3"></i></button>
	
<c:if test="${read.bgno == 19 or read.bgno == 20 or read.bgno == 21 or read.bgno == 22 or read.bgno == 23 or read.bgno == 24 or read.bgno == 25 or read.bgno == 26 or read.bgno == 27 or read.bgno == 28 or read.bgno == 32}">
					<button type="button" class="btn btn-primary ml-4 mt-1" onclick="location.href='/member/loginView'">${read.devhit} <i class="fab fa-dev ml-5"></i></button>

</c:if>
</c:if>
</div>


</div>
<div></div>



<hr/>




<div  style="margin-left:1px;">
					<button type="button" class="btn btn-primary float-right mb-1" onclick="location.href='/board/list?page=${scri.page}&bgno=${scri.bgno}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort}'">목록</button>
					<c:if test="${login.memberRank == 3}">
					<button type="button" class="btn btn-dark  mr-1" id="delete_btn">삭제</button>
					<button type="button" class="btn btn-success float-right mr-1" id="update_btn">수정</button>
					</c:if>
					<c:if test="${login.memberId == read.id}">
					<button type="button" class="btn btn-success float-right mr-1" id="update_btn">수정</button>
					<button type="button" class="btn btn-dark  mr-1" id="delete_btn">삭제</button>
					</c:if>
					<c:if test="${not empty login}">
						<c:if test="${login.memberId != read.id}">
						<button type="button" class="btn btn-success" onclick="scrap(); return false;">스크랩<i class="fas fa-check-double ml-1"></i></button>
						</c:if>
					</c:if>
					<c:if test="${empty login}">
						<button type="button" class="btn btn-success" onclick="location.href='/member/loginView'">스크랩<i class="fas fa-check-double ml-1"></i></button>
					</c:if>
					
					
</div>
<div class="my-3 p-3 bg-white rounded shadow">
	<c:choose >
	<c:when test="${move.next == 9999}">
	<button type="button" class="btn btn-warning mr-3" disabled>다음글이 없습니다</button>
	</c:when>
	
	<c:when test="${move.next != 9999 and empty login or nextPageCheck == 0 }">
	
	<button type="button" class="btn btn-warning mr-3" onclick="location.href='/board/readView?bno=${move.next}&bgno=${scri.bgno}&sort=${scri.sort}'"> <span class="glyphicon glyphicon-menu-up" aria-hidden="true"></span>다음글</button>
		<a href="/board/readView?bno=${move.next}&bgno=${scri.bgno}&sort=${scri.sort}" style="color: black"> ${move.nexttitle} </a>
	</c:when>
	
	<c:when test="${move.next != 9999 and not empty login and nextPageCheck == 1}">
	
	<button type="button" class="btn btn-secondary mr-3" onclick="location.href='/board/readView?bno=${move.next}&bgno=${scri.bgno}&sort=${scri.sort}'"> <span class="glyphicon glyphicon-menu-up" aria-hidden="true"></span>다음글</button>
		<a href="/board/readView?bno=${move.next}&bgno=${scri.bgno}&sort=${scri.sort}" style="color: gray"> ${move.nexttitle} (읽음) </a>
	</c:when>
	
	
	</c:choose>
	<hr/>
	
	<c:choose>
	
	<c:when test="${move.last == 9999}">
	<button type="button" class="btn btn-info mr-3" disabled>이전글이 없습니다</button>
	</c:when>
	
	<c:when test="${move.last != 9999 and empty login or lastPageCheck == 0}">
	<button type="button" class="btn btn-info mr-3 " onclick="location.href='/board/readView?bno=${move.last}&bgno=${scri.bgno}&sort=${scri.sort}'"> <span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>이전글</button>
	<a href="/board/readView?bno=${move.last}&bgno=${scri.bgno}&sort=${scri.sort}" style="color: black"> ${move.lasttitle}</a>
	</c:when>
	
	<c:when test="${move.last != 9999 and not empty login and lastPageCheck == 1}">
	<button type="button" class="btn btn-secondary mr-3 " onclick="location.href='/board/readView?bno=${move.last}&bgno=${scri.bgno}&sort=${scri.sort}'"> <span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>이전글</button>
	<a href="/board/readView?bno=${move.last}&bgno=${scri.bgno}&sort=${scri.sort}" style="color: gray"> ${move.lasttitle} (읽음)</a>
	</c:when>

	</c:choose>

</div>



		
    

 <!--                     추가                         -->
    <!--  댓글  -->
  
    <div class="my-3 p-3 bg-white rounded shadow" style="padding-top: 10px">

        <label for="content">Reply</label>
        <c:if test="${not empty login}">
        <form name="commentInsertForm" action="/reply/writeReply" enctype="multipart/form-data" method="post" id="commentInsertForm">
        <input type="hidden"  name="bno" value="${read.bno}" />
        <input type="hidden" name="id" id="id" value="${login.memberId}">
        <input type="hidden" name="bgno" id="bgno" value="${read.bgno}">
             <div class="input-group">
        
               <div class="row">
  <input class="form-control" id="writer" name="writer" value="${login.memberName}" style="width:40%" readonly>
		
             <textarea 
						id="content" name="content"
						class="myEditor"  ></textarea>
              <input type="file" name="file" />
             
               
                    <button class="btn btn-primary" type="button" name="commentInsertBtn" style="width: 40%; margin-top: 10px">댓글등록</button>
              </div>
              </div>
             
        </form>
        </c:if>
        <c:if test="${empty login}">
        <a href="/member/loginView" class="btn btn-secondary btn-block" role="button">
        <i class="fa fa-edit mr-2"></i>댓글을 등록하면 로그인을 해주세요.(클릭시 로그인페이지)</a>
        
        </c:if> 
    </div>
 <script>
        $(document).ready(function () {

         $('.myEditor').summernote({
                lang: 'ko-KR',
                height: 300,
                placeholder: '내용을 입력하세요',
                toolbar: [
                    ['fontname', ['fontname']],
                    ['fontsize', ['fontsize']],
                    ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
                    ['color', ['forecolor', 'color']],
                    ['table', ['table']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['insert', [ 'link', 'video','picture']],
                    ['view', ['help','undo']]
                  ],
                  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체',
                    '굴림', '돋음체', '바탕체'],
                  fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36',
                    '50', '72'] ,
                    
          
                
            });


        });

    </script>

    <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
    <h6 class="border-bottom pb-2 mb-0">Reply list</h6>

        <div class="commentList">
   
        
        </div>
        </div>
    </div>
    
    

 
<!--                     추가                         -->


 <%@ include file="../reply/replyS.jsp" %>
</div>

</div>
<!-- 파일 -->
<div class="my-3 p-2 bg-white rounded shadow" style="text-align:center; width:100%">
<label>첨부파일</label> <br/>
	<c:forEach var="file" items="${file}">
		
						<img src="/image/${file.STORED_FILE_NAME}" style=" max-width: 10%;  height: auto;"> <br />
					<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb) <br/>
					
					<hr/>
					
					</c:forEach>
				<c:if test="${empty file}">
				<h2>첨부파일이 없습니다</h2>
				</c:if>
			
					</div>
</div>
<div class="card shadow mb-2 w-75 " style =" height:100px;">
		<h2> 광고</h2>
		</div>
</div>

<div class="card shadow mb-2 " style ="padding-top:20px; width:150px; height:600px;">
		<h2> 광고</h2>
		</div>
		
    </div>
    </div>

<%@include file="../includes/footer.jsp"%>