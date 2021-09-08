# Using SQL to Change Data
## Introduction
SQL is a powerful language for querying, changing, and deleting data. Almost every discipline in IT will encounter SQL queries at some point. Being familiar with how to use it effectively can help people to achieve greater success in their current role, and possibly even set them up for a move to another role.

In this hands-on lab we are going to work with methods of changing data. This includes inserts, updates, and deletes.

One exciting feature of Azure is the ability to quickly spin up databases that are globally accessible. This gives an SQL professional great agility in creating database backends. It also allows multiple, distributed teams to create reports based on the enterprise data.

To begin working with our sample dataset we're going to log into the Azure portal and create a SQL database. Then we'll use Visual Studio Code, Azure Query Editor, or another tool to connect to the database and begin working with it.

## The Scenario
In our scenario, a customer is getting disappointing results from our front end sales system. To assist them (and hopefully retain their business in the future), we are going to directly intervene in the database. This will require creating a customer record for them, updating that record with an e-mail address, and ultimately removing the record entirely at their request.

>(Note: Be sure to check out our interactive diagram for hidden knowledge!) https://www.lucidchart.com/documents/view/ba8f57ff-c53b-43ec-8407-d592369b67af

## Logging In
Use the credentials provided in the hands-on lab overview page to log into the Azure portal.

## Create an SQL Database
1. On the Home page, click on SQL databases.
2. Click Create sql database.
3. The Subscription dropdown is auto-populated, but there's a resource group sitting in the Resource group dropdown that we'll have to choose.
4. Assign a Database name, something unique, like change_data.
5. Under Server, click Create new:
    - Assign a Server name (must be globally unique)
    - Assign an Admin login
    - Assign a Password, following the requirements.
    - Choose a Location near you.
    - Click OK.
6. Leave Elastic Pool at No.
7. Click Configure database.
    - Click the area for Basic.
    - Click Apply.
8. Click Next: Additional Settings.
    - Under Use existing data click Sample.
9. Click Review + create.
10. Double-check everything and click Create.

After a short time, you will have a fully functional SQL database preloaded with data and ready to go!

>Note: If you will be connecting from your client machine rather than using the Azure Query Editor, take these additional steps.

1. Click the Go to resource button.
2. Click Set server firewall at the top.
3. Click Add client IP.
4. Add your public IP address (it may autofill for you).
5. Click Save.

## Connect Your Client
1. Go to the Overview page for your SQL database. (If you've navigated away, return by clicking SQL databases in the far left pane, then on your database name. Or use the breadcrumb menu at the top.):
    - We need the Server name there, and we can click on the little "Copy to clipboard" button to grab it for later use.
    - If you'd like to avoid potential connection issues and use a simple editor, click on Query editor, which is currently in preview.
2. If you'd rather use a local client, follow these steps (for the purposes of this example, we are going to assume Visual Studio Code is being used):
    - Download and install Visual Studio Code.(https://code.visualstudio.com/):
        - Install the MSSQL extension:
            - Click on the Extensions icon on the far left side.
            - Search for MSSQL, click on it, and click Install.
3. Open a new window, and change the type by clicking on Plain Text at the bottom right, then choosing SQL (by typing it) in the Select Language Mode text area at the top of the screen.
4. On the same screen, down where we clicked Plain Text a second ago, click on Disconnected.
5. In the top pane that pops up, choose Create Connection Profile:

    - Paste the Server name that we copied from our database overview page and hit Enter.
    - Type or paste (we'd have to copy it from the overview page as well, in order to paste) our Database name and hit Enter.
    - Choose SQL Login and hit Enter.
    - Enter the Admin login you specified earlier and hit Enter.
    - Enter the Password you specified earlier and hit Enter.
    - Choose whether or not you'd like to save the password and hit Enter.
    - Type a Profile Name and hit Enter.

In the bottom right you should see a message saying that the profile has been created and that you are connected. Now let's have some fun!

## List the Database Tables
1. Let's start by finding out what tables are in our database to work with. Use the query below to list those tables and their associated schemas from a system view:
```
    SELECT t.name as TableName, s.name as SchemaName
    FROM sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
```
## Add Another Customer
1. A new customer's registration failed, so we need to update the Customer table manually. Use the statement below to add the disgruntled customer Delmar Database with a few minimal fields:
```
    INSERT INTO SalesLT.Customer (FirstName, MiddleName, LastName, PasswordHash, PasswordSalt)
    VALUES ('Delmar', 'D.', 'Database', 'oMm8YHksV5Ejn8wACj3H', 'zr2at1t3')
```

## Update the Customer's Email Address
1. Unfortunately, the sales system placed Delmar's order and neglected to record his email address. So he has not been receiving updates on his order. Update his address manually to avoid another issue with the sales system, and hopefully preserve a valued customer:
```
    UPDATE SalesLT.Customer
    SET EmailAddress = 'delmar@linuxacademy.com'
    WHERE FirstName = 'Delmar' AND LastName = 'Database'
```
Now let's check to make sure the change worked:
```
    SELECT FirstName, EmailAddress
    FROM SalesLT.Customer
    WHERE FirstName = 'Delmar'
```
We should see his name and email address pop up in the query results.

## Delete the Customer's Record
1. Poor Delmar. None of his orders have been successful. Now he's had it, and wishes his account to be completely deleted. As our product team works overtime to fix the dastardly sales system, we will happily comply with Delmar's request to remove his account using the statement below:
```
    DELETE FROM SalesLT.Customer
    WHERE FirstName = 'Delmar' AND LastName = 'Database'
```
Let's verify this was effective too:
```
    SELECT * FROM SalesLT.Customer
    WHERE FirstName = 'Delmar' AND LastName = 'Database'
```