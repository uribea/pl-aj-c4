/**

 *Contains the implementation for a winning game, displays the winner and if there is a draw  

 * @author  Perla De la O ,Alan Uribe, Germain Vargas

 *

 */package ext;

import c4.model.Player;
import c4.model.Board;

import java.awt.event.ActionEvent;

public privileged aspect EndGame extends SecondInstance {
	
	
	 pointcut discDropped(): call(int dropInSlot(int, Player));
	 int around(): discDropped(){
		 if(!virtual.board.isWonBy(virtual.player))
			 return proceed();
		 return -1;
	 }
	 after(): discDropped(){
		int actualCurr=(currPlayer+1)%2;
		boolean isDraw=board.isFull();
		boolean isWonBy=board.isWonBy(virtual.player);
		if(isWonBy)
		{
			virtual.showMessage(virtual.player.name() + " won!:) ");
			
		}
		if(isDraw)
		{
			virtual.showMessage(" Draw :(");

		}
	}
	
	pointcut newGame(): execution(void newButtonClicked(ActionEvent));
	void around(): newGame(){
		if(virtual.board.isWonBy(virtual.player))
		{
			currPlayer=0;
			virtual.startNewGame();
		}
		else
		{
			proceed();
		}	
	}
	
}
        

	
  


