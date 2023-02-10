-- list all bands with glam rock as the main stryle ranked by their longetivity

select band_name, (ifnull(split, '2020') - formed) as lifespan from metal_bands where FIND_IN_SET('Glam rock', ifnull(style, "")) > 0 order by lifespan desc;