/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.dao;

import cc.sc.common.persistence.CrudDao;
import cc.sc.common.persistence.annotation.MyBatisDao;
import cc.sc.modules.info.entity.MsgLog;

/**
 * 短信发送日志DAO接口
 * @author 许军杰
 * @version 2018-01-24
 */
@MyBatisDao
public interface MsgLogDao extends CrudDao<MsgLog> {
	
}