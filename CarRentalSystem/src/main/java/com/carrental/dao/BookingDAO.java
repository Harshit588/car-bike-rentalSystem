package com.carrental.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;
import com.carrental.model.Booking;
import com.carrental.util.HibernateUtil;

public class BookingDAO {

    public boolean saveBooking(Booking booking) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession()) {
            // Start a transaction
            transaction = session.beginTransaction();

            // Save the booking object
            session.save(booking);

            // Commit the transaction
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback(); // Rollback in case of an error
            }
            e.printStackTrace();
        }
        return false;
    }
}
