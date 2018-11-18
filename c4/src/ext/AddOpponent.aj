package ext;
import java.awt.Color;
import c4.base.*;
import c4.model.Player;

public privileged aspect AddOpponent extends SecondInstance {

   /** Two players of the game. */
	private Boolean blue = false;
	
   /** Change the turn after a player’s move. */
   private void C4Dialog.changeTurn(ColorPlayer opponent) {
	       player = opponent;
	       if(!board.isFull())
	    	   showMessage(player.name() + "'s turn.");
	       repaint();
       
   }
   
   pointcut turn(): execution(void makeMove(int));
   
   after(): turn() {
	   if(!virtual.board.isWonBy(virtual.player)) {
		   if (blue) {
			   virtual.changeTurn(players[0]);
			   panel.setDropColor(virtual.player.color());
			   blue = false;
		   } else {
			   virtual.changeTurn(players[1]);
			   panel.setDropColor(virtual.player.color());
			   blue = true;
		   }
	   }
   }
   
   pointcut add(): execution(void configureUI());
   
   before(): add() {
	  players[1] = player2;
   }
   
   pointcut reset(): execution(void startNewGame());
   after(): reset() {
	   
		   blue = false;
		   virtual.changeTurn(players[0]);	   
		   panel.setDropColor(virtual.player.color());

   }
}
