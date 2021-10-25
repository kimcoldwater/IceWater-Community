package kr.co.controller;

import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.util.WebUtils;

import kr.co.commons.sns.SNSLogin;
import kr.co.commons.sns.SnsValue;
import kr.co.service.MemberService;
import kr.co.util.FileUtils;
import kr.co.vo.LoginVO;
import kr.co.vo.MemberVO;
import kr.co.vo.PageMaker;
import kr.co.vo.SearchCriteria;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	private FileUtils fileUtil;
	
	@Inject 
	private MemberService memberService;
	
	@Inject
	private SnsValue naverSns;
	
	@RequestMapping(value="/registerView",method= RequestMethod.GET)
	public String registerView() throws Exception{
		logger.info("registerView");
		return "/member/registerView";
	}
	
	@RequestMapping(value = "/register", method=RequestMethod.POST)
	public String register(MemberVO memberVO, RedirectAttributes rttr, Model model)throws Exception{
		logger.info("register");
		String hashedPw = BCrypt.hashpw(memberVO.getMemberPw(), BCrypt.gensalt());
		memberVO.setMemberPw(hashedPw);
		memberService.register(memberVO);
		model.addAttribute("member", memberVO);
		
		
		rttr.addFlashAttribute("msg", "가입이 완료되었습니다");
		rttr.addAttribute("memberEmail", memberVO.getMemberEmail());
		rttr.addAttribute("memberId", memberVO.getMemberId());
		
		return "redirect:/member/registerAuth";
		
		
	}
	
	@RequestMapping(value="registerEmail", method=RequestMethod.GET)
	public String emailConfirm(String memberEmail,String key,Model model)throws Exception{
		logger.info("Key="+key);
		logger.info("Email"+memberEmail);
		memberService.memberAuth(memberEmail,key);
		model.addAttribute("memberEmail", memberEmail);
		
		return "/member/registerEmail";
	}
	
	
	//아이디유효성체크 
	@RequestMapping(value="/idCnt", method=RequestMethod.POST)
	@ResponseBody
	public String idCnt(@RequestBody String filterJSON,HttpServletResponse response, ModelMap model)throws Exception{
		JSONObject resMap= new JSONObject();
		//resMap이라는 JSONObject를 만듬 기본사용법과 특징은 Map와 유사하다 key,value형식으로 데이터를 관리.
		try {
			ObjectMapper mapper = new ObjectMapper();
			MemberVO searchVO = (MemberVO) mapper.readValue(filterJSON, new TypeReference<MemberVO>()
					{});
			int idCnt = memberService.idCnt(searchVO);
			logger.info("idCnt"+idCnt);
			
			resMap.put("res", "ok");
			resMap.put("idCnt", idCnt);
			
		}catch(Exception e) {
			System.out.println(e.toString());
			resMap.put("res","error");
		}
		
		logger.info("idCnt"+resMap);
		response.setContentType("text/html: charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(resMap);
		
		return null;
	}
	
	
	
	
	@RequestMapping(value="/loginView",method= RequestMethod.GET)
	public String loginView(@ModelAttribute("loginVO")LoginVO loginVO,HttpServletRequest request,Model model) throws Exception{
		logger.info("loginView");
		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if(null != inputFlashMap) {
			model.addAttribute("msg",(String) inputFlashMap.get("msg"));
		}
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		return "/member/loginView";
	}
	
	//이메일인증
	@RequestMapping(value="/registerAuth",method= RequestMethod.GET)
	public String loginView(HttpServletRequest request,Model model,@RequestParam("memberEmail")String memberEmail,@RequestParam("memberId")String memberId) throws Exception{
		logger.info("loginView");
		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if(null != inputFlashMap) {
			model.addAttribute("msg",(String) inputFlashMap.get("msg"));
		}
		model.addAttribute("memberEmail", memberEmail);
		model.addAttribute("memberId", memberId);
		
		
		return "/member/registerAuth";
	}
	
	//로그인
	@RequestMapping(value="/login" , method= RequestMethod.POST)
	public String loginPost(LoginVO loginVO, HttpSession httpSession,Model model)throws Exception{
		logger.info("loginVO"+loginVO.getMemberId());
		MemberVO memberVO = memberService.login(loginVO);
		
	
		if(memberService.memberRankCheck(loginVO.getMemberId()) == 1) {
			logger.info("들어옴?? ");
			httpSession.invalidate();
			model.addAttribute("sanctionTime", memberService.memberSanctionTime(memberVO.getMemberId()));
			return "/member/sanction";
		}
		logger.info("Pw"+memberVO);
		if( memberVO == null || !BCrypt.checkpw(loginVO.getMemberPw(), memberVO.getMemberPw())) {
			return "/member/loginCheck";
		}
		
		if(memberVO.getMemberAuth() == 0) {
			model.addAttribute("Auth", memberVO.getMemberAuth());
			return "/member/registerReady";
		}
		
		
		model.addAttribute("member", memberVO);
		
		if(loginVO.isUseCookie()) {
			int amount = 60*60*24*7;
			Date sessionLimit = new Date(System.currentTimeMillis() + (1000*amount));
			memberService.keepLogin(memberVO.getMemberId(), httpSession.getId(), sessionLimit);
		
		}

		

		
		return "board/list";
		
		
	}
	
	
	@RequestMapping(value="/naverLogin", method = {RequestMethod.GET, RequestMethod.POST})
	public String snsLoginCallback(HttpSession session,Model model,@RequestParam String code)throws Exception{
		logger.info("naverLogin");
		SnsValue sns = naverSns;
		
		
		SNSLogin snsLogin = new SNSLogin(sns);
		MemberVO snsUser = snsLogin.getUserProfile(code);
		logger.info("Profile="+snsUser.getNaverid());
		
		if(memberService.snsLoginCheck(snsUser.getNaverid()) == 0) {
		memberService.snsRegister(snsUser.getNaverid(), snsUser.getNickname(), snsUser.getEmail());
		}
		MemberVO memberVO = memberService.snsLogin(snsUser.getNaverid());
		session.setAttribute("login", memberVO);
		return "redirect:/board/list";
	}

	
	@RequestMapping(value="/errorLogin",method= RequestMethod.GET)
	public String errorLogin() throws Exception{
		logger.info("errorLogin");
		return "/member/errorLogin";
	}
	
	//로그아웃
	@RequestMapping(value="/logout" , method=RequestMethod.GET)
	public String logout(HttpServletRequest request,  HttpSession session, HttpServletResponse response,ModelMap model)throws Exception{
		logger.info("logout");
		
		Object URL = session.getAttribute("URL");
		Object object = session.getAttribute("login");
		if(object != null) {
			MemberVO memberVO = (MemberVO) object;
			session.removeAttribute("login");
			session.invalidate();
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				memberService.keepLogin(memberVO.getMemberId(),"none",new Date());
				
			}
		}
		logger.info("URL"+ URL);
		 String requestURL = "/";
		    if(StringUtils.isNotBlank((String) URL)) 
		    	requestURL = (String)URL;
		
		return "redirect:"+requestURL;
		
		
	}
	

	
	
	
	
	
	
	@RequestMapping(value="/registerReady",method= RequestMethod.GET)
	public String registerReady() throws Exception{
		logger.info("errorLogin");
		return "/member/registerReady";
	}
	
	//
	@RequestMapping(value="/loginCheck",method= RequestMethod.GET)
	public String loginCheck() throws Exception{
		logger.info("loginCheck");
		return "/member/loginCheck";
	}
	
	//아이디찾기뷰
	@RequestMapping(value="/findIdView", method=RequestMethod.GET)
	public String findIdView() throws Exception{
		return"/member/findIdView";
	}
	
	//아이디찾기
	@RequestMapping(value="/findId", method=RequestMethod.POST)
	public String findId(MemberVO memberVO,Model model) throws Exception{
		logger.info("memberEmail"+memberVO.getMemberEmail());
				
		if(memberService.findIdCheck(memberVO.getMemberEmail())==0) {
		model.addAttribute("msg", "이메일을 확인해주세요");
		return "/member/findIdView";
		}else {
		model.addAttribute("member", memberService.findId(memberVO.getMemberEmail()));
		return
				"/member/findId";
		}
	}
	
	
	//비번찾기뷰
	@RequestMapping(value="/findPwView" , method=RequestMethod.GET)
	public String findPwView() throws Exception{
		return"/member/findPwView";
	}
		
	//비밀번호찾기
	@RequestMapping(value="/findPw", method=RequestMethod.POST)
	public String findPw(MemberVO memberVO,Model model) throws Exception{
		logger.info("memberPw"+memberVO.getMemberId());
		
		if(memberService.findPwCheck(memberVO)==0) {
			logger.info("memberPWCheck");
			model.addAttribute("msg", "아이디와 이메일를 확인해주세요");
			
			return "/member/findPwView";
		}else {
	
		memberService.findPw(memberVO.getMemberEmail(),memberVO.getMemberId());
		model.addAttribute("member", memberVO.getMemberEmail());
		
		return"/member/findPw";
		}
	}
	
	//회원정보수정뷰
	@RequestMapping(value="/infoView", method=RequestMethod.GET)
	public String infoView() throws Exception{
		return"/member/infoView";
	}
	
	@RequestMapping(value="/infoUpdate", method=RequestMethod.POST)
	public String infoUpdate(HttpServletRequest request,HttpSession session,MemberVO memberVO,Model model,RedirectAttributes rttr)throws Exception{
		memberService.infoUpdate(memberVO); 
		session.invalidate();
		rttr.addFlashAttribute("msg", "정보 수정이 완료되었습니다. 다시 로그인해주세요.");
		return"redirect:/member/loginView";
	}
	
	//닉네임 유효성 체크
		@RequestMapping(value="/nameCheck",method=RequestMethod.POST)
		@ResponseBody
		public String idCnt(@RequestBody String filterJSON,HttpServletResponse response,Model model)throws Exception{
			JSONObject resMap = new JSONObject();
			try {
				ObjectMapper mapper = new ObjectMapper();
				MemberVO searchVO = (MemberVO) mapper.readValue(filterJSON, new TypeReference<MemberVO>(){});
				
				int nameCnt = memberService.nameCheck(searchVO);
				resMap.put("res", "ok");
				resMap.put("nameCnt", nameCnt);
				}catch(Exception e) {
					System.out.println(e.toString());
					resMap.put("res","error");
				}
			response.setContentType("text/html: charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(resMap);
			
			return null;
		}
	
	@RequestMapping(value="/pwUpdateView", method=RequestMethod.GET)
	public String pwUpdateView() throws Exception{
		return "/member/pwUpdateView";
	}

	@RequestMapping(value="/pwCheck" , method=RequestMethod.POST)
	@ResponseBody
	public int pwCheck(MemberVO memberVO) throws Exception{
		String memberPw = memberService.pwCheck(memberVO.getMemberId());
		
		if(memberVO == null || !BCrypt.checkpw(memberVO.getMemberPw(), memberPw)) {
			return 0;
		}
		
		return 1;
	}
	
	@RequestMapping(value="/pwUpdate" , method=RequestMethod.POST)
	public String pwUpdate(String memberId,String memberPw1,RedirectAttributes rttr,HttpSession session)throws Exception{
		String hashedPw = BCrypt.hashpw(memberPw1, BCrypt.gensalt());
		memberService.pwUpdate(memberId, hashedPw);
		session.invalidate();
		rttr.addFlashAttribute("msg", "정보 수정이 완료되었습니다. 다시 로그인해주세요.");
		
		return "redirect:/member/loginView";
	}
	
	@RequestMapping(value="/deleteView", method=RequestMethod.GET)
	public String deleteView() throws Exception{
		return "/member/deleteView";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(String memberId,RedirectAttributes rttr,HttpSession session)throws Exception{
		memberService.delete(memberId);
		session.invalidate();
		rttr.addFlashAttribute("msg", "이용해주셔서 감사합니다.");
		return "redirect:/member/loginView";
	}
	
	
	@RequestMapping(value="/updateImg", method=RequestMethod.POST)
	public String updateImg(MultipartHttpServletRequest mpRequest, HttpSession session , String memberId)throws Exception {
		
		String memberImg = fileUtil.updateImg(mpRequest); 

		MemberVO memberVO = (MemberVO) session.getAttribute("login");
		
		memberService.updateImg(memberImg, memberId);
		
		memberVO.setMemberImg(memberImg);
		session.setAttribute("login", memberVO);
		
				
		return "redirect:/member/infoView";
	}


	
	//관리자페이지
	@RequestMapping(value="/master", method=RequestMethod.GET)
	public String memberSanctionView(HttpSession session, Model model,@ModelAttribute("scri") SearchCriteria scri) throws Exception{
		MemberVO memberVO = (MemberVO)session.getAttribute("login");
		
		if(memberVO.getMemberRank() != 3 || memberVO == null) {
			session.invalidate();
			return "/member/loginView";
		}
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(memberService.memberListCount());
		
		model.addAttribute("list", memberService.memberList(scri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("notice", memberService.noticeView());
		return "/member/master";
	}
	
	@RequestMapping(value="/memberSanction", method=RequestMethod.POST)
	public String memberSanction(Model model,String memberName,int sanctionTime) throws Exception{
		
		memberService.memberSanction(memberName,sanctionTime);	
		
		
		return "redirect:/member/master";
	}
	
	@RequestMapping(value="/memberSanctionCancel", method=RequestMethod.POST)
	public String memberSanction(Model model,String memberId) throws Exception{
		
		memberService.memberSanctionCancel(memberId);	
		
		
		return "redirect:/member/master";
	}
	
	
	@RequestMapping(value="/memberDelete", method=RequestMethod.POST)
	public String memberDelete(String memberId) throws Exception{
		
		memberService.delete(memberId);	
		
		
		return "redirect:/member/master";
	}
	
	@RequestMapping(value="/insertPoint", method=RequestMethod.POST)
	public String insertPoint(String memberId, String memberPoint) throws Exception{
		memberService.insertPoint(memberId, memberPoint);
		return "redirect:/member/master";
	}
	
	@RequestMapping(value="/insertDevPoint", method=RequestMethod.POST)
	public String insertDevPoint(String memberId, String memberPoint) throws Exception{
		memberService.insertDevPoint(memberId, memberPoint);
		return "redirect:/member/master";
	}
	
	@RequestMapping(value="/insertNotice", method=RequestMethod.POST)
	public String insertNotice(int bno)throws Exception{
		memberService.insertNotice(bno);
		return "redirect:/member/master";
	}
	
	@RequestMapping(value="/deleteNotice", method=RequestMethod.POST)
	public String deleteNotice(int bno)throws Exception{
		memberService.deleteNotice(bno);
		return "redirect:/member/master";
	}
	
	@RequestMapping(value="/memberMaster", method=RequestMethod.POST)
	public String memberMaster(String memberId)throws Exception{
		memberService.memberMaster(memberId);
		return "redirect:/member/master";
	}
	
	@RequestMapping(value="/memberMasterCancel", method=RequestMethod.POST)
	public String memberMasterCancel(String memberId)throws Exception{
		memberService.memberMasterCancel(memberId);
		return "redirect:/member/master";
	}
	
	
	
	
	
	
	
	
	
	
} 


