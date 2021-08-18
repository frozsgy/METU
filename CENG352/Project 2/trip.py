from user import User

import psycopg2

from config import read_config
from messages import *
from datetime import datetime

POSTGRESQL_CONFIG_FILE_NAME = "database.cfg"

"""
    Connects to PostgreSQL database and returns connection object.
"""

login_time = -1


def connect_to_db():
    db_conn_params = read_config(filename=POSTGRESQL_CONFIG_FILE_NAME, section="postgresql")
    conn = psycopg2.connect(**db_conn_params)
    conn.autocommit = False
    return conn


"""
    Splits given command string by spaces and trims each token.
    Returns token list.
"""


def tokenize_command(command):
    tokens = command.split(" ")
    return [t.strip() for t in tokens]


"""
    Prints list of available commands of the software.
"""


def help(conn, user):
    # 0 -> all users
    # 1 -> free and premium users
    # 2 -> premium users
    help_keys = (("\n*** Please enter one of the following commands ***", 0),
                 ("> help", 0),
                 ("> sign_up <user_id> <first_name> <last_name>", 0),
                 ("> sign_in <user_id>", 0),
                 ("> sign_out", 1),
                 ("> show_memberships", 1),
                 ("> show_subscription", 1),
                 ("> subscribe <membership_id>", 1),
                 ("> review <review_id> <business_id> <stars>", 1),
                 ("> search_for_businesses <keyword_1> <keyword_2> <keyword_3> ... <keyword_n>", 1),
                 ("> suggest_businesses", 2),
                 ("> get_coupon", 2),
                 ("> quit", 0))
    level = 0
    if user is not None:
        level = 1
        query = "SELECT m.membership_id FROM membership m JOIN subscription s ON s.membership_id = m.membership_id WHERE s.user_id = %s"
        try:
            cursor = conn.cursor()
            cursor.execute(query, (user.user_id,))
            conn.commit()
            membership = cursor.fetchone()[0]
            if membership > 1:
                level = 2
        except Exception:
            conn.rollback()
            return False, CMD_EXECUTION_FAILED

    for help_text, text_level in help_keys:
        if level >= text_level:
            print(help_text)


"""
    Saves user with given details.
    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.
    - If the operation is successful, commit changes and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; rollback, do nothing on the database and return tuple (False, CMD_EXECUTION_FAILED).
"""


def sign_up(conn, user_id, user_name):
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    user_query = "INSERT INTO users (user_id, user_name, review_count, yelping_since, useful, funny, cool, fans, average_stars, session_count) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
    subscription_query = "INSERT INTO subscription (user_id, membership_id, time_spent) VALUES(%s, 1, 0);"
    r = None
    try:
        cursor = conn.cursor()
        cursor.execute(user_query, (user_id, user_name, 0, now, 0, 0, 0, 0, 0, 0))
        cursor.execute(subscription_query, (user_id,))
        conn.commit()
        r = (True, CMD_EXECUTION_SUCCESS)
    except Exception:
        conn.rollback()
        r = (False, CMD_EXECUTION_FAILED)
    return r


"""
    Retrieves user information if there is a user with given user_id and user's session_count < max_parallel_sessions.
    - Return type is a tuple, 1st element is a user object and 2nd element is the response message from messages.py.
    - If there is no such user, return tuple (None, USER_SIGNIN_FAILED).
    - If session_count < max_parallel_sessions, commit changes (increment session_count) and return tuple (user, CMD_EXECUTION_SUCCESS).
    - If session_count >= max_parallel_sessions, return tuple (None, USER_ALL_SESSIONS_ARE_USED).
    - If any exception occurs; rollback, do nothing on the database and return tuple (None, USER_SIGNIN_FAILED).
"""


