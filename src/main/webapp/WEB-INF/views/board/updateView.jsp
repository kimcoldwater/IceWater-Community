<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(document).on("click","#fileDel", function(){
				$(this).parent().remove();
			})
			
			fn_addFile();
			
			$("#cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/readView?bno=${update.bno}"
					+"&bgno=${scri.bgno}" 
						+"&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}"
					   + "&sort=${scri.sort}";
			})
			
			$("#update_btn").on("click", function(){
				
				
				if(fn_valiChk()){
					return false;
				}
				
				var updateYN = confirm("수정하시겠습니까?")
				if(updateYN == true){
				formObj.attr("action", "/board/update");
				formObj.attr("method", "post");
				formObj.submit();
				}else{
					return false;
				}
				
				

			})
		})
			
		function fn_valiChk(){
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){
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
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
 		var fileNoArry = new Array();
 		var fileNameArry = new Array();
 		function fn_del(value, name){
 			
 			fileNoArry.push(value);
 			fileNameArry.push(name);
 			$("#fileNoDel").attr("value", fileNoArry);
 			$("#fileNameDel").attr("value", fileNameArry);
 		}
		
	</script>

<%@include file="../includes/header.jsp"%>

<div class="row" style="margin-bottom:20px; margin-left:1px;">
<div class="col-lg-12">
<h1 class="page-header">글수정</h1>
</div>
</div>

<div class="panel" style="margin-left:1px;">
<div id="contAreaBox">
<div class="panel">
<div class="panel-body">
<form name="updateForm" role="form" method="post" action="/board/update" enctype="multipart/form-data">
					<input type="hidden" name="bno" value="${update.bno}" readonly="readonly"/>
				  <input type="hidden" id="bgno" name="bgno" value="${scri.bgno}"> 	
   <input type="hidden" id="page" name="page" value="${scri.page}"> 
  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
  <input type="hidden" id="sort" name="sort" value="${scri.sort}">
  	<input type="hidden" id="fileNoDel" name="fileNoDel[]" value=""> 
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value=""> 
 
<div class="table-responsive" style="text-align:center;">
	<table id="datatable-scroller"
		class="table table-bordered tbl_Form">
		<caption></caption>
		<colgroup>
			<col width="250px" />
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th class="active">제목</th>
				<td class="form-inline"><input type="text" id="title"
					name="title" class="chk" title="제목을 입력하세요" style="width: 840px" value="${update.title}"/>
				</td>
			</tr>
			<tr>
				<th class="active" >작성자</th>
				<td class="form-inline"><input id="writer"
					name="writer" class="chk" style="width: 200px" value="${update.writer}" readonly/>
				</td>
			</tr>
			<tr>
				<th class="active" >내용</th>
					<td class="form-inline"><textarea 
						id="myEditor" name="content"
						class="chk" > <c:out value="${update.content}" /></textarea></td>	
			
			</tr>
			
			<tr>
								<td id="fileIndex">
									<c:forEach var="file" items="${file}" varStatus="var">
									<div>
										<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
										<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
										<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
										<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');" type="button">삭제</button><br>
									</div>
									</c:forEach>
								</td>
							</tr>
			
		</tbody>
	</table>
</div>
<div style="margin-left:1px;">
	<button type="button" id="update_btn" class="btn btn-primary" >수정</button>
	<button type="button" id="cancel_btn" class="btn btn-primary">취소</button>
	<button type="button" id="fileAdd_btn" class="btn btn-primary">파일추가</button>
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