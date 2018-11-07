package ext;

privileged aspect LogMove {
	
   pointcut LogMov() : 
        execution (* c4.base.C4Dialog.makeMove(int));
   
   void around() : LogMov() { 
	   Object[] arg = thisJoinPoint.getArgs();
	   System.out.println("placed slot at " + arg[0]);
	   proceed();
   }
   
}