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
		//LOGGER.info("service에서 dao로 넘길거다");
		animalDao.insert(animal);
	}

	public Animal getAnimal(int dno) {
		LOGGER.info("service에서 dao로 넘길거다");
		Animal animal = animalDao.selectByDno(dno);
		return animal;
	}

	public List<Animal> listupdate() {
		List list = new ArrayList<>();
		list = animalDao.listupdate();
		return list;
	}
}
