package com.mycompany.project.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.AnimalDao;
import com.mycompany.project.model.Animal;

@Service
public class AnimalService {
	private static final Logger LOGGER = LoggerFactory.getLogger(AnimalService.class);

	@Autowired
	private AnimalDao animalDao;

	public void SaveImage(Animal animal) {
		animalDao.insert(animal);
	}

	public Animal getAnimal(int dno) {
		Animal animal = animalDao.selectByDno(dno);
		return animal;
	}

	public int getTotalListNo() {
		return animalDao.count();
	}

	public Object getListByPage(int pageNo, int rowsPerPage) {
		List<Animal> list = animalDao.selectByPage(pageNo, rowsPerPage);
		return list;
	}

	public List getanalysisMonth() {
		List monthlist = new ArrayList<>();
		monthlist= animalDao.getanalysisMonth();
		return monthlist;
	}

	public List getanalysisRegion() {
		List regionlist = new ArrayList<>();
		regionlist= animalDao.getanalysisRegion();
		return regionlist;
	}

	public String mainDangerLevel() {
		String howdanger= animalDao.getmainDangerLevel();
		return howdanger;
	}
}
