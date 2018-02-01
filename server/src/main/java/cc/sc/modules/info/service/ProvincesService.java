/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.Provinces;
import cc.sc.modules.info.dao.ProvincesDao;

/**
 * 省份Service
 * @author 许军杰
 * @version 2018-01-11
 */
@Service
@Transactional(readOnly = true)
public class ProvincesService extends CrudService<ProvincesDao, Provinces> {

	public Provinces get(Integer id) {
		return super.get(id);
	}
	
	public List<Provinces> findList(Provinces provinces) {
		return super.findList(provinces);
	}
	
	public Page<Provinces> findPage(Page<Provinces> page, Provinces provinces) {
		return super.findPage(page, provinces);
	}
	
	@Transactional(readOnly = false)
	public void save(Provinces provinces) {
		super.save(provinces);
	}
	
	@Transactional(readOnly = false)
	public void delete(Provinces provinces) {
		super.delete(provinces);
	}
	
}