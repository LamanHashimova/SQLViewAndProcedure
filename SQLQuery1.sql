Create Database Library
 Use Library
 Create Table Books
(
	Id int identity Primary Key,
	Name nvarchar(100) Not Null Check(len(Name) Between 2 And 100),
	PageCount int Check(PageCount>= 10)
)

 Create Table Authors 
(
	Id int identity Primary Key,
	Name nvarchar(100) Not Null,
	Surname nvarchar(100) Not Null,
)
Alter Table Books
Add AuthorId int Foreign Key References Authors(Id)

Insert Into Books
Values
('Suc ve Ceza',649,1),
('Qurur ve onyargi',121,2),
('Anna Karenina',333,3),
('1984',230,4)

Insert Into Authors
Values
('Victor','Huqo'),
('Marc','Levy'),
('Paulo','Picasso'),
('George','orwel')

Create View usv_GetBooksStatistic 
as
select b.Id, b.Name,b.PageCount,a.Name+' '+a.Surname as AuthorFullName from Books b join Authors a on b.AuthorId=a.Id

Create procedure usp_GetBooksStatisticsByName
@name nvarchar(100)
as
Begin
select b.Id, b.Name,b.PageCount,a.Name+' '+a.Surname as AuthorFullName from Books b join Authors a on b.AuthorId=a.Id Where b.Name=@name 
End

Alter procedure usp_GetBooksStatisticsByName
@name nvarchar(100),
@authorId nvarchar(100)
as
Begin
select b.Id, b.Name,b.PageCount,a.Name+' '+a.Surname as AuthorFullName from Books b join Authors a on b.AuthorId=a.Id Where b.Name=@name and b.AuthorId=@authorId
End

Create View usv_GetAuthorStatistic 
as
Select a.Id, a.Name+' '+a.Surname as FullName, COUNT(b.AuthorId) as BooksCount from Books b Join Authors a  ON b.AuthorId=a.Id Group by b.AuthorId