package com.mycompany.project.controller;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.project.model.Animal;
import com.mycompany.project.service.AnimalService;

@Controller
@RequestMapping("/home") 
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private AnimalService animalService;
	
	@RequestMapping("/main.do")
	public String central(){
		LOGGER.info("실행");
		return "home/main";
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
			int dno = (int)((Math.random()*10)*1000 +1);
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
	
	@GetMapping("/imageView.do")
	public String imageView(int dno, Model model) {
		LOGGER.info("실행");
		Animal animal = new Animal();
		animal = animalService.getAnimal(dno);
		model.addAttribute("animalView", animal);
		return "home/history";
	}
	
	@RequestMapping("/status.do")
	public String status(){
		LOGGER.info("실행");
		return "home/status";
	}
}