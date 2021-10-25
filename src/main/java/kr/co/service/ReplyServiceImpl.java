package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dao.BoardDAO;
import kr.co.dao.ReplyDAO;
import kr.co.util.FileUtils;
import kr.co.vo.LogVO;
import kr.co.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Inject
	public ReplyDAO dao;
	@Inject
	public BoardDAO daoo;
	@Inject
	private FileUtils fileUtils;

	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return dao.readReply(bno);
	}

	@Transactional
	@Override
	public void writeReply(ReplyVO vo,MultipartHttpServletRequest mpRequest) throws Exception {
		
		dao.writeReply(vo);
		daoo.replyCount(vo.getBno());
		
		List<Map<String,Object>> listt = fileUtils.parseInsertFileInfoReply(vo,mpRequest);
		int size = listt.size();
		for(int i=0; i<size; i++) {
			dao.insertFileReply(listt.get(i));
		}
		
		//활동로그
		LogVO logVO = new LogVO();
		logVO.setBno(vo.getBno());
		logVO.setRno(vo.getRno());
		logVO.setMemberId(vo.getId());
		logVO.setCategori(6);
		daoo.insertLog(logVO);
		
	}

	@Override
	public int updateReply(ReplyVO vo) throws Exception{
		return dao.updateReply(vo);
	}
	
	@Transactional
	@Override
	public void deleteReply(ReplyVO vo) throws Exception{
		int bno = dao.getBno(vo.getRno());
		 dao.deleteReply(vo);
		 daoo.replyCount(bno);
			//활동로그
			LogVO logVO = new LogVO();
			logVO.setRno(vo.getRno());
			logVO.setMemberId(vo.getId());
			logVO.setCategori(6);
			daoo.deleteReplyLog(logVO);
	}

	@Override
	public ReplyVO selectReply(int rno) throws Exception{
		return dao.selectReply(rno);
	}
	
	
	//Like
	
		@Override
		public void updateLike(int rno) throws Exception{
			 dao.updateLike(rno);
		}
		
		@Override
		public void updateLikeCancel(int rno) throws Exception{
			dao.updateLikeCancel(rno);
		}

		
		@Override
		public void insertLike(int bno,int rno,String memberId) throws Exception{
				dao.insertLike(bno, rno, memberId);
				
				//활동로그
				LogVO logVO = new LogVO();
				logVO.setBno(bno);
				logVO.setRno(rno);
				logVO.setMemberId(memberId);
				logVO.setCategori(7);
				daoo.insertLog(logVO);
		}
		
		@Override
		public void deleteLike(int rno,String memberId)throws Exception{
				dao.deleteLike(rno, memberId);
				
				//활동로그
				LogVO logVO = new LogVO();
				logVO.setRno(rno);
				logVO.setMemberId(memberId);
				logVO.setCategori(7);
				daoo.deleteReplyLog(logVO);
		}
		
		@Override
		public int likeCheck(int rno,String memberId) throws Exception{
			return dao.likeCheck(rno, memberId);
		}
		
		
		
		@Override
		public void memberPointPlus(String writerId)throws Exception{
			dao.memberPointPlus(writerId);
		}
		
		public void memberPointDown(String writerId)throws Exception{
			dao.memberPointDown(writerId);
		}
	
		//Hate
		
		@Override
		public void updateHate(int rno) throws Exception{
			 dao.updateHate(rno);
		}
		
		@Override
		public void updateHateCancel(int rno) throws Exception{
			dao.updateHateCancel(rno);
		}

		
		@Override
		public void insertHate(int bno,int rno , String memberId) throws Exception{
				dao.insertHate(bno, rno, memberId);
				
				//활동로그
				LogVO logVO = new LogVO();
				logVO.setBno(bno);
				logVO.setRno(rno);
				logVO.setMemberId(memberId);
				logVO.setCategori(8);
				daoo.insertLog(logVO);
		}
		
		@Override
		public void deleteHate(int rno,String memberId)throws Exception{
				dao.deleteHate(rno, memberId);
				
				//활동로그
				LogVO logVO = new LogVO();
				logVO.setRno(rno);
				logVO.setMemberId(memberId);
				logVO.setCategori(8);
				daoo.deleteReplyLog(logVO);
		}
		
		@Override
		public int hateCheck(int rno,String memberId) throws Exception{
			return dao.hateCheck(rno, memberId);
		}
		
		//DEV
		@Override
		public void updateDev(int rno) throws Exception{
			 dao.updateDev(rno);
		}
		
		@Override
		public void updateDevCancel(int rno) throws Exception{
			dao.updateDevCancel(rno);
		}

		
		@Override
		public void insertDev(int bno,int rno, String memberId) throws Exception{
				dao.insertDev(bno, rno, memberId);
				
				//활동로그
				LogVO logVO = new LogVO();
				logVO.setBno(bno);
				logVO.setRno(rno);
				logVO.setMemberId(memberId);
				logVO.setCategori(9);
				daoo.insertLog(logVO);
				
		}
		
		@Override
		public void deleteDev(int rno,String memberId)throws Exception{
				dao.deleteDev(rno, memberId);
				
				//활동로그
				LogVO logVO = new LogVO();
				logVO.setRno(rno);
				logVO.setMemberId(memberId);
				logVO.setCategori(9);
				daoo.deleteReplyLog(logVO);
		}
		
		@Override
		public int devCheck(int rno,String memberId) throws Exception{
			return dao.devCheck(rno, memberId);
		}
		
		
		
		@Override
		public void memberDevPointPlus(String writerId)throws Exception{
			dao.memberDevPointPlus(writerId);
		}
		
		public void memberDevPointDown(String writerId)throws Exception{
			dao.memberDevPointDown(writerId);
		}

}
