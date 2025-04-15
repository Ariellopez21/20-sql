from datetime import date, datetime  
from typing import Optional

from sqlalchemy.dialects.postgresql import ARRAY, TSVECTOR
from sqlalchemy import String, ForeignKey
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy.types import JSON

class Base(DeclarativeBase):
    pass
 
class User(Base):
    __tablename__ = "users"
    
    id: Mapped[int] = mapped_column(primary_key=True)
    first_name: Mapped[str] = mapped_column(String(100), unique=True, index=True)
    last_name: Mapped[str] = mapped_column(String(100))
    email: Mapped[str] = mapped_column(String(150))
    phone: Mapped[Optional[str]] = mapped_column(String(20))
    address: Mapped[Optional[str]] = mapped_column(String(200))
    preferences: Mapped[Optional[dict]] = mapped_column(JSON)

    #books: Mapped[list["Book"]] = relationship(back_populates="user")
    loans: Mapped[list["Loan"]] = relationship(back_populates="users")

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

    loans: Mapped[list["Loan"]] = relationship(back_populates="books")

    def __repr__(self) -> str:
        return f"Book(id={self.id}, title={self.title}, publication_year={self.publication_year})"    


class Loan(Base):
    __tablename__ = "loans"

    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id")) # user_id -> ref. a "users" en clase User.
    book_id: Mapped[int] = mapped_column(ForeignKey("users.id"))
    loan_date: Mapped[date] = mapped_column(default="1973-09-11")
    due_date: Mapped[date] = mapped_column(default="2020-04-26")
    return_date: Mapped[Optional[date]] = mapped_column(default=None)
    #user: Mapped["User"] = relationship(back_populates="loans")

    user: Mapped["User"] = relationship(back_populates="loans")
    book: Mapped["Book"] = relationship(back_populates="loans")

    def __repr__(self) -> str:
        return f"Loan(id={self.id}, user_id={self.user_id}, loan_date={self.loan_date}, due_date={self.due_date}), return_date={self.return_date})"
'''
class UsuarioGrupo(Base):
    __tablename__ = "usuarios_grupos"

    usuario_id: Mapped[int] = mapped_column(ForeignKey("usuarios.id"), primary_key=True) 
    grupo_id: Mapped[int] = mapped_column(ForeignKey("grupos.id"), primary_key=True)
'''