def sign_in(conn, user_id):
    check_user_query = "SELECT COUNT(*) FROM users WHERE user_id = %s"
    user_session_count_query = "SELECT session_count FROM users WHERE user_id = %s"
    max_parallel_session_query = "SELECT m.max_parallel_sessions FROM membership m JOIN subscription s ON s.membership_id = m.membership_id WHERE s.user_id = %s"
    increment_session_count_query = "UPDATE users SET session_count = session_count + 1 WHERE user_id = %s"
    get_user_query = "SELECT user_id, user_name, review_count, yelping_since, useful, funny, cool, fans, average_stars, session_count FROM users WHERE user_id = %s"
    try:
        cursor = conn.cursor()
        cursor.execute(check_user_query, (user_id,))
        conn.commit()
        count = cursor.fetchone()[0]
        if count != 1:
            return None, USER_SIGNIN_FAILED
        # count 1, user exists
        cursor.execute(user_session_count_query, (user_id,))
        conn.commit()
        user_session_count = cursor.fetchone()[0]
        cursor.execute(max_parallel_session_query, (user_id,))
        conn.commit()
        max_parallel_session_count = cursor.fetchone()[0]
        if user_session_count < max_parallel_session_count:
            cursor.execute(increment_session_count_query, (user_id,))
            conn.commit()
            cursor.execute(get_user_query, (user_id,))
            user_id, user_name, review_count, yelping_since, useful, funny, cool, fans, average_stars, session_count = cursor.fetchone()
            user = User(user_id, user_name, review_count, yelping_since, useful, funny, cool, fans, average_stars,
                        session_count)
            global login_time
            login_time = datetime.timestamp(datetime.now())
            return user, CMD_EXECUTION_SUCCESS
        else:
            return None, USER_ALL_SESSIONS_ARE_USED
    except Exception:
        conn.rollback()
        return None, USER_SIGNIN_FAILED


"""
    Signs out from given user's account.
    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.
    - Decrement session_count of the user in the database.
    - If the operation is successful, commit changes and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; rollback, do nothing on the database and return tuple (False, CMD_EXECUTION_FAILED).
"""


def sign_out(conn, user):
    user_id = user.user_id
    decrement_session_count_query = "UPDATE users SET session_count = (CASE WHEN session_count > 0 THEN (session_count - 1) ELSE 0 END) WHERE user_id= %s"
    update_time_spent_query = "UPDATE subscription SET time_spent = time_spent + %s WHERE user_id = %s"
    try:
        cursor = conn.cursor()
        cursor.execute(decrement_session_count_query, (user_id,))
        global login_time
        time_spent = round(((datetime.timestamp(datetime.now()) - login_time) * 1000), 2)
        cursor.execute(update_time_spent_query, (time_spent, user_id,))
        conn.commit()
        return True, CMD_EXECUTION_SUCCESS
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED


"""
    Quits from program.
    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.
    - Remember to sign authenticated user out first.
    - If the operation is successful, commit changes and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; rollback, do nothing on the database and return tuple (False, CMD_EXECUTION_FAILED).
"""


def quit(conn, user):
    if user is not None:
        try:
            status, message = sign_out(conn, user)
            if status is True:
                return True, CMD_EXECUTION_SUCCESS
            else:
                return False, CMD_EXECUTION_FAILED
        except Exception:
            conn.rollback()
            return False, CMD_EXECUTION_FAILED
    return True, CMD_EXECUTION_SUCCESS


"""
    Retrieves all available memberships and prints them.
    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.
    - If the operation is successful; print available memberships and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; return tuple (False, CMD_EXECUTION_FAILED).

    Output should be like:
    #|Name|Max Sessions|Monthly Fee
    1|Silver|2|30
    2|Gold|4|50
    3|Platinum|10|90
"""


def show_memberships(conn, user):
    query = "SELECT membership_id, membership_name, max_parallel_sessions, monthly_fee FROM membership"
    try:
        cursor = conn.cursor()
        cursor.execute(query)
        conn.commit()
        memberships = cursor.fetchall()
        result = ["#|Name|Max Sessions|Monthly Fee"]
        for id, name, max_session, fee in memberships:
            result.append(f"{id}|{name}|{max_session}|{fee}")
        print('\n'.join(result))
        return True, CMD_EXECUTION_SUCCESS
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED


"""
    Retrieves authenticated user's membership and prints it. 
    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.
    - If the operation is successful; print the authenticated user's membership and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; return tuple (False, CMD_EXECUTION_FAILED).

    Output should be like:
    #|Name|Max Sessions|Monthly Fee
    2|Gold|4|50
"""


