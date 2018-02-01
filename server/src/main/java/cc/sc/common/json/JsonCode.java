package cc.sc.common.json;

import java.util.HashMap;
import java.util.Map;

/**
 * @description: Json公共码表  
 * @author: liun   
 * @date: 2017年1月6日 上午11:27:07 
 * @version: V1.0
 */
public class JsonCode { 
	
	/**
	 * OK
	 */
	public static final int SUCCESS = 200;
	
	
	/**
	 * 400
	 */
	public static final int BAD_REQUEST = 400;
	
	/**
	 * 401
	 */
	public static final int NOT_USER_EXIST = 401;
	
	/**
	 * 402
	 */
	public static final int USER_EXIST = 402;
	
	/**
	 * 403
	 */
	public static final int CAPTCHA_ERROR = 403;
	
	/**
	 * 404
	 */
	public static final int NOT_FOUND = 404;
	
	/**
	 * 405
	 */
	public static final int PASSWORD_ERROR = 405;
	
	/**
	 * 406
	 */
	public static final int PASSWORD_DIFFERENCE = 406;
	
	/**
	 * 407
	 */
	public static final int MOBILE_PASSWORD_ERROR = 407;
	
	/**
	 * 415
	 */
	public static final int BAD_PARAMETER = 415;
	
	/**
	 * 416
	 */
	public static final int NOT_PERMISSION = 416;
	
	/**
	 * 500
	 */
	public static final int SERVER_ERROR = 500;
	
	/**
	 * 501
	 */
	public static final int SESSION_INVALID = 501;
	
	/**
	 * 502
	 */
	public static final int RE_LOGIN = 502;
	
	/**
	 * 503
	 */
	public static final int DATA_IS_EMPTY = 503;
	
	/**
	 * 结果集map
	 */
	private static Map<Integer, String> msgMap = new HashMap<Integer, String>();
	
	/**
	 * @return map
	 */
	public static Map<Integer, String> getMsgMap() {
		msgMap.put(JsonCode.SUCCESS, "OK");
		msgMap.put(JsonCode.BAD_REQUEST, "操作失败");
		msgMap.put(JsonCode.USER_EXIST, "用户已存在");
		msgMap.put(JsonCode.NOT_USER_EXIST, "用户不存在");
		msgMap.put(JsonCode.CAPTCHA_ERROR, "验证码不正确");
		msgMap.put(JsonCode.NOT_FOUND, "找不到资源");
		msgMap.put(JsonCode.PASSWORD_ERROR, "密码错误");
		msgMap.put(JsonCode.PASSWORD_DIFFERENCE, "两次密码输入不一致");
		msgMap.put(JsonCode.MOBILE_PASSWORD_ERROR, "用户名或密码错误");
		msgMap.put(JsonCode.BAD_PARAMETER, "参数丢失");
		msgMap.put(JsonCode.NOT_PERMISSION, "没有此权限");
		msgMap.put(JsonCode.SERVER_ERROR, "系统错误");
		msgMap.put(JsonCode.SESSION_INVALID, "SESSION失效");
		msgMap.put(JsonCode.RE_LOGIN, "重新登录");
		msgMap.put(JsonCode.DATA_IS_EMPTY, "找不到数据");
		return msgMap;
	}
	
}
