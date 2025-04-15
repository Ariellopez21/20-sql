from datetime import date, datetime  
from typing import Optional

from sqlalchemy.dialects.postgresql import ARRAY, TSVECTOR
from sqlalchemy import String, ForeignKey
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy.types import JSON

class Base(DeclarativeBase):
    pass

# HACER CLASE AUTHORS, BOOKS, USERS. 
 
class User(Base):
    __tablename__ = "users"
    
    id: Mapped[int] = mapped_column(primary_key=True)
    first_name: Mapped[str] = mapped_column(String(100), unique=True, index=True)
    last_name: Mapped[str] = mapped_column(String(100))
    email: Mapped[str] = mapped_column(String(150))
    phone: Mapped[Optional[str]] = mapped_column(String(20))
    address: Mapped[Optional[str]] = mapped_column(String(200))
    preferences: Mapped[Optional[dict]] = mapped_column(JSON)

    books: Mapped[list["Book"]] = relationship(back_populates="user")
    # grupos: Mapped[list["Grupo"]] = relationship(back_populates="usuarios", secondary="usuarios_grupos")

    def __repr__(self) -> str:
        return f"User(id={self.id}, first_name={self.first_name}, last_name={self.last_name}, email={self.email})"

class Book(Base):
    __tablename__ = "books"

    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str] = mapped_column(String(200), unique=True, index=True)
    publication_year: Mapped[Optional[date]]
    isbn: Mapped[Optional[str]] = mapped_column(String(20), unique=True)
    keywords: Mapped[Optional[list[str]]] = mapped_column(ARRAY(String))
    description: Mapped[Optional[str]] = mapped_column(String(500))
    tsvector: Mapped[Optional[str]] = mapped_column(TSVECTOR)
    #publication_year: Mapped[date] = mapped_column(ForeignKey("usuarios.id"))

    user: Mapped["User"] = relationship(back_populates="books")

    def __repr__(self) -> str:
        return f"Book(id={self.id}, title={self.title}, publication_year={self.publication_year})"    
'''
class Grupo(Base):
    __tablename__ = "grupos"

    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str]
    
    usuarios: Mapped[list["Usuario"]] = relationship(back_populates="grupos", secondary="usuarios_grupos")

    def __repr__(self) -> str:
        return f"Grupo(id={self.id},nombre={self.nombre})"

class UsuarioGrupo(Base):
    __tablename__ = "usuarios_grupos"

    usuario_id: Mapped[int] = mapped_column(ForeignKey("usuarios.id"), primary_key=True) 
    grupo_id: Mapped[int] = mapped_column(ForeignKey("grupos.id"), primary_key=True)
'''