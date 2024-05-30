use estore;

call usp_AddConstraintForeignKey("FK_OrderProductLink_Order", "OrderProductLink", "OrderID", "Order", "OrderID");

call usp_AddConstraintForeignKey("FK_OrderProductLink_Product", "OrderProductLink", "ProductID", "Product", "ProductID");