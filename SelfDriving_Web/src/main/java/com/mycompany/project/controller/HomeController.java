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

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.project.model.Animal;
import com.mycompany.project.service.AnimalService;

@Controller
@RequestMapping("/home") 
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private AnimalService animalService;
	
	@RequestMapping("/main.do")
	public String main(){
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
		String newAddr = "C:/MyWorkspace/git2/Final_AIoT_Web/SelfDriving_Web/src/main/webapp/resource/img/tempImg/attack.jpg";
		LOGGER.info(imgLoc);
		
		FileInputStream fis = null;
		FileOutputStream fos = null;

		fis = new FileInputStream(imgLoc);            	// 원본파일
		fos = new FileOutputStream(newAddr);   			// 복사위치
		   
		byte[] buffer = new byte[1024];
		int readcount = 0;
		  
		while((readcount=fis.read(buffer)) != -1) {
			fos.write(buffer, 0, readcount);    		// 파일 복사 
		}
		
		fos.flush();
		fis.close();
		fos.close();
	}
		
	
	
	
	
	
	
	
	
	
	
	
		//newAddr = newAddr.replace("C:/MyWorkspace/git2/Final_AIoT_Web/SelfDriving_Web/src/main/webapp/resource/img/tempImg", "");
		
/*		PrintWriter pw = response.getWriter();
		pw.write(newAddr);
		pw.flush();
		pw.close();	*/
	
		
		
		//파일 프로젝트 root에 저장하고 src를 리턴하기
/*		
		try {
			InputStream is = new FileInputStream(imgLoc);
			OutputStream os = new FileOutputStream("/src/resource/img/tempImg/attack.jpg");
			
			byte[] buffer = new byte[1000];
			while(true) {
				int readByteNum = is.read(buffer);
				if(readByteNum == -1) {
					break;
				}
				os.write(buffer, 0, readByteNum);
			}
			//출력 스트림 마지막에는 늘 플러쉬!
			os.flush();
			os.close();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
/*		
		
		File file = new File(imgLoc);
 		File newFile = new File("${pageContext.request.contextPath}/resource/img/tempImg/copied.jpg");
 		ImageIO.write(file,"jpg", newFile);*/
 		
/*		ImageIO.write(file,"jpg", new File)
		Image orginalImage = ImageIO.read(new File(imgLoc));
		ImageIO.write(orginalImage, "jpg", new File("${pageContext.request.contextPath}/resource/img/tempImg/copied.jpg"));
*/
		

		//BufferedImage image = ImageIO.read(new File(imgLoc));
		
/*		imgLoc = "\"" + imgLoc + "\"";
		LOGGER.info(imgLoc);*/
		//return imgLoc;
	
/*	@GetMapping("/imageView.do")
	@ResponseBody
	public void imageView(	@RequestParam int dno,
						 	HttpServletRequest request, HttpServletResponse response) throws Exception {

		Animal animal = new Animal();
		animal = animalService.getAnimal(dno);
		LOGGER.info("이미지 뽑았다ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
		
		String filePath = animal.getDlocation();
		response.setContentType(animal.getDimagetype());
		
		InputStream is = new FileInputStream(filePath);
		OutputStream os = response.getOutputStream();
		FileCopyUtils.copy(is, os);
		os.close();
		is.close();
	}*/
	
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