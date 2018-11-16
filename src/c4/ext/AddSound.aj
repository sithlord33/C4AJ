package c4.ext;

import java.net.URL;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;

import c4.model.Player;


public privileged aspect AddSound {
	
	private Clip blue, red;
	
	URL blueURL = getClass().getResource("/click.wav");
	URL redURL = getClass().getResource("/boing.wav");
	
	pointcut move(int slot, Player player):
		call(void C4Dialog.makeMove(int)) && args(slot) && target(player);
	
	void around():
		call(void C4Dialog.makeMove(int)) && args(slot) && target(player){
		try {
			AudioInputStream blueIS = AudioSystem.getAudioInputStream(blueURL);
			blue = AudioSystem.getClip();
			blue.open(blueIS);
			
			AudioInputStream redIS = AudioSystem.getAudioInputStream(redURL);
			red = AudioSystem.getClip();
			red.open(redIS);
		}
		catch(Exception e) {
			System.out.println("failed to get audio clips");
		}
		
		blue.start();
		blue.setMicrosecondPosition(0);
	}
	
	
	
	

}
