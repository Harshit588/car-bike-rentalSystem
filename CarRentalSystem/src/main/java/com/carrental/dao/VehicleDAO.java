package com.carrental.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.carrental.model.Vehicle;
import com.carrental.util.HibernateUtil;

public class VehicleDAO {

	public void saveVehicle(Vehicle vehicle) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSession()) {
			transaction = session.beginTransaction();
			session.save(vehicle);
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		}
	}

	public List<Vehicle> getAllVehicles() {
		try (Session session = HibernateUtil.getSession()) {
			return session.createQuery("from Vehicle", Vehicle.class).list();
		}
	}

	public Vehicle getVehicleById(int id) {
		try (Session session = HibernateUtil.getSession()) {
			return session.get(Vehicle.class, id);
		}
	}
}
