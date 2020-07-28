package com.mycompany.project.service;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
    	LOGGER.info("Message arrived : " +topic);
    	ObjectMapper mapper = new ObjectMapper();
    	String json = new String(mqttMessage.getPayload());
    	Map<String, Object> map = new HashMap<String, Object>();
    	map = mapper.readValue(json, new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>(){});
    	//System.out.println(map);
    	
    	String savedFileName = (String) map.get("Cam");
    	String date= (String) map.get("time");
    	ArrayList<String> clss= (ArrayList<String>) map.get("Class");
    	LOGGER.info(String.valueOf(clss.size()));
    	savedFileName=savedFileName.substring(0, 10);
    	String listString= "";
    	if (clss.size()!= 0) {	
    	for (String s : clss)
    	{
    	    listString += s;
    	}
    	}
    	Animal animal= new Animal();
    	animal.setDimagesname(savedFileName);
    	animal.setDtimeconv(date);
		animal.setDname(listString);
    	animalDao.insert(animal);
    }

	@Override
	public void connectionLost(Throwable cause) {
		 System.out.println("Lost Connection." + cause.getCause());	
	}

	@Override
	public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {
		System.out.println("Message with " + iMqttDeliveryToken + " delivered.");
	}
	

}
