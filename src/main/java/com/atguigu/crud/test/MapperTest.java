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
 * @date:2018-8-8 ����7:50:13
 * @version :
 * @��������:����dao�㹤��
 */
//ע�������
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
		//1�����벿��
//		departmentMapper.insertSelective(new Department(3,"����"));
//		departmentMapper.insertSelective(new Department(null,"����2"));
		//2������Ա�����ݣ�����Ա��
//		employeeMapper.insertSelective(new Employee(2, "cxg", "m", "222@qq.com", 1));
		//3������������Ա����������ʹ�ÿ���ִ������������sqlSession��
		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid=UUID.randomUUID().toString().substring(0, 5);
			
			mapper.insertSelective(new Employee(null,uid, "m", uid+"@atguigu.com", 1));
		}
		System.out.println("���");
	}

}
