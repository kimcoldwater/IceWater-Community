package kr.co.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.service.BoardService;
import kr.co.service.ReplyService;
import kr.co.vo.ReplyVO;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value ="/reply")
public class ReplyController {
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);

	@Inject
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	@RequestMapping(value = "/readReply")
	public List<ReplyVO> readReply(Model model,int bno)throws Exception{
		logger.info("readReply");
		
		return replyService.readReply(bno);
	}
	
	@RequestMapping(value = "/writeReply")
	public void writeReply(ReplyVO vo,int bgno,MultipartHttpServletRequest mpRequest)throws Exception{
		logger.info("writeReply");
		logger.info("mpRequest=" + mpRequest);
		
		if(bgno == 19 || bgno == 20 || bgno == 21 || bgno == 22 || bgno == 23) {
			service.upDevPoint(1 , vo.getId());
		}else {
			service.upPoint(1,vo.getId());
		}
		
		replyService.writeReply(vo,mpRequest);
	}
	
	@RequestMapping(value = "/updateReply")
	public int updateReply(ReplyVO vo) throws Exception{
		logger.info("updateReply");
		return replyService.updateReply(vo);
	}
	
	@RequestMapping(value = "/deleteReply")
	public void deleteReply(ReplyVO vo)throws Exception{
		logger.info("deleteReply");
		
		

	
	 replyService.deleteReply(vo);
	}
	
	
	@RequestMapping(value = "/commentLike")
	public int updateLike(int bno,int rno,  String memberId, String writerId,Model model)throws Exception{
	
		
			
		if(replyService.hateCheck(rno, memberId) == 1) {
			int likeCheck = 2;
		return likeCheck;
		
		}else {
			int likeCheck = replyService.likeCheck(rno, memberId);
			if(likeCheck == 0) {
				//좋아요 처음누름
				replyService.insertLike(bno, rno , memberId );//like테이블 삽입
				replyService.updateLike(rno);	//게시판테이블 +1
				replyService.memberPointPlus(writerId); //회원포인트 +1
				
			}else if(likeCheck == 1) {
				replyService.updateLikeCancel(rno); //게시판테이블 =1
				replyService.deleteLike(rno, memberId); //like테이블 삭제
				replyService.memberPointDown(writerId);
		
			}
			return likeCheck;
			}
	}
	
	
	@RequestMapping(value = "/commentHate")
	public int updateHate(int bno,int rno, String memberId,String writerId,Model model)throws Exception{
			if(replyService.likeCheck(rno, memberId) == 1) {
				int hateCheck = 2;
			return hateCheck;
			
			}else {
			int hateCheck = replyService.hateCheck(rno, memberId);
			if(hateCheck == 0) {
				//좋아요 처음누름
				replyService.insertHate(bno,rno,memberId); //like테이블 삽입
				replyService.updateHate(rno);	//게시판테이블 +1
				replyService.memberPointDown(writerId);
				
			}else if(hateCheck == 1) {
				replyService.updateHateCancel(rno); //게시판테이블 =1
				replyService.deleteHate(rno, memberId); //like테이블 삭제
				replyService.memberPointPlus(writerId);
				
			}
			return hateCheck;
			}
	
		
	}
	
	
	@RequestMapping(value = "/commentDev" )
	public int updateDev(int bno, int rno, String memberId,String writerId,Model model)throws Exception{
			int devCheck = replyService.devCheck(rno, memberId);
			if(devCheck == 0) {
				//좋아요 처음누름
				replyService.insertDev(bno,rno, memberId); //like테이블 삽입
				replyService.updateDev(rno);	//게시판테이블 +1
				replyService.memberDevPointPlus(writerId);
				
			}else if(devCheck == 1) {
				replyService.updateDevCancel(rno); //게시판테이블 =1
				replyService.deleteDev(rno, memberId); //like테이블 삭제
				replyService.memberDevPointDown(writerId);
				
			}
			return devCheck;
			}
	
	
	
}
