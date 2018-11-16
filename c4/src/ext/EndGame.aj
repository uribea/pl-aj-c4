package c4.ext;

import c4.model.Player;
import c4.model.Board;

import java.awt.event.ActionEvent;

public privileged aspect EndGame {
	//boolean game won goes in supper
	//players list of players goes in super
	//C4Dialog game goes in supper
	//int curPlayer=0; goes in super
	//boolean game won goes in supper
	//Board board goes in supper
	//suppermust have 
	//pointcut getGame(): call(C4Dialog.new());
	//after() returning (C4Dialog game): getGame(){
	//update values from C4Dialog}
	//after 
	after(): discDropped(){
		//curPlayer int that stores the current player
		int actualCurr=(Curplayer+1)%2;
		boolean isDraw=board.isFull();
		boolean isWonBy=board.isWonBy(players.get(currPlayer));
		if(isWonBy)
		{
			//players is the list where the players are stored
			game.showMessage(players.get(curPlayer).name()+ " won!:) ");
			gameWon=true;
		}
		if(isDraw)
		{
			game.showMessage(" Draw :(");
		}
	}
	
	pointcut newGame(): execution(void newButtonClicked(ActionEvent));
	void around(): newGame(){
		if(gameWon)
		{
			gameWon=false;
			curPlayer=0;
			game.changeTurn(players.get(0));
			game.startNewGame();
		}
		else
		{
			proceed();
		}	
	}
	
}
        

	
  


