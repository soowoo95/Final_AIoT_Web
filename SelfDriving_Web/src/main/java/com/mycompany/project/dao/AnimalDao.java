package com.mycompany.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public Animal selectByDno(int dno) {
		//LOGGER.info("db에서 select할거다");
		Animal animal = selectOne("animal.selectByDno",dno);
		return animal;
	}

	public int count() {
		int totalRows = selectOne("animal.count");
		return totalRows;
	}

	public List<Animal> selectByPage(int pageNo, int rowsPerPage) {
		LOGGER.info("실행");
		int startIndex = (pageNo-1) * rowsPerPage;
		Map<String, Integer> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("rowsPerPage", rowsPerPage);
		List<Animal> list = selectList("animal.selectByPage", map);
		return list;
	}

	public List getanalysisMonth() {
		List monthlist = selectList("animal.monthList");
		return monthlist;
	}

	public List getanalysisRegion() {
		List monthlist = selectList("animal.regionList");
		return monthlist;
	}

	public String getmainDangerLevel() {
		String howdanger = selectOne("animal.howdanger");
		return howdanger;
	}
}
