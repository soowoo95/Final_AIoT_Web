package com.mycompany.project.controller;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.tomcat.jni.Time;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.project.service.MQTT;
import com.mycompany.project.model.Animal;
import com.mycompany.project.model.Pager;
import com.mycompany.project.service.AnimalService;
import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/home") 
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private AnimalService animalService;
	
	@Autowired
	MQTT ReadFromOtherMQTT;
	
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
	}
	
	@RequestMapping("/landing.do")
	public String landing(){
		LOGGER.info("실행");
		return "home/landing";
	}
	
	
	@RequestMapping("/main.do")
	public String main(){
		return "home/main";
	}
	
	@RequestMapping("/jetracer.do")
	public String jetbot(){
		LOGGER.info("실행");
		return "home/jetracer";
	}
	
	@RequestMapping("/imageView.do")
	@ResponseBody
	public void imageView(@RequestParam int dno,
						HttpServletResponse response) throws Exception {

		Animal animal = new Animal();
		animal = animalService.getAnimal(dno);
		LOGGER.info("이미지 뽑았다ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
		
		String imgLoc = animal.getDlocation();
		LOGGER.info(imgLoc);
		
		InputStream is = new FileInputStream(imgLoc);
		OutputStream os = response.getOutputStream();
		FileCopyUtils.copy(is, os);
		os.close();
		is.close();
	}

	@RequestMapping("/status.do")
	public String status(){
		LOGGER.info("실행");
		return "home/status";
	}
	
	@RequestMapping("/analysis.do")
	public String analysis(){
		LOGGER.info("실행");
		return "home/analysis";
	}
	
	@RequestMapping("/history.do")
	public String history(Model model, @RequestParam(defaultValue="1")int pageNo, 
						@RequestParam(defaultValue="7") int rowsPerPage,
						HttpSession httpSession) {
		LOGGER.info("실행");

		Pager pager = new Pager(rowsPerPage, 5, animalService.getTotalListNo(), pageNo);
		model.addAttribute("pager", pager);
		httpSession.setAttribute("pager", pager);

		model.addAttribute("animal", animalService.getListByPage(pageNo,rowsPerPage));
		return "home/history";
	}

	@RequestMapping("/sleep.do")
	@ResponseBody
	public void sleep() {
		try {
			//주어진 time millisecond만큼 잠든다.
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// 트라이-캐치
			e.printStackTrace();
		}
	}	
}