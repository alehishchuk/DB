use estore;

call usp_AddConstraintAlternateKey("AK_Product_Name", "Product", "Name");

call usp_AddConstraintAlternateKey("AK_Product_Brand", "Product", "Brand");

call usp_AddConstraintForeignKey("FK_Product_CatalogSection", "Product", "CatalogID", "CatalogSection", "CatalogSectionID");

call usp_AddConstraintForeignKey("FK_Product_Employee", "Product", "EmployeeID", "Employee", "EmployeeID");

call usp_AddConstraintForeignKey("FK_Product_ProductState", "Product", "State", "ProductState", "ProductStateID");