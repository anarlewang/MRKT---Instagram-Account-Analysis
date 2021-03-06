#!pip install sqlalchemy
#!pip install pymysql
import sqlalchemy 
import pymysql

# Connection details
user = "***"
password = "***"
host = "*****"
port = 3306
db = "***"
connection_engine = sqlalchemy.create_engine('mysql+pymysql://' + user + ':' + password + '@' + host + ':' + str(port) + '/' + db , echo=True)
# You can use user, password, port and db info to connect via MySQL Workbench

# Write your SQL through this way in Python (returns a Pandas dataframe)
## Show all tables:
pd.read_sql("show tables", con = connection_engine)
## Read in LIWC2015 text table:
text_data = pd.read_sql('select * from ins_text_data',con=connection_engine)
## Read in account info table
instagram_data = pd.read_sql('select * from ins_account_data',con=connection_engine)

