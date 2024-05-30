use estore;

call usp_AddConstraintForeignKey("FK_OrderEditHistory_Order", "OrderEditHistory", "OrderID", "Order", "OrderID");

call usp_AddConstraintForeignKey("FK_OrderEditHistory_Employee", "OrderEditHistory", "EmployeeID", "Employee", "EmployeeID");