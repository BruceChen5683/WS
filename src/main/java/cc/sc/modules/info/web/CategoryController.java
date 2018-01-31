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
import cc.sc.modules.info.entity.Category;
import cc.sc.modules.info.service.CategoryService;

/**
 * 分类Controller
 * @author 许军杰
 * @version 2018-01-08
 */
@Controller
@RequestMapping(value = "${adminPath}/info/category")
public class CategoryController extends BaseController {

	@Autowired
	private CategoryService categoryService;
	
	@ModelAttribute
	public Category get(@RequestParam(required=false) Integer id) {
		Category entity = null;
		if (null!=id){
			entity = categoryService.get(id);
		}
		if (entity == null){
			entity = new Category();
		}
		return entity;
	}
	
	@RequiresPermissions("info:category:view")
	@RequestMapping(value = {"list", ""})
	public String list(Category category, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Category> page = categoryService.findPage(new Page<Category>(request, response), category); 
		model.addAttribute("page", page);
		return "modules/info/categoryList";
	}

	@RequiresPermissions("info:category:view")
	@RequestMapping(value = "form")
	public String form(Category category, Model model) {
		model.addAttribute("category", category);
		return "modules/info/categoryForm";
	}

	@RequiresPermissions("info:category:edit")
	@RequestMapping(value = "save")
	public String save(Category category, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, category)){
			return form(category, model);
		}
		categoryService.save(category);
		addMessage(redirectAttributes, "保存分类成功");
		return "redirect:"+Global.getAdminPath()+"/info/category/?repage";
	}
	
	@RequiresPermissions("info:category:edit")
	@RequestMapping(value = "delete")
	public String delete(Category category, RedirectAttributes redirectAttributes) {
		categoryService.delete(category);
		addMessage(redirectAttributes, "删除分类成功");
		return "redirect:"+Global.getAdminPath()+"/info/category/?repage";
	}

}