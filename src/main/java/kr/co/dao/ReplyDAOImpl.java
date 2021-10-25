package kr.co.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	SqlSession sql;

	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sql.selectList("replyMapper.readReply", bno);
	}

	@Override
	public int writeReply(ReplyVO vo) throws Exception {
		return sql.insert("replyMapper.insertReply", vo);
	}

	@Override
	public int updateReply(ReplyVO vo) throws Exception{
		return sql.update("replyMapper.updateReply", vo);
	}

	@Override
	public int deleteReply(ReplyVO vo) throws Exception{
		return sql.delete("replyMapper.deleteReply", vo);
	}

	@Override
	public ReplyVO selectReply(int rno) throws Exception{
		return sql.selectOne("replyMapper.selectReply", rno);
	}
	@Override
	public int getBno(int rno)throws Exception{
		return sql.selectOne("replyMapper.getBno", rno);
	}

	public void insertFileReply(Map<String, Object> map) throws Exception{
		sql.insert("replyMapper.insertFileReply", map);
	}
	
	//추천기능
	
	
	@Override
	public void updateLike(int rno) throws Exception{
	 sql.update("replyMapper.updateLike", rno);
	}
	
	@Override
	public void updateLikeCancel(int rno) throws Exception{
	sql.update("replyMapper.updateLikeCancel", rno);

	}

	
	@Override
	public void insertLike(int bno,int rno,String memberId) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("bno", bno);
		map.put("rno", rno);
		sql.insert("replyMapper.insertLike", map);
	}
	
	@Override
	public void deleteLike(int rno,String memberId)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("rno", rno);
		sql.delete("replyMapper.deleteLike", map);
	}
	
	@Override
	public int likeCheck(int rno,String memberId) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("rno", rno);
		return sql.selectOne("replyMapper.likeCheck", map);
	}
	

	@Override
	public void memberPointPlus(String writerId)throws Exception{ 
		sql.update("replyMapper.memberPointPlus", writerId);
	}
	
	@Override
	public void memberPointDown(String writerId)throws Exception{
		sql.update("replyMapper.memberPointDown", writerId);
	}
	
	// HATE
	
	
			@Override
			public void updateHate(int rno) throws Exception{
			 sql.update("replyMapper.updateHate", rno);
			}
			
			@Override
			public void updateHateCancel(int rno) throws Exception{
				 sql.update("replyMapper.updateHateCancel", rno);

			}
			
			
			@Override
			public void insertHate(int bno,int rno,String memberId) throws Exception{
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("memberId", memberId);
				map.put("bno", bno);
				map.put("rno", rno);
				sql.insert("replyMapper.insertHate", map);
			}
			
			@Override
			public void deleteHate(int rno,String memberId)throws Exception{
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("memberId", memberId);
				map.put("rno", rno);
				sql.delete("replyMapper.deleteHate", map);
			}
			
			@Override
			public int hateCheck(int rno,String memberId) throws Exception{
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("memberId", memberId);
				map.put("rno", rno);
				return sql.selectOne("replyMapper.hateCheck", map);
			}
			
			//DEV
			
			@Override
			public void updateDev(int rno) throws Exception{
			 sql.update("replyMapper.updateDev", rno);
			}
			
			@Override
			public void updateDevCancel(int rno) throws Exception{
				 sql.update("replyMapper.updateDevCancel", rno);

			}

			
			@Override
			public void insertDev(int bno,int rno,String memberId) throws Exception{
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("memberId", memberId);
				map.put("bno", bno);
				map.put("rno", rno);
				sql.insert("replyMapper.insertDev", map);
			}
			
			@Override
			public void deleteDev(int rno,String memberId)throws Exception{
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("memberId", memberId);
				map.put("rno", rno);
				sql.delete("replyMapper.deleteDev", map);
			}
			
			@Override
			public int devCheck(int rno,String memberId) throws Exception{
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("memberId", memberId);
				map.put("rno", rno);
				return sql.selectOne("replyMapper.devCheck", map);
			}
			
		
			@Override
			public void memberDevPointPlus(String writerId)throws Exception{ 
				sql.update("replyMapper.memberDevPointPlus", writerId);
			}
			
			@Override
			public void memberDevPointDown(String writerId)throws Exception{
				sql.update("replyMapper.memberDevPointDown", writerId);
			}
	


}
