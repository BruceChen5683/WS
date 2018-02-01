/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;

import cc.sc.common.persistence.DataEntity;

/**
 * 短信发送日志Entity
 * @author 许军杰
 * @version 2018-01-24
 */
public class MsgLog extends DataEntity<MsgLog> {
	
	private static final long serialVersionUID = 1L;
	private String cellphone;		// 手机号
	private String code;		// 验证码值
	
	public MsgLog() {
		super();
	}

	public MsgLog(Integer id){
		super(id);
	}

	@Length(min=0, max=255, message="手机号长度必须介于 0 和 255 之间")
	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	
	@Length(min=0, max=255, message="验证码值长度必须介于 0 和 255 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
}