use estore;

call usp_AddConstraintAlternateKey("AK_CatalogSection_Name", "CatalogSection", "Name");

call usp_AddConstraintForeignKey("FK_CatalogSection_CatalogSection", "CatalogSection", "Catalog", "CatalogSection", "CatalogSectionID");
//не создается
call usp_AddConstraintForeignKey("FK_CatalogSection_Employee", "CatalogSection", "DirectorID", "Employee", "EmployeeID");