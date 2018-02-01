/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.Cities;
import cc.sc.modules.info.dao.CitiesDao;

/**
 * 城市Service
 * @author 许军杰
 * @version 2018-01-11
 */
@Service
@Transactional(readOnly = true)
public class CitiesService extends CrudService<CitiesDao, Cities> {

	public Cities get(Integer id) {
		return super.get(id);
	}
	
	public List<Cities> findList(Cities cities) {
		return super.findList(cities);
	}
	
	public Page<Cities> findPage(Page<Cities> page, Cities cities) {
		return super.findPage(page, cities);
	}
	
	@Transactional(readOnly = false)
	public void save(Cities cities) {
		super.save(cities);
	}
	
	@Transactional(readOnly = false)
	public void delete(Cities cities) {
		super.delete(cities);
	}
	
}