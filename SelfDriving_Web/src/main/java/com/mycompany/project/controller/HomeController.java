package com.mycompany.project.controller;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import javax.annotation.PostConstruct;

import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.project.service.MQTT;
import com.mycompany.project.service.MqttToMqtt;
import com.mycompany.project.model.Animal;
import com.mycompany.project.service.AnimalService;

@Controller
@RequestMapping("/home") 
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private AnimalService animalService;
	@Autowired
	MqttToMqtt ReadAndSend;
	@Autowired
	MQTT ReadFromOtherMQTT;
	/*@Autowired
	private MqttPublishSample mqttPublishSample;*/
	@RequestMapping("/main.do")
	@PostConstruct
	public String main(){
		String MqttServer1= "tcp://192.168.3.184:1883";
		String client_id = "hostname";
		String username = "hostname";	
		String passwd = "12345";	
		String topic = "/2cctv";
		String msg = "HIYOM";
	
		//Receive message from Mqtt not Machine
		
		ReadFromOtherMQTT.chogihwa(MqttServer1, client_id, username, passwd);
		ReadFromOtherMQTT.init(topic);
		
		sleep(1000);
		try {
			ReadFromOtherMQTT.subscribe(0);	
		}
		finally
		{
			LOGGER.info("오류래");
		}
		//Receive message from Machine and Send to other MQTT
		ReadAndSend.chogihwa(MqttServer1, client_id, username, passwd, ReadFromOtherMQTT);
		/*try {
			ReadAndSend.init();
		}
		finally
		{
			LOGGER.info("오류래");
		}*/
		return "home/main";
	}
	static void sleep(int time){
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/jetbot.do")
	public String jetbot(){
		LOGGER.info("실행");
		return "home/jetbot";
	}

	@RequestMapping("/history.do")
	public String history(Model model) {
		LOGGER.info("실행");
		
		ArrayList<Animal> animalList = new ArrayList<Animal>();
		for (int i = 0; i < 10; i++) {
			int dno = (int)((Math.random()*1000) +1);
			Animal animal = new Animal();
			animal = animalService.getAnimal(dno);
			animal.setDfinder(animal.getDfinder().replace("/", ""));
			animalList.add(animal);
		}
		model.addAttribute("animal",animalList);
		return "home/history";
	}

	@PostMapping("/imageView.do")
	@ResponseBody
	public void imageView(	@RequestBody Map<String, Object>jsonDNO,
							HttpServletResponse response) throws Exception {

		Object DNO = jsonDNO.get("dno");
		LOGGER.info(DNO.toString());
		
		int dno = Integer.parseInt((DNO.toString()));

		Animal animal = new Animal();
		animal = animalService.getAnimal(dno);
		LOGGER.info("이미지 뽑았다ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
		
		String imgLoc = animal.getDlocation();
		LOGGER.info(imgLoc);
		
		FileInputStream fis = null;
		FileOutputStream fos = null;

		fis = new FileInputStream(imgLoc);            	// 원본파일
		String newAddr = "C:/MyWorkspace/git2/Final_AIoT_Web/SelfDriving_Web/src/main/webapp/resource/img/tempImg/attack.jpg";
		fos = new FileOutputStream(newAddr);   			// 복사위치
		   
		byte[] buffer = new byte[1024];
		int readcount = 0;
		  
		while((readcount=fis.read(buffer)) != -1) {
			fos.write(buffer, 0, readcount);    		// 파일 복사 
		}
		
		fis.close();
		fos.close();
		
		newAddr = newAddr.replace("C:/MyWorkspace/git2/Final_AIoT_Web/SelfDriving_Web/src/main/webapp/resource/img/tempImg", "");

		PrintWriter pw = response.getWriter();
		pw.write(newAddr);
		pw.flush();
		pw.close();	
	}

	@GetMapping("/fileview.do")
	@ResponseBody
	public String fileview(	@RequestBody Map<String, Object>jsonDNO,
							HttpServletResponse response) throws Exception {

		Object DNO = jsonDNO.get("dno");
		LOGGER.info(DNO.toString());
		
		int dno = Integer.parseInt((DNO.toString()));
		
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
		
		return "home/fileview";
	}

	@RequestMapping("/status.do")
	public String status(){
		LOGGER.info("실행");
		return "home/status";
	}
	
	@PostMapping("/getAnimalList.do")
	@ResponseBody
	public List listupdate(){
		//LOGGER.info("애니멀리스트");
		List<Animal> animallist= new ArrayList<Animal>();
		animallist = animalService.listupdate();
		for (Animal animal : animallist) {
			animal.setDfinder(animal.getDfinder().replace("/", ""));
		}
		return animallist;
	}
}