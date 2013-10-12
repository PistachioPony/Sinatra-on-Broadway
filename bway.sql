CREATE TABLE shows (
  id serial primary key,
  title varchar(50), 
  year integer, 
  composer varchar(50), 
  img_url varchar(255) 
);

CREATE TABLE songs (
  id serial primary key,
  title varchar(50),
  embed_url varchar(255),
  show_id integer references shows(id)
);