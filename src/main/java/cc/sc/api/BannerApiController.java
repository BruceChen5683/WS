package cc.sc.api;

import cc.sc.common.utils.ResultData;
import cc.sc.common.web.BaseController;
import cc.sc.modules.info.entity.Banner;
import cc.sc.modules.info.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "${apiPath}/banner")
public class BannerApiController extends BaseController {
    @Autowired
    private BannerService bannerService;

    @RequestMapping(value = "list/{region}")
    @ResponseBody
    public ResultData list(@PathVariable("region") String region) {
        Banner query = new Banner();
        query.setRegion(region);
        List<Banner> list = bannerService.findList(query);
        return ResultData.getOKResultData(list);
    }
}
