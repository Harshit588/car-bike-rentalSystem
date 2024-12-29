package com.carrental.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.carrental.model.Booking;
import com.carrental.model.User;
import com.carrental.model.Vehicle;

public class HibernateUtil {

	private static SessionFactory sessionFactory = null;
	private static Session session;

	static {
		sessionFactory = new Configuration().configure()
				.addAnnotatedClass(User.class)
				.addAnnotatedClass(Booking.class)
				.addAnnotatedClass(Vehicle.class)
				.buildSessionFactory();
	}

	public static Session getSession() {
		if (sessionFactory != null) {
			session = sessionFactory.openSession();
		}
		return session;
	}

}