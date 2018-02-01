package cc.sc.api;

import cc.sc.common.utils.ResultData;
import cc.sc.common.web.BaseController;
import cc.sc.modules.info.entity.AgentPerson;
import cc.sc.modules.info.entity.Merchant;
import cc.sc.modules.info.service.AgentPersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping(value = "${apiPath}/agent")
public class AgentPersonApiController extends BaseController {
    @Autowired
    private AgentPersonService agentPersonService;

    /**
     * 添加商户
     *
     * @param agentPerson
     * @return
     */
    @RequestMapping(value = "addAgent")
    @ResponseBody
    public ResultData addAgent(AgentPerson agentPerson, @RequestParam MultipartFile image, HttpServletRequest request) throws IOException {
        String savePath = request.getSession().getServletContext().getRealPath("/")
                + "/uploadTempDirectory/";
        File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String fileName = System.currentTimeMillis() + ".jpg";
        File saveFile = new File(savePath, fileName);
        image.transferTo(saveFile);
        agentPerson.setIdCardImage("/uploadTempDirectory/" + fileName);
        agentPersonService.save(agentPerson);
        return ResultData.getOKResultData(agentPerson.getId());
    }

}
