package com.mycompany.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Sign;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SignDao extends EgovAbstractMapper {
	private static final Logger LOGGER = LoggerFactory.getLogger(SignDao.class);

	public void insert(Sign sign) {
		insert("sign.insert", sign);
	}

	public Sign selectBySno(int sno) {
		Sign sign = selectOne("sign.selectBySno",sno);
		return sign;
	}
	
	public int count() {
		int totalRows = selectOne("sign.count");
		return totalRows;
	}
	
	public List<Sign> selectByPage(int pageSNo, int rowsPerPage) {
		LOGGER.info("실행");
		int startIndex = (pageSNo-1) * rowsPerPage;
		Map<String, Integer> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("rowsPerPage", rowsPerPage);
		List<Sign> list = selectList("sign.selectByPage", map);
		return list;
	}

}