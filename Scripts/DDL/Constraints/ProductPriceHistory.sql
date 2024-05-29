use estore;

call usp_AddConstraintForeignKey("FK_ProductPriceHistory_Employee", "ProductPriceHistory", "EmployeeID", "Employee", "EmployeeID");

call usp_AddConstraintForeignKey("FK_ProductPriceHistory_Product", "ProductPriceHistory", "ProductID", "Product", "ProductID");