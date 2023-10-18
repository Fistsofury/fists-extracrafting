CREATE TABLE IF NOT EXISTS `crafting_xp` (
    `charidentifier` VARCHAR(255) NOT NULL,
    `category` VARCHAR(255) NOT NULL,
    `xp` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`charidentifier`, `category`)
);