def show_subscription(conn, user):
    user_id = user.user_id
    query = "SELECT m.* FROM membership m JOIN subscription s ON s.membership_id = m.membership_id WHERE s.user_id = %s"
    try:
        cursor = conn.cursor()
        cursor.execute(query, (user_id,))
        conn.commit()
        memberships = cursor.fetchall()
        result = ["#|Name|Max Sessions|Monthly Fee"]
        for id, name, max_session, fee in memberships:
            result.append(f"{id}|{name}|{max_session}|{fee}")
        print('\n'.join(result))
        return True, CMD_EXECUTION_SUCCESS
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED


"""
    Insert user-review-business relationship to Review table if not exists in Review table.
    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.
    - If a user-review-business relationship already exists (checking review_id is enough), do nothing on the database and return (True, CMD_EXECUTION_SUCCESS).
    - If the operation is successful, commit changes and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If the business_id is incorrect; rollback, do nothing on the database and return tuple (False, CMD_EXECUTION_FAILED).
    - If any exception occurs; rollback, do nothing on the database and return tuple (False, CMD_EXECUTION_FAILED).
"""


def review(conn, user, review_id, business_id, stars):
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    review_count_query = "SELECT COUNT(*) FROM review WHERE review_id = %s"
    business_count_query = "SELECT COUNT(*) FROM business WHERE business_id = %s"
    review_query = "INSERT INTO review (review_id, user_id, business_id, stars, \"date\", useful, funny, cool) VALUES(%s, %s, %s, %s, %s, %s, %s, %s)"
    try:
        cursor = conn.cursor()
        cursor.execute(review_count_query, (review_id,))
        conn.commit()
        count = cursor.fetchone()[0]
        if count != 0:
            return False, NOT_PERMITTED
        cursor.execute(business_count_query, (business_id,))
        conn.commit()
        business_count = cursor.fetchone()[0]
        if business_count == 0:
            conn.rollback()
            return False, NOT_PERMITTED
        cursor.execute(review_query, (review_id, user.user_id, business_id, stars, now, 0, 0, 0))
        conn.commit()
        return True, CMD_EXECUTION_SUCCESS
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED


"""
    Subscribe authenticated user to new membership.
    - Return type is a tuple, 1st element is a user object and 2nd element is the response message from messages.py.
    - If target membership does not exist on the database, return tuple (None, SUBSCRIBE_MEMBERSHIP_NOT_FOUND).
    - If the new membership's max_parallel_sessions < current membership's max_parallel_sessions, return tuple (None, SUBSCRIBE_MAX_PARALLEL_SESSIONS_UNAVAILABLE).
    - If the operation is successful, commit changes and return tuple (user, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; rollback, do nothing on the database and return tuple (None, CMD_EXECUTION_FAILED).
"""


def subscribe(conn, user, membership_id):
    query = "SELECT COUNT(*) FROM membership WHERE membership_id = %s"
    try:
        cursor = conn.cursor()
        cursor.execute(query, (membership_id,))
        conn.commit()
        if cursor.fetchone()[0] != 1:
            return None, SUBSCRIBE_MEMBERSHIP_NOT_FOUND
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED

    query = "SELECT membership_id, membership_name, max_parallel_sessions, monthly_fee FROM membership WHERE membership_id = %s"
    try:
        cursor = conn.cursor()
        cursor.execute(query, (membership_id,))
        conn.commit()
        next_id, next_name, next_max_session, next_fee = cursor.fetchone()
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED

    user_id = user.user_id
    query = "SELECT m.* FROM membership m JOIN subscription s ON s.membership_id = m.membership_id WHERE s.user_id = %s"
    try:
        cursor = conn.cursor()
        cursor.execute(query, (user_id,))
        conn.commit()
        curr_id, curr_name, curr_max_session, curr_fee = cursor.fetchone()
        if curr_max_session <= next_max_session:
            update_membership_query = "UPDATE subscription SET membership_id = %s WHERE user_id = %s"
            try:
                cursor = conn.cursor()
                cursor.execute(update_membership_query, (membership_id, user_id,))
                conn.commit()
                return user, CMD_EXECUTION_SUCCESS
            except Exception:
                conn.rollback()
                return False, CMD_EXECUTION_FAILED
        else:
            return None, SUBSCRIBE_MAX_PARALLEL_SESSIONS_UNAVAILABLE
    except Exception:
        conn.rollback()
        return None, SUBSCRIBE_MEMBERSHIP_NOT_FOUND


