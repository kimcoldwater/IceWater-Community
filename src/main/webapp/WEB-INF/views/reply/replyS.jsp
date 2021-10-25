<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<script >
var bno = '${read.bno}'; //게시글 번호

var bgno = '${read.bgno}';

var writer = '${login.memberId}' ;

var login = "${login}";

var helppoint = "${read.helppoint}";

var questionid = "${read.questionid}";

var readWriter = '${read.id}';

var readTitle = '${read.title}';

var rank = '${login.memberRank}';

$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    
	//var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
  	var insertData = new FormData($('#commentInsertForm')[0]);
    commentInsert(insertData); //Insert 함수호출(아래)
});
 
 
 
//댓글 목록 
function commentList(){
	
	
    $.ajax({
        url : '/reply/readReply',
        type : 'get',
        data : {'bno':bno },
        success : function(data){
            var a =''; 
            if(data<1){
            	a +='<h2>등록된 댓글이 없습니다</h2> ';}
            
            $.each(data, function(key, value){ 
            	
            	var ID = String(value.id);
            	
                a += '<div class="card shadow mb-2" >';
                a += '<div class="commentInfo'+value.rno+' ml-2 mb-2 ">'+'# '+value.rno+' <br/> ';
                
                a += '<a href="/board/mypageView?select=log&memberId='+value.memberVO.memberId+'" style="color: black">';
				a += '<img src="/image/'+value.memberVO.memberImg+'" style=" max-width: 30px;  height: 30px; border: 0px; border-radius:50%;"> ';
                
                a += '<span style="font-size: 25px">'+value.memberVO.memberName+'</span> </a>';
                a += '<span style="font-size: 10px"><i class="fas fa-heart ml-1" style="color:red"></i></span>'+value.memberVO.memberPoint+'';
                a += '<span style="font-size: 12px"><i class="fa fa-bolt ml-1" style="color:blue" aria-hidden="true"></i></span>'+value.memberVO.memberDevPoint;
                a += '<div class="commentDate'+value.rno+' mb-4 ">         '+value.regdate+'</div>' ;
                a += '<tr><td class="commentContent'+value.rno+'"> '+value.content +'</td><tr> <br/>';
                
                if(writer == value.id){
                    a += '<button type="button" class="btn btn-success mr-2" onclick="commentUpdate('+value.rno+');"> 수정 </button>';
                
               
                a += '<button type="button" class="btn btn-dark mr-2" onclick="commentDelete('+value.rno+');"> 삭제 </button> ';
                }
                
                if(rank == 3){
                	 a += '<button type="button" class="btn btn-success mr-2" onclick="commentUpdate('+value.rno+');"> 수정 </button>';
                     
                     
                     a += '<button type="button" class="btn btn-dark mr-2" onclick="commentDelete('+value.rno+');"> 삭제 </button> ';
                }
                
                
                if(${login != null}){
               a +='<button type="button" class="btn btn-warning mr-2" onclick="commentLike('+value.bno+','+value.rno+' ,\''+value.id+'\')">'+value.likehit+' <i class="fas fa-thumbs-up"></i></button>'; 
               a +='<button type="button" class="btn btn-danger mr-2" onclick="commentHate('+value.bno+','+value.rno+' , \''+value.id+'\')">'+value.hatehit+' <i class="fas fa-thumbs-down"></i></button>'; 
               if( bgno == 19 || bgno == 20 || bgno == 21 || bgno == 22 ||  bgno == 23 ||  bgno == 24|| bgno == 25|| bgno == 26|| bgno == 27|| bgno == 28 || bgno == 32){
               a +='<button type="button" class="btn btn-primary mr-2" onclick="commentDev('+value.bno+','+value.rno+' , \''+value.id+'\')">'+value.devhit+' <i class="fab fa-dev"></i></button>';
				if(${read.questioncheck == 0 && read.id == login.memberId}) {   
					if(value.id != writer){
               a +='<button type="button" class="btn btn-success float-right" onclick="questionCheck('+value.bno+','+helppoint+',\''+value.id+'\','+value.rno+')"> <i class="far fa-check-circle fa-4x"></i> </button> ';
					}
					}
               }
              }
                if(${read.questioncheck == 1}){
				if(value.rno == questionid ){
				a +='<i class="fas fa-check-circle float-right fa-4x" style ="color:red"></i>';
				 }
                }

                a += '  </div> </div> ';
            });
            
            $(".commentList").html(a);
        }
    });
}

//채택
function questionCheck(bno,helppoint,id,rno){
	 $.ajax({
         type : "POST",  
         url : "/board/questionCheck",       
         dataType : "json",   
         data : {'bno' : bno ,'helppoint' : helppoint, 'Id' : id,'rno':rno, 'memberId':writer},
         error : function(){
            alert("통신 에러");
         },
         success : function(questionCheck) {
             
                 if(questionCheck == 1){
                 	alert("채택완료");
                 	location.reload();
                 }
                 else if (likeCheck == 2){
                  alert("채택문제발생");
                  commentList();
             }
                 
               //소켓
          		if(socket){
       			let socketMsg = "questionCheck,"+id+","+readWriter+","+bno+","+readTitle+","+bgno;
       			console.log(socketMsg);
       			socket.send(socketMsg);
       		}
              //소켓끝
              
         }
     });
	 
	 
		//알람
		
	 $.ajax({
	        url : '/board/insertAlram',
	        type : 'post',
	        data : {'toId': writer , 'fromId': id , 'bno':bno,'title':readTitle, 'categori': "questionCheck",'bgno':bgno },
	        dataType : "json", 
	        success : function(alram){
	         		alret("알람입력성공");
	              if(alram == 1){
	            	  alert("알람입력성공")
	              }else{
	            	  alert("알람입력실패")
	              }
	        }
	    
	    });
	//알람끝
	 
	 
}

