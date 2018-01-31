/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.dao;

import cc.sc.common.persistence.CrudDao;
import cc.sc.common.persistence.annotation.MyBatisDao;
import cc.sc.modules.info.entity.Cities;

/**
 * 城市DAO接口
 * @author 许军杰
 * @version 2018-01-11
 */
@MyBatisDao
public interface CitiesDao extends CrudDao<Cities> {
	
}