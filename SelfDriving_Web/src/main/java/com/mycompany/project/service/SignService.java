package com.mycompany.project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.SignDao;
import com.mycompany.project.model.Sign;

@Service
public class SignService {
	private static final Logger LOGGER = LoggerFactory.getLogger(SignService.class);

	@Autowired
	private SignDao signDao;

	public Sign getSign(int sno) {
		Sign sign = signDao.selectBySno(sno);
		return sign;
	}

	public int getTotalListNo() {
		return signDao.count();
	}

	public Object getListByPage(int pageSNo, int rowsPerPage) {
		List<Sign> list = signDao.selectByPage(pageSNo, rowsPerPage);
		return list;
	}
}
