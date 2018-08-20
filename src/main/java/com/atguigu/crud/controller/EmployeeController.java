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
 * @date:2018-8-9 ����6:10:24
 * @version :
 * @��������:Ա��������
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	//@ResponseBody:������תJson
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) throws Exception {
		// �ⲻ��һ����ҳ��ѯ��
		// ����PageHelper��ҳ���
		//�ڲ�ѯ֮ǰ����Ҫ���ã�����ҳ�룬�Լ�ÿҳ�Ĵ�С:PageHelper.startPage(pn, 5):��ʾ����pnҳ��ÿҳ��ʾ5������
		PageHelper.startPage(pn, 5);
		// startPage��������������ѯ����һ����ҳ��ѯ
		List<Employee> emps = employeeService.getAll();
		// ʹ��pageInfo��װ��ѯ��Ľ����ֻ��Ҫ��pageInfo����ҳ������ˡ�
		//page���װ����ϸ�ķ�ҳ��Ϣ���������ǲ�ѯ����������.����������ʾ��ҳ��Ϊ5ҳ
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	
	
	//Ա����Ϣ��ѯ
	//pn����ʾ��ǰ�˴��ݵڼ�ҳ��Ĭ���ǵ�һҳdefaultValue="1"
	//@RequestMapping("/emps")
	public String getEmps(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) throws Exception {
		// �ⲻ��һ����ҳ��ѯ��
		// ����PageHelper��ҳ���
		//�ڲ�ѯ֮ǰ����Ҫ���ã�����ҳ�룬�Լ�ÿҳ�Ĵ�С:PageHelper.startPage(pn, 5):��ʾ����pnҳ��ÿҳ��ʾ5������
		PageHelper.startPage(pn, 5);
		// startPage��������������ѯ����һ����ҳ��ѯ
		List<Employee> emps = employeeService.getAll();
		// ʹ��pageInfo��װ��ѯ��Ľ����ֻ��Ҫ��pageInfo����ҳ������ˡ�
		//page���װ����ϸ�ķ�ҳ��Ϣ���������ǲ�ѯ����������.����������ʾ��ҳ��Ϊ5ҳ
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
