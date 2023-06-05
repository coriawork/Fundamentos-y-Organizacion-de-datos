program MaeDet;

const
  VA = 'ZZZZ';

type
  str4 = string[4];

  prod = record
    cod: str4;                     // Código del producto
    descripcion: string[30];       // Descripción del producto
    pu: real;                      // Precio unitario del producto
    cant: integer;                 // Cantidad actual del producto
  end;

  v_prod = record
    cod: str4;                     // Código del producto
    cv: integer;                   // Cantidad vendida del producto
  end;

  detalle = file of v_prod;         // Archivo detalle que contiene registros de v_prod
  maestro = file of prod;           // Archivo maestro que contiene registros de prod

procedure leerDe(var de: detalle; var r1: v_prod);
begin
  if (not eof(de)) then 
    Read(de, r1)
  else
    r1.cod := VA;
end;
procedure ActualizarMaestro(var ma: maestro; var de: detalle);
var
  rMa: prod;
  r1: v_prod
begin
    assign (ma, 'maestro');  
    assign (de, 'detalle');
    reset (ma);  reset (de);
    leerDe(de,r1);  
    while (r1.cod <> VA) do begin
        read(ma, rMa);
        while (rMa.cod <> r1.cod) do
          read (ma,rMa);
        while (rMa.cod = r1.cod) do begin
          rMa.cant := rMa.cant - r1.cv;        
	       leerDe(de,r1);          
        end;
        seek (ma, filepos(ma)-1);
        write(ma,rMa);
    end;
End;
procedure ImprimirDetallesMaestros(var ma: maestro; var de: detalle);
var
  rMa: prod;
  r1: v_prod;
begin
  Assign(ma, 'maestro');
  Reset(ma);

  Assign(de, 'detalle');
  Reset(de);

  writeln('----- Detalles -----');
  while not eof(de) do
  begin
    read(de, r1);
    writeln('Código: ', r1.cod, ' - Cantidad: ', r1.cv);
  end;
  
  writeln('----- Maestro -----');
  while not eof(ma) do
  begin
    read(ma, rMa);
    writeln('Código: ', rMa.cod, ' - Descripción: ', rMa.descripcion, ' - Cantidad: ', rMa.cant);
  end;

  Close(ma);
  Close(de);
end;

var
  det1: detalle;
  ma: maestro;
  rMa: prod;
  r1: v_prod;

begin
  // Crear y llenar el archivo detalle con registros de ejemplo
  Assign(det1, 'detalle');
  Rewrite(det1);
  r1.cod := 'A001';
  r1.cv := 5;
  Write(det1, r1);
  r1.cod := 'A001';
  r1.cv := 3;
  Write(det1, r1);
  r1.cod := 'A002';
  r1.cv := 10;
  Write(det1, r1);
  Close(det1);

  // Crear y llenar el archivo maestro con registros de ejemplo
  Assign(ma, 'maestro');
  Rewrite(ma);
  rMa.cod := 'A001';
  rMa.descripcion := 'Producto 1';
  rMa.pu := 10.5;
  rMa.cant := 8;
  Write(ma, rMa);
  rMa.cod := 'A002';
  rMa.descripcion := 'Producto 2';
  rMa.pu := 8.7;
  rMa.cant := 11;
  Write(ma, rMa);
  Close(ma);

  // Imprimir los detalles y el maestro antes de la actualización
  ImprimirDetallesMaestros(ma, det1);

  // Actualizar el archivo maestro en base a los registros del archivo detalle
  ActualizarMaestro(ma, det1, rMa, r1);

  // Imprimir los detalles y el maestro después de la actualización
  ImprimirDetallesMaestros(ma, det1);
end.