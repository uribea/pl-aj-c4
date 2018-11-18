/**

 *Contains the implementation for adding a disc for both player one and player 2

 * @author  Perla De la O ,Alan Uribe, Germain Vargas

 *

 */package ext;

import java.awt.Color;
import java.awt.Graphics;
import c4.base.BoardPanel;
import java.awt.event.*;

public privileged aspect PressDisc extends SecondInstance{
	   private Color bckColor = new Color(238,238,238);
	   private MouseAdapter mouseListener;
	   private int slotm = -1;
	   private int BoardPanel.slotM = -1;
	   private void BoardPanel.addMousePressed(MouseAdapter mouseAdapter){}
	  
	   pointcut discPressed( Graphics gs, BoardPanel pane) :
		   execution (void c4.base.BoardPanel.drawDroppableCheckers(Graphics))
		   && args(gs)
		   && this(pane)
		   && !withincode(void c4.base.BoardPanel.addMousePressed());
	    
	   after( Graphics gs, BoardPanel pane): discPressed(gs,pane){
		   if(pane.slotM>=0 && !virtual.board.isWonBy(virtual.player)) {
			   pane.drawChecker(this.g,this.bckColor, pane.slotM, -1, 2);

			   pane.drawChecker(this.g,this.virtual.player.color(), pane.slotM, -1, 7);
		   }
		   pane.slotM=-1;
	   }
	   
	   pointcut repaintAfterPressed()://BoardPanel pane) :
		   call ( int c4.base.BoardPanel.locateSlot(*))
		   &&within(c4.base.BoardPanel);
	   after( ): repaintAfterPressed(){
		   this.panel.repaint();
	   }

	   pointcut buttonPressed(BoardPanel pane):
		   execution(BoardPanel.new(..))&&this(pane);
		   
	   after(BoardPanel pane):buttonPressed(pane){
		 	   pane.addMouseListener(new MouseAdapter() {
		 		   @Override
		 		   public void mousePressed(MouseEvent e) {
		 			   pane.slotM = (Integer)pane.locateSlot(e.getX(), e.getY());
		 			   if (pane.slotM >= 0 && pane.board.isSlotOpen(pane.slotM))
		 				  //pane.slotM = pane.slotM;
		 				   pane.repaint();
		 		   }
		 		  @Override
		 		  public void mouseReleased(MouseEvent e) {
		 			  pane.slotM =-1;
		 			  pane.repaint();
		 		  }
		 	   });
	   }

}



