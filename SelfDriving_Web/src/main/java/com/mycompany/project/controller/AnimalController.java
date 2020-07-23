package com.mycompany.project.controller;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.project.model.Animal;
import com.mycompany.project.service.AnimalService;

@Controller
@RequestMapping("/animal") 
public class AnimalController{
	private static final Logger LOGGER = LoggerFactory.getLogger(AnimalController.class);
	
	@Autowired
	private AnimalService animalService;
	
	@ResponseBody
	@PostMapping("/saveImage.do")
	public void saveImage(@RequestBody Map<String, Object>jsonData) throws Exception {
		
		LOGGER.info("들어왔니");

		Object video = jsonData.get("Cam");
		Object clss = jsonData.get("Class");
		Object dfinder = jsonData.get("witness");
		LOGGER.info(dfinder.toString());
		
		Date date = new Date();
		String StringDate = new SimpleDateFormat("YYYY-MM-dd a hh-mm-ss-S").format(date);
		String saveDir = "C:/MyWorkspace/final_project/savedImages/";
		String savedFileName = "savedAt_" + StringDate + ".jpg";
		String filepath = saveDir + savedFileName;
		decoder(video.toString(), filepath);

		Animal animal = new Animal();
		savedFileName = savedFileName.replaceAll(":", "-");
		savedFileName = savedFileName.replaceAll(" ", "-");
		
		String dname = clss.toString();
		dname = dname.replace("[", "");
		dname = dname.replace("]", "");
		LOGGER.info(dname);
		
		int countSemi = StringUtils.countMatches(dname, ",");
		int dnum = countSemi + 1;
		
		animal.setDimagesname(savedFileName);
		animal.setDtime(date);
		animal.setDlocation(filepath);
		animal.setDname(dname);
		animal.setDnum(dnum);
		animal.setDfinder(dfinder.toString());

		animalService.SaveImage(animal);
		LOGGER.info("service로 넘긴다");
	}
		
		public static boolean decoder(String data, String target){
			byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);
			try {
				BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
				ImageIO.write(bufImg, "jpg", new File(target));
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
			return true;
		}
}