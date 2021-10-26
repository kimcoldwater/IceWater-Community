package kr.co.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.BoardVO;
import kr.co.vo.LoginVO;
import kr.co.vo.MemberVO;
import kr.co.vo.SearchCriteria;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession sqlsession;
	
	@Override
	public void register(MemberVO memberVO) throws Exception{
		sqlsession.insert("memberMapper.register", memberVO);
		
	}
	
	@Override
	public int idCnt(MemberVO memberVO)throws Exception{
		return sqlsession.selectOne("memberMapper.idCnt", memberVO);
	}

	@Override
	public MemberVO login(LoginVO loginVO)throws Exception{
		System.out.println("DAOloginVO"+loginVO.getMemberPw());
		return sqlsession.selectOne("memberMapper.login", loginVO);
	}
	
	@Override
	public void keepLogin(String memberId,String sessionId, Date sessionLimit)throws Exception{
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("sessionLimit", sessionLimit);
		
		sqlsession.update("memberMapper.keepLogin", paramMap);
	}
	
	@Override
	public MemberVO checkUserWithSessionKey(String value) throws Exception{
		return sqlsession.selectOne("memberMapper.check", value);
	}

	@Override
	public void createAuthKey(String memberEmail,String authKey) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberEmail", memberEmail);
		map.put("authKey", authKey);
		
		sqlsession.selectOne("memberMapper.createAuthKey", map);
		
	}
	
	@Override
	public void memberAuth(String memberEmail,String key) throws Exception{
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("authKey", key);
		map.put("memberEmail", memberEmail);
		sqlsession.update("memberMapper.memberAuth", map);
	}
	
	@Override
	public List<MemberVO> findId(String memberEmail)throws Exception{
		return sqlsession.selectList("memberMapper.findId", memberEmail);
	}
	
	@Override
	public int findIdCheck(String memberEmail)throws Exception{
		return sqlsession.selectOne("memberMapper.findIdCheck", memberEmail);
	}
	
	@Override
	public int findPw(String memberEmail,String memberId,String memberPw)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberEmail", memberEmail);
		map.put("memberId", memberId);
		map.put("memberPw", memberPw);
		return sqlsession.update("memberMapper.findPw", map);
	}
	
	@Override
	public int findPwCheck(MemberVO memberVO)throws Exception{
	return sqlsession.selectOne("memberMapper.findPwCheck", memberVO);	
	}

	@Override
	public void infoUpdate(MemberVO memberVO)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberEmail", memberVO.getMemberEmail());
		map.put("memberName", memberVO.getMemberName());
		map.put("memberId", memberVO.getMemberId());
		
	sqlsession.update("memberMapper.infoUpdate", map);
	}
	
	@Override
	public int nameCheck(MemberVO memberVO)throws Exception{
		
		return sqlsession.selectOne("memberMapper.nameCheck", memberVO);
	}
	
	@Override
	public String pwCheck(String memberId)throws Exception{
		return sqlsession.selectOne("memberMapper.pwCheck", memberId);
	}
	
	@Override
	public void pwUpdate(String memberId, String hashedPw) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("memberPw", hashedPw);
		sqlsession.update("memberMapper.pwUpdate", map);
		
	}
	
	@Override
	public void delete(String memberId)throws Exception{
		sqlsession.delete("memberMapper.delete", memberId);
	}
	
	@Override
	public void updateImg(String memberImg,String memberId)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("memberImg", memberImg);
		sqlsession.update("memberMapper.updateImg",map);
	}
	
	
	
	
	//회원정지
	@Override
	public void memberSanction(String memberId,String sanctionTime)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("sanctionTime", sanctionTime);
		sqlsession.update("masterMapper.memberSanction", map);
	}
	
	//회원정지해제
	@Override
	public void memberSanctionCancel(String memberId)throws Exception{
		sqlsession.update("masterMapper.memberSanctionCancel",memberId);
	}
		
	//회원정지유무 확인
	@Override
	public int memberRankCheck(String memberId)throws Exception{
		return sqlsession.selectOne("masterMapper.memberRankCheck", memberId);
	}
	
	//정지시간확인
	@Override
	public Date memberSanctionTime(String memberId)throws Exception{
		return sqlsession.selectOne("masterMapper.memberSanctionTime", memberId);
	}

	//회원목록+검색
	@Override
	public List<MemberVO> memberList(SearchCriteria scri) throws Exception{
		return sqlsession.selectList("masterMapper.memberList", scri);
	}
	
	public int memberListCount()throws Exception{
		return sqlsession.selectOne("masterMapper.memberListCount");
	}

	public void insertPoint(String memberId , String memberPoint) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("memberPoint", memberPoint);
		sqlsession.update("masterMapper.insertPoint", map);
	}
	
	public void insertDevPoint(String memberId, String memberPoint) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("memberPoint", memberPoint);
		sqlsession.update("masterMapper.insertDevPoint", map);
	}

	public void insertNotice(int bno) throws Exception{
		sqlsession.update("masterMapper.insertNotice", bno);
	}

	public void deleteNotice(int bno) throws Exception{
		sqlsession.update("masterMapper.deleteNotice", bno);
	}
	
	public List<BoardVO> noticeView()throws Exception{
		return sqlsession.selectList("masterMapper.noticeView");
	}
	
	
	//관리자 지정
	public void memberMaster(String memberId)throws Exception{
		sqlsession.update("masterMapper.memberMaster", memberId);
	}
	
	public void memberMasterCancel(String memberId)throws Exception{
		sqlsession.update("masterMapper.memberMasterCancel", memberId);

	}
	
	
	//소셜로그인
	public void snsRegister(String id,String name,String email)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", id);
		map.put("memberPw", "1111");
		map.put("memberName", name);
		map.put("memberEmail", email);
		map.put("memberId_yn", "Y");
		
		sqlsession.insert("memberMapper.register", map);
	}
	
	//소셜로그인 회원가입체크
	public int snsLoginCheck(String id)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", id);
		return sqlsession.selectOne("memberMapper.snsLoginCheck", map);
	}

	//소셜로그인
	public MemberVO snsLogin(String id)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("memberId", id);
		return sqlsession.selectOne("memberMapper.login", map);
	}

}
