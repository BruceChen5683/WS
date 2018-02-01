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
import cc.sc.modules.info.entity.AgentPerson;
import cc.sc.modules.info.service.AgentPersonService;

/**
 * 代理人Controller
 * @author 许军杰
 * @version 2018-01-10
 */
@Controller
@RequestMapping(value = "${adminPath}/info/agentPerson")
public class AgentPersonController extends BaseController {

	@Autowired
	private AgentPersonService agentPersonService;
	
	@ModelAttribute
	public AgentPerson get(@RequestParam(required=false) Integer id) {
		AgentPerson entity = null;
		if (null!=id){
			entity = agentPersonService.get(id);
		}
		if (entity == null){
			entity = new AgentPerson();
		}
		return entity;
	}
	
	@RequiresPermissions("info:agentPerson:view")
	@RequestMapping(value = {"list", ""})
	public String list(AgentPerson agentPerson, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AgentPerson> page = agentPersonService.findPage(new Page<AgentPerson>(request, response), agentPerson); 
		model.addAttribute("page", page);
		return "modules/info/agentPersonList";
	}

	@RequiresPermissions("info:agentPerson:view")
	@RequestMapping(value = "form")
	public String form(AgentPerson agentPerson, Model model) {
		model.addAttribute("agentPerson", agentPerson);
		return "modules/info/agentPersonForm";
	}

	@RequiresPermissions("info:agentPerson:edit")
	@RequestMapping(value = "save")
	public String save(AgentPerson agentPerson, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, agentPerson)){
			return form(agentPerson, model);
		}
		agentPersonService.save(agentPerson);
		addMessage(redirectAttributes, "保存代理人成功");
		return "redirect:"+Global.getAdminPath()+"/info/agentPerson/?repage";
	}
	
	@RequiresPermissions("info:agentPerson:edit")
	@RequestMapping(value = "delete")
	public String delete(AgentPerson agentPerson, RedirectAttributes redirectAttributes) {
		agentPersonService.delete(agentPerson);
		addMessage(redirectAttributes, "删除代理人成功");
		return "redirect:"+Global.getAdminPath()+"/info/agentPerson/?repage";
	}

}