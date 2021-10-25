package kr.co.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.BoardService;
import kr.co.service.ReplyService;
import kr.co.vo.AlramVO;
import kr.co.vo.BoardVO;
import kr.co.vo.MemberVO;
import kr.co.vo.PageMaker;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
		
	@Inject
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	@RequestMapping(value="/startPage", method=RequestMethod.GET)
	public String startPage() throws Exception{
		return "/board/startPage";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model)throws Exception {
		String memberId = "";
		
		if(session.getAttribute("login") != null) {
		MemberVO memberVO =(MemberVO) session.getAttribute("login");
		memberId = memberVO.getMemberId();
		}
		model.addAttribute("list",service.bestList(memberId));
		model.addAttribute("qna",service.qnaList(memberId));
		model.addAttribute("best1",service.bestList1(memberId));
		model.addAttribute("best3",service.bestList3(memberId));
		model.addAttribute("best4",service.bestList4(memberId));
		model.addAttribute("best6",service.bestList6(memberId));
		model.addAttribute("bestBoard",service.bestBoard(memberId));
		return "/board/home";
	}
	
	@RequestMapping(value = "board/list", method = RequestMethod.GET)
	public String list(HttpSession session,Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("list"+scri.getBgno());
		
			if(session.getAttribute("login") != null) {
			MemberVO memberVO =(MemberVO) session.getAttribute("login");			
			scri.setMemberId(memberVO.getMemberId());
		
			}
		
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(scri);
			pageMaker.setTotalCount(service.listCount(scri));
		model.addAttribute("list", service.list(scri));
		model.addAttribute("notice", service.notice());
	
		
		model.addAttribute("pageMaker", pageMaker);
		
	
	
		
		return "board/list";
		
	}
	
	
	//글작성 페이지
	@RequestMapping(value = "/board/writeView", method=RequestMethod.GET)
	public String writeView(HttpSession session ,@ModelAttribute("scri") SearchCriteria scri,Model model) throws Exception{
		logger.info("writeView ID");
		MemberVO memberVO =(MemberVO) session.getAttribute("login");
		model.addAttribute("point", service.questionPointCheck(memberVO.getMemberId()));
		
		model.addAttribute("bgno", scri.getBgno());
		
		
		
		return "/board/writeView";
		
	}
	
	//글작성
	@RequestMapping(value="/board/write", method=RequestMethod.POST)
	public String write(BoardVO boardVO,MultipartHttpServletRequest mpRequest, RedirectAttributes rttr,@ModelAttribute("scri")SearchCriteria scri) throws Exception{
		logger.info("write");
		logger.info("mpRequest");
		//기본글작성포인트
		if(boardVO.getBgnoinsert() == 25 || boardVO.getBgnoinsert() == 26|| 
				boardVO.getBgnoinsert() == 27 || boardVO.getBgnoinsert() == 28 || boardVO.getBgnoinsert() == 32) {
			service.upDevPoint(3, boardVO.getId());
		}else {
			service.upPoint(3, boardVO.getId());
		}
		
		service.write(boardVO,mpRequest);
		
		//채택점수부여
		if(boardVO.getHelppoint() != 0) {
		service.questionPointDown(boardVO.getHelppoint(),boardVO.getId());
		
		}
		
		
		
		
		rttr.addAttribute("bgno", scri.getBgno());
		rttr.addAttribute("sort", scri.getSort());
		return "redirect:/board/list";
	}
	
	
	
	@RequestMapping(value="/board/readView", method=RequestMethod.GET)
	public String read(HttpSession session,@ModelAttribute("scri") SearchCriteria scri,BoardVO boardVO, Model model) throws Exception{
		logger.info("read");
		
		//읽은 목록 표시
		if(session.getAttribute("login") != null) {
			MemberVO memberVO =(MemberVO) session.getAttribute("login");
		
		//처음 읽었다면 저장테이블에 insert
		if(service.boardCheck(boardVO.getBno(),memberVO.getMemberId())==0) {
		
		service.insertBoardCheck(boardVO.getBno(), memberVO.getMemberId());
		}
		
		//이전글 다음글 읽은 목록 표시
		BoardVO movePageVO = service.movePage(boardVO);
		
		int nextPageCheck = service.nextPageCheck(movePageVO.getNext(), memberVO.getMemberId());
		model.addAttribute("nextPageCheck", nextPageCheck);
		
		int lastPageCheck = service.nextPageCheck(movePageVO.getLast(),memberVO.getMemberId());
		model.addAttribute("lastPageCheck", lastPageCheck);
		}
		
		model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
		model.addAttribute("replyVO",new ReplyVO());
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);
		
		model.addAttribute("move", service.movePage(boardVO));
		model.addAttribute("scrap", service.scrapCount(boardVO.getBno()));
		
		
		return "/board/readView";
				
	}
	
	@RequestMapping(value="/board/updateView", method=RequestMethod.GET)
	public String updateView(BoardVO boardVO, Model model , @ModelAttribute("scri") SearchCriteria scri)throws Exception{
		logger.info("updateView");
		
		model.addAttribute("update", service.read(boardVO.getBno()));
		model.addAttribute("scri",scri);
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);
		
		return"board/updateView";
	}
	
	// 게시판 수정
		@RequestMapping(value = "/update", method = RequestMethod.POST)
		public String update(BoardVO boardVO, 
							 @ModelAttribute("scri") SearchCriteria scri, 
							 RedirectAttributes rttr,
							 @RequestParam(value="fileNoDel[]") String[] files,
							 @RequestParam(value="fileNameDel[]") String[] fileNames,
							 MultipartHttpServletRequest mpRequest) throws Exception {
			logger.info("update");
			service.update(boardVO, files, fileNames, mpRequest);
			
			rttr.addAttribute("bno", boardVO.getBno());
			rttr.addAttribute("bgno", scri.getBgno());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			rttr.addAttribute("sort", scri.getSort());

			return "redirect:/board/readView";
		}
				
	
		@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
		public String delete(BoardVO boardVO,@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
			logger.info("delete ID"+boardVO.getId());
			
			service.delete(boardVO);
			
			rttr.addAttribute("bgno", scri.getBgno());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			rttr.addAttribute("sort", scri.getSort());
			return "redirect:/board/list";
		}
		
		@RequestMapping(value="/board/fileDown")
		public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
			Map<String, Object> resultMap = service.selectFileInfo(map);
			String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
			String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
			
			// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\mp\\file\\"+storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		}
		
		
		
		
		//LIKE누름
		@ResponseBody
		@RequestMapping(value = "/board/updateLike" , method = RequestMethod.POST)
		public int updateLike(HttpSession session,int bno,@RequestParam("memberId")String memberId,@RequestParam("writerId")String writerId,Model model)throws Exception{
				logger.info("좋아요");
				
				MemberVO memberVO =(MemberVO) session.getAttribute("login");
				String memberID = memberVO.getMemberId();
				logger.info("updateLike-memberID"+memberID);

				
				if(service.hateCheck(bno, memberId) == 1) {
					int likeCheck = 2;
					return likeCheck; 
				}else {
				
				int likeCheck = service.likeCheck(bno, memberId);
				if(likeCheck == 0) {
					//좋아요 처음누름
					service.insertLike(bno, memberId); //like테이블 삽입
					service.updateLike(bno);	//게시판테이블 +1
					service.memberPointPlus(writerId); //회원포인트 +1
					
				}else if(likeCheck == 1) {
					service.updateLikeCancel(bno); //게시판테이블 =1
					service.deleteLike(bno, memberId); //like테이블 삭제
					service.memberPointDown(writerId);
			
				}
				return likeCheck;
				}
			
		}
		
		//HATE 누름
		@ResponseBody
		@RequestMapping(value = "/board/updateHate" , method = RequestMethod.POST)
		public int updateHate(int bno, String memberId,String writerId,Model model)throws Exception{
				if(service.likeCheck(bno, memberId) == 1) {
					int hateCheck = 2;
				return hateCheck;
				
				}else {
				int hateCheck = service.hateCheck(bno, memberId);
				if(hateCheck == 0) {
					//좋아요 처음누름
					service.insertHate(bno, memberId); //like테이블 삽입
					service.updateHate(bno);	//게시판테이블 +1
					service.memberPointDown(writerId);
					
				}else if(hateCheck == 1) {
					service.updateHateCancel(bno); //게시판테이블 =1
					service.deleteHate(bno, memberId); //like테이블 삭제
					service.memberPointPlus(writerId);
					
				}
				return hateCheck;
				}
		
			
		}
		
		//DEV 누름
		@ResponseBody
		@RequestMapping(value = "/board/updateDev" , method = RequestMethod.POST)
		public int updateDev(int bno, String memberId,String writerId,Model model)throws Exception{
				int devCheck = service.devCheck(bno, memberId);
				if(devCheck == 0) {
					//좋아요 처음누름
					service.insertDev(bno, memberId); //like테이블 삽입
					service.updateDev(bno);	//게시판테이블 +1
					service.memberDevPointPlus(writerId);
					
				}else if(devCheck == 1) {
					service.updateDevCancel(bno); //게시판테이블 =1
					service.deleteDev(bno, memberId); //like테이블 삭제
					service.memberDevPointDown(writerId);
					
				}
				return devCheck;
				}
		
			
		

		//채택
		@ResponseBody
		@RequestMapping(value = "/board/questionCheck",method=RequestMethod.POST)
		public int questionCheck(int bno,int helppoint,String Id,int rno,String memberId) throws Exception{
			int questionCheck ;
			try {
			service.questionPointUp(helppoint, Id);
			service.questionCheck(bno,rno);
			service.insertLog(bno,rno,Id,memberId);
			service.insertLogReply(bno,rno,Id,memberId);
			questionCheck = 1;
			}catch(Exception e) {
				questionCheck = 2;
				return questionCheck;
			}
			return questionCheck;
			
			
		}
		
		
		
		
		//스크랩
		@ResponseBody
		@RequestMapping(value = "/board/scrap", method=RequestMethod.POST)
		public int scrap (String Id, int bno) throws Exception{
			int scrap = service.scrapCheck(Id, bno);
			if (scrap == 0) {
			service.scrap(Id, bno);
			}else if(scrap == 1) {
			service.scrapCancel(Id, bno);
			}
			return scrap;
		}
		
		
		@RequestMapping(value="/board/mypageView", method=RequestMethod.GET)
		public String mypageView(String select,String memberId,Model model) throws Exception{
			logger.info("select"+select);
			model.addAttribute("info",service.memberInfo(memberId));
			model.addAttribute("memberId", memberId);
			model.addAttribute("memberDevCount", service.memberDevCount(memberId));
			
			if(select.equals("log")) {
			model.addAttribute("log",service.memberLog(memberId));
			}else if(select.equals("write")) {
			model.addAttribute("write",service.memberWrite(memberId));
			}else if(select.equals("scrap")) {
			model.addAttribute("scrap", service.memberScrap(memberId));
			}else if(select.equals("reply")) {
			model.addAttribute("reply", service.memberReply(memberId));
			}
			return "/board/mypageView";
			
		}
		
		
		//인기게시판
		@RequestMapping(value = "board/popular", method = RequestMethod.GET)
		public String popularBoard(HttpSession session,Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
			logger.info("list"+scri.getBgno());
			
				if(session.getAttribute("login") != null) {
				MemberVO memberVO =(MemberVO) session.getAttribute("login");			
				scri.setMemberId(memberVO.getMemberId());
			
				}
			
				
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(scri);
				pageMaker.setTotalCount(service.popularCount(scri));
			model.addAttribute("list", service.popularBoard(scri));
			model.addAttribute("notice", service.notice());
		
			
			model.addAttribute("pageMaker", pageMaker);
			
		
		
			
			return "/board/popular";
			
		}
	
		
		
		
		
		//알람
				@ResponseBody
				@RequestMapping(value = "/board/insertAlram", method=RequestMethod.POST)
				public int insertAlram (String toId , String fromId , String bno , String title , String categori,String bgno) throws Exception{
					logger.info("알람insert"+categori+"//"+fromId+toId+bno+categori+title);
					int alram = 1;
					
					service.insertAlram(toId, fromId, bno, title, categori,bgno);
					
					return alram;
				}
		
		//알람수
				@ResponseBody
				@RequestMapping(value = "/board/alramCount", method=RequestMethod.GET)
				public int alramCount (String memberId) throws Exception{
					
					int alram = service.alramCount(memberId);
					
					return alram;
				}	
				
				
				//알람목록
				@ResponseBody
				@RequestMapping(value = "/board/alramList", method=RequestMethod.GET)
				public List<AlramVO> alramList(String memberId) throws Exception{
										
					return service.alramList(memberId);
				}	
				
				
				//알람클릭
				@ResponseBody
				@RequestMapping(value = "/board/alramClick", method=RequestMethod.POST)
				public String alramClick(String memberId, int bno) throws Exception{
					logger.info("알람클릭");
					service.alramClick(memberId, bno);
					
					return "/board/readView?bno="+bno;
				}	
				
		
}
	
		
	


