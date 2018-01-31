/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import cc.sc.common.persistence.DataEntity;

/**
 * 订单Entity
 * @author 许军杰
 * @version 2018-01-29
 */
public class TradeOrder extends DataEntity<TradeOrder> {
	
	private static final long serialVersionUID = 1L;
	private String tradeNo;		// 交易订单号
	private Integer merchantId;		// 商户id
	private Double money;		// 交易金额
	private Integer state;		// 状态（0 等待支付 -1支付超时 1 支付成功）
	private String platforms;		// 支付平台
	private String payAccount;		// 支付账号
	private Date payDate;		// 支付时间
	
	public TradeOrder() {
		super();
	}

	public TradeOrder(Integer id){
		super(id);
	}

	@Length(min=0, max=64, message="交易订单号长度必须介于 0 和 64 之间")
	public String getTradeNo() {
		return tradeNo;
	}

	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}
	
	public Integer getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
	
	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}
	
	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	
	@Length(min=0, max=255, message="支付平台长度必须介于 0 和 255 之间")
	public String getPlatforms() {
		return platforms;
	}

	public void setPlatforms(String platforms) {
		this.platforms = platforms;
	}
	
	@Length(min=0, max=255, message="支付账号长度必须介于 0 和 255 之间")
	public String getPayAccount() {
		return payAccount;
	}

	public void setPayAccount(String payAccount) {
		this.payAccount = payAccount;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	
}