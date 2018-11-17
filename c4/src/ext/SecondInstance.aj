package ext;
import java.awt.Color;
import java.awt.Graphics;
import java.util.LinkedList;

import c4.base.*;
import c4.model.Board;


public privileged abstract aspect SecondInstance {
	protected C4Dialog virtual;
	protected ColorPlayer player2 = new ColorPlayer("Red", Color.RED);;
	protected Boolean blue = false;
	protected ColorPlayer[] players = new ColorPlayer[2];
	protected Graphics g;
	protected BoardPanel panel;
	protected Color dropColor;
	protected int currPlayer = 0;
	protected Board board;

	   pointcut getVirtual(): call(C4Dialog.new());
	   after() returning(C4Dialog virtual): getVirtual() {
		   this.virtual = virtual;
		   this.board = virtual.board;
		   this.players[0] = this.virtual.player;

	   }
	   /*pointcut getGame(): call(C4Dialog.new());
	    after() returning(C4Dialog game): getGame(){
	        this.game = game;
	        this.board = game.board;
	        players =  new LinkedList<>();
	        players.add(this.game.player);
	        players.add(new ColorPlayer("Red", Color.RED));
	    }*/
	   pointcut getGraphics(Graphics g) :
		   execution(* c4.base.BoardPanel.paint(Graphics)) && args(g);
	   void around(Graphics g): getGraphics(g){
		   this.g =  g;
		   proceed(g);
	   }
	   
	   pointcut getPlayerColor(Color color) :
		   execution(* c4.base.BoardPanel.setDropColor(Color)) && args(color);
	   void around(Color color): getPlayerColor(color){
		   this.dropColor =  color;
	   }	
	   pointcut getBoardPanel() :
		   call(BoardPanel.new(*));
	   after() returning(BoardPanel panel) : getBoardPanel(){
		   this.panel = panel;
	   }


}