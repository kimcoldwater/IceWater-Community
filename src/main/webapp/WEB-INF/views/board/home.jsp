<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<%@include file="../includes/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">IceWater</h1>
		<a href="/board/startPage"
			class="d-none d-sm-inline-block btn btn-sm btn-dark shadow-sm">포트폴리오
			소개페이지 </a>
	</div>



	<div class="row">

		<!-- Area Chart -->
		<div class="col-xl-8 col-lg-8">
			<div class="card shadow mb-4 ">
				<!-- Card Header - Dropdown -->
				<div
					class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-dark">
					<h6 class="m-0 font-weight-bold text-white">Weekly Best (1주내
						가장 많은 추천수)</h6>

				</div>
				<!-- Card Body -->
				<div class="card-body">
					<div>
						<!-- list -->


						<table class="table table-borderless table-sm" width="100%"
							cellspacing="0">


							<c:forEach items="${list}" var="list" begin="0" end="10">

								<c:choose>
									<c:when
										test="${not empty login and list.bno == list.boardCheckVO.bno and list.boardCheckVO.memberId == login.memberId}">
										<tr class="table-active">
									</c:when>
									<c:otherwise>
										<tr>
									</c:otherwise>
								</c:choose>

								<td width="100px"><strong><%@include
											file="../includes/listCategory.jsp"%></strong>
								</td>


								<td width="35%"><a
									href="/board/readView?bno=${list.bno}&
															bgno=${list.bgno}"
									style="color: red"> <strong>${list.title} </strong></a></td>



								<td><strong><a
										href="/board/mypageView?select=log&memberId=${list.id}"
										style="color: black"> <img
											src="/image/${list.memberVO.memberImg}"
											style="max-width: 25px; height: 25px; border: 0px; border-radius: 50%;">
											<c:out value="${list.memberVO.memberName}" />
									</a> <span style="font-size: 8px"><i class="fas fa-heart"
											style="color: red"></i>${list.memberVO.memberPoint}</span> <span
										style="font-size: 8px"><i class="fa fa-bolt"
											style="color: blue" aria-hidden="true"></i>${list.memberVO.memberDevPoint}</span>
								</strong></td>


								<td><fmt:formatDate value="${list.regdate}" pattern="MM-dd" /></td>
								<td><i class="far fa-eye mr-1"></i>
								<c:out value="${list.hit} " /></td>

								<td><i class="fas fa-thumbs-up mr-1" style="color: red;"></i>${list.likehit}
								</td>


								</tr>

							</c:forEach>
						</table>

					</div>
				</div>
			</div>
		</div>


		<!-- qna -->
		<div class="col-xl-4 col-lg-4">
			<div class="card shadow mb-4" style="height: 500px;">
				<!-- Card Header - Dropdown -->
				<div
					class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-success">
					<h6 class="m-0 font-weight-bold text-white">미채택 Q&A</h6>

				</div>
				<!-- Card Body -->
				<div class="card-body">
					<div>
						<table class="table table-borderless table-sm" width="100%"
							cellspacing="0">


							<c:forEach items="${qna}" var="qna" begin="0" end="12">

								<c:choose>
									<c:when
										test="${not empty login and qna.bno == qna.boardCheckVO.bno and qna.boardCheckVO.memberId == login.memberId}">
										<tr class="table-active">
									</c:when>
									<c:otherwise>
										<tr>
									</c:otherwise>
								</c:choose>



								<td width="50%"><a
									href="/board/readView?bno=${qna.bno}&
															bgno=${qna.bgno} "
									style="color: green"> <strong>${qna.title}
									</strong></a></td>


								<td><fmt:formatDate value="${qna.regdate}" pattern="MM-dd" /></td>

								<td><i class="far fa-check-circle" style="color: green"></i>${qna.helppoint}
								</td>


								</tr>

							</c:forEach>
						</table>



					</div>

				</div>
			</div>
		</div>


		<!-- Content Row -->
		<div class="row">
			<div class="col-lg-12 mb-4">
				<div class="card shadow mb-4" style="height: 500px;">
					<div class="card-header py-3 bg-danger">
						<h6 class="m-0 font-weight-bold text-white">인기글 (추천수 20이상
							최신순)</h6>
					</div>
					<div class="card-body">

						<div>

							<table class="table table-borderless table-sm" width="100%"
								cellspacing="0">


								<c:forEach items="${bestBoard}" var="list" begin="0" end="10">

									<c:choose>
										<c:when
											test="${not empty login and list.bno == list.boardCheckVO.bno and list.boardCheckVO.memberId == login.memberId}">
											<tr class="table-active">
										</c:when>
										<c:otherwise>
											<tr>
										</c:otherwise>
									</c:choose>

									<td width="200px"><strong><%@include
												file="../includes/listCategory.jsp"%></strong>
									</td>


									<td width="35%"><a
										href="/board/readView?bno=${list.bno}&
															bgno=${list.bgno}"
										style="color: red"> <strong>${list.title} </strong></a></td>



									<td><strong><a
											href="/board/mypageView?select=log&memberId=${list.id}"
											style="color: black"> <img
												src="/image/${list.memberVO.memberImg}"
												style="max-width: 25px; height: 25px; border: 0px; border-radius: 50%;">
												<c:out value="${list.memberVO.memberName}" />
										</a> <span style="font-size: 8px"><i class="fas fa-heart"
												style="color: red"></i>${list.memberVO.memberPoint}</span> <span
											style="font-size: 8px"><i class="fa fa-bolt"
												style="color: blue" aria-hidden="true"></i>${list.memberVO.memberDevPoint}</span>
									</strong></td>


									<td><fmt:formatDate value="${list.regdate}"
											pattern="MM-dd" /></td>
									<td><i class="far fa-eye mr-1"></i>
									<c:out value="${list.hit} " /></td>

									<td><i class="fas fa-thumbs-up mr-1" style="color: red;"></i>${list.likehit}
									</td>


									</tr>

								</c:forEach>
							</table>

						</div>


					</div>
				</div>
			</div>
			<!-- Content Column -->
			<div class="col-lg-6 mb-4">

				<!-- 자유카테고리 -->
				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-info">
						<h6 class="m-0 font-weight-bold text-white">자유(2일내 추천수순)</h6>
					</div>
					<div class="card-body">
						<div>
							<table class="table table-borderless table-sm" width="100%"
								cellspacing="0">


								<c:forEach items="${best1}" var="list" begin="0" end="4">

									<c:choose>
										<c:when
											test="${not empty login and list.bno == list.boardCheckVO.bno and list.boardCheckVO.memberId == login.memberId}">
											<tr class="table-active">
										</c:when>
										<c:otherwise>
											<tr>
										</c:otherwise>
									</c:choose>

									<td width="50px"></td>

									<td width="50%"><a
										href="/board/readView?bno=${list.bno}&
															bgno=${list.bgno} "
										style="color: red"> <strong>${list.title}
										</strong></a></td>


									<td><fmt:formatDate value="${list.regdate}"
											pattern="MM-dd" /></td>

									<td><i class="far fa-eye mr-1"></i>${list.hit}</td>


									</tr>

								</c:forEach>
							</table>

						</div>

					</div>
				</div>

				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-info">
						<h6 class="m-0 font-weight-bold text-white">회사생활</h6>
					</div>
					<div class="card-body">
						<div>
							<table class="table table-borderless table-sm" width="100%"
								cellspacing="0">


								<c:forEach items="${best4}" var="list" begin="0" end="4">

									<c:choose>
										<c:when
											test="${not empty login and list.bno == list.boardCheckVO.bno and list.boardCheckVO.memberId == login.memberId}">
											<tr class="table-active">
										</c:when>
										<c:otherwise>
											<tr>
										</c:otherwise>
									</c:choose>

									<td width="50px"></td>

									<td width="50%"><a
										href="/board/readView?bno=${list.bno}&
															bgno=${list.bgno} "
										style="color: red"> <strong>${list.title}
										</strong></a></td>


									<td><fmt:formatDate value="${list.regdate}"
											pattern="MM-dd" /></td>

									<td><i class="far fa-eye mr-1"></i>${list.hit}</td>


									</tr>

								</c:forEach>
							</table>

						</div>
					</div>
				</div>

				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-dark">
						<h6 class="m-0 font-weight-bold text-white">카테고리 추가 시</h6>
					</div>
					<div class="card-body"></div>
				</div>

				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-dark">
						<h6 class="m-0 font-weight-bold text-white">Projects</h6>
					</div>
					<div class="card-body"></div>
				</div>



			</div>

			<div class="col-lg-6 mb-4">



				<!-- 오른쪽 -->
				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-info">
						<h6 class="m-0 font-weight-bold text-white">취업준비</h6>
					</div>
					<div class="card-body">
						<div>
							<table class="table table-borderless table-sm" width="100%"
								cellspacing="0">


								<c:forEach items="${best3}" var="list" begin="0" end="4">

									<c:choose>
										<c:when
											test="${not empty login and list.bno == list.boardCheckVO.bno and list.boardCheckVO.memberId == login.memberId}">
											<tr class="table-active">
										</c:when>
										<c:otherwise>
											<tr>
										</c:otherwise>
									</c:choose>

									<td width="50px"></td>

									<td width="50%"><a
										href="/board/readView?bno=${list.bno}&
															bgno=${list.bgno} "
										style="color: red"> <strong>${list.title}
										</strong></a></td>


									<td><fmt:formatDate value="${list.regdate}"
											pattern="MM-dd" /></td>

									<td><i class="far fa-eye mr-1"></i>${list.hit}</td>


									</tr>

								</c:forEach>
							</table>

						</div>
					</div>
				</div>

				<!-- Approach -->
				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-info">
						<h6 class="m-0 font-weight-bold text-white">썸·연애</h6>
					</div>
					<div class="card-body">
						<div>
							<table class="table table-borderless table-sm" width="100%"
								cellspacing="0">


								<c:forEach items="${best6}" var="list" begin="0" end="4">

									<c:choose>
										<c:when
											test="${not empty login and list.bno == list.boardCheckVO.bno and list.boardCheckVO.memberId == login.memberId}">
											<tr class="table-active">
										</c:when>
										<c:otherwise>
											<tr>
										</c:otherwise>
									</c:choose>

									<td width="50px"></td>

									<td width="50%"><a
										href="/board/readView?bno=${list.bno}&
															bgno=${list.bgno} "
										style="color: red"> <strong>${list.title}
										</strong></a></td>


									<td><fmt:formatDate value="${list.regdate}"
											pattern="MM-dd" /></td>

									<td><i class="far fa-eye mr-1"></i>${list.hit}</td>


									</tr>

								</c:forEach>
							</table>

						</div>
					</div>
				</div>


				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-dark">
						<h6 class="m-0 font-weight-bold text-white">카테고리 추가 시</h6>
					</div>
					<div class="card-body"></div>
				</div>



				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-dark">
						<h6 class="m-0 font-weight-bold text-white">Projects</h6>
					</div>
					<div class="card-body"></div>
				</div>





			</div>
		</div>

	</div>
</div>

<!-- /.container-fluid -->

<%@include file="../includes/footer.jsp"%>
<!-- Page level plugins -->
<script src="/resources/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="/resources/js/demo/chart-area-demo.js"></script>
<script src="/resources/js/demo/chart-pie-demo.js"></script>
