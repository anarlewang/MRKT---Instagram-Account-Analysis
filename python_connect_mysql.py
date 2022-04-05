#!pip install sqlalchemy
#!pip install pymysql
import sqlalchemy 
import pymysql

# Connection details
user = "admin"
password = "tuIzaqrAKLMe32G0"
host = "instagram-data-db.csik1hfjt1qb.us-east-1.rds.amazonaws.com"
port = 3306
db = "instagram_data"
connection_engine = sqlalchemy.create_engine('mysql+pymysql://' + user + ':' + password + '@' + host + ':' + str(port) + '/' + db , echo=True)
# You can use user, password, port and db info to connect via MySQL Workbench

# Write your SQL through this way in Python (returns a Pandas dataframe)
data = pd.read_sql('select * from ins_account_data',con=connection_engine)
