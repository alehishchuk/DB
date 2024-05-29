use estore;

call usp_AddConstraintForeignKey("FK_ProductStateHistory_Employee", "ProductStateHistory", "EmployeeID", "Employee", "EmployeeID");

call usp_AddConstraintForeignKey("FK_ProductStateHistory_Product", "ProductStateHistory", "ProductID", "Product", "ProductID");