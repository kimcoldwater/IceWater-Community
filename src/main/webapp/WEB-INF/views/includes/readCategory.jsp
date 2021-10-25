<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:choose >
	
	<c:when test="${read.bgno == 1}">
	자유게시판
	</c:when>
	<c:when test="${read.bgno == 2}">
	공지사항
	</c:when>
	<c:when test="${read.bgno == 3}">
	취업준비
	</c:when>
	<c:when test="${read.bgno == 4}">
	회사생활
	
	</c:when>
	<c:when test="${read.bgno == 5}">
	이직 · 커리어
	</c:when>
	<c:when test="${read.bgno == 6}">
	썸 · 연애
	</c:when>
	<c:when test="${read.bgno == 7}">
	투자
	</c:when>
	<c:when test="${read.bgno == 8}">
	여행 · 먹방
	</c:when>
	<c:when test="${read.bgno == 9}">
	헬스 · 다이어트
	</c:when>
	<c:when test="${read.bgno == 10}">
	패션 · 뷰티 
	</c:when>
	<c:when test="${read.bgno == 11}">
	스포츠 
	</c:when>
	<c:when test="${read.bgno == 12}">
	반려동물 
	</c:when>
	<c:when test="${read.bgno == 13}">
	유머 
	</c:when>
	<c:when test="${read.bgno == 14}">
	게임
	</c:when>
	<c:when test="${read.bgno == 15}">
	결혼·육아
	</c:when>
	<c:when test="${read.bgno == 16}">
	자동차
	</c:when>
	<c:when test="${read.bgno == 17}">
	취미생활
	</c:when>
	<c:when test="${read.bgno == 18}">
	장터
	</c:when>
	<c:when test="${read.bgno == 19}">
	Q & A All
	</c:when>
	<c:when test="${read.bgno == 20}">
	개발
	</c:when>
	<c:when test="${read.bgno == 21}">
	언어
	</c:when>
	<c:when test="${read.bgno == 22}">
	알고리즘
	</c:when>
	<c:when test="${read.bgno == 23}">
	고민
	</c:when>
	
	<c:when test="${read.bgno == 25}">
	IT NEWS
	</c:when> 
	
	<c:when test="${read.bgno == 26}">
	Tips & 강좌
	</c:when>
	<c:when test="${read.bgno == 27}">
	IT행사 
	</c:when>
	<c:when test="${read.bgno == 28}">
	장비사용기
	</c:when>
	<c:when test="${read.bgno == 29}">
	구인
	</c:when>
	<c:when test="${read.bgno == 30}">
	구직
	</c:when>
	<c:when test="${read.bgno == 31}">
	기업 리뷰 게시판 입니다. 
	</c:when>
	
	
	

	
	</c:choose>