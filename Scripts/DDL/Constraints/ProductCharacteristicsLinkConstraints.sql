use estore;

call usp_AddConstraintForeignKey("FK_ProductCharacteristicsLink_CharacteristicsValue", "ProductCharacteristicsLink", "CharacteristicsID", "Characteristics", "CharacteristicsID");

call usp_AddConstraintForeignKey("FK_ProductCharacteristicsLink_Product", "ProductCharacteristicsLink", "ProductID", "Product", "ProductID");