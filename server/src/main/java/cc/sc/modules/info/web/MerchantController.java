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
import cc.sc.modules.info.entity.Merchant;
import cc.sc.modules.info.service.MerchantService;

/**
 * 商户Controller
 *
 * @author 许军杰
 * @version 2018-01-10
 */
@Controller
@RequestMapping(value = "${adminPath}/info/comMerchant")
public class MerchantController extends BaseController {

    @Autowired
    private MerchantService merchantService;

    @ModelAttribute
    public Merchant get(@RequestParam(required = false) Integer id) {
        Merchant entity = null;
        if (null != id) {
            entity = merchantService.get(id);
        }
        if (entity == null) {
            entity = new Merchant();
        }
        return entity;
    }

    @RequiresPermissions("info:comMerchant:view")
    @RequestMapping(value = {"list", ""})
    public String list(Merchant merchant, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Merchant> page = merchantService.findPage(new Page<Merchant>(request, response), merchant);
        model.addAttribute("page", page);
        return "modules/info/comMerchantList";
    }

    @RequiresPermissions("info:comMerchant:view")
    @RequestMapping(value = "form")
    public String form(Merchant comMerchant, Model model) {
        model.addAttribute("comMerchant", comMerchant);
        return "modules/info/comMerchantForm";
    }

    @RequiresPermissions("info:comMerchant:edit")
    @RequestMapping(value = "save")
    public String save(Merchant comMerchant, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, comMerchant)) {
            return form(comMerchant, model);
        }
        merchantService.save(comMerchant);
        addMessage(redirectAttributes, "保存商户成功");
        return "redirect:" + Global.getAdminPath() + "/info/comMerchant/?repage";
    }

    @RequiresPermissions("info:comMerchant:edit")
    @RequestMapping(value = "delete")
    public String delete(Merchant comMerchant, RedirectAttributes redirectAttributes) {
        merchantService.delete(comMerchant);
        addMessage(redirectAttributes, "删除商户成功");
        return "redirect:" + Global.getAdminPath() + "/info/comMerchant/?repage";
    }

}