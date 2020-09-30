import subprocess as sp
import pymysql
import pymysql.cursors
from tabulate import tabulate
import os

from dotenv import load_dotenv
load_dotenv()

MYSQL_USERNAME = os.getenv("MYSQL_USERNAME")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
DB_NAME = os.getenv("DB_NAME")
MYSQL_HOST = os.getenv("MYSQL_HOST")


def showLeagueTable():
    query = "SELECT `Name`, `W` + `L` + `D` AS `MP`, `W`, `L`, `D`, `GF`, `GA`, `GF` - `GA` AS `GD`, 3 * `W` + `D` AS `Points` FROM CLUBS ORDER BY `Points` DESC,`GD` DESC,`GF` DESC"
    cur.execute(query)
    table = cur.fetchall()
    print("Current League Standings")
    print()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def clubPlayers():
    print("To Do")


def goalsScored():
    print("To Do")


def managerInfo():
    print("To Do")


def goalSaved():
    print("To Do")


def updatePlayerGoals():
    print("To Do")


def insertMatch():
    print("To Do")


def updateContractLength():
    print("To Do")


def dispatch(ch):
    if ch == 1:
        showLeagueTable()
    elif ch == 2:
        clubPlayers()
    elif ch == 3:
        goalsScored()
    elif ch == 4:
        managerInfo()
    elif ch == 5:
        goalsSaved()
    elif ch == 6:
        updatePlayerGoals()
    elif ch == 7:
        insertMatch()
    elif ch == 8:
        updateContractLength()


while True:
    tmp = sp.call('clear', shell=True)

    try:
        con = pymysql.connect(host=MYSQL_HOST, user=MYSQL_USERNAME,
                              password=MYSQL_PASSWORD, db=DB_NAME, cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear', shell=True)

        if con.open:
            print("Successfully Connected to the Database")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE > ")

        with con.cursor() as cur:
            while True:
                tmp = sp.call('clear', shell=True)
                print("Premier League CLI")
                print("----------Queries----------")
                print("1. View League Table")
                print("2. Club Players")
                print("3. Goals Scored Stats")
                print("4. Manager Info")
                print("5. Goals Saved Stats")
                print("----------Updates----------")
                print("6. Update Goals Scored by a Player")
                print("7. Insert New Match")
                print("8. Update Player Contract Lenght")
                print("----------Others----------")
                print("9. Logout")
                ch = 100
                while ch > 9:
                    try:
                        ch = int(input("Enter choice > "))
                        if ch > 9:
                            continue
                    except ValueError:
                        continue
                    tmp = sp.call('clear', shell=True)
                if ch == 9:
                    exit(0)
                else:
                    dispatch(ch)
                    tmp = input("Enter any key to CONTINUE > ")

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print("Connection Refused: Either username or password is incorrect or you don't have the permissions to access the database")
        tmp = input("Enter any key to Retry or type 'quit' to exit: ")
        if tmp == "quit":
            break
