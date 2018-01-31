/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import org.hibernate.validator.constraints.Length;

import cc.sc.common.persistence.DataEntity;

/**
 * 城市Entity
 *
 * @author 许军杰
 * @version 2018-01-11
 */
public class Cities extends DataEntity<Cities> {

    private static final long serialVersionUID = 1L;
    private String city;        // city
    private Integer provinceid;        // provinceid
    private Integer isHot;        // 热门

    public Cities() {
        super();
    }

    public Cities(Integer id) {
        super(id);
    }

    @Length(min = 1, max = 50, message = "city长度必须介于 1 和 50 之间")
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Length(min = 1, max = 20, message = "provinceid长度必须介于 1 和 20 之间")
    public Integer getProvinceid() {
        return provinceid;
    }

    public void setProvinceid(Integer provinceid) {
        this.provinceid = provinceid;
    }

    public Integer getIsHot() {
        return isHot;
    }

    public void setIsHot(Integer isHot) {
        this.isHot = isHot;
    }
}