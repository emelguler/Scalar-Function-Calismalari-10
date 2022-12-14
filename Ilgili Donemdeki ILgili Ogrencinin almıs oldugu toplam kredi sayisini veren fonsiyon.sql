USE [Okul]


--Ilgili Donemdeki ILgili Ogrencinin almıs oldugu toplam kredi sayisini veren fonsiyon:

ALTER FUNCTION [dbo].[FN$OgrencininAldigiToplamKrediSayisi](@Ogrenci_Id int,@Donem_Id int)
returns int
as
begin
declare @sonuc as int


set  @sonuc = (select  sum(b.KrediSayisi)
from

(select o.Id as Ogrenci_Id, o.Adi+' '+o.SoyAdi as adisoyadi,
Ders_Id,do.Adi as dönemadi,d.KrediSayisi
from dbo.OgrenciOgretmenDers as ood
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.OgretmenDers  as og on og.Id=ood.OgretmenDers_Id and og.Statu=1
inner join dbo.Ders as d on d.Id=og.Ders_Id and d.Statu=1
inner join dbo.Donem as do on do.Id=og.Donem_Id and do.Statu=1
where ood.Statu=1
and o.Id = @Ogrenci_Id
and do.Id = @Donem_Id
group by o.Id,og.Ders_Id,o.Adi,o.SoyAdi,do.Adi,d.KrediSayisi)b
group by b.Ogrenci_Id,b.adisoyadi,b.dönemadi)




return @sonuc
end


--cagiralim:
select [dbo].[FN$OgrencininAldigiToplamKrediSayisi](2,1)





--where clause kontrolu:
select  sum(b.KrediSayisi)
from

(select o.Id as Ogrenci_Id, o.Adi+' '+o.SoyAdi as adisoyadi,
Ders_Id,do.Adi as dönemadi,d.KrediSayisi
from dbo.OgrenciOgretmenDers as ood
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.OgretmenDers  as og on og.Id=ood.OgretmenDers_Id and og.Statu=1
inner join dbo.Ders as d on d.Id=og.Ders_Id and d.Statu=1
inner join dbo.Donem as do on do.Id=og.Donem_Id and do.Statu=1
where ood.Statu=1
and o.Id = 2
and do.Id = 1
group by o.Id,og.Ders_Id,o.Adi,o.SoyAdi,do.Adi,d.KrediSayisi)b
group by b.Ogrenci_Id,b.adisoyadi,b.dönemadi
