package com.hxzy.telexam.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import java.util.Arrays;

@Aspect  //声明是一个切面类
@Component //声明被springIOC管理
public class TxAspect {
	
	public TxAspect(){
		/*System.out.println("通知...");*/
	}
	
	//前置通知
	@Before("execution(* com.hxzy.telexam.*.*(..)) ")
	public void mothedBefore(JoinPoint joinPoint){
		String classname=joinPoint.getTarget().getClass().getName();
		String mothedname=joinPoint.getSignature().getName();
		String args=Arrays.toString(joinPoint.getArgs());
		System.out.println("[前置通知],类名称是="+classname+",方法名称="+mothedname+",参数="+args);
	}
	
	//后置通知
	@After("execution(* com.hxzy.telexam.*.*(..)) ")
	public void mothedAfter(JoinPoint joinPoint){
		String classname=joinPoint.getTarget().getClass().getName();
		String mothedname=joinPoint.getSignature().getName();
		String args=Arrays.toString(joinPoint.getArgs());
		System.out.println("[后置通知],类名称是="+classname+",方法名称="+mothedname+",参数="+args);
	}
	
	//返回通知
	@AfterReturning(pointcut="execution(* com.hxzy.telexam.*.*(..)) ",returning="res")
	public void mothedAfterReturning(JoinPoint joinPoint,Object res){
		String classname=joinPoint.getTarget().getClass().getName();
		String mothedname=joinPoint.getSignature().getName();
		String args=Arrays.toString(joinPoint.getArgs());
		System.out.println("[返回通知],类名称是="+classname+",方法名称="+mothedname+",参数="+args+",返回结果="+res);
	}
	
	//异常通知[只有方法发生异常，才会执行]
	@AfterThrowing(pointcut="execution(* com.hxzy.telexam.*.*(..)) ",throwing="e")
	public void mothedAfterThrowing(JoinPoint joinPoint,Exception e){
		String classname=joinPoint.getTarget().getClass().getName();
		String mothedname=joinPoint.getSignature().getName();
		String args= Arrays.toString(joinPoint.getArgs());
		System.out.println("[异常通知],类名称是="+classname+",方法名称="+mothedname+",参数="+args+",异常信息="+e);
	}
	
	/**
	 * 环绕通知
	 * @param joinPoint
	 
	@Around("execution(* com.huaxin.*.service.impl.*.*(..))")
	public Object mothodAround(ProceedingJoinPoint joinPoint){
		Object result=null;
		String classname=joinPoint.getTarget().getClass().getName();
		String methodname=joinPoint.getSignature().getName();
		String praper=Arrays.toString(joinPoint.getArgs());
		System.out.println("[环绕通知] 类="+classname+",方法="+methodname+",参数="+praper);
		// 执行目标组件的方法
        try {
			result = joinPoint.proceed();
			System.out.println("[环绕通知] 执行结果="+result);
		} catch (Throwable e) {
			e.printStackTrace();
		}
        System.out.println("[环绕通知] 方法="+methodname+",参数="+praper+",已经执行完毕");
		return result;
	}
*/
}
