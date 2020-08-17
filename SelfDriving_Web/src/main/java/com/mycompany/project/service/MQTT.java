package com.mycompany.project.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.project.dao.AnimalDao;
import com.mycompany.project.model.Animal;
import com.mysql.fabric.xmlrpc.base.Array;

@Service
public class MQTT extends Thread implements MqttCallback {
	private static String Broker;
	private static String Client_ID;
	private static String UserName;
	private static String Passwd;
	private static MqttAsyncClient Client;
	private static MqttMessage message;
	private static MemoryPersistence persistence;
	private static MqttConnectOptions connOpts;
	private static Long[] datearray;
	private static String topic;
	private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(MQTT.class);
	private static final String AClassAnimal[] = { "멧돼지", "곰" };
	private static final String BClassAnimal[] = { "너구리", "노루" };
	private static final String CClassAnimal[] = { "고라니", "토끼" };
	@Autowired
	private AnimalDao animalDao;

	public void chogihwa(String broker, String client_id, String username, String passwd) {
		LOGGER.info("초기화");
		this.Broker = broker;
		this.Client_ID = client_id;
		this.UserName = username;
		this.Passwd = passwd;
		datearray = new Long[7];
		Arrays.fill(datearray, System.currentTimeMillis());
	}

	@Override
	public void run() {
		while (true) {
			long datenow = System.currentTimeMillis();

			InetAddress local = null;
			try {
				local = InetAddress.getLocalHost();
			} catch (UnknownHostException e1) {
				e1.printStackTrace();
			}
			String ip = local.getHostAddress();

			if (datenow - datearray[0] > 1000) {
				publish(ip, 0, "/res/1jet");
			}
			if (datenow - datearray[1] > 1000) {
				publish(ip, 0, "/res/2jet");
			}
			if (datenow - datearray[2] > 1000) {
				publish(ip, 0, "/res/3jet");
			}
			if (datenow - datearray[3] > 1000) {
				publish(ip, 0, "/res/1cctv");
			}
			if (datenow - datearray[4] > 1000) {
				publish(ip, 0, "/res/2cctv");
			}
			if (datenow - datearray[5] > 1000) {
				publish(ip, 0, "/res/3cctv");
			}
			if (datenow - datearray[6] > 1000) {
				publish(ip, 0, "/res/4cctv");
			}

			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			super.run();
		}

	}

	public void init(String topic) {
		this.topic = topic;
		this.persistence = new MemoryPersistence();
		try {
			Client = new MqttAsyncClient(this.Broker, this.Client_ID, this.persistence);
			Client.setCallback(this);

			connOpts = new MqttConnectOptions();
			// if(Client_ID!=null && Passwd != null){
			connOpts.setUserName(this.UserName);
			connOpts.setPassword(this.Passwd.toCharArray());
			// }
			connOpts.setCleanSession(true);
			System.out.println("Connecting to broker: " + this.Broker);

			Client.connect(connOpts);

			System.out.println("Connected");

			message = new MqttMessage();
		} catch (MqttException me) {
			System.out.println("reason " + me.getReasonCode());
			System.out.println("msg " + me.getMessage());
			System.out.println("loc " + me.getLocalizedMessage());
			System.out.println("cause " + me.getCause());
			System.out.println("excep " + me);
			me.printStackTrace();
		}

		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void disconnect() {
		try {
			Client.disconnect();
			Client.close();
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void publish(String msg, int qos, String restopic) {
		// LOGGER.info("답장을보내죠.");
		message.setQos(qos);
		message.setPayload(msg.getBytes());

		try {
			Client.publish(restopic, message);
		} catch (MqttPersistenceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void subscribe(int qos) {
		try {
			Client.subscribe("/req/1jetracer", 0);
			Client.subscribe("/req/2jetracer", 0);
			Client.subscribe("/req/3jetracer", 0);
			Client.subscribe("/req/1cctv", 0);
			Client.subscribe("/req/2cctv", 0);
			Client.subscribe("/req/3cctv", 0);
			Client.subscribe("/req/4cctv", 0);
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getTopic() {
		return topic;
	}

	@Override
	public void messageArrived(String topic, MqttMessage mqttMessage) throws Exception {
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
		String ip = local.getHostAddress();

		// LOGGER.info("Message arrived : " +topic);
		if (topic.equals("/req/1jet")) {
			datearray[0] = System.currentTimeMillis();
			publish(ip, 0, "/res1jet");
		}
		if (topic.equals("/req/2jet")) {
			datearray[1] = System.currentTimeMillis();
			publish(ip, 0, "/res2jet");
		}
		if (topic.equals("/req/3jet")) {
			datearray[2] = System.currentTimeMillis();
			publish(ip, 0, "/res/3jet");
		}
		if (topic.equals("/req/1cctv")) {
			datearray[3] = System.currentTimeMillis();
			publish(ip, 0, "/res/1cctv");
		}
		if (topic.equals("/req/2cctv")) {
			datearray[4] = System.currentTimeMillis();
			publish(ip, 0, "/res/2cctv");
		}
		if (topic.equals("/req/3cctv")) {
			datearray[5] = System.currentTimeMillis();
			publish(ip, 0, "/res/3cctv");
		}
		if (topic.equals("/req/4cctv")) {
			datearray[6] = System.currentTimeMillis();
			publish(ip, 0, "/res/4cctv");
		}
		ObjectMapper mapper = new ObjectMapper();
		String json = new String(mqttMessage.getPayload());
		Map<String, Object> map = new HashMap<String, Object>();
		map = mapper.readValue(json, new TypeReference<Map<String, Object>>() {
		});
		// System.out.println(map);

		// 찾은 객체 이름를 저장온다 경로에 넣으려면 /는 없어져야겠지
		String dfinder = topic;
		dfinder = dfinder.replace("/", "");
		dfinder = dfinder.replace("req", "");

		// 비디오 BASE64형식을 가져온다
		String video = (String) map.get("Cam");

		// 저장한 시각을 가져온다
		Date date = new Date();
		String StringDate = new SimpleDateFormat("YYYY-MM-dd HH-mm-ss-S").format(date);
		String saveDir = "C:/MyWorkspace/final_project/savedImages/";
		String savedFileName = "savedAt_" + dfinder + StringDate + ".jpg";
		String filepath = saveDir + savedFileName;
		String DLevel = "D";
		// 탐지된 객체 배열을 가져온다.
		ArrayList<String> clss = (ArrayList<String>) map.get("Class");
		String listString = "";
		// 배열의 개수가 0이면 저장하지 않는다.
		// 배열이 멧돼지나 고라니 등 포함하지 않으면 저장하지 않아도 될 지도 모를 수 도.
		if (clss.size() != 0) {
			if (Arrays.asList(AClassAnimal).containsAll(clss)) {
				DLevel = "A";
			}
			if (Arrays.asList(BClassAnimal).containsAll(clss)) {
				DLevel = "B";
			}
			if (Arrays.asList(CClassAnimal).containsAll(clss)) {
				DLevel = "C";
			}
			// 사진을 저장하자
			decoder(video, filepath);

			for (String s : clss) {
				// 객체 배열을 뽑아오기.
				listString += "," + s;

			}
			listString = listString.substring(1);
			// 객체를 생성하고 set하고 Dao로 DB에 넘겨서 저장한다.
			Animal animal = new Animal();
			animal.setDimagesname(savedFileName);
			animal.setDtime(date);
			animal.setDlevel(DLevel);
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
		// System.out.println("Message with " + iMqttDeliveryToken + " delivered.");
	}

	public static boolean decoder(String data, String target) {
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
