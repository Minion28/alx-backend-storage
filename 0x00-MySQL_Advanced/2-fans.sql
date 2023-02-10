--rank country origins by bands ordered by number of non-unique fans
select origin, sum(fans) as nb_fans from metal_bands group by origin order by nb_fans desc;