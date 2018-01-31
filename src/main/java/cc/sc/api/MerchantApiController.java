package cc.sc.api;

import cc.sc.common.persistence.Page;
import cc.sc.common.utils.DateUtils;
import cc.sc.common.utils.ResultData;
import cc.sc.common.utils.StringUtils;
import cc.sc.common.web.BaseController;
import cc.sc.modules.info.entity.Merchant;
import cc.sc.modules.info.entity.MerchantImage;
import cc.sc.modules.info.service.MerchantImageService;
import cc.sc.modules.info.service.MerchantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping(value = "${apiPath}/merchant")
public class MerchantApiController extends BaseController {

    @Autowired
    private MerchantService merchantService;

    @Autowired
    private MerchantImageService merchantImageService;

    @RequestMapping(value = "getListByCategory/{id}/{pageNo}/{region}/{sort}")
    @ResponseBody
    public ResultData getListByCategory(@PathVariable("id") Integer id, @PathVariable("pageNo") Integer pageNo
            , @PathVariable("region") String region, @PathVariable("sort") Integer sort) {
        Merchant query = new Merchant();
        if (pageNo == null) {
            pageNo = 0;
        }
        Page<Merchant> page = new Page<Merchant>(pageNo, 20);
        if (id == null || id == 0) {
            id = null;
        }
        if (sort == null) {
            sort = 0;
        }
        switch (sort) {
            case 0:
                break;
            case 1:
                page.setOrderBy("a.view_num desc");
                break;
        }
        query.setCategoryId(id);
        query.setRegion(region);
        page = merchantService.findPage(page, query);
        List<Merchant> list = page.getList();
        return ResultData.getOKResultData(list);
    }

    @RequestMapping(value = "query")
    @ResponseBody
    public ResultData query(String region, String queryText) {
        Merchant query = new Merchant();
        query.setRegion(region);
        query.setQueryText(queryText);
        List<Merchant> list = merchantService.findList(query);
        return ResultData.getOKResultData(list);
    }

    /**
     * 根据地区获取热门商户
     *
     * @param region
     * @return
     */
    @RequestMapping(value = "getHotList/{region}")
    @ResponseBody
    public ResultData getListByCategory(@PathVariable("region") String region) {
        List<Merchant> list = merchantService.getHotList(region);
        return ResultData.getOKResultData(list);
    }


    /**
     * 添加商户
     *
     * @param merchant
     * @return
     */
    @RequestMapping(value = "addMerchant")
    @ResponseBody
    public ResultData addMerchant(Merchant merchant) {
        merchantService.save(merchant);
        if (merchant.getImageIdStr() != null) {
            String[] imageIds = merchant.getImageIdStr().split(",");
            MerchantImage image = merchantImageService.get(Integer.parseInt(imageIds[0]));
            merchant.setLogoUrl(image.getPicUrl());
            merchantImageService.updateMerchant(imageIds, merchant.getId());
            merchantService.save(merchant);

        }
        return ResultData.getOKResultData(merchant.getId());
    }

    /**
     * 获取商户详情
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "detail/{id}")
    @ResponseBody
    public ResultData getMerchant(@PathVariable("id") Integer id) {
        Merchant merchant = merchantService.get(id);
        List<String> images = merchantImageService.findListByMerchant(id);
        merchant.setImages(images);
        merchantService.updateViewNum(id);
        return ResultData.getOKResultData(merchant);
    }

    @RequestMapping(value = "addMerchant1")
    @ResponseBody
    public ResultData addMerchant1(@RequestBody Merchant merchant) {
        merchantService.save(merchant);
        return ResultData.getOKResultData(merchant.getId());
    }

    /**
     * 上传文件 用@RequestParam注解来指定表单上的file为MultipartFile
     *
     * @param multipartfile
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/uploadImage")
    @ResponseBody
    public ResultData uploadImage(@RequestParam("pic") MultipartFile multipartfile, HttpServletRequest request) throws IOException {
        //保存文件到临时目录
        String savePath = request.getSession().getServletContext().getRealPath("/")
                + "/uploadTempDirectory/";
        File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String fileName = System.currentTimeMillis() + ".jpg";
        File saveFile = new File(savePath, fileName);
        multipartfile.transferTo(saveFile);
        MerchantImage image = new MerchantImage();
        image.setPicType(1);
        image.setPicUrl("/uploadTempDirectory/" + fileName);
        merchantImageService.save(image);
        return ResultData.getOKResultData(image.getId());
    }

    @RequestMapping(value = "/changeAd")
    @ResponseBody
    public ResultData changeAd(Merchant merchant, HttpServletRequest request) throws IOException {
        if (merchant.getId() == null) {
            return ResultData.getERRResultData("参数错误");
        }
        String adWord = merchant.getAdWord();
        if (StringUtils.isEmpty(adWord)) {
            return ResultData.getERRResultData("参数错误");
        }
        merchant = merchantService.get(merchant);
        merchant.setAdWord(adWord);
        merchantService.save(merchant);
        return ResultData.getOKResultData("success");
    }

    @RequestMapping(value = "/changeMainProducts")
    @ResponseBody
    public ResultData changeMainProducts(Merchant merchant, HttpServletRequest request) throws IOException {
        if (merchant.getId() == null) {
            return ResultData.getERRResultData("参数错误");
        }
        String mainProducts = merchant.getMainProducts();
        if (StringUtils.isEmpty(mainProducts)) {
            return ResultData.getERRResultData("参数错误");
        }
        merchant = merchantService.get(merchant);
        merchant.setMainProducts(mainProducts);
        merchantService.save(merchant);
        return ResultData.getOKResultData("success");
    }

    /**
     * 通过手机号查询推荐数量
     *
     * @param cellphone
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/findNum/{cellphone}")
    @ResponseBody
    public ResultData findNum(@PathVariable("cellphone") String cellphone, HttpServletRequest request) throws IOException {
        Integer num = merchantService.findNum(cellphone, null);
        return ResultData.getOKResultData(num);
    }

    /**
     * 通过手机号查询推荐数量
     *
     * @param cellphone
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/getReferees/{cellphone}")
    @ResponseBody
    public ResultData getReferees(@PathVariable("cellphone") String cellphone, HttpServletRequest request) throws IOException {
        String today = DateUtils.getDate("yyyy-MM-dd");
        Integer num = merchantService.findNum(cellphone, today);
        return ResultData.getOKResultData(num);
    }
}
