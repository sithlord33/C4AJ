import c4.model.Board;

import javax.sound.sampled.*;
import java.io.IOException;

import c4.base.C4Dialog;
import c4.model.*;

public aspect AddSound {

   private static final String SOUND_DIR = "/sound/";

   public static void playAudio(String filename) {
       try {
           AudioInputStream audioIn = AudioSystem.getAudioInputStream(
                   AddSound.class.getResource(SOUND_DIR + filename));
           Clip clip = AudioSystem.getClip();
           clip.open(audioIn);
           clip.start();
       } catch (UnsupportedAudioFileException
               | IOException | LineUnavailableException e) {
           e.printStackTrace();
       }
   }

   pointcut makeMove(int slot, Player p):
           execution(int Board.dropInSlot(int , Player)) && args(slot, p);

   after(int slot, Player p): makeMove(slot, p) {
       if(p.name().equals("Blue"))
           playAudio("click.wav");
       else
           playAudio("boing.wav");
   }
   
   pointcut newGame(C4Dialog d):
	   call(void C4Dialog.startNewGame()) && this(d);
   
   after(C4Dialog d): newGame(d){
	   playAudio("applause.wav");
   }
}
