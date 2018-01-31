/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;

import cc.sc.common.persistence.DataEntity;

/**
 * 代理人Entity
 *
 * @author 许军杰
 * @version 2018-01-10
 */
public class AgentPerson extends DataEntity<AgentPerson> {

    private static final long serialVersionUID = 1L;
    private String name;        // 姓名
    private String idCard;        // 身份证号
    private String cellphone;        // 手机号
    private String alipayAccount;        // 支付宝账号
    private String weixinAccount;        // 微信账号
    private String idCardImage;        // 身份证图片
    private Integer state;        // 状态

    public AgentPerson() {
        super();
    }

    public AgentPerson(Integer id) {
        super(id);
    }

    @Length(min = 0, max = 255, message = "姓名长度必须介于 0 和 255 之间")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Length(min = 0, max = 255, message = "身份证号长度必须介于 0 和 255 之间")
    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    @Length(min = 0, max = 255, message = "手机号长度必须介于 0 和 255 之间")
    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    @Length(min = 0, max = 255, message = "支付宝账号长度必须介于 0 和 255 之间")
    public String getAlipayAccount() {
        return alipayAccount;
    }

    public void setAlipayAccount(String alipayAccount) {
        this.alipayAccount = alipayAccount;
    }

    @Length(min = 0, max = 255, message = "微信账号长度必须介于 0 和 255 之间")
    public String getWeixinAccount() {
        return weixinAccount;
    }

    public void setWeixinAccount(String weixinAccount) {
        this.weixinAccount = weixinAccount;
    }

    @Length(min = 0, max = 255, message = "身份证图片长度必须介于 0 和 255 之间")
    public String getIdCardImage() {
        return idCardImage;
    }

    public void setIdCardImage(String idCardImage) {
        this.idCardImage = idCardImage;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

}