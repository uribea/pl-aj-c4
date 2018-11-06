package ext;

import java.awt.List;
import c4.base.*;
import c4.model.*;

public privileged aspect AddSound {
	   private List<Player> players;

	    public int dropInSlot(int slot, Player player) {
	        for (int y = HEIGHT - 1; y >= 0; y--) {
	            if (places[slot][y] == null) {
	                places[slot][y] = player;
	                if (changeListener != null) {
	                    changeListener.checkerDropped(slot, y, player);
	                }
	                return y;
	            }
	        }
	        return -1;
	    }
	    
	   pointcut discDropped() : 
	        execution (* c4.base.BoardPanel.dropInSlot(int, ColorPlayer));
	   
	   after() : discDropped() { 
		   Object[] arg = thisJoinPoint.getArgs();
		   player 
		   if(((Object) arg[1]).name() == "Blue")
		   proceed();
	   }
	   
}
