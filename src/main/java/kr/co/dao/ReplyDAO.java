package kr.co.dao;

import java.util.List;
import java.util.Map;

import kr.co.vo.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> readReply(int bno) throws Exception;
	
	public int writeReply(ReplyVO vo) throws Exception;
	
	public int updateReply(ReplyVO vo)throws Exception;
	
	public int deleteReply(ReplyVO vo)throws Exception;
	
	public ReplyVO selectReply(int rno)throws Exception;
	
	public int getBno(int rno)throws Exception;
	
	public void insertFileReply(Map<String, Object> map) throws Exception;
	
	//추천로직
	
	
	public void updateLike(int rno) throws Exception;
	
	public void updateLikeCancel(int rno) throws Exception;
	
	public void insertLike(int bno,int rno,String memberId) throws Exception;
	
	public void deleteLike(int rno,String memberId)throws Exception;
	
	public int likeCheck(int rno,String memberId) throws Exception;
		
	public void memberPointPlus(String writerId)throws Exception;
	
	public void memberPointDown(String writerId)throws Exception;
	
	
	// 반대
	
	
		public void updateHate(int rno) throws Exception;
		
		public void insertHate(int bno,int rno,String memberId) throws Exception;
		
		public void deleteHate(int rno,String memberId)throws Exception;
		
		public int hateCheck(int rno,String memberId) throws Exception;
		
		public void updateHateCancel(int rno) throws Exception;
		
		
		//DEV
		public void updateDev(int bno) throws Exception;
		
		public void updateDevCancel(int bno) throws Exception;
		
		public void insertDev(int bno,int rno,String memberId) throws Exception;
		
		public void deleteDev(int bno,String memberId)throws Exception;
		
		public int devCheck(int bno,String memberId) throws Exception;
				
		public void memberDevPointPlus(String writerId)throws Exception;
		
		public void memberDevPointDown(String writerId)throws Exception;
}
