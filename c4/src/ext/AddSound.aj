package ext;

import java.awt.List;
import java.io.IOException;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

import c4.model.*;
import c4.base.*;

public privileged aspect AddSound {
	/** Directory where audio files are stored. */
	   private static final String SOUND_DIR = "/sound/";

	   pointcut dropSound() :
	        execution (* c4.model.Board.dropInSlot(int, Player));
	   
	   int around(): dropSound(){
		   Object[] arg = thisJoinPoint.getArgs();
		   Player player = (Player) arg[1];
		   boolean end = false;
		   if(end)
			   end = false;
		   else
			   playAudio(player.name + ".wav");
		   
		   return proceed();
	   }
	

	   /** Play the given audio file. Inefficient because a file will be 
	    * (re)loaded each time it is played. */

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

}