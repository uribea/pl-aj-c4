package ext;
import java.awt.Color;
import c4.base.*;

public privileged aspect AddOpponent extends SecondInstance{

   /** Two players of the game. */
	private Boolean blue = false;
	
   /** Change the turn after a player’s move. */
   private void C4Dialog.changeTurn(ColorPlayer opponent) {
       player = opponent;
       showMessage(player.name() + "'s turn.");
       repaint();
   }
   
   pointcut turn(): execution(void makeMove(int));
   
   after(): turn() {
	   if (blue) {
		   virtual.changeTurn(players[0]);
		   System.out.println("TURN BLUE...");
		   panel.setDropColor(virtual.player.color());
		   blue = false;
	   } else {
		   virtual.changeTurn(players[1]);
		   System.out.println("TURN RED...");
		   panel.setDropColor(virtual.player.color());
		   blue = true;
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
	   System.out.print("RESET..");
   }
}
