program corteControl;
{
    El archivo se encuentra ordenado por provincia, partido y ciudad
    ejem

    |******************************|
    |Provincia: xxxx               |
    |------------------------------|
    |Partido:yyyy                  |
    |------------------------------|
    |Ciudad #Var. #Muj. Desocupados|
    |------------------------------|
    |  aaa  ....  ....  .......... |
    |------------------------------|
    |  bbb  ....  ....  .......... |
    |------------------------------|
    |  ccc  ....  ....  .......... |
    |------------------------------|
    |Total Partido ............... |
    |------------------------------|
    |Partido:zzzz                  |
    |------------------------------|
    |Ciudad #Var. #Muj. Desocupado |
    |------------------------------|
    |...... ..... ..... .......... |
    |------------------------------|
    |Total Partido ............... |
    |------------------------------|
    |Partido:zzzz                  |
    |------------------------------|
    |Total Provincia:...           |
    |******************************|
    |Provincia:gggg                |
    |------------------------------|
    Se uzara el anterior formato donde se puede ver que se divide por provincia y cada provincia tiene ciudad partido y cantidad de mujeres , varones y desocupados
    Ademas un Instituto es un archivo de muchas provincias.
    el algoritmo quiere calcular la cantidad 
}
const valoralto='zzzz';
  type str10 = string[10];
       prov = record
         provincia, partido, ciudad: str10;            
         cant_varones, 
         cant_mujeres, 
         cant_desocupados : integer; 
       end;
       instituto = file of prov;
procedure leer (var archivo:instituto;  var dato:prov);
  begin
   if (not eof( archivo ))
    then read (archivo,dato)
    else dato.provincia := valoralto;
end;

var regm: prov;
    inst: instituto;
    t_varones, t_mujeres, 
    t_desocupa, t_prov_var, 
    t_prov_muj, t_prov_des: integer;
    ant_prov, ant_partido : str10;
begin
    assign (inst, 'censo' ); 
    reset (inst); 

    leer (inst, regm);
   
    writeln ('Provincia: ',regm.provincia);
    writeln ('Partido: ', regm.partido);
    writeln('Ciudad','Mas','Fem','Desocupa');

    t_varones := 0;     
    t_mujeres := 0;   
    t_desocupa := 0;
    t_prov_var := 0;    
    t_prov_muj := 0;  
    t_prov_des := 0;
    // Mientras no sea el fin del archivo Instituto
    while ( regm.provincia <> valoralto)do begin 
        ant_prov := regm.provincia; 
        ant_partido := regm.partido;
        // Mientras es la misma provincia y el mismo partido
        while (ant_prov=regm.provincia) and (ant_partido=regm.partido) do begin
            write (regm.ciudad, regm.cant_varones,regm.cant_mujeres,regm.cant_desocupados);
            //Sumo los valores
            t_varones := t_varones + regm.cant_varones;      
            t_mujeres := t_mujeres + regm.cant_mujeres;
            t_desocupa := t_desocupa + regm.cant_desocupados;
            leer (inst, regm);
        end;
        // Escribo el total del partido 
        writeln ('Total Partido: ', t_varones, t_mujeres, t_desocupa);
        // Sumo el total de las provincias
        t_prov_var := t_prov_var + t_varones; 
        t_prov_muj := t_prov_muj +  t_mujeres;  
        t_prov_des := t_prov_des + t_desocupa;
        // Vuelvo todos a 0
        t_varones := 0; t_mujeres := 0; t_desocupa := 0;
        
        // Igualo el partido
        ant_partido := regm.partido;
        // Si la provincia es ditinta
        if (ant_prov <> regm.provincia) then begin
            // Escribo los totales de la provincia
            writeln ('TotalProv.',t_prov_var, t_prov_muj, t_prov_des);
            t_prov_var := 0; t_prov_muj := 0; 
            t_prov_des := 0;
            writeln('Prov.:',regm.provincia);
        end;
        writeln('Partido:', regm.partido);
    end;
end.
