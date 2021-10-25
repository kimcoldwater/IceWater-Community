<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">



$(document).ready(function(){
	
	$("#cancle_btn").on("click", function(){
		
		var cancleYN = confirm("취소하시겠습니까?")
		if(cancleYN == true){
			location.href = "/board/list?bgno=${scri.bgno}&sort=${scri.sort}"
		}else{
			return false;
		}
		
		
	
	
	});
	
	var formObj = $("form[name='writeForm']");


	$("#write_btn").on("click", function(){
		if(fn_valiChk()){
			return false;
		}
		formObj.attr("action", "/board/write");
		formObj.attr("method", "post");
		formObj.submit();
	});
	fn_addFile();
})
	
 
 
	function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			} 
		}

function fn_addFile(){
	var fileIndex = 1;
	//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
	$("#fileAdd_btn").on("click", function(){
		$("#fileIndex").append("<div ><input class='file-path validate' type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
		
	});
	$(document).on("click","#fileDelBtn", function(){
		$(this).parent().remove();
		
	});
}


</script>

<%@include file="../includes/header.jsp"%>

<div class="row" style="margin-bottom:20px; margin-left:1px;">
<div class="col-lg-12">
<h1 class="page-header">글작성</h1>
</div>
</div>

<div class="panel" style="margin-left:1px;">
<div id="contAreaBox">
<div class="panel">
<div class="panel-body">
<form name="writeForm" role="form" action="/board/write" method="post" enctype="multipart/form-data">
<div class="table-responsive" style="text-align:center;">
   <input type="hidden" name="bgno" value="${scri.bgno}"/> 
   <input type="hidden" name="id" id="id" value="${login.memberId}">
  
	<table id="datatable-scroller"
		class="table table-bordered tbl_Form">
		<caption></caption>
		<colgroup>
			<col width="250px" />
			<col />
		</colgroup>
		<tbody>
			<tr>
			<th class="active">카테고리</th>
			<td>
			<c:choose>
				<c:when test="${bgno == 19 or bgno == 20 or bgno == 21 or bgno == 22 or bgno == 23}">
			<select  name="bgnoinsert" class="chk" id="bgnoinsert" title="Q&A게시판을 선택하세요">
							
							<option value="" >Q&A 게시판을 선택해주세요</option>
														
							<option value="20" <c:if test="${scri.bgno == 20 or scri.bgno == 19}">selected </c:if>>개발</option>
							<option value="21" <c:if test="${scri.bgno == 21}">selected </c:if>>언어</option>
							<option value="22" <c:if test="${scri.bgno == 22}">selected </c:if>>알고리즘</option>
							<option value="23" <c:if test="${scri.bgno == 23}">selected </c:if>>고민</option>
							
										
						</select> 
			</c:when>
			<c:otherwise>
			<select  name="bgnoinsert" class="chk" id="bgnoinsert" title="게시판을 선택하세요">
							
							<option value="" > 게시판을 선택해주세요</option>
							<option value="1" <c:if test="${scri.bgno == 1}">selected </c:if>>자유</option>
							<option value="2" <c:if test="${scri.bgno == 2}">selected </c:if>>공지사항</option>
							<option value="3" <c:if test="${scri.bgno == 3}">selected </c:if>>취업준비</option>
							<option value="4" <c:if test="${scri.bgno == 4}">selected </c:if>>회사생활</option>
							<option value="5" <c:if test="${scri.bgno == 5}">selected </c:if>>이직/커리어</option>
							<option value="6" <c:if test="${scri.bgno == 6}">selected </c:if>>썰/연애</option>
							<option value="7" <c:if test="${scri.bgno == 7}">selected </c:if>>투자</option>
							<option value="8" <c:if test="${scri.bgno == 8}">selected </c:if>>여행/먹방</option>
							<option value="9" <c:if test="${scri.bgno == 9}">selected </c:if>>헬스/다이어트</option>
							<option value="10" <c:if test="${scri.bgno == 10}">selected </c:if>>패션/뷰티</option>
							<option value="11" <c:if test="${scri.bgno == 11}">selected </c:if>>스포츠</option>
							<option value="12" <c:if test="${scri.bgno == 12}">selected </c:if>>반려동물</option>
							<option value="13" <c:if test="${scri.bgno == 13}">selected </c:if>>유머</option>
							<option value="14" <c:if test="${scri.bgno == 14}">selected </c:if>>게임</option>
							<option value="15" <c:if test="${scri.bgno == 15}">selected </c:if>>결혼생활</option>
							<option value="16" <c:if test="${scri.bgno == 16}">selected </c:if>>자동차</option>
							<option value="17" <c:if test="${scri.bgno == 17}">selected </c:if>>취미생활</option>
							<option value="18" <c:if test="${scri.bgno == 18}">selected </c:if>>장터</option>
														
							<option value="20" <c:if test="${scri.bgno == 20 or scri.bgno == 19}">selected </c:if>>개발</option>
							<option value="21" <c:if test="${scri.bgno == 21}">selected </c:if>>언어</option>
							<option value="22" <c:if test="${scri.bgno == 22}">selected </c:if>>알고리즘</option>
							<option value="23" <c:if test="${scri.bgno == 23}">selected </c:if>>고민</option>
							<option value="25" <c:if test="${scri.bgno == 25 or scri.bgno == 24}">selected </c:if>>IT NEWS</option>
							<option value="26" <c:if test="${scri.bgno == 26}">selected </c:if>>Tips</option>
							<option value="27" <c:if test="${scri.bgno == 27}">selected </c:if>>IT행사</option>
							<option value="28" <c:if test="${scri.bgno == 28}">selected </c:if>>장비사용기</option>
							<option value="29" <c:if test="${scri.bgno == 29}">selected </c:if>>구인</option>
							<option value="30" <c:if test="${scri.bgno == 30}">selected </c:if>>구직</option>
							<option value="31" <c:if test="${scri.bgno == 31}">selected </c:if>>기업리뷰</option>
							<option value="32" <c:if test="${scri.bgno == 32}">selected </c:if>>Devlong</option>
							
										
						</select> 
			
		</c:otherwise>
		
				
		
			</c:choose>
						</td>
			</tr>
		<c:if test="${bgno == 19 or bgno == 20 or bgno == 21 or bgno == 22 or bgno == 23}">
			
			<tr>
			<th class="active">내공</th>
			<td>
				<select  name="helppoint" class="chk" id="helppoint" title="Q&A게시판을 선택하세요">
							
							<option value="0" >0</option>
			<c:if test="${point >= 10 }"><option value="10" >10</option></c:if>
			<c:if test="${point >= 20 }"><option value="20" >20</option></c:if>
			<c:if test="${point >= 30 }"><option value="30" >30</option></c:if>
			<c:if test="${point >= 40 }"><option value="40" >40</option></c:if>
			<c:if test="${point >= 50 }"><option value="50" >50</option></c:if>
			<c:if test="${point >= 80 }"><option value="80" >80</option></c:if>
			<c:if test="${point >= 100 }"><option value="100" >100</option></c:if>
						
										
						</select> 				
			
			</td>
			
			</tr>
			</c:if>
			<tr>
				<th class="active" >작성자</th>
				<td class="form-inline"><input id="writer"
					name="writer" class="chk" value="${login.memberName}" style="width:200px" readonly/>
				</td>
			</tr>
			<tr>
				<th class="active">제목</th>
				<td class="form-inline"><input type="text" id="title"
					name="title" class="chk" title="제목을 입력하세요." style="width: 840px" />
				</td>
			</tr>
			
			

				<tr>
				<th class="active" >내용</th>
				<td class="form-inline"><textarea 
						id="myEditor" name="content"
						class="chk" title="내용을 입력하세요."></textarea></td>
			</tr>
		
			<tr><td id="fileIndex">
			
			<div>  
			 <button id="fileAdd_btn" class="btn btn-primary" type="button">파일추가+</button>
			</div>
			</td></tr>
		</tbody>
	</table>
	
</div>

<div style="margin-left:1px;">
	<button type="submit" class="btn btn-primary" id="write_btn" >등록</button>
	<button type="button" class="btn btn-danger" id="cancle_btn">취소</button>
</div>

</form>
</div>
</div>
</div>
</div>

  
    <script>
        $(document).ready(function () {

            $('#myEditor').summernote({
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
<%@include file="../includes/footer.jsp"%>


