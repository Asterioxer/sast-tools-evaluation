import os
import sqlite3

def login(user_input):
    conn = sqlite3.connect("users.db")
    query = "SELECT * FROM users WHERE name = '" + user_input + "'"
    cursor = conn.execute(query)
    return cursor.fetchall()

password = "hardcoded_password"
print(login("admin"))
