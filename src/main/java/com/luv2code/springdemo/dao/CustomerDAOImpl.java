package com.luv2code.springdemo.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.luv2code.springdemo.entity.Customer;

@Repository
public class CustomerDAOImpl implements CustomerDAO {

	// need to inject the session factory
	@Autowired
	private SessionFactory sessionFactory;

	public List<Customer> getCustomers() {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// create a query
		Query<Customer> theQuery = currentSession.createQuery("from Customer c order by c.lastName", Customer.class);

		// execute query and get result list
		List<Customer> customers = theQuery.getResultList();

		// return the results
		return customers;

	}

	public void saveCustomer(Customer theCustomer) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// save/update the customer
		currentSession.saveOrUpdate(theCustomer);

	}

	public Customer getCustomer(int theId) {
		//get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		//get student
		Customer theCustomer = currentSession.get(Customer.class, theId);
		//return customer
		return theCustomer;
		
	}

	public void deleteCustomer(int theId) {
		
		//get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		//delete student with primary key
		Query theQuery = 
				currentSession.createQuery("delete from Customer where id=:customerId");
		theQuery.setParameter("customerId", theId);
	
		theQuery.executeUpdate();
		
	}

	public List<Customer> searchCustomers(String theSearchName) {
		// 
		//get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		Query<Customer> theQuery = null;
		if (theSearchName != null &&theSearchName.trim().length()>0) {
			theQuery = currentSession.createQuery("from Customer where lower(firstName) like :theName or lower(lastName) like :theName");
			theQuery.setParameter("theName", "%"+ theSearchName.toLowerCase() + "%");
			List<Customer> theCustomers= theQuery.getResultList();
			return theCustomers;
		}
		else {
			return getCustomers();
		}
	}

}
