package kr.co.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dao.MemberDAO;
import kr.co.util.FileUtils;
import kr.co.util.MailUtils;
import kr.co.util.TempKey;
import kr.co.vo.BoardVO;
import kr.co.vo.LoginVO;
import kr.co.vo.MemberVO;
import kr.co.vo.SearchCriteria;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject 
	private MemberDAO memberDAO;
	
	@Inject
	private JavaMailSender mailSender;
	
	
	
	@Transactional
	@Override
	public void register(MemberVO memberVO) throws Exception{
		memberDAO.register(memberVO);
		
		String key = new TempKey().getKey(50,false);
		memberDAO.createAuthKey(memberVO.getMemberEmail(), key);
		MailUtils sendMail = new MailUtils(mailSender);
		sendMail.setSubject("[ICEWATER 커뮤니티 이메일 인증메일 입니다.]"); //메일제목
		sendMail.setText(
				"<h1>메일인증</h1>" +
						"<br/>"+memberVO.getMemberId()+"님 "+
						"<br/>ICEWATER에 회원가입해주셔서 감사합니다."+
						"<br/>아래 [이메일 인증 확인]을 눌러주세요."+
						"<a href='http://3.15.248.44:8080/member/registerEmail?memberEmail=" + memberVO.getMemberEmail() +
						"&key=" + key +
						"' target='_blenk'>이메일 인증 확인</a>");
		sendMail.setFrom("kimfk567@gmail.com", "ICEWATER");
		sendMail.setTo(memberVO.getMemberEmail());
		sendMail.send();
		
	}
	
	@Override
	public void findPw(String memberEmail,String memberId)throws Exception{
		String memberKey = new TempKey().getKey(6,false);
		String memberPw = BCrypt.hashpw(memberKey,BCrypt.gensalt());
		 memberDAO.findPw(memberEmail,memberId,memberPw);
		 MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject("[ICEWATER 커뮤니티 임시 비밀번호 입니다.]"); //메일제목
			sendMail.setText(
					"<h1>임시비밀번호 발급</h1>" +
							"<br/>"+memberId+"님 "+
							"<br/>비밀번호 찾기를 통한 임시 비밀번호입니다."+
							"<br/>임시비밀번호 :   <h2>"+memberKey+"</h2>"+
							"<br/>로그인 후 비밀번호 변경을 해주세요."+
							"<a href='http://3.15.248.44:8080/member/loginView"+
							">로그인 페이지</a>");
			sendMail.setFrom("kimfk567@gmail.com", "ICEWATER");
			sendMail.setTo(memberEmail);
			sendMail.send();
	}
	
	@Override
	public int idCnt(MemberVO memberVO)throws Exception{
		return memberDAO.idCnt(memberVO);
	}
	
	@Override
	public MemberVO login(LoginVO loginVO)throws Exception{
		return memberDAO.login(loginVO);
	}
	
	@Override
	public void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception{
		memberDAO.keepLogin(userId, sessionId, sessionLimit);
	}

	@Override
	public MemberVO checkLoginBefore(String value) throws Exception{
		return memberDAO.checkUserWithSessionKey(value);
	}
	
	@Override
	public void memberAuth(String memberEmail,String key) throws Exception{
		memberDAO.memberAuth(memberEmail,key);
	}
	
	@Override
	public List<MemberVO> findId(String memberEmail)throws Exception{
		return memberDAO.findId(memberEmail);
	}
	
	@Override
	public int findIdCheck(String memberEmail)throws Exception{
		return memberDAO.findIdCheck(memberEmail);
	}

	
	@Override
	public int findPwCheck(MemberVO memberVO)throws Exception{
		return memberDAO.findPwCheck(memberVO);
	}

	@Override
	public void infoUpdate(MemberVO memberVO)throws Exception{
		memberDAO.infoUpdate(memberVO);
	}

	@Override
	public int nameCheck(MemberVO memberVO)throws Exception{
		return memberDAO.nameCheck(memberVO);
	}
	
	@Override
	public String pwCheck(String memberId)throws Exception{
		return memberDAO.pwCheck(memberId);
	}
	
	@Override
	public void pwUpdate(String memberId, String hashedPw)throws Exception{
		memberDAO.pwUpdate(memberId, hashedPw);
	}
	
	@Override
	public void delete(String memberId)throws Exception{
		memberDAO.delete(memberId);
	}
	
	@Override
	public void updateImg(String memberImg,String memberId)throws Exception{
		memberDAO.updateImg(memberImg, memberId);
		
	}
	
	//회원정지
	@Override
	public void memberSanction(String memberId,String sanctionTime)throws Exception{
		memberDAO.memberSanction(memberId,sanctionTime);
	}
	
	//회원정지해제
	@Override
	public void memberSanctionCancel(String memberId)throws Exception{
		memberDAO.memberSanctionCancel(memberId);
	}
	
	@Override	
	//회원정지유무 확인
	public int memberRankCheck(String memberId)throws Exception{
		return memberDAO.memberRankCheck(memberId);
	}
	
	//정지시간확인
	@Override
	public Date memberSanctionTime(String memberId)throws Exception{
		return memberDAO.memberSanctionTime(memberId);
	}
	
		
	@Override
	public List<MemberVO> memberList(SearchCriteria scri) throws Exception{
		return memberDAO.memberList(scri);
	}
	
	public int memberListCount()throws Exception{
		return memberDAO.memberListCount();
	}
	
	public void insertPoint(String memberId , String memberPoint)throws Exception {
		memberDAO.insertPoint(memberId, memberPoint);
	}
	
	public void insertDevPoint(String memberId, String memberPoint)throws Exception {
		memberDAO.insertDevPoint(memberId, memberPoint);
	}

	//공지사항유무
	public void insertNotice(int bno)throws Exception {
		memberDAO.insertNotice(bno);
	}

	public void deleteNotice(int bno)throws Exception {
		memberDAO.deleteNotice(bno);
	}
	
	public List<BoardVO> noticeView()throws Exception{
		return memberDAO.noticeView();
	}

	
	//관리자 지정
	@Override
	public void memberMaster(String memberId)throws Exception{
		memberDAO.memberMaster(memberId);
	}
	
	@Override
	public void memberMasterCancel(String memberId)throws Exception{
		memberDAO.memberMasterCancel(memberId);

	}
	
	
	
	//소셜로그인
	public void snsRegister(String id,String name,String email)throws Exception{
		memberDAO.snsRegister(id, name, email);
	}
	
	//소셜로그인 체크
	public int snsLoginCheck(String id)throws Exception{
		return memberDAO.snsLoginCheck(id);
	}
	
	//소셜로그인
	public MemberVO snsLogin(String id)throws Exception{
		return memberDAO.snsLogin(id);
	}
	

	
}
