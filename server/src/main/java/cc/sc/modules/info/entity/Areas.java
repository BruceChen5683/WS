/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;

import cc.sc.common.persistence.DataEntity;

/**
 * 区域Entity
 *
 * @author 许军杰
 * @version 2018-01-11
 */
public class Areas extends DataEntity<Areas> {

    private static final long serialVersionUID = 1L;
    private String area;        // area
    private Integer cityid;        // cityid

    public Areas() {
        super();
    }

    public Areas(Integer id) {
        super(id);
    }

    @Length(min = 1, max = 50, message = "area长度必须介于 1 和 50 之间")
    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public Integer getCityid() {
        return cityid;
    }

    public void setCityid(Integer cityid) {
        this.cityid = cityid;
    }

}