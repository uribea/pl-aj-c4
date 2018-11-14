package ext;
import java.awt.Color;
import c4.base.*;

public privileged aspect AddOpponent {

   /** Two players of the game. */
	private ColorPlayer[] players = new ColorPlayer[2];
	private C4Dialog virtual;
	ColorPlayer player2 = new ColorPlayer("Red", Color.RED);;
	private Boolean blue = false;
	
   /** Change the turn after a player’s move. */
   private void C4Dialog.changeTurn(ColorPlayer opponent) {
       player = opponent;
       showMessage(player.name() + "'s turn.");
       repaint();
   }
   
   // make copy of the C4Dialog 
   pointcut getVirtual(): call(C4Dialog.new());
   after() returning(C4Dialog virtual): getVirtual() {
	   this.virtual = virtual;
	   this.players[0] = this.virtual.player;
   }
   
   pointcut turn(): execution(void makeMove(int));
   
   after(): turn() {
	   if (blue) {
		   virtual.changeTurn(players[0]);
		   System.out.println("TURN BLUE...");
		   blue = false;
	   } else {
		   virtual.changeTurn(players[1]);
		   System.out.println("TURN RED...");
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