"""
    Searches for businesses with given search_text.
    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.
    - Print all businesses whose names contain given search_text IN CASE-INSENSITIVE MANNER.
    - If the operation is successful; print businesses found and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; return tuple (False, CMD_EXECUTION_FAILED).

    Output should be like:
    Id|Name|State|Is_open|Stars
    1|A4 Coffee Ankara|ANK|1|4
    2|Tetra N Caffeine Coffee Ankara|ANK|1|4
    3|Grano Coffee Ankara|ANK|1|5
"""


def search_for_businesses(conn, user, search_text):
    search_query = "SELECT business_id, business_name, \"state\", is_open, stars FROM business WHERE business_name ILIKE %s ORDER BY business_id"
    try:
        cursor = conn.cursor()
        cursor.execute(search_query, ('%{}%'.format(search_text),))
        conn.commit()
        businesses = cursor.fetchall()
        results = ["Id|Name|State|Is_open|Stars"]
        for business_id, business_name, state, is_open, stars in businesses:
            try:
                # in my db, i store is_open as a boolean value, however if it is stored as integer, this would yield
                # exceptions, therefore i have written this hack.
                is_open = 1 if is_open is True else 0
            except:
                pass
            results.append(f"{business_id}|{business_name}|{state}|{is_open}|{stars}")
        print('\n'.join(results))
        return True, CMD_EXECUTION_SUCCESS
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED


"""
    Suggests combination of these businesses:

        1- Gather the reviews of that user.  From these reviews, find the top state by the reviewed business count.  
        Then, from all open businesses find the businesses that is located in the found state.  
        You should collect top 5 businesses by stars.

        2- Perform the same thing on the Tip table instead of Review table.

        3- Again check the review table to find the businesses get top stars from that user.  
        Among them get the latest reviewed one.  Now you need to find open top 3 businesses that is located in the same state 
        and has the most stars (if there is an equality order by name and get top 3).


    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.    
    - Output format and return format are same with search_for_businesses.
    - Order these businesses by their business_id, in ascending order at the end.
    - If the operation is successful; print businesses suggested and return tuple (True, CMD_EXECUTION_SUCCESS).
    - If any exception occurs; return tuple (False, CMD_EXECUTION_FAILED).
"""


def suggest_businesses(conn, user):
    level = 0
    if user is not None:
        level = 1
        query = "SELECT m.membership_id FROM membership m JOIN subscription s ON s.membership_id = m.membership_id WHERE s.user_id = %s"
        try:
            cursor = conn.cursor()
            cursor.execute(query, (user.user_id,))
            conn.commit()
            membership = cursor.fetchone()[0]
            if membership > 1:
                level = 2
        except Exception:
            conn.rollback()
            return False, CMD_EXECUTION_FAILED
    if level < 2:
        return False, NOT_ALLOWED

    recommendation_query = """
        (
            SELECT b.business_id, b.business_name, b.state, b.is_open, b.stars FROM business b
            WHERE b.is_open = true AND
            b.state IN (
                SELECT b.state FROM review r 
                JOIN business b
                ON b.business_id = r.business_id
                WHERE r.user_id = %s
                AND r.stars >= (
                    SELECT MAX(r.stars) FROM review r 
                    JOIN business b
                    ON b.business_id = r.business_id
                    WHERE r.user_id = %s)
                    ORDER BY r.date DESC LIMIT 1
                )
            ORDER BY b.stars DESC, b.business_name LIMIT 3
        )
        UNION
        (
            SELECT b.business_id, b.business_name, b.state, b.is_open, b.stars FROM business b 
            WHERE b.state IN (
                SELECT k.state FROM (
                    SELECT COUNT(b.state) as review_count, b.state FROM tip r 
                    JOIN business b
                    ON b.business_id = r.business_id
                    WHERE r.user_id = %s
                    GROUP BY b.state
                    ORDER BY review_count DESC LIMIT 1
                ) k
            )
            AND
            b.is_open = true
            ORDER BY b.stars DESC
            LIMIT 5
        )
        UNION 
        (
            SELECT b.business_id, b.business_name, b.state, b.is_open, b.stars FROM business b 
            WHERE b.state IN (
                SELECT k.state FROM  (
                    SELECT COUNT(b.state) as review_count, b.state FROM review r 
                    JOIN business b
                    ON b.business_id = r.business_id
                    WHERE r.user_id = %s
                    GROUP BY b.state
                    ORDER BY review_count DESC LIMIT 1
                ) k 
            )
            AND
            b.is_open = true
            ORDER BY b.stars DESC
            LIMIT 5
        )
        ORDER BY business_id;
        """

    try:
        cursor = conn.cursor()
        cursor.execute(recommendation_query, (user.user_id, user.user_id, user.user_id, user.user_id,))
        conn.commit()
        businesses = cursor.fetchall()
        results = ["Id|Name|State|Is_open|Stars"]
        for business_id, business_name, state, is_open, stars in businesses:
            try:
                # in my db, i store is_open as a boolean value, however if it is stored as integer, this would yield
                # exceptions, therefore i have written this hack.
                is_open = 1 if is_open is True else 0
            except:
                pass
            results.append(f"{business_id}|{business_name}|{state}|{is_open}|{stars}")
        print('\n'.join(results))
        return True, CMD_EXECUTION_SUCCESS
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED


