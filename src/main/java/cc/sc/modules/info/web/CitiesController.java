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
import cc.sc.modules.info.entity.Cities;
import cc.sc.modules.info.service.CitiesService;

/**
 * 城市Controller
 * @author 许军杰
 * @version 2018-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/info/cities")
public class CitiesController extends BaseController {

	@Autowired
	private CitiesService citiesService;
	
	@ModelAttribute
	public Cities get(@RequestParam(required=false) Integer id) {
		Cities entity = null;
		if (null!=id){
			entity = citiesService.get(id);
		}
		if (entity == null){
			entity = new Cities();
		}
		return entity;
	}
	
	@RequiresPermissions("info:cities:view")
	@RequestMapping(value = {"list", ""})
	public String list(Cities cities, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Cities> page = citiesService.findPage(new Page<Cities>(request, response), cities); 
		model.addAttribute("page", page);
		return "modules/info/citiesList";
	}

	@RequiresPermissions("info:cities:view")
	@RequestMapping(value = "form")
	public String form(Cities cities, Model model) {
		model.addAttribute("cities", cities);
		return "modules/info/citiesForm";
	}

	@RequiresPermissions("info:cities:edit")
	@RequestMapping(value = "save")
	public String save(Cities cities, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cities)){
			return form(cities, model);
		}
		citiesService.save(cities);
		addMessage(redirectAttributes, "保存城市成功");
		return "redirect:"+Global.getAdminPath()+"/info/cities/?repage";
	}
	
	@RequiresPermissions("info:cities:edit")
	@RequestMapping(value = "delete")
	public String delete(Cities cities, RedirectAttributes redirectAttributes) {
		citiesService.delete(cities);
		addMessage(redirectAttributes, "删除城市成功");
		return "redirect:"+Global.getAdminPath()+"/info/cities/?repage";
	}

}