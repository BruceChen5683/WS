/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cc.sc.common.persistence.Page;
import cc.sc.common.service.CrudService;
import cc.sc.modules.info.entity.TradeOrder;
import cc.sc.modules.info.dao.TradeOrderDao;

/**
 * 订单Service
 *
 * @author 许军杰
 * @version 2018-01-29
 */
@Service
@Transactional(readOnly = true)
public class TradeOrderService extends CrudService<TradeOrderDao, TradeOrder> {

    public TradeOrder get(Integer id) {
        return super.get(id);
    }

    public List<TradeOrder> findList(TradeOrder tradeOrder) {
        return super.findList(tradeOrder);
    }

    public Page<TradeOrder> findPage(Page<TradeOrder> page, TradeOrder tradeOrder) {
        return super.findPage(page, tradeOrder);
    }

    @Transactional(readOnly = false)
    public void save(TradeOrder tradeOrder) {
        super.save(tradeOrder);
    }

    @Transactional(readOnly = false)
    public void delete(TradeOrder tradeOrder) {
        super.delete(tradeOrder);
    }

    public TradeOrder findByMerchantId(Integer id) {
        return dao.findByMerchantId(id);
    }

    public TradeOrder getByTradeNo(String tradeNo) {
        return dao.getByTradeNo(tradeNo);
    }
}