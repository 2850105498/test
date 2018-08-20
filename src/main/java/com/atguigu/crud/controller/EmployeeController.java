package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author: Cxg
 * @date:2018-8-9 下午6:10:24
 * @version :
 * @方法描述:员工处理器
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	//@ResponseBody:将数据转Json
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) throws Exception {
		// 这不是一个分页查询；
		// 引入PageHelper分页插件
		//在查询之前是需要调用，传入页码，以及每页的大小:PageHelper.startPage(pn, 5):表示传入pn页，每页显示5条数据
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		//page里封装了详细的分页信息，包括我们查询出来的数据.传递连续显示的页数为5页
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	
	
	//员工信息查询
	//pn：表示从前端传递第几页，默认是第一页defaultValue="1"
	//@RequestMapping("/emps")
	public String getEmps(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) throws Exception {
		// 这不是一个分页查询；
		// 引入PageHelper分页插件
		//在查询之前是需要调用，传入页码，以及每页的大小:PageHelper.startPage(pn, 5):表示传入pn页，每页显示5条数据
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		//page里封装了详细的分页信息，包括我们查询出来的数据.传递连续显示的页数为5页
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
