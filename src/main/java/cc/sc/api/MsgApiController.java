package cc.sc.api;

import cc.sc.common.utils.ResultData;
import cc.sc.common.utils.SMSUtils;
import cc.sc.common.utils.StringUtils;
import cc.sc.common.web.BaseController;
import cc.sc.modules.info.entity.MsgLog;
import cc.sc.modules.info.service.MsgLogService;
import com.aliyuncs.exceptions.ClientException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@RequestMapping("${apiPath}/msg")
public class MsgApiController extends BaseController {
    static final String templeCode = "SMS_122281934";
    static final String templeMsg = "{\"code\":\"%s\"}";
    @Autowired
    private MsgLogService msgLogService;

    @RequestMapping("sendMsg/{cellphone}")
    @ResponseBody
    public ResultData sendMsg(@PathVariable("cellphone") String cellphone) throws ClientException {
        if (StringUtils.isEmpty(cellphone) || cellphone.length() != 11) {
            return ResultData.getERRResultData("手机号不正确");
        }
        String code = SMSUtils.getRandomCode(6);
        boolean res = SMSUtils.sendSms(cellphone, templeCode, String.format(templeMsg, code));
        if (res) {
            MsgLog msgLog = new MsgLog();
            msgLog.setCellphone(cellphone);
            msgLog.setCreateDate(new Date());
            msgLog.setCode(code);
            msgLogService.save(msgLog);
            return ResultData.getOKResultData(code);
        } else {
            return ResultData.getERRResultData("send fail");
        }

    }
}
