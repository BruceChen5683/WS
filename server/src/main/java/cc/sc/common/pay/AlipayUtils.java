package cc.sc.common.pay;

import cc.sc.common.config.Global;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;

import java.util.Map;

public class AlipayUtils {
    private static String appId = Global.getConfig("alipay_appid");

    private static String privateKey = Global.getConfig("alipay_private_key");
    private static String charSet = "UTF-8";
    private static String format = "json";
    private static String publicKey = Global.getConfig("alipay_public_key");
    private static String signType = "RSA2";
    private static String serverUrl = "https://openapi.alipay.com/gateway.do";
    private static String aliNotifyUrl = Global.getConfig("aliNotifyUrl");

    public static String createOrder(String outtradeno, int type, String money) {
        String res = null;
        //实例化客户端
        AlipayClient alipayClient = new DefaultAlipayClient(serverUrl, appId, privateKey, format, charSet, publicKey, signType);
//实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
        AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
//SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
        AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
//        model.setBody("我是测试数据");
        String subject = type == 1 ? "万商普通商家认证-费用" : "万商高级商家认证-费用";
        subject += money + "元";
        model.setSubject(subject);
        model.setOutTradeNo(outtradeno);
//        model.setTimeoutExpress("x");
        model.setTotalAmount(money);
        request.setBizModel(model);
        request.setNotifyUrl(aliNotifyUrl);
        try {
            //这里和普通的接口调用不同，使用的是sdkExecute
            AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
            res = response.getBody();//就是orderString 可以直接给客户端请求，无需再做处理。
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        return res;
    }

    public static boolean checkSign(Map<String, String> params) {
        boolean flag = false;
        try {
            flag = AlipaySignature.rsaCheckV1(params, publicKey, charSet, signType);
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        return flag;
    }
}
