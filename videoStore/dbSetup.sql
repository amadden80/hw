

-- Host  ec2-54-227-252-82.compute-1.amazonaws.com
-- Database  dckli0k8nh4ndk
-- User  pvmhnpkfkivhhq
-- Port  5432
-- Password  Hide ajSCm09X0lm48MnxzfH12Brgf2

create table videos
(
  id serial8 primary key,
  title varchar(255),
  description text,
  url text,
  genre varchar(255)
);

