package ext;

import c4.model.Player;
import c4.model.Board;

import java.awt.event.ActionEvent;

public privileged aspect EndGame extends SecondInstance {

	boolean gameWon=false;
	

	 pointcut discDropped(): call(int dropInSlot(int, Player));
	after(): discDropped(){
		int actualCurr=(currPlayer+1)%2;
		boolean isDraw=board.isFull();
		boolean isWonBy=board.isWonBy(virtual.player);
		if(isWonBy)
		{
			virtual.showMessage(virtual.player.name() + " won!:) ");
			gameWon=true;
		}
		if(isDraw)
		{
			virtual.showMessage(" Draw :(");
		}
	}
	
	pointcut newGame(): execution(void newButtonClicked(ActionEvent));
	void around(): newGame(){
		if(gameWon)
		{
			gameWon=false;
			currPlayer=0;
			//virtual.changeTurn(players[0]);your code to change turn
			virtual.startNewGame();
			
		}
		else
		{
			proceed();
		}	
	}
	
}
        

	
  


