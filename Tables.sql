CREATE DATABASE DB19_10_23
use DB19_10_23
CREATE TABLE tags(
    Id INTEGER IDENTITY(1,1)PRIMARY KEY,
    tag_name VARCHAR(255),
    icon TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_bu UNIQUEIDENTIFIER,
)

SELECT * FROM tags;

CREATE TABLE categories(
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    parent_Id UNIQUEIDENTIFIER ,
    category_name VARCHAR(255),
    category_description TEXT,
    icon TEXT,
    Image_path TEXT,
    active BIT,
    created_at DATETIME,
    updated_at DATETIME,
    created_by UNIQUEIDENTIFIER,
    updated_bu UNIQUEIDENTIFIER,
)
SELECT * FROM categories;

CREATE TABLE staff_accounts(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  phone_number VARCHAR(100),
  email VARCHAR(255),
  password_hash TEXT,
  active BIT,
  profile_Img TEXT,
  registered_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)

SELECT * FROM staff_accounts;

CREATE TABLE notifications(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  account_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES staff_accounts(Id) ,
  title VARCHAR(100),
  content TEXT,
  seen BIT,
  created_at DATETIME,
  receive_time DATETIME,
  notification_expiry_date DATETIME,

)

-- 

CREATE Table products(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  product_name varchar(255),
  SKU varchar(255),
  regular_price numeric,
  discount_price numeric,
  quantity integer,
  short_description varchar(165),
  product_description text,
  product_weight numeric,
  product_note varchar(255),
  published BIT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)

-- 

CREATE Table product_tags(
  tag_Id INTEGER FOREIGN KEY REFERENCES tags(Id),
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
)
-- 
CREATE Table product_categories(
  category_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES categories(Id),
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
)
-- 
CREATE TABLE roles (
  Id INTEGER IDENTITY(1,1) PRIMARY KEY ,
  role_name varchar(255),
  privileges text,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)
-- 

CREATE Table staff_roles(
  staff_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES staff_accounts(id),

  role_Id integer FOREIGN KEY REFERENCES roles(Id),
)
-- 
CREATE Table attributes(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  attribute_name varchar(255),
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,

)
-- 
CREATE Table product_attributes(
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
  attribute_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES attributes(Id),
)

-- 

CREATE Table attribute_values(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  attribute_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES attributes(Id),
  attribute_value varchar(255),
  color varchar(50),
)
-- 
CREATE Table variant_attribute_values(
  variant_attribute_value_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES variants(Id),
  attribute_value_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES attribute_values(Id),
)

CREATE TABLE variants(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  variant_attribute_value_Id UNIQUEIDENTIFIER ,
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
)

-- 

CREATE TABLE variant_values(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  variant_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES variants(Id),
  price NUMERIC,
  quantity INTEGER,
)

CREATE Table slideshows(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  destination_url text,
  Image_url text,
  clicks INTEGER,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)

-- 

CREATE Table orders(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  coupon_id integer,
  customer_id UNIQUEIDENTIFIER,
  order_status_Id INTEGER,
  order_approved_at DATETIME,
  order_delivered_carrier_date DATETIME,
  order_delivered_customer_date DATETIME,
  created_at DATETIME,
)

-- 

CREATE Table coupons(
  Id UNIQUEIDENTIFIER PRIMARY KEY FOREIGN KEY REFERENCES orders(Id),
  code varchar(255),
  coupon_description text,
  discount_value numeric,
  discount_type varchar(50),
  times_used integer,
  max_usage integer,
  coupon_start_date DATETIME,
  coupon_end_date DATETIME,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)

CREATE Table product_coupons(
  coupon_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES coupons(Id),
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
)
-- 



CREATE Table galleries(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
  Image_path text,
  thumbnail BIT,
  display_order INTEGER,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)

CREATE Table sells(
  Id UNIQUEIDENTIFIER PRIMARY KEY ,
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
  price REAL,
  quantity INTEGER,
)

-- 

CREATE Table shippings(
  Id INTEGER PRIMARY KEY ,
  name text,
  active BIT,
  Icon_path text,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)
CREATE Table order_Items(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
  order_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES orders(Id),
  price NUMERIC,
  quantity integer,
  shipping_Id integer FOREIGN KEY REFERENCES shippings(Id), 
)

CREATE Table product_shippings(
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
  shipping_Id INTEGER FOREIGN KEY REFERENCES shippings(Id),
  ship_charge numeric,
  free BIT,
  estimated_days numeric,

)

CREATE Table order_statuses(
  Id UNIQUEIDENTIFIER PRIMARY KEY FOREIGN KEY  REFERENCES orders(Id),
  status_name varchar(255),
  color varchar(50),
  privacy varchar(50),
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER,
)

CREATE Table customers(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  first_name varchar(100),
  last_name varchar(100),
  phone_number varchar(255),
  email text,
  password_hash text,
  active BIT,
  registered_at DATETIME,
  created_at DATETIME,
)

CREATE Table cards(
  card_Id UNIQUEIDENTIFIER  PRIMARY KEY, 
  customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES customers(Id),
)
CREATE Table card_Items(
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  card_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES cards(card_Id),
  product_Id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES products(Id),
  quantity INTEGER,
)


CREATE Table customer_address(
  Id UNIQUEIDENTIFIER PRIMARY KEY ,
  customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES customers(Id),
  address_line1 text,
  address_line2 text,
  postal_code varchar(255),
  country varchar(255),
  city varchar(255),
  phone_number varchar(255),
)