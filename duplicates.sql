--Create table
create table duplicate
(
    id  bigint,
    val text
);

--Generate duplicates
insert into duplicate
select generate_series(1, 10), 'some_text_' || trunc(random() * 10);

--list duplicates
select k.id
from (
  select id, val, rank()over (partition by val order by id) as pos
  from duplicate
) as k
where pos >= 2;

--Del duplicates
delete from duplicate
where id in (
  select k.id
  from (
    select id, val, rank()over (partition by val order by id) as pos
    from duplicate
  ) as k
  where pos >= 2
);
