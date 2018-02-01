/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.modules.info.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cc.sc.common.config.Global;
import cc.sc.common.persistence.Page;
import cc.sc.common.web.BaseController;
import cc.sc.common.utils.StringUtils;
import cc.sc.modules.info.entity.MerchantImage;
import cc.sc.modules.info.service.MerchantImageService;

/**
 * 商户图片Controller
 * @author 许军杰
 * @version 2018-01-10
 */
@Controller
@RequestMapping(value = "${adminPath}/info/merchantImage")
public class MerchantImageController extends BaseController {

	@Autowired
	private MerchantImageService merchantImageService;
	
	@ModelAttribute
	public MerchantImage get(@RequestParam(required=false) Integer id) {
		MerchantImage entity = null;
		if (null!=id){
			entity = merchantImageService.get(id);
		}
		if (entity == null){
			entity = new MerchantImage();
		}
		return entity;
	}
	
	@RequiresPermissions("info:merchantImage:view")
	@RequestMapping(value = {"list", ""})
	public String list(MerchantImage merchantImage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MerchantImage> page = merchantImageService.findPage(new Page<MerchantImage>(request, response), merchantImage); 
		model.addAttribute("page", page);
		return "modules/info/merchantImageList";
	}

	@RequiresPermissions("info:merchantImage:view")
	@RequestMapping(value = "form")
	public String form(MerchantImage merchantImage, Model model) {
		model.addAttribute("merchantImage", merchantImage);
		return "modules/info/merchantImageForm";
	}

	@RequiresPermissions("info:merchantImage:edit")
	@RequestMapping(value = "save")
	public String save(MerchantImage merchantImage, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, merchantImage)){
			return form(merchantImage, model);
		}
		merchantImageService.save(merchantImage);
		addMessage(redirectAttributes, "保存商户图片成功");
		return "redirect:"+Global.getAdminPath()+"/info/merchantImage/?repage";
	}
	
	@RequiresPermissions("info:merchantImage:edit")
	@RequestMapping(value = "delete")
	public String delete(MerchantImage merchantImage, RedirectAttributes redirectAttributes) {
		merchantImageService.delete(merchantImage);
		addMessage(redirectAttributes, "删除商户图片成功");
		return "redirect:"+Global.getAdminPath()+"/info/merchantImage/?repage";
	}

}