use estore;

call usp_AddConstraintForeignKey("FK_ProductWarehouseLink_Warehouse", "ProductWarehouseLink", "WarehouseID", "Warehouse", "WarehouseID");

call usp_AddConstraintForeignKey("FK_ProductWarehouseLink_Product", "ProductWarehouseLink", "ProductID", "Product", "ProductID");