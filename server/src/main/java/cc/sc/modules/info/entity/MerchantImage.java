/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;

import cc.sc.common.persistence.DataEntity;

/**
 * 商户图片Entity
 * @author 许军杰
 * @version 2018-01-10
 */
public class MerchantImage extends DataEntity<MerchantImage> {
	
	private static final long serialVersionUID = 1L;
	private String picUrl;		// 图片地址
	private Integer merchantId;		// 商户id
	private Integer picType;		// 图片类型
	
	public MerchantImage() {
		super();
	}

	public MerchantImage(Integer id){
		super(id);
	}

	@Length(min=0, max=255, message="图片地址长度必须介于 0 和 255 之间")
	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
	public Integer getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
	
	public Integer getPicType() {
		return picType;
	}

	public void setPicType(Integer picType) {
		this.picType = picType;
	}
	
}