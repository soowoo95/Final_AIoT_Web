package com.mycompany.project.controller;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.project.service.MQTT;
import com.mycompany.project.service.SignService;
import com.mycompany.project.model.Animal;
import com.mycompany.project.model.Pager;
import com.mycompany.project.model.Sign;
import com.mycompany.project.model.SignPager;
import com.mycompany.project.service.AnimalService;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/home") 
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private AnimalService animalService;
	@Autowired
	private SignService signService;
	@Autowired
	MQTT ReadFromOtherMQTT;
	
	//MQTT 연결 및 스레드 실행
	@PostConstruct
	public void mqttConnect() {
		String MqttServer1= "tcp://192.168.3.105:1883";
		String client_id = "hostname";
		String username = "hostname";	
		String passwd = "12345";
		String topic = "/*";
	
		ReadFromOtherMQTT.chogihwa(MqttServer1, client_id, username, passwd);
		ReadFromOtherMQTT.init(topic);
		ReadFromOtherMQTT.subscribe(0);

		//MQTT mqtt = new MQTT();
		//mqtt.start();
		ReadFromOtherMQTT.setDaemon(true);
		ReadFromOtherMQTT.start();
	}
	
	@RequestMapping("/main.do")
	public String main(){
		return "home/main";
	}
	
	//history.jsp에서 이미지를 보여준다.
	@RequestMapping("/imageView.do")
	@ResponseBody
	public void imageView(@RequestParam int dno,
						  HttpServletResponse response) throws Exception {

		Animal animal = new Animal();
		animal = animalService.getAnimal(dno);

		String imgLoc = animal.getDlocation();
		LOGGER.info(imgLoc);
		
		InputStream is = new FileInputStream(imgLoc);
		OutputStream os = response.getOutputStream();
		FileCopyUtils.copy(is, os);
		os.close();
		is.close();
	}
	
	//history.jsp에서 이미지를 보여준다.
	@RequestMapping("/imageView2.do")
	@ResponseBody
	public void imageView2(@RequestParam int sno,
						  HttpServletResponse response) throws Exception {

		Sign sign = new Sign();
		sign = signService.getSign(sno);
		//LOGGER.info("이미지 뽑았다ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
		
		String imgLoc = sign.getSlocation();
		LOGGER.info(imgLoc);
		
		InputStream is = new FileInputStream(imgLoc);
		OutputStream os = response.getOutputStream();
		FileCopyUtils.copy(is, os);
		os.close();
		is.close();
	}
	//status.jsp에 넘겨줄 CCTV가 찍은 유해동물 리스트
	@RequestMapping("/status.do")
	public String status(Model model){
		LOGGER.info("실행");
		List<Animal>list = animalService.getCCTVanimal();
		model.addAttribute("animal", list);
		return "home/status";
	}

	@ResponseBody
	@RequestMapping("/dcompleteUpdate.do")
	public void update(@RequestParam Map<String,Object> data){
		LOGGER.info("실행");
		Object dnoStr = data.get("dno");
		int dno = Integer.parseInt((String) dnoStr);
		System.out.println("넘어온 사건 번호: " + dno);
		animalService.updateDcomplete(dno);
		System.out.println("업데이트 처리 완료했지롱");
	}
	
	@RequestMapping("/analysis.do")
	public String analysis(){
		LOGGER.info("실행");
		return "home/analysis";
	}

	@RequestMapping("/intro.do")
	public String intro(){
		LOGGER.info("실행");
		return "home/intro";
	}

	@RequestMapping("/history.do")
	public String history(Model model, 
						  @RequestParam(defaultValue="1")int pageNo, 
						  @RequestParam(defaultValue="1")int pageSNo,
						  @RequestParam(defaultValue="7") int rowsPerPage,
						  HttpSession httpSession) {
		
		LOGGER.info("실행");

		Pager pager = new Pager(rowsPerPage, 10, animalService.getTotalListNo(), pageNo);
		model.addAttribute("pager", pager);
		httpSession.setAttribute("pager", pager);
		
		SignPager signPager = new SignPager(rowsPerPage, 10, signService.getTotalListNo(), pageSNo);
		model.addAttribute("signPager", signPager);
		httpSession.setAttribute("signPager", signPager);

		model.addAttribute("animal", animalService.getListByPage(pageNo,rowsPerPage));
		model.addAttribute("sign", signService.getListByPage(pageSNo, rowsPerPage));
		
		return "home/history";
	}

	@RequestMapping("/analysisMonth.do")
	@ResponseBody
	public List analysisMonth() {
		List monthlist = new ArrayList<>(); 
		monthlist = animalService.getanalysisMonth();
		return monthlist;
	}
	
	@RequestMapping("/analysisMonthwithterm.do")
	@ResponseBody
	public List analysisMonth(@RequestBody String termval) {
		termval= termval.replaceAll("=", "");
		List monthlistwithterm = new ArrayList<>(); 
		monthlistwithterm = animalService.getanalysisMonthwithterm(termval);
		return monthlistwithterm;
	}
	
	@RequestMapping("/analysisHour.do")
	@ResponseBody
	public List analysisHour() {
		List hourlist = new ArrayList<>(); 
		hourlist = animalService.getanalysisHour();
		return hourlist;
	}
	
	@RequestMapping("/analysisHourwithterm.do")
	@ResponseBody
	public List analysisHourwithterm(@RequestBody String termval){
		LOGGER.info(termval);
		termval= termval.replaceAll("=", "");
		List hourlistwithterm = new ArrayList<>(); 
		hourlistwithterm = animalService.getanalysisHourwithterm(termval);
		return hourlistwithterm;
	}
	
	@RequestMapping("/analysisRegion.do")
	@ResponseBody
	public List analysisRegion() {
		List regionlist = new ArrayList<>(); 
		regionlist = animalService.getanalysisRegion();
		return regionlist;
	}
	
	@RequestMapping("/analysisRegionwithterm.do")
	@ResponseBody
	public List analysisRegionwithterm(@RequestBody String termval){
		LOGGER.info(termval);
		termval= termval.replaceAll("=", "");
		List regionlistwithterm = new ArrayList<>(); 
		regionlistwithterm = animalService.getanalysisRegionwithterm(termval);
		return regionlistwithterm;
	}
	
	@RequestMapping("/mainDangerLevel.do")
	@ResponseBody
	public String mainDangerLevel() {
		String howdanger = animalService.mainDangerLevel();
		return howdanger;
	}
	
	@RequestMapping("/LevelCount.do")
	@ResponseBody
	public List mainLevelCount() {
		List dlevelCount = new ArrayList<>();
		dlevelCount = animalService.levelCount();
		return dlevelCount;
	}
	
	@RequestMapping("/jetson1.do")
	public String jetson1() {
		LOGGER.info("실행");						
		return "home/jetson1";
	}
	@RequestMapping("/jetson2.do")
	public String jetson2() {
		LOGGER.info("실행");						
		return "home/jetson2";
	}	
	@RequestMapping("/jetson3.do")
	public String jetson3() {
		LOGGER.info("실행");						
		return "home/jetson3";
	}	
}