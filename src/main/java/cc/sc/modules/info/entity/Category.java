/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import cc.sc.common.persistence.DataEntity;

/**
 * 分类Entity
 *
 * @author 许军杰
 * @version 2018-01-08
 */
public class Category extends DataEntity<Category> {

    private static final long serialVersionUID = 1L;
    private Category parent;        // parent_id
    private String name;        // 名称
    private String icon;        // 图标
    private Integer sort;        // 排序

    public Category() {
        super();
    }

    public Category(Integer id) {
        super(id);
    }

    @JsonBackReference
    public Category getParent() {
        return parent;
    }

    public void setParent(Category parent) {
        this.parent = parent;
    }

    @Length(min = 0, max = 32, message = "名称长度必须介于 0 和 32 之间")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Length(min = 0, max = 255, message = "图标长度必须介于 0 和 255 之间")
    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

}