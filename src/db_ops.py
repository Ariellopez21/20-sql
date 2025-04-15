from typing import Sequence
from unittest import result
from sqlalchemy import select, update
from sqlalchemy.exc import NoResultFound
from sqlalchemy.orm import selectinload

from src.db import Session, engine
from src.models import Base, User

'''
7. Crear Modelo: books, loans. 
'''

def create_database():
    Base.metadata.create_all(engine)

def query_users():
    with Session() as session:
        #stmt = select(Usuario).where(Usuario.apodo.is_(None)).order_by(Usuario.nombre_usuario) # Statement = stmt
        stmt = select(User)
        #stmt.order_by(Usuario.nombre_usuario.desc()) # Statement = stmt

        results = session.execute(stmt).scalars().fetchall()

        for user in results:
            print(user)
        #session.get(User,1).
        return results

def get_user(name: list, session) -> User | None: 
    # Nombre y apellido
    if len(name) == 2:

        stmt = (
            select(User)
            .where(User.first_name == name[0] and User.last_name == name[1])
            #.options(selectinload(Usuario.emails))
            )

        user = session.execute(stmt).scalar_one_or_none()

        return user
    
    else: 
        print("Por favor, ingresar nombre y apellido")
        return None
    
def get_next_user_id() -> int:
    with Session() as session:
        stmt = select(User).order_by(User.id.desc())
        result = session.execute(stmt).scalars().first()
        
        if result:
            return result.id + 1
        else:
            return 1
        
def add_user(id: int, first_name: str, last_name: str, email: str, phone: str | None, address: str | None, preferences: dict | None) -> None:
    new_user = User(id=id,
            first_name=first_name,
              last_name=last_name,
              email=email,
              phone=phone,
              address=address, 
              preferences=preferences)

    with Session() as session:
        session.add(new_user)

        session.commit()
        print("usuario agregado con id:", new_user.id)

def update_user(first_name: str, last_name: str, email: str | None = None, phone: str | None = None, address: str | None = None, preferences: dict | None = None) -> None:
    with Session() as session:
        with session.begin():
            try: 
                stmt = (
                    update(User)
                    .where(User.first_name == first_name
                           and User.last_name == last_name)
                           .values(
                               email=email,
                               phone=phone,
                               address=address,
                               preferences=preferences
                           )
                )
                session.execute(stmt)

            except NoResultFound:
                print(f"Usuario de nombre {first_name} {last_name} no encontrado")

def delete_user(first_name: str, last_name: str) -> None:
    with Session() as session:
        with session.begin():
            try: 
                user = session.execute(
                select(User)
                .where(User.first_name == first_name 
                       and User.last_name == last_name)).scalar_one()

                session.delete(user)
                
            except NoResultFound:
                print(f"Usuario de nombre {first_name} {last_name} no encontrado")
'''
def disable_user(username: str) -> None:
    with Session() as session:
        with session.begin():
            try: 
                user = session.execute(select(Usuario).where(Usuario.nombre_usuario == username)).scalar_one()

                user.habilitado = False
            except NoResultFound:
                print(f"User {username} not found")

def turn_enabled_users(usernames: list[str], is_habilitado=True) -> None:
    with Session() as session:
        with session.begin():
            stmt = (
                update(Usuario)
                .where(Usuario.nombre_usuario.in_(usernames))
                .values(habilitado=is_habilitado)
            )
            session.execute(stmt)



def add_email_to_user(username: str, email: str) -> None:
    with Session() as session:
        with session.begin():
            user = session.execute(
                select(Usuario).where(Usuario.nombre_usuario == username)
            ).scalar_one()
            user.emails.append(Email(email=email))

# YA NO SIRVE PORQUE LO SUSTITUYE EMAILS DE MODELS.PY
def get_user_emails(username: str) -> Sequence[Email]:
    with Session() as session:
        user = session.execute(
            select(Usuario).where(Usuario.nombre_usuario == username)
        ).scalar_one()

        stmt = (
            select(Email).where(Email.usuario_id == user.id)
        )

        result = session.execute(stmt).scalars().fetchall()
        
        return result
    
def crear_grupo(name: str) -> Grupo:
    with Session() as session:
        with session.begin():
            grupo = Grupo(nombre=name)
            session.add(grupo)
            return grupo

def get_group(name: str) -> Grupo | None:
    with Session() as session:
        group = session.execute(
            select(Grupo)
            .where(Grupo.nombre == name)
        ).scalar_one_or_none()

        return group

'''