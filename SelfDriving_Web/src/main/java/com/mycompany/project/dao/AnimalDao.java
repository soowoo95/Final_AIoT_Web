package com.mycompany.project.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Animal;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class AnimalDao extends EgovAbstractMapper {
	private static final Logger LOGGER = LoggerFactory.getLogger(AnimalDao.class);

	public void insert(Animal animal) {
		//LOGGER.info("db에 insert할거다");
		insert("insert", animal);
	}
}
