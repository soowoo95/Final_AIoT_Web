package com.mycompany.project.controller;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.project.service.MQTT;
import com.mycompany.project.model.Animal;
import com.mycompany.project.service.AnimalService;

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
		String MqttServer1= "tcp://192.168.3.184:1883";
		String client_id = "hostname";
		String username = "hostname";	
		String passwd = "12345";	
		String topic = "/*";
	
		ReadFromOtherMQTT.chogihwa(MqttServer1, client_id, username, passwd);
		ReadFromOtherMQTT.init(topic);
		ReadFromOtherMQTT.subscribe(0);	
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

	@RequestMapping("/history.do")
	public String history(Model model) {
		LOGGER.info("실행");
		
		ArrayList<Animal> animalList = new ArrayList<Animal>();
		for (int i = 0; i < 10; i++) {
			int dno = i + 1;
			Animal animal = new Animal();
			animal = animalService.getAnimal(dno);
			animal.setDfinder(animal.getDfinder());
			animalList.add(animal);
		}
		model.addAttribute("animal",animalList);
		return "home/history";
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