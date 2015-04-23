# HAVEN
Haven project for Central Services

This repository contains all source code for the Bussines intelligence project, wrote on pl/sql,
the reports created on jasper server and all the database structures.

PREREQUISITES:

* Have a MySql database 5.6 or later
* Have an Instance of Jasper server running (for the data source you need to install jdbc mysql driver or use the default mariadb driver)
* Jasper Studio (optional) to import the reports to Jasper server (you need to install jdbc driver for mysql)


SETUP THE ENVIRONMENT:

* Import the dump file included on the repo into Mysql
* Import the metadata file Haven Full export on jasper

NEXT STEPS:
* Get the data for Openbook, trades and balances comes from a feed and loaded by an ETL process that uses the apropiate stored procedures
  to add records for every table.

