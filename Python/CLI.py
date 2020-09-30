import subprocess as sp
import pymysql
import pymysql.cursors
import os

from dotenv import load_dotenv
load_dotenv()

MYSQL_USERNAME = os.getenv("MYSQL_USERNAME")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
DB_NAME = os.getenv("DB_NAME")
MYSQL_HOST = os.getenv("MYSQL_HOST")

while(1):
    tmp = sp.call('clear', shell=True)

    try:

        con = pymysql.connect(host=MYSQL_HOST, user=MYSQL_USERNAME,
                              password=MYSQL_PASSWORD, db=DB_NAME, cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear', shell=True)

        if(con.open)
            print("Connected")
        else:
            print("Failed to connect")
        
        tmp = input("Enter any key to CONTINUE>")

        while con:
            cur = con.cursor()
            while(1):
                tmp = sp.call('clear')