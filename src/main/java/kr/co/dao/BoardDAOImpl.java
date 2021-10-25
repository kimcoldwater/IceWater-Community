package kr.co.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.AlramVO;
import kr.co.vo.BoardVO;
import kr.co.vo.LogVO;
import kr.co.vo.MemberVO;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
		@Inject
		private SqlSession sqlsession;
	// 게시글 작성
		@Override
		public void write(BoardVO boardVO) throws Exception{
			sqlsession.insert("boardMapper.insert", boardVO);
			
		}
		
		//게시글 목록 조회
		@Override
		public List<BoardVO> list(SearchCriteria scri) throws Exception{
			int bgno = scri.getBgno();
			
			
			
				
			return sqlsession.selectList("boardMapper.listPage",scri);
			
		}
		@Override
		public int listCount(SearchCriteria scri) throws Exception{
			return sqlsession.selectOne("boardMapper.listCount", scri);
		}
		
		@Override
		public BoardVO read(int bno) throws Exception{
			return sqlsession.selectOne("boardMapper.read", bno);
		}
		
		@Override
		public void update(BoardVO boardVO) throws Exception{
			 sqlsession.update("boardMapper.update", boardVO);
		}
		
		@Override
		public void delete(int bno) throws Exception{
			sqlsession.delete("boardMapper.delete", bno);
		}
		
		@Override
		public void boardHit(int bno) throws Exception{
			sqlsession.update("boardMapper.boardHit", bno);
		}
		
		@Override
		public void replyCount(int bno)throws Exception{
			
			
			sqlsession.update("replyMapper.replyCount", bno);
		}
		
		@Override
		public void insertFile(Map<String, Object> map)throws Exception{
			sqlsession.insert("boardMapper.insertFile", map);
		}
		
		@Override
		public List<Map<String, Object>> selectFileList(int bno)throws Exception{
			return sqlsession.selectList("boardMapper.selectFileList", bno);
		}
		
		@Override
		public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
			return sqlsession.selectOne("boardMapper.selectFileInfo", map);
		}
		
		@Override
		public void updateFile(Map<String, Object> map)throws Exception{
			sqlsession.update("boardMapper.updateFile", map);
		}
		
		@Override
		public BoardVO movePage(BoardVO boardVO)throws Exception{
		 
			return sqlsession.selectOne("boardMapper.movePage", boardVO);
		}
		
		@Override
		public List<BoardVO> notice() throws Exception{
			return sqlsession.selectList("boardMapper.notice");
		}

		
		
		//추천기능
		
		
		@Override
		public void updateLike(int bno) throws Exception{
		 sqlsession.update("likeMapper.updateLike", bno);
		}
		
		@Override
		public void updateLikeCancel(int bno) throws Exception{
			 sqlsession.update("likeMapper.updateLikeCancel", bno);

		}

		
		@Override
		public void insertLike(int bno,String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			sqlsession.insert("likeMapper.insertLike", map);
		}
		
		@Override
		public void deleteLike(int bno,String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			sqlsession.delete("likeMapper.deleteLike", map);
		}
		
		@Override
		public int likeCheck(int bno,String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			return sqlsession.selectOne("likeMapper.likeCheck", map);
		}
		
	
		@Override
		public void memberPointPlus(String writerId)throws Exception{ 
			sqlsession.update("likeMapper.memberPointPlus", writerId);
		}
		
		@Override
		public void memberPointDown(String writerId)throws Exception{
			sqlsession.update("likeMapper.memberPointDown", writerId);
		}
		
	
		// HATE
		
		
		@Override
		public void updateHate(int bno) throws Exception{
		 sqlsession.update("likeMapper.updateHate", bno);
		}
		
		@Override
		public void updateHateCancel(int bno) throws Exception{
			 sqlsession.update("likeMapper.updateHateCancel", bno);

		}
		
		
		@Override
		public void insertHate(int bno,String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			sqlsession.insert("likeMapper.insertHate", map);
		}
		
		@Override
		public void deleteHate(int bno,String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			sqlsession.delete("likeMapper.deleteHate", map);
		}
		
		@Override
		public int hateCheck(int bno,String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			return sqlsession.selectOne("likeMapper.hateCheck", map);
		}
		
		//DEV
		
		@Override
		public void updateDev(int bno) throws Exception{
		 sqlsession.update("likeMapper.updateDev", bno);
		}
		
		@Override
		public void updateDevCancel(int bno) throws Exception{
			 sqlsession.update("likeMapper.updateDevCancel", bno);

		}

		
		@Override
		public void insertDev(int bno,String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			sqlsession.insert("likeMapper.insertDev", map);
		}
		
		@Override
		public void deleteDev(int bno,String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			sqlsession.delete("likeMapper.deleteDev", map);
		}
		
		@Override
		public int devCheck(int bno,String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			return sqlsession.selectOne("likeMapper.devCheck", map);
		}
		
	
		@Override
		public void memberDevPointPlus(String writerId)throws Exception{ 
			sqlsession.update("likeMapper.memberDevPointPlus", writerId);
		}
		
		@Override
		public void memberDevPointDown(String writerId)throws Exception{
			sqlsession.update("likeMapper.memberDevPointDown", writerId);
		}
		
		
		
		
		//회원 읽은글 표시
		@Override
		public void insertBoardCheck(int bno,String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			sqlsession.insert("boardMapper.insertBoardCheck", map);
		}
		
		@Override
		public int boardCheck(int bno,String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			
			return sqlsession.selectOne("boardMapper.boardCheck", map);
			
		}
		
		@Override
		public int nextPageCheck(int nextbno,String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", nextbno);
			
			return sqlsession.selectOne("boardMapper.boardCheck", map);
		}

		//상황별 포인트 추가
		@Override
		public void upPoint(int point , String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("point", point);
			sqlsession.update("likeMapper.upPoint", map);
		}
		
		@Override
		public void upDevPoint(int point, String memberId)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("point", point);
			sqlsession.update("likeMapper.upDevPoint", map);

		}
		
		//채택 (내공)포인트 다운
		public void questionPointDown(int helppoint , String Id)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", Id);
			map.put("helppoint",helppoint );
			sqlsession.update("boardMapper.questionPointDown", map);
			
		}
		
		//채택된 회원에게 포인트 전달
		public void questionPointUp(int helppoint , String Id)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", Id);
			map.put("helppoint", helppoint );
			sqlsession.update("boardMapper.questionPointUp", map);
		}
		
		//채택완료로 바꾸기
		public void questionCheck(int bno,int rno)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("rno", rno);
			map.put("bno", bno );
			sqlsession.update("boardMapper.questionCheck", map);
		}
		
		//세션갱신 대신 내공갱신
		@Override
		public int questionPointCheck(String memberId)throws Exception{
			return sqlsession.selectOne("boardMapper.questionPointCheck", memberId);
		}
		
	
		
		
		//스크랩기능
		public void scrap(String memberId,int bno)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
			map.put("bno", bno );
			sqlsession.insert("boardMapper.scrap", map);
		}
		
		//게시글 스크랩 수
		public int scrapCount(int bno)throws Exception{
			return sqlsession.selectOne("boardMapper.scrapCount", bno);
		}
		
		//스크랩 중복확인 & 취소
		public void scrapCancel(String memberId,int bno)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
			map.put("bno", bno );
			sqlsession.delete("boardMapper.scrapCancel", map);
		}
		
		public int scrapCheck(String memberId,int bno)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
			map.put("bno", bno );
			return sqlsession.selectOne("boardMapper.scrapCheck", map);
		}

		
		
		
		
		//마이페이지 활동로그
		public void insertLog(LogVO logVO)throws Exception{
			sqlsession.insert("logMapper.insertLog", logVO);
		}
		
		//활동로그 삭제
		public void deleteLog(LogVO logVO)throws Exception{
			sqlsession.delete("logMapper.deleteLog", logVO);
		}
		
		//활동로그 댓글삭제
		public void deleteReplyLog(LogVO logVO)throws Exception{
			sqlsession.delete("logMapper.deleteReplyLog", logVO);
		}
		
		//활동로그 List
		public List<LogVO> memberLog(String memberId) throws Exception{
			return sqlsession.selectList("logMapper.memberLog", memberId);
		}
		
		//프로필
		public MemberVO memberInfo(String memberId)throws Exception{
			return sqlsession.selectOne("logMapper.memberInfo", memberId);
		}
		
		//내 게시글
		public List<BoardVO> memberWrite(String memberId)throws Exception{
			return sqlsession.selectList("logMapper.memberWrite", memberId);
		}
		
		//내 덧글
		public List<ReplyVO> memberReply(String memberId)throws Exception{
			return sqlsession.selectList("logMapper.memberReply", memberId);
		}
		
		//내 스크랩
		public List<BoardVO> memberScrap(String memberId)throws Exception{
			return sqlsession.selectList("logMapper.memberScrap", memberId);
		}
		
		//채택받은 수
		public int memberDevCount(String memberId)throws Exception{
			return sqlsession.selectOne("logMapper.memberDevCount", memberId);
		}
		
		
		
		
		
		
		
		//메인페이지 쿼리
		
		//일주일 내 인기글
		public List<BoardVO> bestList(String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
			
			return sqlsession.selectList("bestMapper.bestList", map);
		}
		
		//미채택 Q&A
		public List<BoardVO> qnaList(String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
			
			return sqlsession.selectList("bestMapper.qnaList", map);
		}
		
		//2일내 자유 인기글
		public List<BoardVO> bestList1(String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
					
			return sqlsession.selectList("bestMapper.bestList1", map);
		}
		
		//2일내  취업준비 인기글
		public List<BoardVO> bestList3(String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
					
			return sqlsession.selectList("bestMapper.bestList3", map);
		}
		
		//2일 내 회사생활 인기글글
		public List<BoardVO> bestList4(String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
					
			return sqlsession.selectList("bestMapper.bestList4", map);
		}
		
		//2일 내 회사생활 인기글
		public List<BoardVO> bestList6(String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
					
			return sqlsession.selectList("bestMapper.bestList6", map);
		}
		
		//추천수 20이상 최신 인기글
		public List<BoardVO> bestBoard(String memberId) throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId",memberId );
					
			return sqlsession.selectList("bestMapper.bestBoard", map);
		}
		
		
		
		
		//인기게시판
		public List<BoardVO> popularBoard(SearchCriteria scri) throws Exception{
			return sqlsession.selectList("bestMapper.popularBoard",scri);
		}

		public int popularCount(SearchCriteria scri) throws Exception{
			return sqlsession.selectOne("bestMapper.popularCount", scri);
		}
		
		
		
		
		//알람기능
		
		public void insertAlram(String toId , String fromId , String bno , String title,String categori,String bgno)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("toid", toId);
			map.put("fromid", fromId);
			map.put("bno", bno);
			map.put("title", title);
			map.put("categori", categori);
			map.put("bgno", bgno);
			
			sqlsession.insert("logMapper.insertAlram", map);
		}

		
		//알람 수
		public int alramCount(String memberId)throws Exception{
			return sqlsession.selectOne("logMapper.alramCount", memberId);
		}

		//알람목록
		public List<AlramVO> alramList(String memberId) throws Exception{
			return sqlsession.selectList("logMapper.alramList", memberId);
		}

		//알람클릭
		public void alramClick(String memberId, int bno)throws Exception{
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("memberId", memberId);
			map.put("bno", bno);
			
			sqlsession.delete("logMapper.alramClick", map);
		}

}


