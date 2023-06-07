{
Provincia: .………                           
Ciudad: …………

Sucursal: ………..
Vendedor 1   Total $$
…
Vendedor N   Total $$
Total Sucursal:      Total $$

Sucursal: ……….
Vendedor 1   Total $$
…
Vendedor N   Total $$
Total Sucursal:      Total $$
……
Total Ciudad: $$
}

{
Ciudad: …………
…
Total Ciudad: $$
Total Provincia: $$
Provincia: .………                           
…
Total Ciudad: $$
}
// Total Provincia:    $$
// Total Empresa:  $$
program PruebaCC;
const
    VA = 'ZZZ';
type
    //se dispone de archivos con el siguiente type
    str20=string[20];
    Ventas = record
        provincia:str20;
        ciudad:str20;
        sucursal:str20;
        vendedor:integer;
        monto:real;
    end;
    ArchVen = file of Ventas;
    
procedure Leer(var arch:ArchVen;var r:Ventas)
begin
    if(eof(arch))then
        r.provincia:=VA
    else
        read(arch,r);
end;
var
    actuales:Ventas;
    regV:Ventas;
    venta:ArchVen;
    proAct,ciuAct,sucAct:str20;
    totales:real;
begin
    Assing(venta,'venta');
    reset(venta);
    read(actuales,'venta');
    Leer(venta,regV);
    while(actuales.provincia <> VA)do begin
        regV.provincia:=proAct;
        total:=0;
        while(proAct = regV.provincia)do begin
            ciuAct:=regV.ciudad;
            WriteLn('ciudad: '+ciuAct);
            while regV.ciudad = ciuAct do begin
                sucAct:=regV.sucursal;
                WriteLn('sucursal: '+sucAct);
                while regV.sucursal = sucAct  do begin
                    WriteLn('Vendedor nro: '+regV.vendedor+' Monto: '+regV.monto);
                    total:=total+regV.monto;
                    Leer(venta,regV);
                end;
            end;
        end;
    end;
end.
