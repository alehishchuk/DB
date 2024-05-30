use estore;

call usp_AddConstraintForeignKey("FK_OrderStatusHistory_Order", "OrderStatusHistory", "OrderID", "Order", "OrderID");

call usp_AddConstraintForeignKey("FK_OrderStatusHistory_Employee", "OrderStatusHistory", "EmployeeID", "Employee", "EmployeeID");

call usp_AddConstraintForeignKey("FK_OrderStatusHistory_OrderStatus", "OrderStatusHistory", "OrderStatusID", "OrderStatus", "OrderStatusID");