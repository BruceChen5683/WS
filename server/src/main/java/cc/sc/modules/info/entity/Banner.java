/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;

import cc.sc.common.persistence.DataEntity;

/**
 * banner广告图Entity
 * @author 许军杰
 * @version 2018-01-10
 */
public class Banner extends DataEntity<Banner> {
	
	private static final long serialVersionUID = 1L;
	private String bannerUrl;		// banner地址
	private String region;		// 区域
	private Integer redictType;		// 跳转类型
	private String redictUrl;		// 跳转url
	private Integer merchantId;		// 商户id
	
	public Banner() {
		super();
	}

	public Banner(Integer id){
		super(id);
	}

	@Length(min=0, max=255, message="banner地址长度必须介于 0 和 255 之间")
	public String getBannerUrl() {
		return bannerUrl;
	}

	public void setBannerUrl(String bannerUrl) {
		this.bannerUrl = bannerUrl;
	}
	
	@Length(min=0, max=255, message="区域长度必须介于 0 和 255 之间")
	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}
	
	public Integer getRedictType() {
		return redictType;
	}

	public void setRedictType(Integer redictType) {
		this.redictType = redictType;
	}
	
	@Length(min=0, max=255, message="跳转url长度必须介于 0 和 255 之间")
	public String getRedictUrl() {
		return redictUrl;
	}

	public void setRedictUrl(String redictUrl) {
		this.redictUrl = redictUrl;
	}
	
	public Integer getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
	
}