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
import cc.sc.modules.info.entity.Areas;
import cc.sc.modules.info.service.AreasService;

/**
 * 区域Controller
 * @author 许军杰
 * @version 2018-01-11
 */
@Controller
@RequestMapping(value = "${adminPath}/info/areas")
public class AreasController extends BaseController {

	@Autowired
	private AreasService areasService;
	
	@ModelAttribute
	public Areas get(@RequestParam(required=false) Integer id) {
		Areas entity = null;
		if (null!=id){
			entity = areasService.get(id);
		}
		if (entity == null){
			entity = new Areas();
		}
		return entity;
	}
	
	@RequiresPermissions("info:areas:view")
	@RequestMapping(value = {"list", ""})
	public String list(Areas areas, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Areas> page = areasService.findPage(new Page<Areas>(request, response), areas); 
		model.addAttribute("page", page);
		return "modules/info/areasList";
	}

	@RequiresPermissions("info:areas:view")
	@RequestMapping(value = "form")
	public String form(Areas areas, Model model) {
		model.addAttribute("areas", areas);
		return "modules/info/areasForm";
	}

	@RequiresPermissions("info:areas:edit")
	@RequestMapping(value = "save")
	public String save(Areas areas, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, areas)){
			return form(areas, model);
		}
		areasService.save(areas);
		addMessage(redirectAttributes, "保存区域成功");
		return "redirect:"+Global.getAdminPath()+"/info/areas/?repage";
	}
	
	@RequiresPermissions("info:areas:edit")
	@RequestMapping(value = "delete")
	public String delete(Areas areas, RedirectAttributes redirectAttributes) {
		areasService.delete(areas);
		addMessage(redirectAttributes, "删除区域成功");
		return "redirect:"+Global.getAdminPath()+"/info/areas/?repage";
	}

}