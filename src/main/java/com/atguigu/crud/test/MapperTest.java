package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**
 * @author: Cxg
 * @date:2018-8-8 下午7:50:13
 * @version :
 * @方法描述:测试dao层工作
 */
//注解测试类
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired 
	SqlSession sqlSession;
	@Test
	public void testCRUD() {
		//1、插入部门
//		departmentMapper.insertSelective(new Department(3,"开发"));
//		departmentMapper.insertSelective(new Department(null,"开发2"));
		//2、生成员工数据，测试员工
//		employeeMapper.insertSelective(new Employee(2, "cxg", "m", "222@qq.com", 1));
		//3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession。
		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid=UUID.randomUUID().toString().substring(0, 5);
			
			mapper.insertSelective(new Employee(null,uid, "m", uid+"@atguigu.com", 1));
		}
		System.out.println("完成");
	}

}
