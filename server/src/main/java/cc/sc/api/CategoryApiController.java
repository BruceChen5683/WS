/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cc.sc.api;

import cc.sc.common.config.Global;
import cc.sc.common.persistence.Page;
import cc.sc.common.utils.ResultData;
import cc.sc.common.web.BaseController;
import cc.sc.modules.info.entity.Category;
import cc.sc.modules.info.service.CategoryService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 分类Controller
 *
 * @author 许军杰
 * @version 2018-01-08
 */
@Controller
@RequestMapping(value = "${apiPath}/category")
public class CategoryApiController extends BaseController {

    @Autowired
    private CategoryService categoryService;

    @ModelAttribute
    public Category get(@RequestParam(required = false) Integer id) {
        Category entity = null;
        if (null != id) {
            entity = categoryService.get(id);
        }
        if (entity == null) {
            entity = new Category();
        }
        return entity;
    }

    @RequestMapping(value = "list/{parentId}")
    @ResponseBody
    public ResultData list(@PathVariable("parentId") Integer parentId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Category parent = new Category(parentId == null ? 0 : parentId);
        Category category = new Category();
        category.setParent(parent);
        List<Category> list = categoryService.findList(category);
        return ResultData.getOKResultData(list);
    }

}