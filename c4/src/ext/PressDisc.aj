package ext;

import java.awt.Color;
import java.awt.Graphics;
import c4.base.BoardPanel;

public privileged aspect PressDisc {
		//private static final boolean DISABLED = true;
	   private int slot;
	   private Graphics g;
	   pointcut getGraphics(Graphics g) :
		   execution(* c4.base.BoardPanel.paint(Graphics)) && args(g);
	   void around(Graphics g): getGraphics(g){
		   this.g =  g;
	   }
	   
	   private Color dropColor;
	   pointcut getPlayerColor(Color color) :
		   execution(* c4.base.BoardPanel.setDropColor(Color)) && args(color);
	   void around(Color color): getPlayerColor(color){
		   this.dropColor =  color;
	   }	
	   
	   BoardPanel panel;
	   pointcut getBoardPanel() :
		   initialization(* c4.base.BoardPanel.BoardPanel());
	   BoardPanel around(): getBoardPanel(){
		   this.panel =  proceed();
		   return this.panel;
	   }
	   
	   
	   pointcut discPressed(int slot) :
	        execution (* c4.base.BoardPanel.ClickListener.slotClicked(int)) && args(slot);
	   void around(int slot): discPressed(slot){
		   System.out.println("disk pressed");
		   c4.base.BoardPanel.drawChecker(g, dropColor, slot, -1, 1);
		   proceed(slot);
	   }


}
