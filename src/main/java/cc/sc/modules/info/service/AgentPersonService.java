/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.AgentPerson;
import cc.sc.modules.info.dao.AgentPersonDao;

/**
 * 代理人Service
 * @author 许军杰
 * @version 2018-01-10
 */
@Service
@Transactional(readOnly = true)
public class AgentPersonService extends CrudService<AgentPersonDao, AgentPerson> {

	public AgentPerson get(Integer id) {
		return super.get(id);
	}
	
	public List<AgentPerson> findList(AgentPerson agentPerson) {
		return super.findList(agentPerson);
	}
	
	public Page<AgentPerson> findPage(Page<AgentPerson> page, AgentPerson agentPerson) {
		return super.findPage(page, agentPerson);
	}
	
	@Transactional(readOnly = false)
	public void save(AgentPerson agentPerson) {
		super.save(agentPerson);
	}
	
	@Transactional(readOnly = false)
	public void delete(AgentPerson agentPerson) {
		super.delete(agentPerson);
	}
	
}