//좋아요
function commentLike(bno,rno,id){ 
	
    $.ajax({
           type : "POST",  
           url : "/reply/commentLike",       
           dataType : "json",   
           data :{'bno' : bno ,'rno' : rno, 'writerId' : id , 'memberId' : writer},
           error : function(){
              alert("통신 에러","error","확인",function(){});
           },
           success : function(likeCheck) {
        	 
        	   
                   if(likeCheck == 0){
                   	alert("추천완료.");
                   	commentList();
      
                   	
                    //소켓
                    if(id != writer){
                	if(socket){
                		let socketMsg = "commentLike,"+id+","+writer+","+bno+","+readTitle+","+bgno;
                		console.log(socketMsg);
                		socket.send(socketMsg);
                	}
                    }
                //소켓끝    
                   	
                   }
                   else if (likeCheck == 1){
                    alert("추천취소");
                    commentList();

                   
               }else if(likeCheck == 2){
               	alert("이미 반대하셨습니다");
               }
                   
                 
           }
           
       });
}


//싫어요
function commentHate(bno,rno,id){ 
		     $.ajax({
		            type : "POST",  
		            url : "/reply/commentHate",       
		            dataType : "json",   
		            data : {'bno' : bno,'rno' : rno, 'writerId' : id , 'memberId' : writer},
		            error : function(){
		               alert("통신 에러","error","확인",function(){});
		            },
		            success : function(hateCheck) {
		                
		                    if(hateCheck == 0){
		                    	alert("반대완료.");
		                    	commentList();
		                    }
		                    else if (hateCheck == 1){
		                     alert("반대취소");
		                     commentList();
		                }else if(hateCheck == 2){
		                	alert("이미 추천하셨습니다.");
		                }
		            }
		        });
		 }
		 
//Dev
function commentDev(bno,rno,id){ 
    $.ajax({
           type : "POST",  
           url : "/reply/commentDev",       
           dataType : "json",   
           data : {'bno' : bno, 'rno' : rno, 'writerId' : id , 'memberId' : writer},
           error : function(){
              alert("통신 에러","error","확인",function(){});
           },
           success : function(devCheck) {
               
                   if(devCheck == 0){
                   	alert("DEV 완료.");
                   	commentList();
                   	
                    //소켓
                    if(id != writer){
                	if(socket){
                		let socketMsg = "commentDev,"+id+","+writer+","+bno+","+readTitle+","+bgno;
                		console.log(socketMsg);
                		socket.send(socketMsg);
                	}
                   }
                //소켓끝    
                
                   }
                   else if (devCheck == 1){
                    alert("DEV 취소");
                    commentList();
               }else if(devCheck == 2){
               	alert("이미 추천하셨습니다.");
               }
           }
       });
}
 
//댓글 등록
function commentInsert(insertData){
	console.debug("reply.socket",socket)
		
    $.ajax({
        url : '/reply/writeReply',
        type : 'post',
        data : insertData,
        processData: false, contentType: false,

        enctype : 'multipart/form-data', 
        success : function(data){
         
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=content]').val('');
           		$('.myEditor').summernote('reset');
                
           		//소켓
           		if(readWriter != writer){
           		if(socket){
        			let socketMsg = "reply,"+writer+","+readWriter+","+bno+","+readTitle+","+bgno;
        			console.log(socketMsg);
        			socket.send(socketMsg);
           		}
        	}
        }
    
    });
	
	//알람
	if(readWriter != writer){
	 $.ajax({
	        url : '/board/insertAlram',
	        type : 'post',
	        data : {'toId': writer , 'fromId': readWriter , 'bno':bno,'title':readTitle, 'categori': "reply",'bgno':bgno },
	        dataType : "json", 
	        success : function(alram){
	         		alret("알람입력성공");
	              if(alram == 1){
	            	  alert("알람입력성공")
	              }else{
	            	  alert("알람입력실패")
	              }
	        }
	    
	    });
	}
	//알람끝
	
	
	
}
 //댓글등록끝
 
 
//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function commentUpdate(rno){
	
    var a ='';
    
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="content_'+rno+'" />';
    a += '<span class="input-group-btn"><button class="btn btn-success" type="button" onclick="commentUpdateProc('+rno+');">수정</button>';
    a += '<button class="btn btn-bark" type="button" onclick="commentList()"> 취소</button> </span>';
    a += '</div>' ;
    
    $('.commentContent'+rno).html(a);
    
}
 
//댓글 수정
function commentUpdateProc(rno){
    var updateContent = $('[name=content_'+rno+']').val();
    
    $.ajax({
        url : '/reply/updateReply',
        type : 'post',
        data : {'content' : updateContent, 'rno' : rno},
        success : function(data){
            if(data == 1) commentList(bno); //댓글 수정후 목록 출력 
        }
    });
}

 
//댓글 삭제 
function commentDelete(rno){
    $.ajax({
        url : '/reply/deleteReply',
        type : 'post',
        data : {'rno' : rno , 'id' : writer},
        success : function(data){
           commentList(bno); //댓글 삭제후 목록 출력 
        }
    });
}
 

 
$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});
 
 
 
</script>
