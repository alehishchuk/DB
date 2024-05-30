use estore;

call usp_AddConstraintAlternateKey("AK_Order_Code", "Order", "Code");

call usp_AddConstraintForeignKey("FK_Order_Client", "Order", "ClientID", "Client", "ClientID");

call usp_AddConstraintForeignKey("FK_Order_OrderStatus", "Order", "Status", "OrderStatus", "OrderStatusID");

call usp_AddConstraintForeignKey("FK_Order_Warehouse", "Order", "WarehouseID", "Warehouse", "WarehouseID");

call usp_AddConstraintForeignKey("FK_Order_PickUpPoint", "Order", "PickUpPointID", "PickUpPoint", "PickUpPointID");