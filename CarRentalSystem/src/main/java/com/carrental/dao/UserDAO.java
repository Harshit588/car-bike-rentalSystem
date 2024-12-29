package com.carrental.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.carrental.model.User;
import com.carrental.util.HibernateUtil;

public class UserDAO {

	public boolean registerUser(User user) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSession()) {
			transaction = session.beginTransaction();

			// Save the user object
			session.save(user);

			transaction.commit();
			return true;
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
			return false;
		}
	}

	public User validateUser(String email, String password) {
		try (Session session = HibernateUtil.getSession()) {
			String hql = "FROM User WHERE email = :email AND password = :password";
			Query<User> query = session.createQuery(hql, User.class);
			query.setParameter("email", email);
			query.setParameter("password", password);

			return query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
