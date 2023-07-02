(* 
    Generar Archivos de novelas.
        Novela: Codigo,genero,nombre,duracion,director y precio
    Menu:
        a)  ► Crear y cargar a partir de datos ingresados por teclado.
            ► Utilizar lista invertida.
        
        b)  ► Abrir un archivo existente:
                1) Ingresar una novela 
                2) Modificar Datos de una novela (No modificar codigo)
                3) Eliminar una novela (codigo ingresado por teclado)

        c)  ► Listar en un archivo de texto todas las novelas (incluyendo las borradas ?)
*)
program Tp3Ej3;
const
    VA=9999;
type

    novela = record
        codigo:Integer;
        genero:string[50];
        nombre:string[20];
        duracion:Real;
        director:String[20];
        precio: Real;
    end;

    novelas = file of novela;

procedure readNovela(var reg: novela);
begin
    with reg do begin
        if(codigo <>-1)then begin
            Writeln('genero');
            read(genero);
            Writeln('nombre');
            read(nombre);
            Writeln('duracion');
            read(duracion);
            Writeln('director');
            read(director);
            Writeln('precio');
            read(precio);
        end;
    end;
end;

procedure privateAdd(var arch:novelas; toAdd:novela);
var
    reg:novela;
    head:integer;
begin
    read(arch,reg);
    head:= reg.codigo;
    if(head <> 0)then begin
        head:=head*-1;
        seek(arch,head);
        read(arch,reg);
        head:=reg.codigo;
        Seek(arch,FilePos(arch)-1);
        Write(arch,toAdd);
        Seek(arch,0);
        write(head);
    end
    else begin
        seek(arch,FileSize(arch));
        write(arch,toAdd);
    end;
    
end;

procedure publicAdd(var arch:novelas);
var
    nov:novela;
begin
    readNovela(nov);
    while(nov.codigo <> -1)do begin
        privateAdd(arch,nov);
        readNovela(nov);
    end;
end;

procedure leer(var arch:novelas;var nov:novela);
begin
    if(not EOF(arch))then
        read(arch,nov)
    else
        nov.codigo:=VA;
end;

procedure publicModific(var arch:novelas);
var
    i,codigo: integer;
    nov : novela;
    
begin
    WriteLn('escribe el codigo de la novela a modificar');
    read(codigo);
    leer(arch,nov);
    i:=1;
    while((nov.codigo <> VA) AND (nov.codigo <> codigo))do begin
        leer(arch,nov);
        i:=i+1;
    end;
    if(nov.codigo=VA)then
        Write('no se encontro el codigo',codigo)
    else begin
      Write('Nuevo genero: ');
      read(nov.genero);
      Write('Nuevo nombre: ');
      read(nov.nombre);
      Write('Nuevo duracion: ');
      read(nov.duracion);
      Write('Nuevo director: ');
      read(nov.director);
      Write('Nuevo precio: ');
      read(nov.precio);
      seek(arch,FilePos(arch)-1);
      write(arch,nov);
    end;

end;

procedure privateDelete(var arch:novelas; pos:integer);
var
    head:integer;
    reg:novela;
begin
    Seek(arch,0);
    read(arch,reg);
    head:= reg.codigo;
    seek(arch,FilePos(arch)-1);
    reg.codigo:=pos*-1;
    write(arch,reg);
    seek(arch,pos);
    reg.codigo:=head;
    write(arch,reg);
end;


procedure publicDelete(var arch:novelas);
var
    i,codigo: integer;
    nov : novela;  
begin
    WriteLn('escribe el codigo de la novela a eliminar');
    read(codigo);
    leer(arch,nov);
    i:=1;
    while((nov.codigo <> VA) AND (nov.codigo <> codigo))do begin
        leer(arch,nov);
        i:=i+1;
    end;
    if(nov.codigo=VA)then
        Write('no se encontro el codigo',codigo)
    else 
        privateDelete(arch,i);

end;

procedure show(reg:novela);
begin
    with reg do begin 
        Writeln(' ----------------------');
        Writeln('|CODIGO: ',codigo,'    |');
        Writeln('|genero: ',genero,'    |');
        Writeln('|nombre: ',nombre,'    |');
        Writeln('|duracion: ',duracion,'|');
        Writeln('|director: ',director,'|');
        Writeln('|precio: ',precio,'    |');
        Writeln(' ----------------------');
    end;

end;

procedure showAll(var arch:novelas);
var
    reg:novela;
begin
    leer(arch,reg);
    while (reg.codigo <> VA) do
        show(reg);
end;

var
    option:integer;
    arch:novelas;
    reg:novela;
    name:string;
begin
    Writeln('| 1: para crear archivo |');
    Writeln('| 2: para crear abrir |');
    (* Writeln('| 3: Crear txt de novelas |'); *)
    option:=1;
    if(option = 1)then begin
        Writeln('escriba el nombre del archivo');
        readln(name);
        Assign(arch,name);
        Rewrite(arch);
        reg.codigo:=0;
        write(arch,reg);
        close(arch);
        reset(arch);
        publicAdd(arch);
    end 
    else 
        if(option = 2)then begin
            Write('escriba el nombre del archivo');
            read(name);
            Assign(arch,name);
            reset(arch);
            Seek(arch,1);
            WriteLn('1: agregar novela');
            WriteLn('2: modificar novela');
            WriteLn('3: eliminar novela');
            readln(option);
            if(option = 1)then
                publicAdd(arch)
            else begin
                if(option = 2)then
                    publicModific(arch)
                else
                    if(option = 3)then
                        publicDelete(arch);
            end;

        end;
end.