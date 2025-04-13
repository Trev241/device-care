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

import util.Claim;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClaimDao {

    public List<Claim> getAllClaims() {
        List<Claim> claimList = new ArrayList<>();
        String query = "SELECT * FROM claims ORDER BY claim_date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Claim claim = new Claim();
                claim.setClaimId(rs.getInt("claim_id"));
                claim.setClaimDate(rs.getDate("claim_date"));
                claim.setStatus(rs.getString("status"));
                claim.setDescription(rs.getString("description"));
                claim.setSettlement(rs.getInt("settlement"));
                claim.setProductId(rs.getInt("product_id"));
                claimList.add(claim);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return claimList;
    }

    public void updateClaimStatus(int claimId, String newStatus) {
        String query = "UPDATE claims SET status = ? WHERE claim_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, claimId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
