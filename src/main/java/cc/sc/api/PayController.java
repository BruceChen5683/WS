package cc.sc.api;

import cc.sc.common.pay.AlipayUtils;
import cc.sc.common.utils.ResultData;
import cc.sc.common.web.BaseController;
import cc.sc.modules.info.entity.Merchant;
import cc.sc.modules.info.entity.TradeOrder;
import cc.sc.modules.info.service.MerchantService;
import cc.sc.modules.info.service.TradeOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("${apiPath}/pay")
public class PayController extends BaseController {
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private TradeOrderService tradeOrderService;

    @RequestMapping("toPay/{id}")
    @ResponseBody
    public ResultData toPay(@PathVariable("id") Integer id) {
        Merchant merchant = merchantService.get(id);
        if (merchant == null) {
            return ResultData.getERRResultData("参数不正确");
        }
        if (merchant.getIsAuth() != null && merchant.getIsAuth() == 1) {
            return ResultData.getERRResultData("已经认证成功！");
        }
        TradeOrder order = tradeOrderService.findByMerchantId(id);
        int type = "vip".equals(merchant.getType()) ? 2 : 1;
        String money = null;
        String tradeNo = null;
        String res = null;
        if (order == null) {
            money = type == 1 ? "20" : "2000";
            tradeNo = createTradeNo();
            order = new TradeOrder();
            order.setMerchantId(id);
            order.setMoney(Double.valueOf(money));
            order.setState(0);
            order.setTradeNo(tradeNo);
            order.setCreateDate(new Date());
            tradeOrderService.save(order);
        } else {
            tradeNo = order.getTradeNo();
            money = order.getMoney().toString();
        }
        res = AlipayUtils.createOrder(tradeNo, type, money);
        return ResultData.getOKResultData(res);
    }

    @RequestMapping("notify")
    public void notify(HttpServletRequest request, HttpServletResponse response) {
        logger.info("==================支付异步通知开始");
        //获取支付宝POST过来反馈信息
        Map<String, String> params = new HashMap<>();
        Map requestParams = request.getParameterMap();
        for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            logger.info(name + "=" + valueStr);
            params.put(name, valueStr);
        }
        boolean flag = AlipayUtils.checkSign(params);
        logger.info("==================验签结果:" + flag);
        if (flag) {
            logger.info("==================验签成功");
            String tradeNo = params.get("out_trade_no");
            String status = params.get("trade_status");
            logger.info("==================交易号：" + tradeNo + ",交易状态：" + status);
            TradeOrder order = tradeOrderService.getByTradeNo(tradeNo);
            if (order.getState() == 0) {
                switch (status) {
                    case "TRADE_CLOSED":
                        order.setState(-1);
                        break;
                    case "TRADE_SUCCESS":
                    case "TRADE_FINISHED":
                        order.setState(1);
                        order.setPayAccount(params.get("buyer_logon_id"));
                        order.setPayDate(new Date());
                        Merchant merchant = merchantService.get(order.getMerchantId());
                        merchant.setIsAuth(1);
                        merchantService.save(merchant);
                        logger.info("==================更新isAuth成功");
                        break;
                }
                order.setPlatforms("支付宝");
                tradeOrderService.save(order);
                logger.info("==================更新order成功");
            }
        }
        PrintWriter out = null;
        try {
            logger.info("==================支付异步通知结束");
            out = response.getWriter();
            out.write("success");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String createTradeNo() {
        SimpleDateFormat format = new SimpleDateFormat("MMddHHmmss", Locale.getDefault());
        Date date = new Date();
        String key = format.format(date);
        Random r = new Random();
        key = key + r.nextInt();
        key = key.substring(0, 15);
        return key;
    }
}
