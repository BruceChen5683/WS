package cc.sc.api;

import cc.sc.common.utils.ResultData;
import cc.sc.common.web.BaseController;
import cc.sc.modules.info.entity.Areas;
import cc.sc.modules.info.entity.Cities;
import cc.sc.modules.info.entity.Provinces;
import cc.sc.modules.info.service.AreasService;
import cc.sc.modules.info.service.CitiesService;
import cc.sc.modules.info.service.ProvincesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "${apiPath}/region")
public class RegionApiController extends BaseController {
    @Autowired
    private ProvincesService provincesService;
    @Autowired
    private CitiesService citiesService;
    @Autowired
    private AreasService areasService;

    @ResponseBody
    @RequestMapping(value = "getProvinces")
    public ResultData getProvinces() {
        List<Provinces> list = provincesService.findList(new Provinces());
        return ResultData.getOKResultData(list);
    }

    @ResponseBody
    @RequestMapping(value = "getCity/{id}")
    public ResultData getCities(@PathVariable("id") Integer id) {
        Cities cities = new Cities();
        cities.setProvinceid(id);
        List<Cities> list = citiesService.findList(cities);
        return ResultData.getOKResultData(list);
    }

    @ResponseBody
    @RequestMapping(value = "getArea/{id}")
    public ResultData getAreas(@PathVariable("id") Integer id) {
        Areas areas = new Areas();
        areas.setCityid(id);
        List<Areas> list = areasService.findList(areas);
        return ResultData.getOKResultData(list);
    }

    @ResponseBody
    @RequestMapping(value = "getHotCity")
    public ResultData getHotCity() {
        Cities city = new Cities();
        city.setIsHot(1);
        List<Cities> list = citiesService.findList(city);
        return ResultData.getOKResultData(list);
    }
}
