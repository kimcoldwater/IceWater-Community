package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dao.BoardDAO;
import kr.co.util.FileUtils;
import kr.co.vo.AlramVO;
import kr.co.vo.BoardVO;
import kr.co.vo.LogVO;
import kr.co.vo.MemberVO;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
	private FileUtils fileUtils;
	
	@Inject
	private BoardDAO dao;
	
	@Override
	public void write(BoardVO boardVO,MultipartHttpServletRequest mpRequest) throws Exception{
		dao.write(boardVO);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boardVO, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++){ 
			dao.insertFile(list.get(i)); 
		}
		
		//활동로그
		LogVO logVO = new LogVO();
		logVO.setBno(boardVO.getBno());
		logVO.setMemberId(boardVO.getId());
		logVO.setCategori(1);
		dao.insertLog(logVO);
	}
	
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception{
		
	
		return dao.list(scri);
	}
	
	@Override
	public int listCount(SearchCriteria scri) throws Exception{
		return dao.listCount(scri);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(int bno)throws Exception{
		dao.boardHit(bno);
	
	
		return dao.read(bno);
	}
	
	@Override
	public void update(BoardVO boardVO,String[] files, String[] fileNames,
			MultipartHttpServletRequest mpRequest)throws Exception{
		dao.update(boardVO);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(boardVO,files,fileNames,mpRequest);
		Map<String,Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				dao.insertFile(tempMap);
			}else {
				dao.updateFile(tempMap);
			}
		}
	
	
	}
	
	@Override
	public void delete(BoardVO boardVO) throws Exception{
		dao.delete(boardVO.getBno());
		
		//활동로그
		LogVO logVO = new LogVO();
		logVO.setBno(boardVO.getBno());
		logVO.setMemberId(boardVO.getId());
		logVO.setCategori(1);
		
		dao.deleteLog(logVO);
	}
	
	@Override
	public List<Map<String, Object>> selectFileList(int bno)throws Exception{
		return dao.selectFileList(bno);
	}
	
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
		return dao.selectFileInfo(map);
	}
	
	@Override
	public BoardVO movePage(BoardVO boardVO)throws Exception{
		
		return dao.movePage(boardVO);
	}
	
	@Override
	public List<BoardVO> notice() throws Exception{
		return dao.notice();
	}
	
	
	
	//Like
	
	@Override
	public void updateLike(int bno) throws Exception{
		 dao.updateLike(bno);
		
	}
	
	@Override
	public void updateLikeCancel(int bno) throws Exception{
		dao.updateLikeCancel(bno);
	}

	
	@Override
	public void insertLike(int bno,String memberId) throws Exception{
			dao.insertLike(bno, memberId);
			
			//활동로그
			LogVO logVO = new LogVO();
			logVO.setBno(bno);
			logVO.setMemberId(memberId);
			logVO.setCategori(2);
			dao.insertLog(logVO);
	}
	
	@Override
	public void deleteLike(int bno,String memberId)throws Exception{
			dao.deleteLike(bno, memberId);
			
			//활동로그
			LogVO logVO = new LogVO();
			logVO.setBno(bno);
			logVO.setMemberId(memberId);
			logVO.setCategori(2);
			dao.deleteLog(logVO);
	}
	
	@Override
	public int likeCheck(int bno,String memberId) throws Exception{
		return dao.likeCheck(bno, memberId);
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
	public void updateHate(int bno) throws Exception{
		 dao.updateHate(bno);
	}
	
	@Override
	public void updateHateCancel(int bno) throws Exception{
		dao.updateHateCancel(bno);
	}

	
	@Override
	public void insertHate(int bno,String memberId) throws Exception{
			dao.insertHate(bno, memberId);
			//활동로그
			LogVO logVO = new LogVO();
			logVO.setBno(bno);
			logVO.setMemberId(memberId);
			logVO.setCategori(3);
			dao.insertLog(logVO);
	}
	
	@Override
	public void deleteHate(int bno,String memberId)throws Exception{
			dao.deleteHate(bno, memberId);
			//활동로그
			LogVO logVO = new LogVO();
			logVO.setBno(bno);
			logVO.setMemberId(memberId);
			logVO.setCategori(3);
			dao.deleteLog(logVO);
	
	}
	
	@Override
	public int hateCheck(int bno,String memberId) throws Exception{
		return dao.hateCheck(bno, memberId);
	}
	
	//DEV
	@Override
	public void updateDev(int bno) throws Exception{
		 dao.updateDev(bno);
		 
	}
	
	@Override
	public void updateDevCancel(int bno) throws Exception{
		dao.updateDevCancel(bno);
	}

	
	@Override
	public void insertDev(int bno,String memberId) throws Exception{
			dao.insertDev(bno, memberId);
			//활동로그
			LogVO logVO = new LogVO();
			logVO.setBno(bno);
			logVO.setMemberId(memberId);
			logVO.setCategori(4);
			dao.insertLog(logVO);
	
	}
	
	@Override
	public void deleteDev(int bno,String memberId)throws Exception{
			dao.deleteDev(bno, memberId);
			//활동로그
			LogVO logVO = new LogVO();
			logVO.setBno(bno);
			logVO.setMemberId(memberId);
			logVO.setCategori(4);
			dao.deleteLog(logVO);
	
	}
	
	@Override
	public int devCheck(int bno,String memberId) throws Exception{
		return dao.devCheck(bno, memberId);
	}
	
	
	
	@Override
	public void memberDevPointPlus(String writerId)throws Exception{
		dao.memberDevPointPlus(writerId);
	}
	
	@Override
	public void memberDevPointDown(String writerId)throws Exception{
		dao.memberDevPointDown(writerId);
	}
	
	//상황별 포인트 추가
	@Override
	public void upPoint(int point , String memberId)throws Exception{
		dao.upPoint(point, memberId);
		
	}
	
	@Override
	public void upDevPoint(int point, String memberId)throws Exception{
		dao.upDevPoint(point, memberId);
		
	}
	
	
	
	
	
	
	
	//읽은글
	@Override
	public void insertBoardCheck(int bno,String memberId)throws Exception{
		dao.insertBoardCheck(bno, memberId);
	}
	
	@Override
	public int boardCheck(int bno,String memberId)throws Exception{
		return dao.boardCheck(bno,memberId);
	}
	
	@Override
	public int nextPageCheck(int nextbno,String memberId)throws Exception{
		return dao.nextPageCheck(nextbno, memberId);
	}
	
	
	
	//채택 (내공)포인트 다운
	@Override
	public void questionPointDown(int helppoint , String Id)throws Exception{
		dao.questionPointDown(helppoint, Id);
	}
	
	//채택된 회원에게 포인트 전달
	public void questionPointUp(int helppoint , String Id)throws Exception{
		dao.questionPointUp(helppoint, Id);
	}
	
	//채택완료로 바꾸기
	public void questionCheck(int bno,int rno)throws Exception{
		dao.questionCheck(bno,rno);
	}
	
	//내공체크
	public int questionPointCheck(String memberId)throws Exception{
		return dao.questionPointCheck(memberId);
	}
	
	//채택한 사람 LOG
	public void insertLog(int bno, int rno, String Id,String memberId) throws Exception{
		//활동로그
		LogVO logVO = new LogVO();
		logVO.setBno(bno);
		logVO.setRno(rno);
		logVO.setMemberId(memberId);
		logVO.setQuestionId(Id);
		logVO.setCategori(10);
		dao.insertLog(logVO);
	}
	
	//채택받은사람 LOG
	public void insertLogReply(int bno, int rno, String Id,String memberId) throws Exception{
		//활동로그
		LogVO logVO = new LogVO();
		logVO.setBno(bno);
		logVO.setRno(rno);
		logVO.setMemberId(Id);
		logVO.setCategori(11);
		dao.insertLog(logVO);
	}
	
	
	
	
	
	
	
	//스크랩기능
	public void scrap(String memberId,int bno)throws Exception{
		dao.scrap(memberId, bno);
		//활동로그
		LogVO logVO = new LogVO();
		logVO.setBno(bno);
		logVO.setMemberId(memberId);
		logVO.setCategori(5);
		dao.insertLog(logVO);

	}
	
	//게시글 스크랩 수
	public int scrapCount(int bno)throws Exception{
		return dao.scrapCount(bno);
	}
	
	//스크랩 중복확인 & 취소
	public void scrapCancel(String memberId,int bno)throws Exception{
		dao.scrapCancel(memberId, bno);
		//활동로그
		LogVO logVO = new LogVO();
		logVO.setBno(bno);
		logVO.setMemberId(memberId);
		logVO.setCategori(5);
		dao.deleteLog(logVO);

	}
	
	public int scrapCheck(String memberId,int bno)throws Exception{
		return dao.scrapCheck(memberId, bno);
		
	}
	
	
	
	//마이페이지 활동로그
	public void insertLog(LogVO logVO)throws Exception{
		dao.insertLog(logVO);
	}
	
	//활동로그 List
		public List<LogVO> memberLog(String memberId) throws Exception{
		return dao.memberLog(memberId);
		}
		
		//프로필
		public MemberVO memberInfo(String memberId)throws Exception{
			return dao.memberInfo(memberId);
		}
		
		//내 게시글
		public List<BoardVO> memberWrite(String memberId)throws Exception{
			return dao.memberWrite(memberId);
		}
		
		//내 덧글
		public List<ReplyVO> memberReply(String memberId)throws Exception{
			return dao.memberReply(memberId);
		}
		
		//내 스크랩
		public List<BoardVO> memberScrap(String memberId)throws Exception{
			return dao.memberScrap(memberId);
		}
		
		//채택받은 수
		public int memberDevCount(String memberId)throws Exception{
			return dao.memberDevCount(memberId);
		}
		
		
		
		
	//메인페이지 쿼리
		
		//일주일 내 인기글
		public List<BoardVO> bestList(String memberId) throws Exception{
			return dao.bestList(memberId);
		}
		
		//일주일 내 인기글
		public List<BoardVO> qnaList(String memberId) throws Exception{
		return dao.qnaList(memberId);
		}
		
		//2일 내 자유 인기글
		public List<BoardVO> bestList1(String memberId) throws Exception{
			return dao.bestList1(memberId);
		}
		
		//2일 내 취업준비 인기글
		public List<BoardVO> bestList3(String memberId) throws Exception{
			return dao.bestList3(memberId);
		}
		
		//2일 내 회사생활 인기글
		public List<BoardVO> bestList4(String memberId) throws Exception{
			return dao.bestList4(memberId);
		}
		
		//2일 내 썸,연애 인기글
		public List<BoardVO> bestList6(String memberId) throws Exception{
			return dao.bestList6(memberId);
		}
		
		//최신순 추천수 20개 이상받은 게시글
		public List<BoardVO> bestBoard(String memberId) throws Exception{
			return dao.bestBoard(memberId);
		}
		
		
		
		//인기게시판
		public List<BoardVO> popularBoard(SearchCriteria scri) throws Exception{
			return dao.popularBoard(scri);
		}
		
		public int popularCount(SearchCriteria scri) throws Exception{
			return dao.popularCount(scri);
		}
		
		
		
		//알람기능
		public void insertAlram(String toId , String fromId , String bno , String title , String categori,String bgno)throws Exception{
			dao.insertAlram(toId, fromId, bno, title, categori,bgno);
			
		}
		
		//알람 수
		public int alramCount(String memberId)throws Exception{
			return dao.alramCount(memberId);
		}
		
		//알람목록
		public List<AlramVO> alramList(String memberId) throws Exception{
			return dao.alramList(memberId);
		}
		
		//알람클릭
		public void alramClick(String memberId, int bno)throws Exception{
		dao.alramClick(memberId,bno);
		}
		
		
	
}
