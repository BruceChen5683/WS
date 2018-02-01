/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.dao;

import cc.sc.common.persistence.CrudDao;
import cc.sc.common.persistence.annotation.MyBatisDao;
import cc.sc.modules.info.entity.MerchantImage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商户图片DAO接口
 *
 * @author 许军杰
 * @version 2018-01-10
 */
@MyBatisDao
public interface MerchantImageDao extends CrudDao<MerchantImage> {

    void updateMerchant(@Param("ids") String[] imageIds, @Param("merchantId") int merchantId);

    List<String> findListByMerchant(Integer id);
}