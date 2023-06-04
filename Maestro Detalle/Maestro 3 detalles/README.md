## Precondiciones
Antes de ejecutar el programa, se deben cumplir las siguientes precondiciones:

    ► Ambos archivos (maestro y detalle) están ordenados por el código del producto.
    ► En el archivo detalle solo aparecen productos que existen en el archivo maestro.
    ► Cada producto del maestro puede ser vendido más de una vez a lo largo del día, por lo tanto, en el archivo detalle pueden existir varios registros correspondientes al mismo producto.
    Procedimientos y Funcionalidades
    ► El programa MaeDet consta de los siguientes procedimientos y funcionalidades:
    ► Los archivos detalles estan ordenados de menor a mayor
    # MAESTRO 1 DETALLE 

## Procedimientos
### minimo: si un registro es el minimo asigna min igual a este registro y lee en este registro y su detalle correspondient <a id="minimo"></a>
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
## Actualizacion Maestro detalle
#### ► Asigno el enlace de memoria logica (ma/de) con el archivo en memoria fisica ('maestro'/'detalle') y los abro como escritura / lectura; ademas creo los registros del maestro y del detalle (rMa y r1)

    assign (ma, 'mae1estro');   assign (d1, 'detalle');   
    assign (d2, 'detalle2');  assign (d3, 'detalle3');
    reset (ma);  reset (d1); reset (d2); reset (d3);

#### ► Leo un detalle con el procedimiento [leer](https://github.com/coriawork/Fundamentos-y-Organizacion-de-datos/tree/main/Maestro%20Detalle/Maestro%201%20detalle#leer)
    leer(d1, r1);leer(d2, r2);  leer(d3, r3);
#### ► Calculo el [minimo](#minimo)  
    minimo(r1, r2, r3,d1,d2,d3, min);
#### ► Mientras el codigo del minimo sea distinto de valor alto hago lo siguiente
    while (min.cod <> valoralto) do  
    begin
#### ► Leer un maestro con `Read(ma,rMa)`
    read(ma, rMa);
#### ► Mientras el codigo del registro maestro es distinto al del registro minimo, lo busco en el archivo maestro hasta que coincida
    while (rMa.cod <> min.cod) do
        read (ma,rMa);
#### ► Una vez encontrado mientras sea el mismo (*recordar que en las precondiciones un archivo detalle podia tener mas de un producto*) voy a ir actualizando el valor de `rMa` y calculando el minimo (*con este tambien leo en el minimo*)
    
    while (rMa.cod = r1.cod) do begin
        rMa.cant := rMa.cant - r1.cv;        
        minimo(r1, r2, r3,d1,d2,d3, min);          
    end;
#### ► Una vez que llegue a un registro detalle que no coincide con el registro maestro voy una posicion mas atras en el archivo maestro para escribir las actualizaciones (*Recordar que los archivos cada vez que se lee o se escribe se avanza una posicion por lo que si lo ultimo que hicimos fue leer se va a estar una posicion mas adelante*)
    seek (ma, filepos(ma)-1);
    write(ma,rMa);
    end;

## Procedimiento completo  
    var
        d1,d2,d3:detalle;
        ma:maestro;
        rMa:prod;
        r1,r2,r3:v_prod;
    begin
        assign (ma, 'mae1estro');   assign (d1, 'detalle');   
        assign (d2, 'detalle2');  assign (d3, 'detalle3');
        reset (ma);  reset (d1); reset (d2); reset (d3);
        leer(d1, r1);leer(d2, regd2);  leer(d3, r3);
        minimo(r1, r2, r3,d1,d2,d3, min);
        while (min.cod <> valoralto) do  
        begin
            read(ma,rMa);
            while (rMa.cod <> min.cod) do read(ma,rMa);
            while (rMa.cod = min.cod ) do begin
                rMa.cant:=rMa.cant - min.cantvendida;
                minimo(r1, r2, r3,d1,d2,d3, min);
            end;
            seek (ma, filepos(ma)-1);
            write(ma,rMa);
        end;
    end;
