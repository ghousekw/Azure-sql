# Using SQL to Retrieve Data
## Introduction

In this hands-on lab, we are going to work with various methods of selecting data.

### Solution

Log in to the Azure Portal with the provided username and password in the Credentials section of the Hands-On Lab page.

## Create a SQL Database
1. On the Home page, click SQL databases.
2. Click Create sql database.
3. Under Resource group, do not click Create new and name it because the lab already provides one for us to select.
4. Assign a Database name e.g. sql_lab.
5. Under Server click Create new.
6. Assign a Server name.
7. Assign an Admin login.
8. Assign a Password, following the requirements.
9. Choose the nearest Location.
10. Click OK.
11. Leave Elastic Pool at No.
12. Click Configure database.
13. Click the area for Basic.
14. Click Apply.
15. Click Next: Additional Settings.
16. Under Use existing data click Sample.
17. Click Review + create.
18. Double-check everything and click Create.

After a short time, we will have a fully functional SQL database preloaded with data that's ready to go!

>Note: If we will be connecting from our client machine rather than the Azure Query Editor, take these additional steps:

19. Click Go to resource.

20. Click Set server firewall at the top.
21. Click Add client IP.
22. Add the public IP address (it may autofill).
23. Click Save.

## Connect Your Client

1. Go to the Overview page for the SQL database.

> Note: We can return to the page also by clicking SQL databases in the far left pane, and then on the database name. Or we can use the breadcrumb menu at the top.

2. If we want to avoid potential connection issues and use a simple editor, click Query editor which is currently in preview.

3. If you'd rather use a local client, follow these steps (for the purposes of this example, we are going to assume Visual Studio Code is being used.)
    1. Download and install Visual Studio Code.(https://code.visualstudio.com/)
    2. Install the MSSQL extension.
        1. Click on the Extensions icon on the far left-hand side.
        2. Search for MSSQL, click on it, and then click Install.
4. Open a new window, and change the type by clicking on Plain Text at the bottom right and choosing SQL.
5. In the same area, click Disconnected.
6. In the top pane that pops up choose Create Connection Profile.
7. Copy/paste the Server name from the database Overview page and hit Enter.
8. Type or copy/paste the Database name and hit Enter.
9. Choose SQL Login and hit Enter.
10. Enter the Admin login that was specified earlier and hit Enter.
11. Enter the Password that was specified earlier and hit Enter.
12. Choose whether or not to save the password and hit Enter.
13. Type a Profile Name and hit Enter.

>Note: In the bottom right, we should see a message saying that the profile has been created and indicating our connected status.

Now let's have some fun!

## List the Database Tables
1. Let's start by finding out what tables are in our database to work with. Use the query below to list those tables from a system view:
```
    SELECT name FROM sys.tables
```

## Use a Join to Show the Tables' Schema
1. Without knowledge of which schema a table belongs to we cannot properly query it. Use the query below to associate the table name with its schema name:
```
    SELECT t.name as TableName, s.name as SchemaName
    FROM sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
```

## List Silver Bicycles
1. Looking at the tables we can see that there is an associated ProductCategory table. Use the query below to pull a list of products that filters via the correct category ID for bicycles and the color Silver:
```
    SELECT *
    FROM SalesLT.Product p
    LEFT JOIN SalesLT.ProductCategory c ON p.ProductCategoryID = c.ProductCategoryID
    WHERE c.ProductCategoryID = 5
    AND p.Color = 'Silver'
```
## Narrow Down the List to Items Under $1000 and Sort by Least to Most Expensive
1. We will expand on the last query by adding additional WHERE conditions and an ORDER BY. Use the following:
```
    SELECT *
    FROM SalesLT.Product p
    LEFT JOIN SalesLT.ProductCategory c ON p.ProductCategoryID = c.ProductCategoryID
    WHERE c.ProductCategoryID = 5
    AND p.Color = 'Silver'
    AND p.ListPrice < 1000
    ORDER BY p.ListPrice ASC
```