import sqlite3
import os
package_file = os.path.abspath(os.path.dirname(__file__))
def create_table():

    conn = sqlite3.connect(os.path.join(package_file,'record_data.db'))
    cursor = conn.cursor()

    # Create the "face_encodings_table" table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS face_encodings_table (
            uu_id TEXT PRIMARY KEY,
            name TEXT,
            ref_no TEXT,
            summary TEXT,
            image_bytes BLOB,
            image_encodes BLOB
        )
    ''')

    # Commit changes and close the connection
    conn.commit()
    conn.close()
    return "create DB"
def get_all_data():
    # Connect to SQLite database
    conn = sqlite3.connect(os.path.join(package_file,'record_data.db'))
    cursor = conn.cursor()

    # Execute a SELECT query to retrieve all data
    cursor.execute('''
        SELECT *
        FROM face_encodings_table
    ''')

    # Fetch all results
    all_data = cursor.fetchall()

    # Close the connection
    conn.close()


    return all_data



def check_ref_no_exists(ref_no:str):
    # Connect to SQLite database
    conn = sqlite3.connect(os.path.join(package_file,'record_data.db'))
    print("================-------------------------------=========-=-=-==-=-=-------", os.path.join(package_file,'record_data.db'))
    cursor = conn.cursor()
    print("========================----------------====---------=--------=-", ref_no)
    # Execute a SELECT query to check if ref_no exists
    cursor.execute('''
        SELECT COUNT(*) 
        FROM face_encodings_table 
        WHERE ref_no = ?
    ''', (ref_no,))

    # Fetch the result
    count = cursor.fetchone()[0]
    print("===========------------------------------------------------------", count)

    # Close the connection
    conn.close()

    # Return True if ref_no exists, False otherwise

    return count > 0

        
def insert_data(uu_id, name, ref_no, summary, image_bytes, image_encodes):
    # Connect to SQLite database
    
    conn = sqlite3.connect(os.path.join(package_file,'record_data.db'))
    cursor = conn.cursor()

    # Convert NumPy array to bytes
    image_encodes_bytes = image_encodes.tobytes()

    # Insert data into the table
    cursor.execute('''
        INSERT INTO face_encodings_table (uu_id, name, ref_no, summary, image_bytes, image_encodes)
        VALUES (?, ?, ?, ?, ?, ?)
    ''', (uu_id, name, ref_no, summary, image_bytes, image_encodes_bytes))

    # Commit changes and close the connection
    conn.commit()
    conn.close()
    return "Updata Database"
# Example usage
#all_data = get_all_data()
create  = create_table()