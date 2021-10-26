package kr.co.dao;

import java.util.Date;
import java.util.List;

import kr.co.vo.BoardVO;
import kr.co.vo.LoginVO;
import kr.co.vo.MemberVO;
import kr.co.vo.SearchCriteria;

public interface MemberDAO {
	
	public void register(MemberVO memberVO) throws Exception;
	
	public int idCnt(MemberVO memberVO)throws Exception;
	
	public MemberVO login(LoginVO loginVO)throws Exception;
	
	public void keepLogin(String memberId,String sessionId, Date sessionLimit)throws Exception;	
	
	public MemberVO checkUserWithSessionKey(String value) throws Exception;
	
	public void createAuthKey(String memberEmail,String authKey) throws Exception;
		
	public void memberAuth(String memberEmail,String key) throws Exception;
	
	public List<MemberVO> findId(String memberEmail)throws Exception;
	
	public int findIdCheck(String memberEmail)throws Exception;

	public int findPwCheck(MemberVO memberVO)throws Exception; 
	
	public int findPw(String memberPw,String memberEmail,String memberId)throws Exception;
	
	public void infoUpdate(MemberVO memberVO)throws Exception;
	
	public int nameCheck(MemberVO memberVO)throws Exception;
	
	public String pwCheck(String memberId)throws Exception;
	
	public void pwUpdate(String memberId, String hashedPw)throws Exception;
	
	public void delete(String memberId)throws Exception;
	
	public void updateImg(String memberImg,String memberId)throws Exception;
	
	//회원정지
	public void memberSanction(String memberId,String sanctionTime)throws Exception;
	
	//회원정지해제
	public void memberSanctionCancel(String memberId)throws Exception;

	
	//회원정지유무 확인
	public int memberRankCheck(String memberId)throws Exception;
	
	//정지시간확인
	public Date memberSanctionTime(String memberId)throws Exception;
	
	public List<MemberVO> memberList(SearchCriteria scri) throws Exception;

	public int memberListCount()throws Exception;
	
	public void insertPoint(String memberId , String memberPoint) throws Exception;
	
	public void insertDevPoint(String memberId, String memberPoint) throws Exception;
	
	public void insertNotice(int bno)throws Exception;

	public void deleteNotice(int bno)throws Exception;
	
	public List<BoardVO> noticeView()throws Exception;
	
	//관리자 지정
	public void memberMaster(String memberId)throws Exception;
	
	public void memberMasterCancel(String memberId)throws Exception;
	
	
	
	
	//소셜회원가입
	public void snsRegister(String id,String name,String email)throws Exception;
	
	//소셜로그인 회원가입체크
	public int snsLoginCheck(String id)throws Exception;
	
	//소셜로그인
	public MemberVO snsLogin(String id)throws Exception;
	
}
