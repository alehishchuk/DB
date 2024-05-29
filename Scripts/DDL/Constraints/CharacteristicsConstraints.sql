use estore;
//что неправильно с созданием первого ограничения
call usp_AddConstraintForeignKey("FK_Characteristics_CharacteristicsValue", "Characteristics", "CharacteristicsValue", "CharacteristicsValue", "ProductID");

call usp_AddConstraintForeignKey("FK_Characteristics_Product", "Characteristics", "ProductID", "Product", "ProductID");