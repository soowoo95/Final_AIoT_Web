package com.mycompany.project.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Animal {

	private int dno;			
	private String dname;	
	private int dlevel;
	private int dnum;	
	private String dfinder;	
	private String dlocation;
	private Date dtime;
	
	private String dimagesname;			
	private String dimagetype;
	
	private String dtimeconv;
	
	public int getDno() {
		return dno;
	}
	public void setDno(int dno) {
		this.dno = dno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public int getDlevel() {
		return dlevel;
	}
	public void setDlevel(int dlevel) {
		this.dlevel = dlevel;
	}
	public int getDnum() {
		return dnum;
	}
	public void setDnum(int dnum) {
		this.dnum = dnum;
	}
	public String getDfinder() {
		return dfinder;
	}
	public void setDfinder(String dfinder) {
		this.dfinder = dfinder;
	}
	public String getDlocation() {
		return dlocation;
	}
	public void setDlocation(String dlocation) {
		this.dlocation = dlocation;
	}
	public Date getDtime() {
		return dtime;
	}
	public void setDtime(Date dtime) {
		this.dtime = dtime;
	}
	public void setDtimeconv(String dtimeconv) {
		this.dtimeconv = dtimeconv;
	}
	public String getDimagesname() {
		return dimagesname;
	}
	public void setDimagesname(String dimagesname) {
		this.dimagesname = dimagesname;
	}
	public String getDimagetype() {
		return dimagetype;
	}
	public void setDimagetype(String dimagetype) {
		this.dimagetype = dimagetype;
	}
}