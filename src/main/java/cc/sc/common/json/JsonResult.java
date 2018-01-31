package cc.sc.common.json;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import cc.sc.common.persistence.Page;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @description: Json结果集
 * @author: liun
 * @date: 2016年12月28日 上午11:52:55
 * @version: V1.0
 */
@Repository
@Scope(value = "request")
@JsonIgnoreProperties(value = { "advisors", "targetSource", "targetObject", "targetClass", "frozen", "exposeProxy", "preFiltered", "proxyTargetClass", "proxiedInterfaces" })
public class JsonResult implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(JsonResult.class);
	/**
	 * 结果消息
	 */
	String resultMsg = "OK";
	/**
	 * 结果Code
	 */
	Integer resultCode = JsonCode.SUCCESS;
	/**
	 * 长度
	 */
	// long len;
	/**
	 * 结果信息
	 */
	Object resultInfo;
	/**
	 * csrf非法访问token
	 */
	String token;
	/**
	 * 分页对象
	 */
	Page page;

	/**
	 * 取得结果消息
	 * @return 结果消息
	 */
	public String getResultMsg() {
		return resultMsg;
	}
	/**
	 * 设置结果消息
	 * @param resultMsg 结果消息
	 */
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	/**
	 * 取得token消息
	 * @return token消息
	 */
	public String getToken() {
		return token;
	}
	/**
	 * 设置token消息
	 * @param token token消息
	 */
	public void setToken(String token) {
		this.token = token;
	}
	/**
	 * 取得结果Code
	 * @return 结果Code
	 */
	public Integer getResultCode() {
		return resultCode;
	}
	/**
	 * Description: 设置结果Code
	 * @param resultCode JSON CODE
	 * @since 2016年12月28日 上午11:15:21
	 */
	public void setResultCode(Integer resultCode) {
		this.resultCode = resultCode;
		this.setResultMsg(JsonCode.getMsgMap().get(resultCode));
	}
	/**
	 * 取得结果Code
	 * @return 结果Code
	 */
	public Object getResultInfo() {
		return resultInfo;
	}
	/**
	 * 设置结果信息
	 * @param resultInfo 结果信息
	 */
	public void setResultInfo(Object resultInfo) {
		this.resultInfo = resultInfo;
	}
	/**
	 * Description: 构造函数
	 * @param jsonResult jsonResult对象
	 * @since 2016年12月28日 上午11:49:56
	 */
	public JsonResult(JsonResult r) {
		resultMsg = r.getResultMsg();
		resultCode = r.getResultCode();
		resultInfo = r.getResultInfo();
	}
	/**
	 * Description: 构造函数
	 * @since 2016年12月28日 上午11:55:15
	 */
	public JsonResult() {
	}
	/**
	 * Description: 构造函数
	 * @param code 消息code
	 * @since 2016年12月28日 下午2:02:29
	 */
	public JsonResult(Integer code) {
		this.resultCode = code;
		if (code != null && code > 0) {
			Map<Integer, String> msgMap = JsonCode.getMsgMap();
			String msg = msgMap.get(code);
			if (!StringUtils.isEmpty(msg))
				this.resultMsg = msg;
		}
	}
	/**
	 * Description: 构造函数
	 * @param code 消息code
	 * @param msg 消息内容
	 * @since 2016年12月28日 下午2:02:29
	 */
	public JsonResult(Integer code, String msg) {
		this.resultCode = code;
		this.resultMsg = msg;
	}
	/**
	 * Description: 构造函数
	 * @param data 数据
	 * @since 2016年12月28日 下午2:02:29
	 */
	public JsonResult(Object data) {
		this.resultInfo = data instanceof ArrayList ? JsonUtils.encode(data) : data;
	}
	/**
	 * Description: 构造函数
	 * @param code 消息code
	 * @param msg 消息内容
	 * @param data 数据
	 * @since 2016年12月28日 下午2:02:29
	 */
	public JsonResult(Integer code, String msg, Object data) {
		this.resultCode = code;
		this.resultMsg = msg;
		this.resultInfo = data instanceof ArrayList ? JsonUtils.encode(data) : data;
	}
	/**
	 * Description: 构造函数
	 * @param code 消息code
	 * @param msg 消息内容
	 * @param data 数据
	 * @param len 长度
	 * @since 2016年12月28日 下午2:02:29
	 */
	public JsonResult(Integer code, String msg, Object data, long len) {
		this.resultCode = code;
		this.resultMsg = msg;
		this.resultInfo = data instanceof ArrayList ? JsonUtils.encode(data) : data;
		// this.len = len;
	}
	/**
	 * Description: 构造函数
	 * @param data 数据
	 * @param len 长度
	 * @since 2016年12月28日 下午2:02:29
	 */
	public JsonResult(Object data, long len) {
		this.resultInfo = data instanceof ArrayList ? JsonUtils.encode(data) : data;
		// this.len = len;
	}
	/**
	 * 设置数据
	 * @param data 数据
	 */
	public void setData(Object data) {
		this.resultInfo = data instanceof ArrayList ? JsonUtils.encode(data) : data;
	}
	/**
	 * 取得长度
	 * @return 长度
	 */
	// public long getLen() {
	// return len;
	// }
	//
	// /**
	// * 设置长度
	// * @param len 长度
	// */
	// public void setLen(long len) {
	// this.len = len;
	// }
	/**
	 * Description: 判断结果信息是否存在
	 * @return 是否存在的标志位
	 * @since 2016年12月28日 下午2:02:29
	 */
	// public boolean isExistsData() {
	// if (this.resultInfo != null) {
	// return true;
	// } else {
	// return false;
	// }
	// }
	/**
	 * Description: 将当前JsonResult对象转换成JSON字符串。
	 * @return 转换后的Json字符串
	 * @since 2016年6月28日 下午2:02:29
	 */
	public String objectToJsonStr() {
		return JsonUtils.encode(this);
	}
	/**
	 * Description: 将指定的Json字符串转换成JsonResult对象。
	 * @param s 指定的Json字符串
	 * @return 转换后的JsonResult对象
	 */
	public static JsonResult jsonStrToObject(String s) {
		return JsonUtils.decode(s, JsonResult.class);
	}
	/**
	 * Description: 判断是否成功。
	 * @return 是否成功的标志位
	 */
	// public boolean isSuccess() {
	// return JsonCode.SUCCESS == this.resultCode;
	// }
	/**
	 * 取得数据长度
	 * @return 数据长度
	 */
	// public long getDataLength() {
	// if (this.resultInfo != null) {
	// return this.len;
	// } else {
	// return 0;
	// }
	// }
	public static JsonResult getOkJson(Object data) {
		JsonResult jsonResult = new JsonResult();
		jsonResult.setResultInfo(data);
		jsonResult.setResultCode(JsonCode.SUCCESS);
		return jsonResult;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
}
