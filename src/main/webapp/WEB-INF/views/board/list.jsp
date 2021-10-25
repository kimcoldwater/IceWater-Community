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
<div class="row justify-content-around">
	<!-- Page Heading -->
	<%@include file="../includes/listHeader.jsp"%>
	
	<!-- DataTales Example -->
	<div class="card shadow mb-4 ml-3" style="width:1050px;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold ">
			게시글 <c:choose >
	<c:when test="${scri.perPageNum == 10}">
	10개씩
	</c:when>
	<c:when test="${scri.perPageNum == 20}">
	20개씩
	</c:when>
	<c:when test="${scri.perPageNum == 30}">
	30개씩
	</c:when>
	</c:choose>
	<c:choose >
	<c:when test="${scri.sort == null}">
	최신순
	</c:when>
	<c:when test="${scri.sort eq ''}">
	최신순
	</c:when>
	<c:when test="${scri.sort eq 'bno'}">
	최신순
	</c:when>
	<c:when test="${scri.sort eq 'replyCount'}">
	댓글순
	</c:when>
	<c:when test="${scri.sort eq 'viewCount'}">
	조회순
	</c:when>
	<c:when test="${scri.sort eq 'likeCount'}">
	조회순
	</c:when>
	</c:choose>
			</h6>
		</div>

		<div class="card-body">
			<div class="table-responsive">
				<form role="form" method="get" >
			<c:choose>
			<c:when test="${scri.bgno == 19 or scri.bgno == 20 or scri.bgno == 21 or scri.bgno == 22 or scri.bgno == 23}">
			<button type="button" onclick="location.href='/board/writeView?bgno=${scri.bgno}'" class="btn btn-success mb-3"> <i class="fas fa-edit mr-2"></i>Q&A 글 작성 </button>
			</c:when>
			<c:when test="${scri.bgno != 2}">
			<button type="button" onclick="location.href='/board/writeView?bgno=${scri.bgno}'" class="btn btn-success mb-3"> <i class="fas fa-edit mr-2"></i>새 글 작성 </button>
			</c:when>	
			<c:when test="${login.memberRank == 3}">
			<button type="button" onclick="location.href='/board/writeView?bgno=${scri.bgno}'" class="btn btn-success mb-3"> <i class="fas fa-edit mr-2"></i>공지사항 작성 </button>
			</c:when>	
			
		</c:choose>
				<button type="button" onclick="location.href='/board/list?bgno=${scri.bgno}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=likeCount'" class="btn btn-outline-dark float-right">추천순</button>
				<button type="button" onclick="location.href='/board/list?bgno=${scri.bgno}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=viewCount'" class="btn btn-outline-dark float-right " >조회순</button>
				<button type="button" onclick="location.href='/board/list?bgno=${scri.bgno}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=replyCount'" class="btn btn-outline-dark float-right" data-bs-toggle="button" >댓글순</button>
				<button type="button" onclick="location.href='/board/list?bgno=${scri.bgno}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=bno'" class="btn btn-outline-dark float-right ">최신순</button>
				
				
				<button class="btn btn-dark dropdown-toggle float-right" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    ${scri.perPageNum}
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <a class="dropdown-item" href="/board/list?bgno=${scri.bgno}&page=${scri.page}&perPageNum=10&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort}">10개씩</a>
    <a class="dropdown-item" href="/board/list?bgno=${scri.bgno}&page=${scri.page}&perPageNum=20&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort}">20개씩</a>
    <a class="dropdown-item" href="/board/list?bgno=${scri.bgno}&page=${scri.page}&perPageNum=30&searchType=${scri.searchType}&keyword=${scri.keyword}&sort=${scri.sort}">30개씩</a>
  </div>
					<table class="table table-hover" width="100%" cellspacing="0"     >
						<thead class="thead-dark">
							<tr>
								<th>번호</th>
								<th>카테고리</th>
								<th width="300px"  >제목</th>
								<th width="180px">작성자</th>
								<th>등록일</th>
								<th>조회</th>
								<th>추천</th>
							</tr>
						</thead>
						
						<c:forEach items="${notice}" var="notice">
						<tr>
						<td>#${notice.bno} </td>
						<td><strong>공지사항</strong> </td>
						<td><a href="/board/readView?bno=${notice.bno}&
															bgno=2&
															page=${scri.page}&
															perPageNum=${scri.perPageNum}&
															searchType=${scri.searchType}&
															keyword=${scri.keyword}&
															sort=${scri.sort}"
															> <strong>[공지] ${notice.title} </strong></a></td>
						<td><strong>관리자</strong></td>
						<td><fmt:formatDate value="${notice.regdate}"
										pattern="yy-MM-dd  hh:mm" /></td>
						<td>${notice.hit} </td>
						<td>${notice.likehit} </td>
						
						
						</tr>
						</c:forEach>
						
				<c:forEach items="${list}" var="list">		
						
						<c:choose >
	<c:when test="${not empty login and list.bno == list.boardCheckVO.bno and list.boardCheckVO.memberId == login.memberId}">
	<tr class="table-active">
	</c:when>
	<c:otherwise>
	<tr>
	</c:otherwise>
	</c:choose>
					
						
						
								<td>#<c:out value="${list.bno}" /></td>
								<td>	
	<%@include file="../includes/listCategory.jsp"%>
	</td>

								<td>
								
								
								<a href="/board/readView?bno=${list.bno}&
															bgno=${scri.bgno}&
															page=${scri.page}&
															perPageNum=${scri.perPageNum}&
															searchType=${scri.searchType}&
															keyword=${scri.keyword}&
															sort=${scri.sort}"
															<c:choose >
															<c:when test="${list.likehit > 20}"> style="color: red" </c:when>
															<c:otherwise>
															style="color: black"	
															</c:otherwise>
															</c:choose>
															> 
	
														<strong><c:out value="${list.title}" /></strong></a> <strong> [${list.replyhit}] </strong> 
														 <c:if test="${list.questioncheck == 1}"><i class="fas fa-check-circle float-right" style ="color:red"></i> </c:if>
														 <c:if test="${list.questioncheck == 0}">
														 <c:if test="${list.bgno == 19 or list.bgno == 20 or list.bgno == 21 or list.bgno == 22 or list.bgno == 23}">
														 <i class="far fa-check-circle float-right" style ="color:dark">${list.helppoint}</i>
														  </c:if>
														  </c:if>
													
														</td>

								<td>
								<a href="/board/mypageView?select=log&memberId=${list.id}" style="color: black">
								 <img src="/image/${list.memberVO.memberImg}" style=" max-width: 25px;  height: 25px; border: 0px; border-radius:50%;"> 
								<c:out value="${list.memberVO.memberName}" /> </a>
								<span style="font-size: 10px"><i class="fas fa-heart" style="color:red"></i>${list.memberVO.memberPoint}</span>
								<span style="font-size: 10px"><i class="fa fa-bolt" style="color:blue" aria-hidden="true"></i>${list.memberVO.memberDevPoint}</span>

