/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.Merchant;
import cc.sc.modules.info.dao.MerchantDao;

/**
 * 商户Service
 *
 * @author 许军杰
 * @version 2018-01-10
 */
@Service
@Transactional(readOnly = true)
public class MerchantService extends CrudService<MerchantDao, Merchant> {

    public Merchant get(Integer id) {
        return super.get(id);
    }

    public List<Merchant> findList(Merchant comMerchant) {
        return super.findList(comMerchant);
    }

    public Page<Merchant> findPage(Page<Merchant> page, Merchant comMerchant) {
        return super.findPage(page, comMerchant);
    }

    @Transactional(readOnly = false)
    public void save(Merchant comMerchant) {
        if (comMerchant.getIsNewRecord()) {
            comMerchant.setAttendDate(new Date());
            comMerchant.setIsHot(0);
            comMerchant.setViewNum(0);
        }
        super.save(comMerchant);
    }

    @Transactional(readOnly = false)
    public void delete(Merchant comMerchant) {
        super.delete(comMerchant);
    }

    /**
     * 通过地区获取热门商户
     *
     * @param region
     */
    public List<Merchant> getHotList(String region) {
        return dao.getHotList(region);
    }

    public Integer findNum(String cellphone, String queryDate) {
        return dao.findNum(cellphone, queryDate);
    }

    @Transactional(readOnly = false)
    public void updateViewNum(Integer id) {
        dao.updateViewNum(id);
    }
}