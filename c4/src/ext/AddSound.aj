package ext;

import java.awt.List;
import c4.base.*;
import c4.model.*;

public privileged aspect AddSound {
	/** Directory where audio files are stored. */
	   private static final String SOUND_DIR = "/sound/";

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