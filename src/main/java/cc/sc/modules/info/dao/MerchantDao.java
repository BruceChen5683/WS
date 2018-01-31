/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.dao;

import cc.sc.common.persistence.CrudDao;
import cc.sc.common.persistence.annotation.MyBatisDao;
import cc.sc.modules.info.entity.Merchant;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 商户DAO接口
 *
 * @author 许军杰
 * @version 2018-01-10
 */
@MyBatisDao
public interface MerchantDao extends CrudDao<Merchant> {

    List<Merchant> getHotList(String region);

    Integer findNum(@Param("cellphone") String cellphone, @Param("queryDate") String queryDate);

    void updateViewNum(Integer id);
}