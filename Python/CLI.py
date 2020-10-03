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

connection = pymysql.connect(host=MYSQL_HOST,
                             user=MYSQL_USERNAME, password=MYSQL_PASSWORD, db=DB_NAME,
                             cursorclass=pymysql.cursors.DictCursor)

# Select Queries


def showLeagueTable():
    query = "SELECT `Name`, `W` + `L` + `D` AS `MP`, `W`, `L`, `D`, `GF`, `GA`, `GF` - `GA` AS `GD`, 3 * `W` + `D` AS `Points` FROM CLUBS ORDER BY `Points` DESC,`GD` DESC,`GF` DESC"
    cur.execute(query)
    table = cur.fetchall()
    print("Current League Standings")
    print()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def clubRoster():
    print("Club Roster:")
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
    ch = 1e9
    while ch != 6:
        sp.call('clear', shell=True)
        print("Choose a stat: ")
        print("1. Goals Scored")
        print("2. Assists Provided")
        print("3. Tackles Won")
        print("4. Saves")
        print("5. Clean Sheets")
        print("6. Back")
        while ch > 6 or ch < 1:
            try:
                ch = int(input("Enter choice: "))
            except ValueError:
                continue
            if ch > 6 or ch < 1:
                continue
            elif ch == 6:
                return True
            else:
                sp.call('clear', shell=True)
                playerStatDispatch(ch)
                input("Enter any key to continue")
                ch = 1e9
                break


def playerStatDispatch(ch):
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


