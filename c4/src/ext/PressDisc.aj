package ext;

import java.awt.Color;
import java.awt.Graphics;
import c4.base.BoardPanel;
import c4.model.Board;
import java.awt.event.*;



public privileged aspect PressDisc {
		//private static final boolean DISABLED = true;
	   private Graphics g;
	   private BoardPanel panel;
	   private Color dropColor;
	   
	   
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

	   pointcut discPressed(int slot) :
	     call (boolean c4.model.Board.isSlotOpen(int))
	     && args(slot) 
	     && within(c4.base.BoardPanel) 
	     //&& !withincode(* c4.base.BoardPanel.drawDroppableCheckers(*))
	     ;//&& withincode(* c4.base.BoardPanel.ClickListener.MouseClicked(*));
	   
	   //boolean around(int slot) /*returning(int slot)*/ : 
		/*   discPressed(slot){
		   boolean ava = proceed(slot);
			   if (ava) {
			   panel.drawChecker(g, dropColor, slot, -1, 3);
			   panel.repaint();
			   System.out.println("after repaint");
			   }
		   return ava;
	   }*/

	   pointcut hithere() :
		     execution (int c4.base.BoardPanel.locateSlot(int,int))
		      
		     && within(c4.base.BoardPanel) 
		     
		     //&& withincode(* c4.base.BoardPanel.MouseAdapter(*))
		     ;//&& withincode(* c4.base.BoardPanel.ClickListener.MouseClicked(*));
		   
		   after() returning(int slot) /*returning(int slot)*/ : 
			   hithere(){
		   
		   
			   if (slot>=0) {
				   panel.drawChecker(g, dropColor, slot, -1, 3);
				   panel.repaint();
				   System.out.println("after repaint");
			   }
		   }
		 
		   pointcut hthere(MouseEvent e) :
			     execution (int c4.base.BoardPanel.mouseClicked(MouseEvent))
			     && args(e)
			     && within(c4.base.BoardPanel) 
			     
			     //&& withincode(* c4.base.BoardPanel.MouseAdapter(*))
			     ;//&& withincode(* c4.base.BoardPanel.ClickListener.MouseClicked(*));
			   
			   void around(MouseEvent e) /*returning(int slot)*/ : 
				   hthere(e){
			   
			   
				      //panel.drawChecker(g, dropColor, slot, -1, 3);
					   panel.repaint();
					   System.out.println("after repaint");
				   
			   }
		   
		   
	   pointcut getBoardPanel() :
		   call(BoardPanel.new(*));
	   after() returning(BoardPanel panel) : getBoardPanel(){
		   this.panel = panel;
	   }

}
