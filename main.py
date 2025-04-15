from src.db_ops import add_user, get_next_user_id, update_user, create_database, get_user, query_users, delete_user
from src.db import Session
from faker import Faker

def user_prints():
    fake = Faker()

    print("1. query_users, muestra a todos los usuarios de acuerdo al método __repr__")
    query_users()
    print()

    print("2. get_user, muestra a un usuario en específico")
    with Session() as session:
        usuario = get_user(name=["Pelao","López"], session=session)
        print(usuario)
    print()

    print("3. add_user, agrega un usuario a la tabla users")
    next_id = get_next_user_id()
    add_user(id=next_id,
             first_name=fake.first_name(),
             last_name=fake.last_name(), 
             email=fake.email(), 
             phone=fake.phone_number(),
             address=fake.address(),
             preferences=None)
    print()

    print("4. delete_user, elimina un usuario de la tabla users")
    delete_user("Pelao", "López")
    print()
    

    print("5. update_user, modifica un usuario.")
    update_user(first_name="Barry", last_name="Smith", email="barry.smith@umag.cl")
    print()


def main():
    create_database()
    #user_prints()

if __name__ == "__main__":
    main()
