program MergeNarch;
const valoralto = '9999';
type 
    vendedor = record
        cod: string[4];               
        producto: string[10];         
        montoVenta: real;        
    end;
    ventas = record
        cod: string[4];                
        total: real;              
    end;
    maestro = file of ventas;   
    arc_detalle=array[1..100] of file of vendedor;
    reg_detalle=array[1..100] of vendedor;

procedure leer (var archivo:detalle; var dato:vendedor);
    begin
      if (not eof( archivo ))
        then read (archivo, dato)
        else dato.cod := valoralto;
    end;

procedure minimo (var reg_det: reg_detalle; var min:vendedor; var deta:arc_detalle);
    var i: integer;
    begin
      { busco el mínimo elemento del 
        vector reg_det en el campo cod,
        supongamos que es el índice i }
      min = reg_det[i];
      leer( deta[i], reg_det[i]);
    end; 

var 
    min: vendedor;
    deta: arc_detalle;
    reg_det: reg_detalle;
    mae1: maestro;
    regm: ventas;
    i,n: integer;
begin
    Read(n);
    for i:= 1 to n do begin
        assign (deta[i], 'det'+i); 
      { ojo lo anterior es incompatible en tipos}    
        reset( deta[i] );
        leer( deta[i], reg_det[i] );
    end;
    assign (mae1, 'maestro'); rewrite (mae1);
    minimo (reg_det, min, deta);
    while (min.cod <> valoralto) do begin
       regm.cod := min.cod;
       regm.total := 0;
        while (regm.cod = min.cod ) do begin
            regm.total := regm.total+min.montoVenta;
            minimo (regd1, regd2, regd3, min);
        end;
        write(mae1, regm);
    end;    
end.
