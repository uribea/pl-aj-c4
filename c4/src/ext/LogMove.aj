/**

 *Contains the implementation for adding a move to the game 

 * @author  Perla De la O ,Alan Uribe, Germain Vargas

 *

 */
package ext;

privileged aspect LogMove {
	static boolean enabled = false;
	pointcut LogMov() : 
		execution (* c4.base.C4Dialog.makeMove(int))&&if(enabled);
	
	void around() : LogMov() { 
		Object[] arg = thisJoinPoint.getArgs();
		System.out.println("placed slot at " + arg[0]);
		proceed();
	}
   
}
