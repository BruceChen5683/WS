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
import cc.sc.modules.info.entity.MsgLog;
import cc.sc.modules.info.service.MsgLogService;

/**
 * 短信发送日志Controller
 * @author 许军杰
 * @version 2018-01-24
 */
@Controller
@RequestMapping(value = "${adminPath}/info/msgLog")
public class MsgLogController extends BaseController {

	@Autowired
	private MsgLogService msgLogService;
	
	@ModelAttribute
	public MsgLog get(@RequestParam(required=false) Integer id) {
		MsgLog entity = null;
		if (null!=id){
			entity = msgLogService.get(id);
		}
		if (entity == null){
			entity = new MsgLog();
		}
		return entity;
	}
	
	@RequiresPermissions("info:msgLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(MsgLog msgLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MsgLog> page = msgLogService.findPage(new Page<MsgLog>(request, response), msgLog); 
		model.addAttribute("page", page);
		return "modules/info/msgLogList";
	}

	@RequiresPermissions("info:msgLog:view")
	@RequestMapping(value = "form")
	public String form(MsgLog msgLog, Model model) {
		model.addAttribute("msgLog", msgLog);
		return "modules/info/msgLogForm";
	}

	@RequiresPermissions("info:msgLog:edit")
	@RequestMapping(value = "save")
	public String save(MsgLog msgLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, msgLog)){
			return form(msgLog, model);
		}
		msgLogService.save(msgLog);
		addMessage(redirectAttributes, "保存短信发送日志成功");
		return "redirect:"+Global.getAdminPath()+"/info/msgLog/?repage";
	}
	
	@RequiresPermissions("info:msgLog:edit")
	@RequestMapping(value = "delete")
	public String delete(MsgLog msgLog, RedirectAttributes redirectAttributes) {
		msgLogService.delete(msgLog);
		addMessage(redirectAttributes, "删除短信发送日志成功");
		return "redirect:"+Global.getAdminPath()+"/info/msgLog/?repage";
	}

}