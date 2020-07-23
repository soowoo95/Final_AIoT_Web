package com.mycompany.project.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home") 
public class HomeController 
{
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);

/*	@RequestMapping("/main.do") 
	public String main(String Ledvalue) throws Exception{
		LOGGER.info("실행");
		return "home/main";
	}*/
/*	@RequestMapping("/MainControl.do")
	public String manual(){
		LOGGER.info("실행");
		return "home/MainControl";
	}*/
	@RequestMapping("/MainControl.do")
	public String central(){
		LOGGER.info("실행");
		return "home/MainControl";
	}
	@RequestMapping("/chart.do")
	public String chart(){
		LOGGER.info("실행");
		return "home/chart";
	}
	@RequestMapping("/history.do")
	public String history(){
		LOGGER.info("실행");
		return "home/history";
	}
	@RequestMapping("/status.do")
	public String status(){
		LOGGER.info("실행");
		return "home/status";
	}
}