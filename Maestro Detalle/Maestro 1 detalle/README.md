# MAESTRO 1 DETALLE 
#### DISCLAIMER : LOS PARAMETROS DE LOS PROCEDIMIENTOS NO RESPETAN AL 100% LA SINTAXIS DE PASCAL.
## Precondiciones
Antes de ejecutar el programa, se deben cumplir las siguientes precondiciones:

    ► Ambos archivos (maestro y detalle) están ordenados por el código del producto.
    ► En el archivo detalle solo aparecen productos que existen en el archivo maestro.
    ► Cada producto del maestro puede ser vendido más de una vez a lo largo del día, por lo tanto, en el archivo detalle pueden existir varios registros correspondientes al mismo producto.
    Procedimientos y Funcionalidades
    ► El programa MaeDet consta de los siguientes procedimientos y funcionalidades:

# Descripcion del algoritmo 
## Asignacion 
► se asignan los registros y los archivos que van a contener estos archivos (Mestro y detalle)
       
        prod = record
            ..             
        end;

        v_prod = record
            ...             
        end;

        detalle = file of v_prod;         
        maestro = file of prod;`
## Procedimientos
#### Leer (var archivoDetalle, var regDet)<a id="leer"></a> 
► Se utiliza el procedimiento Leer() para los detalles, si no es final del archivoDetalle escribo en el regDet un registro del archivo, si es el final de archivo del archivoDetalle al regDet se le agrega valor alto

    if (not eof(archivoDetalle)) then  // Si no es fin de archivo detalle
        Read(archivoDetalle, regDet)   // Leo en del archivo un registro 
    else                               // sino
        regDet.cod := VA;              // el codigo del registro se le agrega un valor alto

## Actualizacion Maestro detalle
#### ► Asigno el enlace de memoria logica (ma/de) con el archivo en memoria fisica ('maestro'/'detalle') y los abro como escritura / lectura; ademas creo los registros del maestro y del detalle (rMa y r1)
    
    procedure ActMa(var ma:maestro,var de:detalle);
    var
    r1: v_prod; rMa: prod;       //Asignacion de registros 
    begin
        assign (ma, 'maestro');  //Asignacion Logica / Fisica 
        assign (de, 'detalle');  //Asignacion Logica / Fisica 
        reset (ma);              //Apertura de 'ma' por Lectura/Escritura
        reset (de);              //Apertura de 'de' por Lectura/Escritura
#### ► Leo un detalle con el procedimiento [leer](#leer) y `mientras` el registro `r1` sea distinto al Valor alto se ejecutaran los siguientes puntos:
    leerDe(de,r1);               //se escribe en el registro 'r1' lo leido en el archivo 'de'
    while (r1.cod <> VA) do      // se verifica cada vez que avanzo en el registro que no sea el final
    begin
#### ► Leer un maestro con `Read(ma,rMa)`
        read(ma, rMa);
#### ► Mientras el codigo del registro maestro es distinto al del registro detalle, lo busco en el archivo maestro hasta que coincidan

    while (rMa.cod <> r1.cod) do
        read (ma,rMa);
#### ► Una vez encontrado mientras sea el mismo (*recordar que en las precondiciones un archivo detalle podia tener mas de un producto*) voy a ir actualizando el valor de `rMa`
    
    while (rMa.cod = r1.cod) do begin
        rMa.cant := rMa.cant - r1.cv;        
        leerDe(de,r1);          
    end;
#### ► Una vez que llegue a un registro detalle que no coincide con el registro maestro voy una posicion mas atras en el archivo maestro para escribir las actualizaciones (*Recordar que los archivos cada vez que se lee o se escribe se avanza una posicion por lo que si lo ultimo que hicimos fue leer se va a estar una posicion mas adelante*)
    seek (ma, filepos(ma)-1);
    write(ma,rMa);
    end;

## Procedimiento completo  

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
