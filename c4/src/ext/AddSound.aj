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

public privileged aspect AddSound extends SecondInstance{
	/** Directory where audio files are stored. */
	   private static final String SOUND_DIR = "/sound/";

	   pointcut dropSound(int i,Player player) :
	        execution (* c4.model.Board.dropInSlot(int, Player))&&args(i,player);
	   
	   int around(int i,Player player): dropSound(i,player){
		   //boolean end = false;
		   int j =  proceed(i,player);
		   
		   playAudio(player.name + ".wav");
		   if(virtual.board.isWonBy(player)) {
			   playAudio("Applause.wav");
			   return -1;
		   }
		   return j;
		   
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