"""
    Create coupons for given user. Coupons should be created by following these steps:

        1- Calculate the score by using the following formula:
            Score = timespent + 10 * reviewcount

        2- Calculate discount percentage using the following formula (threshold given in messages.py):
            actual_discount_perc = score/threshold * 100

        3- If found percentage in step 2 is lower than 25% print the following:
            You don’t have enough score for coupons.

        4- Else if found percentage in step 2 is between 25-50% print the following:
            Creating X% discount coupon.

        5- Else create 50% coupon and remove extra time from user's time_spent:
            Creating 50% discount coupon.

    - Return type is a tuple, 1st element is a boolean and 2nd element is the response message from messages.py.    
    - If the operation is successful (step 4 or 5); return tuple (True, CMD_EXECUTION_SUCCESS).
    - If the operation is not successful (step 3); return tuple (False, CMD_EXECUTION_FAILED).
    - If any exception occurs; return tuple (False, CMD_EXECUTION_FAILED).


"""


def get_coupon(conn, user):
    # threshold is defined in messages.py, you can directly use it.
    level = 0
    if user is not None:
        level = 1
        query = "SELECT m.membership_id FROM membership m JOIN subscription s ON s.membership_id = m.membership_id WHERE s.user_id = %s"
        try:
            cursor = conn.cursor()
            cursor.execute(query, (user.user_id,))
            conn.commit()
            membership = cursor.fetchone()[0]
            if membership > 1:
                level = 2
        except Exception:
            conn.rollback()
            return False, CMD_EXECUTION_FAILED
    if level < 2:
        return False, NOT_ALLOWED

    review_count_query = "SELECT COUNT(*) FROM review WHERE user_id = %s"
    time_spent_query = "SELECT time_spent FROM subscription WHERE user_id = %s"

    try:
        cursor = conn.cursor()
        cursor.execute(review_count_query, (user.user_id,))
        conn.commit()
        review_count = cursor.fetchone()[0]
        cursor.execute(time_spent_query, (user.user_id,))
        conn.commit()
        time_spent = cursor.fetchone()[0]
    except Exception:
        conn.rollback()
        return False, CMD_EXECUTION_FAILED

    score = time_spent + 10 * review_count
    actual_discount_percent = score / threshold * 100

    def set_time_spent(conn, user_id, new_time):
        update_time_spent_query = "UPDATE subscription SET time_spent = %s WHERE user_id = %s"
        try:
            cursor = conn.cursor()
            cursor.execute(update_time_spent_query, (new_time, user_id,))
            conn.commit()
            global login_time
            if new_time == 0:
                login_time = datetime.timestamp(datetime.now())
            return True
        except Exception:
            conn.rollback()
            return False

    if actual_discount_percent < 25:
        return False, NOT_ENOUGH_SCORE
    elif actual_discount_percent < 50:
        print(f"Creating {actual_discount_percent}% discount coupon.")
        if set_time_spent(conn, user.user_id, 0):
            return True, CMD_EXECUTION_SUCCESS
        else:
            return False, CMD_EXECUTION_FAILED
    else:
        print(f"Creating 50% discount coupon.")
        removed_time_spent = (threshold - 20 * review_count) / 2
        if set_time_spent(conn, user.user_id, time_spent - removed_time_spent):
            return True, CMD_EXECUTION_SUCCESS
        else:
            return False, CMD_EXECUTION_FAILED
