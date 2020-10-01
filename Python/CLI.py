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
    print("Players of a Club: ")
    print()
    clubName = input("Club Name (Leave empty for all Clubs): ")
    if len(clubName):
        query = """SELECT Name FROM CLUBS WHERE `Name` = %s;"""
        cur.execute(query, (clubName))
        res = cur.fetchone()
    else:
        query = """SELECT Name FROM CLUBS;"""
        cur.execute(query)
        res = cur.fetchall()
    if not res:
        print("No Such Club")
        return
    if len(clubName):
        query = """SELECT * FROM PLAYERS WHERE `Club Name` = %s;"""
        cur.execute(query, (clubName))
    else:
        query = """SELECT * FROM PLAYERS;"""
        cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def playerStats():
    ch = 10
    print("Choose a stat: ")
    print("1. Goals Scored")
    print("2. Assists Provided")
    print("3. Tackles Won")
    print("4. Saves")
    print("5. Clean Sheets")
    print("6. Back")
    while ch > 6:
        try:
            ch = int(input("Enter choice > "))
            if ch > 6:
                continue
            elif ch < 1:
                ch = 10
                continue
        except ValueError:
            continue
    if ch == 1:
        goalsScored()
    elif ch == 2:
        assistsProvided()
    elif ch == 3:
        tacklesWon()
    elif ch == 4:
        goalsSaved()
    elif ch == 5:
        cleanSheets()
    else:
        return True


def goalsScored():
    tmp = sp.call('clear', shell=True)
    print("Goals Scored: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_OUTFIELD.`Goals Scored` FROM PLAYERS, PLAYERS_OUTFIELD WHERE PLAYERS.`Club Name` = PLAYERS_OUTFIELD.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_OUTFIELD.`Jersey Number` ORDER BY PLAYERS_OUTFIELD.`Goals Scored` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def assistsProvided():
    tmp = sp.call('clear', shell=True)
    print("Assists Provided: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_OUTFIELD.`Assists Provided` FROM PLAYERS, PLAYERS_OUTFIELD WHERE PLAYERS.`Club Name` = PLAYERS_OUTFIELD.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_OUTFIELD.`Jersey Number` ORDER BY PLAYERS_OUTFIELD.`Assists Provided` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def tacklesWon():
    tmp = sp.call('clear', shell=True)
    print("Tackles Won: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_OUTFIELD.`Tackles Won` FROM PLAYERS, PLAYERS_OUTFIELD WHERE PLAYERS.`Club Name` = PLAYERS_OUTFIELD.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_OUTFIELD.`Jersey Number` ORDER BY PLAYERS_OUTFIELD.`Tackles Won` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def goalsSaved():
    tmp = sp.call('clear', shell=True)
    print("Saves Stats: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_GOALKEEPER.`Saves` FROM PLAYERS, PLAYERS_GOALKEEPER WHERE PLAYERS.`Club Name` = PLAYERS_GOALKEEPER.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_GOALKEEPER.`Jersey Number` ORDER BY PLAYERS_GOALKEEPER.`Saves` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def cleanSheets():
    tmp = sp.call('clear', shell=True)
    print("Saves Stats: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_GOALKEEPER.`Clean Sheets` FROM PLAYERS, PLAYERS_GOALKEEPER WHERE PLAYERS.`Club Name` = PLAYERS_GOALKEEPER.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_GOALKEEPER.`Jersey Number` ORDER BY PLAYERS_GOALKEEPER.`Clean Sheets` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def managerInfo():
    print("Manager of a Club: ")
    print()
    clubName = input("Club Name (Leave empty for all Clubs): ")
    if len(clubName):
        query = """SELECT Name FROM CLUBS WHERE `Name` = %s;"""
        cur.execute(query, (clubName))
        res = cur.fetchone()
    else:
        query = """SELECT Name FROM CLUBS;"""
        cur.execute(query)
        res = cur.fetchall()
    if not res:
        print("No Such Club")
        return
    if len(clubName):
        query = """SELECT * FROM MANAGERS WHERE `Club Name` = %s;"""
        cur.execute(query, (clubName))
    else:
        query = """SELECT * FROM MANAGERS;"""
        cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


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
        return playerStats()
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
                print("2. Player List of a Club")
                print("3. Player Performance Stats")
                print("4. Manager Info")
                print("5. Match Results")
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
                        elif ch < 1:
                            ch = 100
                            continue
                    except ValueError:
                        continue
                tmp = sp.call('clear', shell=True)
                if ch == 9:
                    exit(0)
                else:
                    back = dispatch(ch)
                    if not back:
                        tmp = input("Enter any key to CONTINUE > ")

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print("Connection Refused: Either username or password is incorrect or you don't have the permissions to access the database")
        tmp = input("Enter any key to Retry or type 'quit' to exit: ")
        if tmp == "quit":
            break
