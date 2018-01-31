/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.Areas;
import cc.sc.modules.info.dao.AreasDao;

/**
 * 区域Service
 * @author 许军杰
 * @version 2018-01-11
 */
@Service
@Transactional(readOnly = true)
public class AreasService extends CrudService<AreasDao, Areas> {

	public Areas get(Integer id) {
		return super.get(id);
	}
	
	public List<Areas> findList(Areas areas) {
		return super.findList(areas);
	}
	
	public Page<Areas> findPage(Page<Areas> page, Areas areas) {
		return super.findPage(page, areas);
	}
	
	@Transactional(readOnly = false)
	public void save(Areas areas) {
		super.save(areas);
	}
	
	@Transactional(readOnly = false)
	public void delete(Areas areas) {
		super.delete(areas);
	}
	
}