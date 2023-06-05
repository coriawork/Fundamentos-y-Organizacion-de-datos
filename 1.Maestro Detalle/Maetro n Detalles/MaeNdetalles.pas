program MaeNdetalles;
const
    N = 10;
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
    arrReg = array[N] of v_prod;
    arrDet = array[N] of detalle;
    maestro = file of prod;

procedure leer (var archivo: detalle; var dato:v_prod);
    var
        i:integer;
    begin
        if (not eof(archivo))then read (archivo,dato)
        else dato.cod := valoralto;
    End;
procedure minimo (var regs:arrReg;var dets:arrDet; var min:v_prod);
 var
    i,imin:integer;
    pos:string;
 begin
    for i:=1 to N do begin
        if (regs[i].cod < min.cod) then begin
            min:=regs[i];
            imin:=i;
        end;
    end;
    leer(dets[imin],regs[imin]);
 end;
procedure CrearArchivos();
    var
        det:detalle;
        reg:v_prod;
        i:integer;
        pos:string;
    begin
        for i:= 1 to N do begin
            Str(i,pos);
            Assign(det,'detalle'+pos);
            Rewrite(det);
            reg.cod:='A'+IntToStr(pos);
            reg.cantVendida:=i;
        end;
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
        det:detalle;
        reg:v_prod;
        regm: prod;
        pos:string;
        regd1, regd2, regd3: v_prod;
    begin
        for i:=1 to N do begin
            Str(i,pos);
            Assign(det, 'detalle'+pos);
            Reset(det);
            read(det,reg);
            writeln('----- Archivo Detalle nro '+pos+' -----');
            while(not eod(det))do begin
                writeln('Código: ', det.cod, ' - Cantidad Vendida: ', det.cantVendida);
                read(det,reg);
            end;
            close(det);
        end;
        Assign(mae1, 'mae1estro');
        Reset(mae1);
        writeln('----- Archivo Maestro -----');
        while not EOF(mae1) do begin
            Read(mae1, regm);
            writeln('Código: ', regm.cod, ' - Cantidad: ', regm.cant);
        end;
end;



var   
    reg
    mae1: maestro;   
    det: arrDet;
begin
    CrearArchivos();
    WriteLn('PRE');
    MostrarArchivosMaestroDetalle();
    assign (mae1, 'mae1estro');
    reset (mae1);
    for i:=1 to N do begin
        assign(det[i],'detalles');
        reset(det1);
        leer(det[i], reg);
    end;   
    
   leer(det2, regd2);  leer(det3, regd3);
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