</td>
								<td><fmt:formatDate value="${list.regdate}"
										pattern="MM-dd  hh:mm" /></td>
								<td><c:out value="${list.hit} " /></td>
								<td><c:out value="${list.likehit}"/></td>
							</tr>
							

						</c:forEach>
						</tbody>
					</table>
					
				
				
						<ul class="pagination">

					<c:if test="${pageMaker.prev}">
						<li class="page-item"><a class="page-link"
							href="/board/list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="idx">
						<li
							class="page-item ${pageMaker.cri.page == idx ? 'active' : ''  }"><a
							class="page-link" href="/board/list${pageMaker.makeSearch(idx)}">${idx}
						</a></li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li class="page-item"><a class="page-link"
							href="/board/list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
					</c:if>
				</ul>
				
				<hr>
					<div class="input-group" style="width:700px">
					<div class="search" >
						<select name="searchType" class="form-control mb-1" >
							<option value="tcw"
								<c:out value="${scri.searchType eq 'tcw' ? 'selected' : ''}"/>>전체</option>
							<option value="t"
								<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
							<option value="c"
								<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
							<option value="w"
								<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
							<option value="tc"
								<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
						</select> 
						
						<input type="text" name="keyword" id="keywordInput"
						class="form-control"
						placeholder="Search for..." value="${scri.keyword}" />
						
						
						<button class ="btn btn-dark" id="searchBtn" type="button">	<i class="fas fa-search fa-sm mr-3"></i>검색</button>
						
						</div>
						</div>
					
						<script>
							$(function() {
								$('#searchBtn')
										.click(
												function() {
													self.location = "list"
															+ '${pageMaker.makeQuery(1)}'
															+ "&searchType="
															+ $(
																	"select option:selected")
																	.val()
															+ "&keyword="
															+ encodeURIComponent($(
																	'#keywordInput')
																	.val());
															
												});
							});
						</script>
		
				</form>


			


				
				<button type="button" onclick="location.href='/board/writeView?bgno=${scri.bgno}'" class="btn btn-success mb-3"> <i class="fas fa-edit mr-2"></i>새 글 작성</button>
			
			</div>
		</div>
		
	</div>
		<div class="card shadow mb-2 " style ="width:150px; height:400px;">
		<h2> 광고</h2>
		</div>
		<div class="card shadow mb-2 w-75" style =" height:100px;">
		<h2> 광고</h2>
		</div>
		</div>
		
		</div>


<!-- /.container-fluid -->


<%@include file="../includes/footer.jsp"%>