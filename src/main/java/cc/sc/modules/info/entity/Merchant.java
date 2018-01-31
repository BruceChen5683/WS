/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import cc.sc.common.persistence.DataEntity;

/**
 * 商户Entity
 *
 * @author 许军杰
 * @version 2018-01-10
 */
public class Merchant extends DataEntity<Merchant> {

    private static final long serialVersionUID = 1L;
    private String name;        // 名称
    private String region;        // 地区
    private Integer categoryId;        // 分类id
    private String cellphone;        // 手机号
    private String logoUrl;        // logo地址
    private String referee;        // 推荐人
    private String refereeCellphone;        // 推荐人电话
    private Date attendDate;        // 入驻时间
    private String mainProducts;        // 主营业务
    private String adWord;        // 广告词
    private String type;        // 类型
    private Integer state;        // 状态
    private String phone;        // 固定电话
    private Integer viewNum;        // 浏览次数
    private String lng;        // 经度
    private String lat;        // 纬度
    private Integer isHot;//是否热门
    private Integer sort;//排序
    private String address;//地址
    private String imageIdStr;//图片的ids
    /**
     * 是否认证
     */
    private Integer isAuth;
    private List<String> images;
    /**
     * 搜索关键词
     */
    private String queryText;

    public Merchant() {
        super();
    }

    public Merchant(Integer id) {
        super(id);
    }

    @Length(min = 0, max = 255, message = "名称长度必须介于 0 和 255 之间")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Length(min = 0, max = 255, message = "地区长度必须介于 0 和 255 之间")
    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    @Length(min = 0, max = 255, message = "手机号长度必须介于 0 和 255 之间")
    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    @Length(min = 0, max = 255, message = "logo地址长度必须介于 0 和 255 之间")
    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    @Length(min = 0, max = 255, message = "推荐人长度必须介于 0 和 255 之间")
    public String getReferee() {
        return referee;
    }

    public void setReferee(String referee) {
        this.referee = referee;
    }

    @Length(min = 0, max = 255, message = "推荐人电话长度必须介于 0 和 255 之间")
    public String getRefereeCellphone() {
        return refereeCellphone;
    }

    public void setRefereeCellphone(String refereeCellphone) {
        this.refereeCellphone = refereeCellphone;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(Date attendDate) {
        this.attendDate = attendDate;
    }

    @Length(min = 0, max = 512, message = "主营业务长度必须介于 0 和 512 之间")
    public String getMainProducts() {
        return mainProducts;
    }

    public void setMainProducts(String mainProducts) {
        this.mainProducts = mainProducts;
    }

    @Length(min = 0, max = 255, message = "广告词长度必须介于 0 和 255 之间")
    public String getAdWord() {
        return adWord;
    }

    public void setAdWord(String adWord) {
        this.adWord = adWord;
    }

    @Length(min = 0, max = 255, message = "类型长度必须介于 0 和 255 之间")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Length(min = 0, max = 255, message = "固定电话长度必须介于 0 和 255 之间")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    @Length(min = 0, max = 255, message = "经度长度必须介于 0 和 255 之间")
    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    @Length(min = 0, max = 255, message = "纬度长度必须介于 0 和 255 之间")
    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public Integer getIsHot() {
        return isHot;
    }

    public void setIsHot(Integer isHot) {
        this.isHot = isHot;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImageIdStr() {
        return imageIdStr;
    }

    public void setImageIdStr(String imageIdStr) {
        this.imageIdStr = imageIdStr;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public String getQueryText() {
        return queryText;
    }

    public void setQueryText(String queryText) {
        this.queryText = queryText;
    }

    public Integer getIsAuth() {
        return isAuth;
    }

    public void setIsAuth(Integer isAuth) {
        this.isAuth = isAuth;
    }
}