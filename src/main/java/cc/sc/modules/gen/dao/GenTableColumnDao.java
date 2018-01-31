/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.gen.dao;

import cc.sc.common.persistence.CrudDao;
import cc.sc.common.persistence.annotation.MyBatisDao;
import cc.sc.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * 
 * @author ThinkGem
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTableColumnDao extends CrudDao<GenTableColumn> {

	public void deleteByGenTableId(Integer genTableId);
}
