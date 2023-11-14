create proc AddOrder
@iduser int
as 
begin
insert into [Order](OrderDate, IDUser) values
(getdate(), @iduser)
end

create proc AddServiceOrder
@idservice int, @idorder int
as
begin
insert into [OrderService](IDService, IDOrder) values
(@idservice, @idorder)
end

create proc AddService
(@nameservice nvarchar(50), @priceservice money)
as
begin
insert into [Service](NameService, PriceService) values
(@nameservice, @priceservice)
end

create proc DeleteServiceOrder
@idservice int, @idorder int
as
begin
delete from OrderService where IDOrder = @idorder and IDService = @idservice
end

create proc DeleteOrder
@idorder int
as
begin
if exists (select * from OrderService where IDOrder = @idorder)
	begin
		delete from [OrderService] where IDOrder = @idorder
	end
delete from [Order] where IDOrder = @idorder
end

create  function getOrderByUser
(@iduser int)
returns table
as
return (select * from [Order] where IDOrder = @iduser)

create  function getServicesOrder
(@idorder int)
returns table
as
return (select IDService, NameService, PriceService from [Service] where IDService in (select IDService from OrderService where IDOrder = @idorder))