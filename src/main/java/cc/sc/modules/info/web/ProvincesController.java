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
import cc.sc.modules.info.entity.Provinces;
import cc.sc.modules.info.service.ProvincesService;

/**
 * 省份Controller
 * @author 许军杰
 * @version 2018-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/info/provinces")
public class ProvincesController extends BaseController {

	@Autowired
	private ProvincesService provincesService;
	
	@ModelAttribute
	public Provinces get(@RequestParam(required=false) Integer id) {
		Provinces entity = null;
		if (null!=id){
			entity = provincesService.get(id);
		}
		if (entity == null){
			entity = new Provinces();
		}
		return entity;
	}
	
	@RequiresPermissions("info:provinces:view")
	@RequestMapping(value = {"list", ""})
	public String list(Provinces provinces, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Provinces> page = provincesService.findPage(new Page<Provinces>(request, response), provinces); 
		model.addAttribute("page", page);
		return "modules/info/provincesList";
	}

	@RequiresPermissions("info:provinces:view")
	@RequestMapping(value = "form")
	public String form(Provinces provinces, Model model) {
		model.addAttribute("provinces", provinces);
		return "modules/info/provincesForm";
	}

	@RequiresPermissions("info:provinces:edit")
	@RequestMapping(value = "save")
	public String save(Provinces provinces, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, provinces)){
			return form(provinces, model);
		}
		provincesService.save(provinces);
		addMessage(redirectAttributes, "保存省份成功");
		return "redirect:"+Global.getAdminPath()+"/info/provinces/?repage";
	}
	
	@RequiresPermissions("info:provinces:edit")
	@RequestMapping(value = "delete")
	public String delete(Provinces provinces, RedirectAttributes redirectAttributes) {
		provincesService.delete(provinces);
		addMessage(redirectAttributes, "删除省份成功");
		return "redirect:"+Global.getAdminPath()+"/info/provinces/?repage";
	}

}