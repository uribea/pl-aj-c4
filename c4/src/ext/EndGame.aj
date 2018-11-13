package c4.ext;

import c4.model.Player;

public privileged aspect EndGame {
	pointcut Winner() :
        execution (* c4.model.Board.isWonBy(Player));
  

}
