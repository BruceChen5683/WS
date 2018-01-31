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
import cc.sc.modules.info.entity.Banner;
import cc.sc.modules.info.service.BannerService;

/**
 * banner广告图Controller
 * @author 许军杰
 * @version 2018-01-10
 */
@Controller
@RequestMapping(value = "${adminPath}/info/banner")
public class BannerController extends BaseController {

	@Autowired
	private BannerService bannerService;
	
	@ModelAttribute
	public Banner get(@RequestParam(required=false) Integer id) {
		Banner entity = null;
		if (null!=id){
			entity = bannerService.get(id);
		}
		if (entity == null){
			entity = new Banner();
		}
		return entity;
	}
	
	@RequiresPermissions("info:banner:view")
	@RequestMapping(value = {"list", ""})
	public String list(Banner banner, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Banner> page = bannerService.findPage(new Page<Banner>(request, response), banner); 
		model.addAttribute("page", page);
		return "modules/info/bannerList";
	}

	@RequiresPermissions("info:banner:view")
	@RequestMapping(value = "form")
	public String form(Banner banner, Model model) {
		model.addAttribute("banner", banner);
		return "modules/info/bannerForm";
	}

	@RequiresPermissions("info:banner:edit")
	@RequestMapping(value = "save")
	public String save(Banner banner, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, banner)){
			return form(banner, model);
		}
		bannerService.save(banner);
		addMessage(redirectAttributes, "保存banner广告图成功");
		return "redirect:"+Global.getAdminPath()+"/info/banner/?repage";
	}
	
	@RequiresPermissions("info:banner:edit")
	@RequestMapping(value = "delete")
	public String delete(Banner banner, RedirectAttributes redirectAttributes) {
		bannerService.delete(banner);
		addMessage(redirectAttributes, "删除banner广告图成功");
		return "redirect:"+Global.getAdminPath()+"/info/banner/?repage";
	}

}