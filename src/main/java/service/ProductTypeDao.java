/************************************************************
 * Copyright 2025 Humber
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy
 * of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 ************************************************************/

package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseConnection;
import util.ProductType;

public class ProductTypeDao {
    public void insertProductType(ProductType productType) {
        String query = "INSERT INTO product_types (name, model, discontinued) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, productType.getName());
            stmt.setString(2, productType.getModel());
            stmt.setInt(3, productType.getDiscontinued());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ProductType> getAllProductTypes() {
        List<ProductType> types = new ArrayList<>();
        String query = "SELECT * FROM product_types";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ProductType pt = new ProductType();
                pt.setName(rs.getString("name"));
                pt.setModel(rs.getString("model"));
                pt.setDiscontinued(rs.getInt("discontinued"));
                types.add(pt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return types;
    }
    
    public ProductType getProductTypeByName(String name) {
        String query = "SELECT * FROM product_types WHERE name = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new ProductType(
                    rs.getString("name"),
                    rs.getString("model"),
                    rs.getInt("discontinued")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProductTypeByName(String originalName, ProductType type) {
        String query = "UPDATE product_types SET name = ?, model = ?, discontinued = ? WHERE name = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, type.getName());
            stmt.setString(2, type.getModel());
            stmt.setInt(3, type.getDiscontinued());
            stmt.setString(4, originalName);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
