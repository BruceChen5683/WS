/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.MerchantImage;
import cc.sc.modules.info.dao.MerchantImageDao;

/**
 * 商户图片Service
 *
 * @author 许军杰
 * @version 2018-01-10
 */
@Service
@Transactional(readOnly = true)
public class MerchantImageService extends CrudService<MerchantImageDao, MerchantImage> {

    public MerchantImage get(Integer id) {
        return super.get(id);
    }

    public List<MerchantImage> findList(MerchantImage merchantImage) {
        return super.findList(merchantImage);
    }

    public Page<MerchantImage> findPage(Page<MerchantImage> page, MerchantImage merchantImage) {
        return super.findPage(page, merchantImage);
    }

    @Transactional(readOnly = false)
    public void save(MerchantImage merchantImage) {
        super.save(merchantImage);
    }

    @Transactional(readOnly = false)
    public void delete(MerchantImage merchantImage) {
        super.delete(merchantImage);
    }

    @Transactional(readOnly = false)
    public void updateMerchant(String[] imageIds, int merchantId) {
        dao.updateMerchant(imageIds, merchantId);
    }

    public List<String> findListByMerchant(Integer id) {
        return dao.findListByMerchant(id);
    }
}