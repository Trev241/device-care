package service;

import java.sql.*;
import java.util.*;

import util.DatabaseConnection;
import util.Product;

public class ProductDao {


    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.serial_no, p.purchase_date, pt.name AS product_type_name "
                + "FROM products p "
                + "JOIN product_types pt ON p.product_type_id = pt.product_type_id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            // Iterate over result set and create User objects
            while (rs.next()) {
            	Product product = new Product();
            	product.setSerialNo(rs.getString("serial_no"));
                product.setPurchaseDate(rs.getDate("purchase_date"));
                product.setProductTypeName(rs.getString("product_type_name"));
                productList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }
    
    public List<Product> searchProducts(String searchQuery) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.serial_no, p.purchase_date, pt.name AS product_type_name "
                + "FROM products p "
                + "JOIN product_types pt ON p.product_type_id = pt.product_type_id "
                + "WHERE p.serial_no LIKE ? OR pt.name LIKE ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            String searchPattern = "%" + searchQuery + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setSerialNo(rs.getString("serial_no"));
                    product.setPurchaseDate(rs.getDate("purchase_date"));
                    product.setProductTypeName(rs.getString("product_type_name"));
                    productList.add(product);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }
}
