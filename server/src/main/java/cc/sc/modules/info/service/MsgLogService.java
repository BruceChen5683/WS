/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.MsgLog;
import cc.sc.modules.info.dao.MsgLogDao;

/**
 * 短信发送日志Service
 * @author 许军杰
 * @version 2018-01-24
 */
@Service
@Transactional(readOnly = true)
public class MsgLogService extends CrudService<MsgLogDao, MsgLog> {

	public MsgLog get(Integer id) {
		return super.get(id);
	}
	
	public List<MsgLog> findList(MsgLog msgLog) {
		return super.findList(msgLog);
	}
	
	public Page<MsgLog> findPage(Page<MsgLog> page, MsgLog msgLog) {
		return super.findPage(page, msgLog);
	}
	
	@Transactional(readOnly = false)
	public void save(MsgLog msgLog) {
		super.save(msgLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(MsgLog msgLog) {
		super.delete(msgLog);
	}
	
}