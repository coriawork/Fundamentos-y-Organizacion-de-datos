program MaeDet3;
const
    valoralto = 'ZZZZ';
type
    str4 = string[4];
    prod = record  
        cod:str4;
        cant:integer;
    end;
    v_prod = record
        cod:str4;
        cantVendida:Integer;
    end;
    detalle = file of v_prod;
    maestro = file of prod;
procedure leer (var archivo: detalle; var dato:v_prod);
    begin
        if (not eof(archivo))then read (archivo,dato)
        else dato.cod := valoralto;
    End;
procedure minimo (var r1,r2,r3: v_prod;var det1,det2,det3:detalle; var min:v_prod);
 begin
   if (r1.cod<=r2.cod) and 
       (r1.cod<=r3.cod) then begin
       min := r1;  
       leer(det1,r1)
     end
     else if (r2.cod<=r3.cod) then begin
            min := r2; leer(det2,r2)
          end
          else begin
            min := r3;leer(det3,r3)
          end;
 end;
procedure CrearArchivos();

    var
        mae1: maestro;
        det1, det2, det3: detalle;
        regm: prod;
        regd1, regd2, regd3: v_prod;
    begin
        // Crear y llenar archivo det1
        Assign(det1, 'detalle');
        Rewrite(det1);
        regd1.cod := 'A02';
        regd1.cantVendida := 5;
        Write(det1, regd1);
        regd1.cod := 'A02';
        regd1.cantVendida := 10;
        Write(det1, regd1);
        Close(det1);

        // Crear y llenar archivo det2
        Assign(det2, 'detalle2');
        Rewrite(det2);
        regd2.cod := 'A02';
        regd2.cantVendida := 8;
        Write(det2, regd2);
        Close(det2);

        // Crear y llenar archivo det3
        Assign(det3, 'detalle3');
        Rewrite(det3);
        regd3.cod := 'C02';
        regd3.cantVendida := 3;
        Write(det3, regd3);
        regd3.cod := 'C02';
        regd3.cantVendida := 6;
        Write(det3, regd3);
        Close(det3);

         // Crear y llenar archivo maestro
        Assign(mae1, 'mae1estro');
        Rewrite(mae1);
        regm.cod := 'A02';
        regm.cant := 30;
        Write(mae1, regm);
        regm.cod := 'C02';
        regm.cant := 30;
        Write(mae1, regm);
        Close(mae1);
    end;    

procedure MostrarArchivosMaestroDetalle;
    var
    mae1: maestro;
    det1, det2, det3: detalle;
    regm: prod;
    regd1, regd2, regd3: v_prod;
    begin
    Assign(mae1, 'mae1estro');
    Assign(det1, 'detalle');
    Assign(det2, 'detalle2');
    Assign(det3, 'detalle3');
    Reset(mae1);
    Reset(det1);
    Reset(det2);
    Reset(det3);

    writeln('----- Archivo Maestro -----');
    while not EOF(mae1) do
    begin
        Read(mae1, regm);
        writeln('Código: ', regm.cod, ' - Cantidad: ', regm.cant);
    end;

    writeln('----- Archivo Detalle 1 -----');
    while not EOF(det1) do
    begin
        Read(det1, regd1);
        writeln('Código: ', regd1.cod, ' - Cantidad Vendida: ', regd1.cantVendida);
    end;

    writeln('----- Archivo Detalle 2 -----');
    while not EOF(det2) do
    begin
        Read(det2, regd2);
        writeln('Código: ', regd2.cod, ' - Cantidad Vendida: ', regd2.cantVendida);
    end;

    writeln('----- Archivo Detalle 3 -----');
    while not EOF(det3) do
    begin
        Read(det3, regd3);
        writeln('Código: ', regd3.cod, ' - Cantidad Vendida: ', regd3.cantVendida);
    end;

    Close(mae1);
    Close(det1);
    Close(det2);
    Close(det3);
    end;


var   
    regm: prod;  min, regd1, regd2,regd3: v_prod;
    mae1: maestro;   
    det1,det2,det3: detalle;
begin
    CrearArchivos();
    WriteLn('PRE');
    MostrarArchivosMaestroDetalle();
    assign (mae1, 'mae1estro');   assign (det1, 'detalle');   
    assign (det2, 'detalle2');  assign (det3, 'detalle3');
    reset (mae1);  reset (det1); reset (det2); reset (det3);
    leer(det1, regd1);leer(det2, regd2);  leer(det3, regd3);
    minimo(regd1, regd2, regd3,det1,det2,det3, min);
    while (min.cod <> valoralto) do  
    begin
        read(mae1,regm);
        while (regm.cod <> min.cod) do read(mae1,regm);
        while (regm.cod = min.cod ) do begin
            regm.cant:=regm.cant - min.cantvendida;
            minimo(regd1, regd2, regd3,det1,det2,det3, min);
        end;
        seek (mae1, filepos(mae1)-1);
        write(mae1,regm);
    end;
    close(mae1);
    close(det1);
    close(det2);
    close(det3);
    WriteLn('POST');
    MostrarArchivosMaestroDetalle();
end.
