package com.atguigu.crud.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.EmployeeMapper;
import com.atguigu.crud.service.EmployeeService;

/**
 * @author: Cxg
 * @date:2018-8-9 ����6:21:48
 * @version :
 * @��������:
 */
@Service
public class EmployeeServiceImpl implements EmployeeService{
	@Autowired
	EmployeeMapper employeeMapper;
	
	/***
	 * ��ѯ����Ա��
	 */
	@Override
	public List<Employee> getAll() throws Exception {
		
		return employeeMapper.selectByExampleWithDept(null);
	}
	
}
