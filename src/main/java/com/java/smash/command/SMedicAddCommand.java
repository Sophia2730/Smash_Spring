package com.java.smash.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.java.smash.dao.MedicDao;

public class SMedicAddCommand implements SCommand {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String employeeNumber = request.getParameter("employeeNumber");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String belong = request.getParameter("belong");
		String contact = request.getParameter("contact");
		String address = request.getParameter("address");
		String birth = request.getParameter("birth");
		
		MedicDao dao = new MedicDao();
		dao.insert(employeeNumber, id, password, name, belong, contact, address, birth); 
	}

}