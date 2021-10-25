package kr.co.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.vo.AlramVO;
import kr.co.vo.BoardVO;
import kr.co.vo.LogVO;
import kr.co.vo.MemberVO;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

public interface BoardService {
	
	
	// 게시글 작성
	public void write(BoardVO boardVO,MultipartHttpServletRequest mpRequest) throws Exception;

	public List<BoardVO> list(SearchCriteria scri) throws Exception;
	
	public int listCount(SearchCriteria scri) throws Exception;
	
	public BoardVO read(int bno)throws Exception;
	
	public void update(BoardVO boardVO, String[] files, 
			String[] filesNames,MultipartHttpServletRequest mpReqeust) throws Exception;
	
	
	public void delete(BoardVO boardVO) throws Exception;
	
	public List<Map<String, Object>> selectFileList(int bno)throws Exception;

	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	
	public BoardVO movePage(BoardVO boardVO)throws Exception;
	
	public List<BoardVO> notice() throws Exception;

	
	//추천

	public void updateLike(int bno) throws Exception;
	
	public void updateLikeCancel(int bno) throws Exception;
	
	public void insertLike(int bno,String memberId) throws Exception;
	
	public void deleteLike(int bno,String memberId)throws Exception;

	public int likeCheck(int bno,String memberId) throws Exception;
		
	public void memberPointPlus(String writerId)throws Exception;
	
	public void memberPointDown(String writerId)throws Exception;
	

	
	//반대
	
	public void updateHate(int bno) throws Exception;
	
	public void insertHate(int bno,String memberId) throws Exception;
	
	public void deleteHate(int bno,String memberId)throws Exception;
	
	public int hateCheck(int bno,String memberId) throws Exception;
	
	public void updateHateCancel(int bno) throws Exception;
	
	
	
	//Dev
	
	public void updateDev(int bno) throws Exception;
	
	public void updateDevCancel(int bno) throws Exception;
	
	public void insertDev(int bno,String memberId) throws Exception;
	
	public void deleteDev(int bno,String memberId)throws Exception;
	
	public int devCheck(int bno,String memberId) throws Exception;
			
	public void memberDevPointPlus(String writerId)throws Exception;
	
	public void memberDevPointDown(String writerId)throws Exception;
	
	//상황별 포인트 추가
	public void upPoint(int point , String memberId)throws Exception;
	
	public void upDevPoint(int point, String memberId)throws Exception;
	
	//조회한 게시글 표시
	public void insertBoardCheck(int bno,String memberId)throws Exception;
	
	public int boardCheck(int bno,String memberId)throws Exception;
	
	public int nextPageCheck(int nextbno,String memberId)throws Exception;
	
	//채택 (내공)포인트 다운
	public void questionPointDown(int helppoint , String Id)throws Exception;
	
	//채택된 회원에게 포인트 전달
	public void questionPointUp(int helppoint , String Id)throws Exception;
	
	//채택완료로 바꾸기
	public void questionCheck(int bno,int rno)throws Exception;
	
	//내공 체크
	public int questionPointCheck(String memberId)throws Exception;
	
	//채택Log
	public void insertLog(int bno, int rno, String Id , String memberId) throws Exception;
	
	public void insertLogReply(int bno, int rno, String Id , String memberId) throws Exception;
	
	
	

	//스크랩기능
	public void scrap(String memberId,int bno)throws Exception;
	
	//게시글 스크랩 수
	public int scrapCount(int bno)throws Exception;
	
	//스크랩 중복확인 & 취소
	public void scrapCancel(String memberId,int bno)throws Exception;
	
	public int scrapCheck(String memberId,int bno)throws Exception;
	
	
	
	//활동로그 List
		public List<LogVO> memberLog(String memberId) throws Exception;
		
		//프로필
		public MemberVO memberInfo(String memberId)throws Exception;
		
		//내 게시글
		public List<BoardVO> memberWrite(String memberId)throws Exception;
		
		//내 덧글
		public List<ReplyVO> memberReply(String memberId)throws Exception;
		
		//내 스크랩
		public List<BoardVO> memberScrap(String memberId)throws Exception;
		
		//채택받은 수
		public int memberDevCount(String memberId)throws Exception;
		
		
	
	
		
	//메인페이지 쿼리
		
		//일주일 내 인기글
		public List<BoardVO> bestList(String memberId) throws Exception;
		
		//미채택qna
		public List<BoardVO> qnaList(String memberId) throws Exception;
	
		//2일 내 자유 인기글
		public List<BoardVO> bestList1(String memberId) throws Exception;
		
		//2일 내 취업준비 인기글
		public List<BoardVO> bestList3(String memberId) throws Exception;
		
		//2일 내 회사생활 인기글
		public List<BoardVO> bestList4(String memberId) throws Exception;
		
		//2일 내 썸,연애 인기글
		public List<BoardVO> bestList6(String memberId) throws Exception;
		
		//최신순 추천수 20개 이상받은 게시글
		public List<BoardVO> bestBoard(String memberId) throws Exception;
		
		
		
		//인기게시판
		public List<BoardVO> popularBoard(SearchCriteria scri) throws Exception;

		public int popularCount(SearchCriteria scri) throws Exception;

		
		
		
		
		//알람기능
		public void insertAlram(String toId , String fromId , String bno , String title , String categori,String bgno)throws Exception;

		//알람 수
		public int alramCount(String memberId)throws Exception;
		
		//알람목록
		public List<AlramVO> alramList(String memberId) throws Exception;
		
		//알람클릭
		public void alramClick(String memberId, int bno)throws Exception;
		
}
