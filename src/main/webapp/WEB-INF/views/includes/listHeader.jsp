
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:choose >
	<c:when test="${scri.bgno == 0}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;All</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp; 커뮤니티 All 
	</p>
	</c:when>
	
	<c:when test="${scri.bgno == 1}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;자유게시판</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;자유로운 주제의 커뮤니티입니다. <a
			target="_blank" href="#">링크</a>.
	</p>
	</c:when>
	<c:when test="${scri.bgno == 2}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;공지사항</h1>
	<p class="mb-4">
		 &nbsp; &nbsp; &nbsp; 공지사항은 관리자만 작성가능합니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 3}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;취업준비</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;취업준비 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 4}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;회사생활</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;회사생활 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 5}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;이직 · 커리어</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;이직 · 커리어 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 6}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;썸 · 연애</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;썸 · 연애 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 7}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;투자</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;부동산 · 주식 · 코인 관련 투자 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 8}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;여행 · 먹방</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;여행 · 먹방 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 9}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;헬스 · 다이어트</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;헬스 · 다이어트 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 10}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;패션 · 뷰티 </h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;패션 · 뷰티 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 11}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;스포츠 </h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;스포츠 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 12}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;반려동물 </h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;반려동물 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 13}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;유머 </h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;유머 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 14}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;게임</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;게임 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 15}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;결혼·육아</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;결혼·육아 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 16}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;자동차</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;자동차 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 17}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;취미생활</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp; 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 18}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;장터</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp; 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 19}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;Q & A All</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;Q & A All 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 20}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;개발</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;개발 관련 Q&A 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 21}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;언어</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;언어 관련 Q&A 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 22}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;알고리즘</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;알고리즘 관련 Q&A 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 23}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;고민</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;고민 상담 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 24}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;Tech All</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;Tech All 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 25}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;IT NEWS </h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;IT NEWS 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 26}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;Tips & 강좌</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;Tips & 강좌 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 27}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;IT행사 </h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;IT행사 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 28}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;장비사용기</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;장비사용기 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 29}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;구인</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;구인 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 30}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;구직</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;구직 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 31}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;기업 리뷰</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;기업 리뷰 게시판 입니다. 
	</p>
	</c:when>
	<c:when test="${scri.bgno == 32}">
	<h1 class="h3 mb-2 text-gray-800">&nbsp; &nbsp;Devlog</h1>
	<p class="mb-4">
		&nbsp; &nbsp; &nbsp;개발&공부 log 게시판 입니다. 
	</p>
	</c:when>
	
	

	
	</c:choose>