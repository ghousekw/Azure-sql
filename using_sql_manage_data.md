# Using SQL to Manage Database Objects
## Introduction
- One exciting feature of Azure is the ability to quickly spin up globally accessible databases. This gives a SQL professional great agility in creating database backends or allowing multiple distributed teams to report off of our enterprise data.

- To begin working with our sample dataset we must log in to the Azure portal and create a SQL database. We then need to connect to the database and begin working with it using a tool such as Visual Studio Code, Azure Query Editor, or one of several others.

- In this scenario, our analytics group has requested a few updates to improve reporting on the Product information. First, a frequently used operation is to search by product name and color, so they'd like the performance of that type of query improved. Second, they'd like the view for product descriptions to include the product number information in addition to its current fields. And lastly, they'd like the table ErrorLog dropped as it is no longer in use.

- Step-by-step instructions are included in the task list. Feel free to follow along there or jump in to begin managing database objects with SQL!

## Connecting to the Lab
1. Log in to the Azure Portal using the credentials provided on the lab instructions page.
## Create a SQL Database
1. Click SQL databases.

1. Click Create SQL database.

1. Click the combo box next to Resource group and select the available resource group.

1. In the box next to Database name, enter "manage_lab".

1. Click Create new under the text box next to Server.

1. In the frame that appears, enter "la-sql-lab-manage" in the box under Server name.

1. Provide a login in the box under Server admin login.

1. Provide a password in the box under Password and enter the same password in the box under Confirm password.

1. Under Location, click the combo box and pick a nearby region.

1. Click OK.

1. Back in the main window, click Configure database.

1. Click the window at the top that says Looking for basic, standard, premium?.

1. Click Apply.

1. Click Next: Additional settings.

1. Under Data source, make sure Use existing data is set to Sample.

1. Click Review + create.

1. Click Create.

## Connect Our Client
1. Click Go to resource.

1. Click Set server firewall at the top of the frame.

1. Click Add client IP at the top of the pop-up window.

1. Click Save.

1. Back in the main window, copy the Server name to the clipboard.

    - The next steps in this lab go through specifically using Visual Studio Code. Other programs can be used but might result in some slight differences in the instructions. Alternatively, you can also use Query Editor (currently in preview). That can be found in the left pane of your Azure SQL Database page.

1. Create a new document.

1. Click Plain Text at the bottom of the window.

1. Change the text type to SQL.

1. Click the window at the top and select Create Connection Profile.

1. Paste the server name copied in a previous step and press Enter.

1. For the database name, enter "manage_lab" without quotes and press Enter.

1. Select SQL Login.

1. Log in using the credentials provided in the previous task.

1. Choose Yes to save the password.

1. Name the profile "manage_lab" without quotes and press Enter.

## Create an Index for Product Name and Color
1. Create the index.
```
    CREATE INDEX IX_Product_NameAndColor
    ON SalesLT.Product (Name, Color)
```
2. Verify the index.
```
    select * from sys.indexes
    where name = 'IX_Product_NameAndColor'
```
## Update the Product Description View
1. Check the current view.
```
    select * from SalesLT.vProductAndDescription
```
2. Alter the view for the product description.
```
ALTER VIEW SalesLT.vProductAndDescription
        AS
        SELECT
            p.ProductID
            ,p.ProductNumber
            ,p.Name
            ,pm.Name AS ProductModel
            ,pmx.Culture
            ,pd.Description
        FROM SalesLT.Product p
            INNER JOIN SalesLT.ProductModel pm
            ON p.ProductModelID = pm.ProductModelID
            INNER JOIN SalesLT.ProductModelProductDescription pmx
            ON pm.ProductModelID = pmx.ProductModelID
            INNER JOIN SalesLT.ProductDescription pd
            ON pmx.ProductDescriptionID = pd.ProductDescriptionID;

        GO
```
3. Verify the changes.
```    
    select * from SalesLT.vProductAndDescription
```
## Delete the Unused ErrorLog Table
1. Drop the ErrorLog table.
```
    DROP TABLE dbo.ErrorLog
```
2. Verify the table no longer exists.
```
    select * from sys.tables
```