use estore;

call usp_AddConstraintForeignKey("FK_Review_Client", "Review", "ClientID", "Client", "ClientID");

call usp_AddConstraintForeignKey("FK_Review_Product", "Review", "ProductID", "Product", "ProductID");