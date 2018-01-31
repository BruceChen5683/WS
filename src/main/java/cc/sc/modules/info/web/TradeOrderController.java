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
import cc.sc.modules.info.entity.TradeOrder;
import cc.sc.modules.info.service.TradeOrderService;

/**
 * 订单Controller
 * @author 许军杰
 * @version 2018-01-29
 */
@Controller
@RequestMapping(value = "${adminPath}/info/tradeOrder")
public class TradeOrderController extends BaseController {

	@Autowired
	private TradeOrderService tradeOrderService;
	
	@ModelAttribute
	public TradeOrder get(@RequestParam(required=false) Integer id) {
		TradeOrder entity = null;
		if (null!=id){
			entity = tradeOrderService.get(id);
		}
		if (entity == null){
			entity = new TradeOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("info:tradeOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(TradeOrder tradeOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TradeOrder> page = tradeOrderService.findPage(new Page<TradeOrder>(request, response), tradeOrder); 
		model.addAttribute("page", page);
		return "modules/info/tradeOrderList";
	}

	@RequiresPermissions("info:tradeOrder:view")
	@RequestMapping(value = "form")
	public String form(TradeOrder tradeOrder, Model model) {
		model.addAttribute("tradeOrder", tradeOrder);
		return "modules/info/tradeOrderForm";
	}

	@RequiresPermissions("info:tradeOrder:edit")
	@RequestMapping(value = "save")
	public String save(TradeOrder tradeOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, tradeOrder)){
			return form(tradeOrder, model);
		}
		tradeOrderService.save(tradeOrder);
		addMessage(redirectAttributes, "保存订单成功");
		return "redirect:"+Global.getAdminPath()+"/info/tradeOrder/?repage";
	}
	
	@RequiresPermissions("info:tradeOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(TradeOrder tradeOrder, RedirectAttributes redirectAttributes) {
		tradeOrderService.delete(tradeOrder);
		addMessage(redirectAttributes, "删除订单成功");
		return "redirect:"+Global.getAdminPath()+"/info/tradeOrder/?repage";
	}

}