package com.mycompany.project.service;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttAsyncClient;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttPersistenceException;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.slf4j.LoggerFactory;
import org.springframework.asm.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.project.dao.AnimalDao;
import com.mycompany.project.model.Animal;

@Service
public class MQTT implements MqttCallback{
	private static String Broker;
	private static String Client_ID;
	private static String UserName;
	private static String Passwd;
	private static MqttAsyncClient Client;
	private static MqttMessage message;
	private static MemoryPersistence persistence;
	private static MqttConnectOptions connOpts;
	private static String topic;
	private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(MQTT.class);
	
	@Autowired
	private AnimalDao animalDao;
	public void chogihwa(String broker, String client_id,String username, String passwd){
		this.Broker = broker;
		this.Client_ID = client_id;
		this.UserName = username;
		this.Passwd = passwd;	
	}
	
	public void init(String topic){
		this.topic = topic;
		this.persistence = new MemoryPersistence();
		try {
			Client = new MqttAsyncClient(this.Broker, this.Client_ID, this.persistence);
			Client.setCallback(this);

			connOpts = new MqttConnectOptions();
			//if(Client_ID!=null && Passwd != null){
				connOpts.setUserName(this.UserName);
				connOpts.setPassword(this.Passwd.toCharArray());
			//}
			connOpts.setCleanSession(true);
			System.out.println("Connecting to broker: "+this.Broker);
			
			Client.connect(connOpts);

			System.out.println("Connected");
			
			message = new MqttMessage();
		} catch(MqttException me) {
			System.out.println("reason "+me.getReasonCode());
			System.out.println("msg "+me.getMessage());
			System.out.println("loc "+me.getLocalizedMessage());
			System.out.println("cause "+me.getCause());
			System.out.println("excep "+me);
			me.printStackTrace();
		}
		
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void disconnect(){
		 try {
			Client.disconnect();
			Client.close();
		 } catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void publish(String msg, int qos){
		message.setQos(qos);
		message.setPayload(msg.getBytes());
		
		try {
			Client.publish(topic, message);
		} catch (MqttPersistenceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void subscribe(int qos){
		try {
			Client.subscribe(topic,qos);
			Client.subscribe("/1cctv",qos);
			Client.subscribe("/2cctv",qos);
			Client.subscribe("/3cctv",qos);
			Client.subscribe("/4cctv",qos);
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String getTopic(){
		return topic;
	}
	
	@Override
	public void messageArrived(String topic, MqttMessage mqttMessage) throws Exception {
    	//LOGGER.info("Message arrived : " +topic);
		
    	ObjectMapper mapper = new ObjectMapper();
    	String json = new String(mqttMessage.getPayload());
    	Map<String, Object> map = new HashMap<String, Object>();
    	map = mapper.readValue(json, new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>(){});
    	//System.out.println(map);
    	
    	//찾은 객체 이름를 저장온다 경로에 넣으려면 /는 없어져야겠지
    	String dfinder= topic;
    	dfinder = dfinder.replace("/", "");
    	
    	//비디오 BASE64형식을 가져온다
    	String video = (String) map.get("Cam");
    	
    	//저장한 시각을 가져온다
    	Date date = new Date();
		String StringDate = new SimpleDateFormat("YYYY-MM-dd HH-mm-ss-S").format(date);
		String saveDir = "C:/MyWorkspace/final_project/savedImages/";
		String savedFileName = "savedAt_" +dfinder+StringDate + ".jpg";
		String filepath = saveDir + savedFileName;

		//탐지된 객체 배열을 가져온다.
    	ArrayList<String> clss= (ArrayList<String>) map.get("Class");
    	
    	String listString= "";
    	//배열의 개수가 0이면 저장하지 않는다.
    	if (clss.size()!= 0) {
    		
    		//사진을 저장하자
    		decoder(video, filepath);
    		
	    	for (String s : clss){
	    		//객체 배열을 뽑아오기.
	    	    listString += ","+s;
	    	}
	    	listString = listString.substring(1);
	    	//객체를 생성하고 set하고 Dao로 DB에 넘겨서 저장한다.
	    	Animal animal= new Animal();
	    	animal.setDimagesname(savedFileName);
	    	animal.setDtime(date);
	    	animal.setDlocation(filepath);
			animal.setDname(listString);
			animal.setDnum(clss.size());
			animal.setDfinder(dfinder);
	    	animalDao.insert(animal);
    	}
    }

	@Override
	public void connectionLost(Throwable cause) {
		 System.out.println("Lost Connection." + cause.getCause());	
	}

	@Override
	public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {
		System.out.println("Message with " + iMqttDeliveryToken + " delivered.");
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
