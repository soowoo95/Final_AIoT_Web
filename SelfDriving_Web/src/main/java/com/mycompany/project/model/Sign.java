package com.mycompany.project.model;

import java.util.Date;

public class Sign {
	
	private int sno;
	private int sactno;
	private String sname;
	private int snum;
	private String sfinder;	
	private String szone;
	private Date stime;
	private int scomplete;
	private String slocation;
	private String simagesname;			
	private String simagetype;
	
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getSactno() {
		return sactno;
	}
	public void setSactno(int sactno) {
		this.sactno = sactno;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getSfinder() {
		return sfinder;
	}
	public void setSfinder(String sfinder) {
		this.sfinder = sfinder;
	}
	public String getSzone() {
		return szone;
	}
	public void setSzone(String szone) {
		this.szone = szone;
	}
	public Date getStime() {
		return stime;
	}
	public void setStime(Date stime) {
		this.stime = stime;
	}
	public int getScomplete() {
		return scomplete;
	}
	public void setScomplete(int scomplete) {
		this.scomplete = scomplete;
	}
	public String getSlocation() {
		return slocation;
	}
	public void setSlocation(String slocation) {
		this.slocation = slocation;
	}
	public String getSimagesname() {
		return simagesname;
	}
	public void setSimagesname(String simagesname) {
		this.simagesname = simagesname;
	}
	public String getSimagetype() {
		return simagetype;
	}
	public void setSimagetype(String simagetype) {
		this.simagetype = simagetype;
	}
}