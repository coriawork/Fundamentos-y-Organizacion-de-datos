program archText;
Type
		tRegistroVotos=Record
			codProv: integer;
			codLoc: integer;
			nroMesa: integer;
			cantVotos: integer;
     	desc:String;
end;
tArchVotos=File of tRegistroVotos;
Var
   	opc: Byte;
   	nomArch, nomArch2: String;
   	arch: tArchVotos; 		carga: Text { archivo de texto con datos de los votos, se lee de el y se genera archivo binario.} 
    votos: tRegistroVotos;
begin
    WriteLn('VOTOS');
    WriteLn;
    WriteLn('0. Terminar el Programa');
    WriteLn('1. Crear un archivo binario desde un arch texto');
    WriteLn('2. Abrir un archivo binario y exportar a texto');
    Repeat
        Write('Ingrese el nro. de opcion: '); ReadLn(opc);
        If (opc=1) or (opc=2) then begin
            WriteLn;
            Write('Nombre del archivo de votos: ');
            ReadLn(nomArch);
            Assign(arch, nomArch); 
        end;
        Case opc of 
        1: 
        begin
            Write('Nombre del archivo de carga: ');
            ReadLn(nomArch2);
            Assign(carga, nomArch2); 
            Reset(carga); {abre archivo de texto con datos}
            Rewrite(arch); {crea nuevo archivo binario}
            while (not eof(carga)) do begin
                ReadLn(carga,votos.codProv,votos.codLoc, votos.nroMesa,votos.cantVotos,votos.desc); {lectura del archivo de texto}
                Write(arch, votos); {escribe binario}
            end;
            Write('Archivo cargado.');
            ReadLn;
            Close(arch); Close(carga) {cierra los dos archivos}
        end;
        {Opcion 2 exporta el contenido del binario a un texto}
        2: 
        begin		  
            Reset(arch); {abre archivo binario}
            Rewrite(carga); {crea archivo de texto, se utiliza el mismo de opcion 1 a modo ejemplo}
            while (not eof(arch)) do begin
                Read(arch, votos); {lee votos del arch binario}
                WriteLn(carga,votos.codProv,’ ‘,votos.codLoc,’ ‘, votos.nroMesa,’ ‘,votos.cantVotos,’ ‘,votos.desc); {escribe en el archivo texto los campos separados por el carácter blanco}
            end;
            Close(arch); Close(carga)
        end;
end.