def goalsScored():
    print("Goals Scored: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_OUTFIELD.`Goals Scored` FROM PLAYERS, PLAYERS_OUTFIELD WHERE PLAYERS.`Club Name` = PLAYERS_OUTFIELD.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_OUTFIELD.`Jersey Number` AND PLAYERS_OUTFIELD.`Goals Scored` > 0 ORDER BY PLAYERS_OUTFIELD.`Goals Scored` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def assistsProvided():
    print("Assists Provided: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_OUTFIELD.`Assists Provided` FROM PLAYERS, PLAYERS_OUTFIELD WHERE PLAYERS.`Club Name` = PLAYERS_OUTFIELD.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_OUTFIELD.`Jersey Number` AND PLAYERS_OUTFIELD.`Assists Provided` > 0 ORDER BY PLAYERS_OUTFIELD.`Assists Provided` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def tacklesWon():
    print("Tackles Won: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_OUTFIELD.`Tackles Won` FROM PLAYERS, PLAYERS_OUTFIELD WHERE PLAYERS.`Club Name` = PLAYERS_OUTFIELD.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_OUTFIELD.`Jersey Number` AND PLAYERS_OUTFIELD.`Tackles Won` > 0 ORDER BY PLAYERS_OUTFIELD.`Tackles Won` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def goalsSaved():
    print("Saves Stats: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_GOALKEEPER.`Saves` FROM PLAYERS, PLAYERS_GOALKEEPER WHERE PLAYERS.`Club Name` = PLAYERS_GOALKEEPER.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_GOALKEEPER.`Jersey Number` AND PLAYERS_GOALKEEPER.`Saves` > 0 ORDER BY PLAYERS_GOALKEEPER.`Saves` DESC;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


def cleanSheets():
    print("Saves Stats: ")
    print()
    query = """SELECT PLAYERS.`First Name`, PLAYERS.`Last Name`, PLAYERS.`Club Name`, PLAYERS_GOALKEEPER.`Clean Sheets` FROM PLAYERS, PLAYERS_GOALKEEPER WHERE PLAYERS.`Club Name` = PLAYERS_GOALKEEPER.`Club Name` AND PLAYERS.`Jersey Number` = PLAYERS_GOALKEEPER.`Jersey Number` AND PLAYERS_GOALKEEPER.`Clean Sheets` > 0 ORDER BY PLAYERS_GOALKEEPER.`Clean Sheets` DESC;"""
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
    if len(table):
        print(tabulate(table, headers="keys", tablefmt='psql'))
    else:
        print("This Club has no Manager")


def matchResults():
    print("Match Results: ")
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
        query = """SELECT FIXTURES.`Home Club`, MATCHES.`Home Team Score`, FIXTURES.`Away Club`, MATCHES.`Away Team Score` FROM FIXTURES JOIN MATCHES ON FIXTURES.`Match ID` = MATCHES.`Match ID` WHERE FIXTURES.`Home Club` = %s OR FIXTURES.`Away Club` = %s;"""
        cur.execute(query, (clubName, clubName))
    else:
        query = """SELECT FIXTURES.`Home Club`, MATCHES.`Home Team Score`, FIXTURES.`Away Club`, MATCHES.`Away Team Score` FROM FIXTURES JOIN MATCHES ON FIXTURES.`Match ID` = MATCHES.`Match ID`;"""
        cur.execute(query)
    table = cur.fetchall()
    if len(table):
        print(tabulate(table, headers="keys", tablefmt='psql'))
    else:
        print("No matches found for this club")


def viewFixtures():
    print("Fixtures: ")
    print()
    query = """SELECT * FROM FIXTURES;"""
    cur.execute(query)
    table = cur.fetchall()
    print(tabulate(table, headers="keys", tablefmt='psql'))


# Delete Queries
def deletePlayer():
    print("Delete Player: ")
    print()
    clubName = input("Club Name: ")
    jerseyNum = input("Jersey Number: ")

    query = """SELECT * FROM PLAYERS WHERE `Club Name` = %s AND `Jersey Number` = %s;"""
    cur.execute(query, (clubName, jerseyNum))
    table = cur.fetchall()
    if len(table):
        print(tabulate(table, headers="keys", tablefmt='psql'))
    else:
        print("No matches found for this player")
        return

    res = input("Are you sure you want to delete the above entry? [y/n] ")
    if res == "y" or res == "Y":
        query = """DELETE FROM PLAYERS WHERE `Club Name` = %s AND `Jersey Number` = %s;"""
        cur.execute(query, (clubName, jerseyNum))
        connection.commit()
        print("Deleted the requested entry")
    else:
        print("Aborted Delete.")
    return


def deleteManager():
    print("Delete Manager: ")
    print()
    clubName = input("Club Name: ")

    query = """SELECT * FROM MANAGERS WHERE `Club Name` = %s;"""
    cur.execute(query, (clubName))
    table = cur.fetchall()
    if len(table):
        print(tabulate(table, headers="keys", tablefmt='psql'))
    else:
        print("No matches found for this manager")
        return

    res = input("Are you sure you want to delete the above entry? [y/n] ")
    if res == "y" or res == "Y":
        query = """DELETE FROM MANAGERS WHERE `Club Name` = %s;"""
        cur.execute(query, (clubName))
        connection.commit()
        print("Deleted the requested entry")
    else:
        print("Aborted Delete.")
    return


# Update Queries

def updatePlayerStats():
    return


def updateStadiumCapacity():
    print("Update Capacity: ")
    print()
    stadiumName = input("Stadium Name: ")

    query = """SELECT * FROM STADIUMS WHERE `Name` = %s;"""
    cur.execute(query, (stadiumName))
    table = cur.fetchall()
    if len(table):
        print(tabulate(table, headers="keys", tablefmt='psql'))
    else:
        print("No matches found for this stadium")
        return

    res = input("Are you sure you want to update the above entry? [y/n] ")
    if res == "y" or res == "Y":
        newCapacity = input("New Capcity: ")
        try:
            query = """UPDATE STADIUMS SET `Capacity` = %s WHERE `Name` = %s"""
            cur.execute(query, (newCapacity, stadiumName))
            connection.commit()
        except Exception as e:
            print("Unable to update. Potentially invalid type for 'New Capacity'")
            return
        print("Updated the requested entry. Updated entry looks like: ")
        query = """SELECT * FROM STADIUMS WHERE `Name` = %s;"""
        cur.execute(query, (stadiumName))
        table = cur.fetchall()
        print(tabulate(table, headers="keys", tablefmt='psql'))
    else:
        print("Aborted Update.")
    return


def updateFixtureKits():
    return


def dispatchQuery(ch):
    if ch == 1:
        showLeagueTable()
    elif ch == 2:
        clubRoster()
    elif ch == 3:
        return playerStats()
    elif ch == 4:
        managerInfo()
    elif ch == 5:
        matchResults()
    elif ch == 6:
        viewFixtures()


def dispatchDelete(ch):
    if ch == 1:
        deletePlayer()
    elif ch == 2:
        deleteManager()


def dispatchUpdate(ch):
    if ch == 1:
        updatePlayerStats()
    elif ch == 2:
        updateStadiumCapacity()
    elif ch == 3:
        updateFixtureKits()


def view():
    ch = 1e9
    while ch != 7:
        sp.call('clear', shell=True)
        print("View Existing Entries")
        print()
        print("Choose one of the options: ")
        print("1. View League Table")
        print("2. View Team Roster")
        print("3. Player Performance Stats")
        print("4. Manager Info")
        print("5. Match Results")
        print("6. View Fixtures")
        print("7. Back")
        while ch > 7 or ch < 1:
            try:
                ch = int(input("Enter a choice: "))
            except ValueError:
                continue
            if ch == 7:
                break
            elif ch > 7 or ch < 1:
                continue
            else:
                sp.call('clear', shell=True)
                back = False
                back = dispatchQuery(ch)
                if not back:
                    input("Enter any key to continue")
                ch = 1e9
                break


def insert():
    print("TODO")


def delete():
    ch = 1e9
    while ch != 3:
        sp.call('clear', shell=True)
        print("Delete Entry from the Database")
        print()
        print("Choose one of the options: ")
        print("1. Delete a Player")
        print("2. Delete a Manager")
        print("3. Back")
        while ch > 3 or ch < 1:
            try:
                ch = int(input("Enter a choice: "))
            except ValueError:
                continue
            if ch == 3:
                break
            elif ch > 3 or ch < 1:
                continue
            else:
                sp.call('clear', shell=True)
                back = False
                back = dispatchDelete(ch)
                if not back:
                    input("Enter any key to continue")
                ch = 1e9
                break


def update():
    ch = 1e9
    while ch != 4:
        sp.call('clear', shell=True)
        print("Delete Entry from the Database")
        print()
        print("Choose one of the options: ")
        print("1. Update an Existing Entry:")
        print("2. Update Stadium Capacity")
        print("3. Update Fixture Kits")
        print("4. Back")
        while ch > 4 or ch < 1:
            try:
                ch = int(input("Enter a choice: "))
            except ValueError:
                continue
            if ch == 4:
                break
            elif ch > 4 or ch < 1:
                continue
            else:
                sp.call('clear', shell=True)
                back = False
                back = dispatchUpdate(ch)
                if not back:
                    input("Enter any key to continue")
                ch = 1e9
                break


def mainMenuChoice(c):
    if c == 1:
        view()
    elif c == 2:
        insert()
    elif c == 3:
        delete()
    elif c == 4:
        update()
    elif c == 5:
        exit(0)


# Essentially main()
sp.call('clear', shell=True)

if connection.open:
    print("Successfully Connected to the Database")
    input("Enter any key to continue ")

else:
    print("Failed to Connect. Aborting...")
    exit(0)

while True:

    sp.call('clear', shell=True)
    try:
        # Using the cursor
        with connection.cursor() as cur:
            sp.call('clear', shell=True)

            # Printing the Main Menu
            print("Premier League CLI")
            print()
            print("Choose an operation to perform:")
            print("1. View existing Entries")
            print("2. Insert a new Entry")
            print("3. Delete an existing Entry")
            print("4. Update and existing Entry")
            print("5. Logout")

            # Inputting a choice and ensuring it is valid
            choice = 1e9
            while choice > 5:
                try:
                    choice = int(input("Enter a choice: "))
                    if(choice > 5):
                        continue
                    elif choice < 1:
                        choice = 1e9
                        continue
                except ValueError:
                    continue
            sp.call('clear', shell=True)
            mainMenuChoice(choice)

    except Exception as e:
        sp.call('clear', shell=True)
        print("Connection refused: Either username or password is incorrect or you don't have the permissions required to access the database")
        tmp = input("Enter any key to Retry of type 'quit' to exit: ")
        if tmp == "quit":
            break
