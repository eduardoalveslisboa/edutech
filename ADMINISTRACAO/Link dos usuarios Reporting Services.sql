Use ReportServer
go


select Name [Nome relatório],'"http://biserver/ReportServer/Pages/ReportViewer.aspx?'+replace(Path,'/','%2f')+'&rs:Command=Render"' Link
from       dbo.[Catalog]        as Cat 
inner join dbo.PolicyUserRole   as Rol    on    Cat.PolicyID=Rol.PolicyId
where userid='F2A0FA6C-8844-4D00-8BC9-6F8290161A03'
and [Path] like '/producao%'
and Type=2








