package com.mycompany.project.controller;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH시 mm분 ss초");
		
		//1부터 1000 사이의 랜덤한 숫자 하나 가져와서 getAnimal 10번 실행해보자
		for (int i = 0; i < 10; i++) {
			int dno = (int)((Math.random()*10) +1);
			Animal animal = new Animal();
			animal = animalService.getAnimal(dno);
			animal.setDfinder(animal.getDfinder().replace("/", ""));
			String to = fm.format(animal.getDtime());
			animal.setDtimeconv(to);
			animalList.add(animal);
		}
		model.addAttribute("animal",animalList);
		return "home/history";
	}
	
	@PostMapping("/imageView.do")
	@ResponseBody
	public String imageView(@RequestBody Map<String, Object>jsonDNO) {
		LOGGER.info("번호 받았다아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
		Object DNO = jsonDNO.get("dno");
		LOGGER.info(DNO.toString());
		
		int dno = Integer.parseInt((DNO.toString()));
		
		Animal animal = new Animal();
		animal = animalService.getAnimal(dno);
		LOGGER.info("이미지 뽑았다ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
		String imgLoc = animal.getDlocation();
		imgLoc = "\"" + imgLoc + "\"";
		LOGGER.info(imgLoc);
		return imgLoc;
	}
	
	@RequestMapping("/status.do")
	public String status(){
		LOGGER.info("실행");
		return "home/status";
	}
	
	@PostMapping("/getAnimalList.do")
	@ResponseBody
	public List listupdate(){
		LOGGER.info("애니멀리스트");
		List<Animal> animallist= new ArrayList<Animal>();
		animallist = animalService.listupdate();
		for (Animal animal : animallist) {
			animal.setDfinder(animal.getDfinder().replace("/", ""));
		}
		return animallist;
	}
}