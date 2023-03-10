import mysql.connector

# Connect to the database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="spj"
)

# Create a cursor object
cursor = db.cursor()

# Read the SQL file
with open("path/to/file.sql", 'r') as f:
    sql = f.read()

# Execute the SQL commands
cursor.execute(sql)

# Commit the changes to the database
db.commit()

# Read data from text files
with open("Databases/supplier.txt") as f:
    supplier_data = f.readlines()
with open("Databases/shipment.txt") as f:
    shipment_data = f.readlines()
with open("Databases/project.txt") as f:
    project_data = f.readlines()
with open("Databases/part.txt") as f:
    part_data = f.readlines()

# Iterate over each line of data and insert it into the corresponding table
for line in supplier_data:
    columns = line.strip().split(" ")
    cursor.execute("INSERT INTO supplier VALUES (%s, %s, %s, %s)", columns)

for line in project_data:
    columns = line.strip().split(" ")
    cursor.execute("INSERT INTO project VALUES (%s, %s, %s)", columns)

for line in part_data:
    columns = line.strip().split(" ")
    cursor.execute("INSERT INTO part VALUES (%s, %s, %s, %s, %s)", columns)

for line in shipment_data:
    columns = line.strip().split(" ")
    cursor.execute("INSERT INTO shipment VALUES (%s, %s, %s, %s)", columns)

# Commit the changes to the database
db.commit()

# Close the cursor and database connection
cursor.close()
db.close()
