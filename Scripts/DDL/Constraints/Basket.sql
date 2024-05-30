use estore;

call usp_AddConstraintForeignKey("FK_Basket_Client", "Basket", "ClientID", "Client", "ClientID");

call usp_AddConstraintForeignKey("FK_Basket_Product", "Basket", "ProductID", "Product", "ProductID");