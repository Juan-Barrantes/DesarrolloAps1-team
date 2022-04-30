CREATE DATABASE bd_NegocioAutosA1;
go

Use bd_NegocioAutosA1;

Create Table tb_Agencia(
	codAgencia smallint not null PRIMARY KEY,
	direccion varchar(75) not null,
	telefono varchar(25) not null);

CREATE TABLE tb_Marca(
	codMarca varchar(20) not null PRIMARY KEY,
	nomMarca varchar(20) not null,
	paisOrg varchar(20) not null);

CREATE TABLE tb_Servicios(
	codServicio smallint not null PRIMARY KEY,
	tipoServ varchar(50) not null,
	precio money not null);
	

Create Table tb_Cochera(
	codCochera smallint not null PRIMARY KEY,
	codAgencia smallint not null FOREIGN KEY REFERENCES tb_Agencia,
	direccion varchar(75) not null,
	capacidad smallint not null);

Create Table tb_Auto(
	placa char(6) not null PRIMARY KEY,
	codCochera smallint not null FOREIGN KEY REFERENCES tb_Cochera,
	codMarca varchar(20) not null FOREIGN KEY REFERENCES tb_Marca,
	marca varchar(20) not null,
	modelo varchar(20) not null,
	añoFabricacion smallint null,
	precio money not null);

Create Table tb_Cliente(
	docIdentidad varchar(15) not null PRIMARY KEY,
	tipoDocumento varchar(25) not null,
	apellidos varchar(35) not null,
	nombre varchar(35) not null,
	direccion varchar(75) null,
	telefono varchar(25) not null);
Alter table tb_Cliente add placa varchar(6)
	

Create Table tb_Reserva(
	codReserva integer not null PRIMARY KEY,
	codAgencia smallint not null Foreign Key REFERENCES tb_Agencia,
	docIdentidad varchar(15) not null Foreign Key REFERENCES tb_Cliente,
	cantidadAutos tinyint not null,
	fechaInicio datetime not null,
	fechaFinal datetime not null);

CREATE TABLE tb_Tratante(
	codTratante smallint not null PRIMARY KEY,
	codAgencia smallint not null FOREIGN KEY REFERENCES tb_Agencia,
	nomTratante varchar (20) not null,
	apeTratante varchar (20) not null,
	dirTratante varchar(45) not null,
	telefono varchar(25) not null);

	CREATE TABLE tb_Comprobante(
	codComprobante smallint not null PRIMARY KEY,
	fechaEmision datetime not null,
	descripcion text not null,
	placa char(6) not null Foreign Key REFERENCES tb_Auto,
	codCochera smallint not null Foreign Key REFERENCES tb_Cochera,
	codTratante smallint not null Foreign Key REFERENCES tb_Tratante,
	docIdentidad varchar(15) not null Foreign Key REFERENCES tb_Cliente,
	codServicio	smallint not null Foreign Key REFERENCES tb_Servicios);

	Delete tb_Cliente
	Insert Into tb_Cliente
	Values('465789639','Cedula de identidad', 'Carrillo Malla','Piero','Av.Los Mangos','255913230','ABCDE'),
	('485639741','Cedula de identidad', 'Solomon Hancock','Juan','Antone Loaf','840417329','HDISFD'),
	('515151283','DNI', 'Deacon Griffin','Jhezmain','Yasmine Lock','115870771','KOPADF'),
	('554558984','Pasaporte de Extranjeria', 'Keiko West','Jenifer','Jarrod Park','101242084','ABC123'),
	('963454871','DNI', 'Allistair Conrad','Nahely','Kassulke Canyon','175666999','OPA456'),
	('548123841','DNI', 'Bernard Thompson','Pedro','Wehner Viaduct','601298275','KSD067'),
	('796214562','Cedula de identidad', 'Glasc Conrad','Renata','Elisa Loaf','464599797','BDR457'),
	('456221546','Cedula de identidad', 'Vaughan Koch','Jaime',' Roob Run','989445035','LPD785'),
	('155154151','Pasaporte de Extranjeria', 'Aguirre Ayers','John','Esperanza Isle','321440267','HTY487'),
	('145194948','Pasaporte de Extranjeria', 'Preston Schmidt','Facundo','Brenda Fork','014473452','FGT467'),
	('651691487','Pasaporte de Extranjeria', 'Brock Ellison','Margarita','Franco Street','710764378',''),
	('457894125','DNI', 'Beasley Galvan','Felipe','Brakus Garden','710964081',''),
	('456478941','DNI', 'Yu Morrison','Pablo','Landen Estate','619067402',''),
	('518748474','Cedula de identidad', 'Marks Patel','Eduardo','Margaret Via','299275702',''),
	('215698489','Cedula de identidad', 'Sims Caldwell','Joseph',' Rutherford Valley','807903302',''),
	('549498494','Pasaporte de Extranjeria', 'Shelton Alvarez','Abelardo','Geoffrey Ville','896793444',''),
	('548744425','Pasaporte de Extranjeria', 'Rivers Evans','Joaquín','Thompson Ports','176093574',''),
	('944987487','Pasaporte de Extranjeria', 'Mathews Rice','Mayra','Tomasa Streets','229020450',''),
	('451487944','Cedula de identidad', 'Archer Levine','Nicolle','Kyra Square','186766110',''),
	('448477847','Cedula de identidad', 'Ruiz Knapp','Viviana','Goodwin Parkways','580404084','');
	Select*From tb_Cliente;
	go

	CREATE PROCEDURE usp_Cliente
		@docIdentidad varchar(15),
		@tipoDocumento varchar(25)=null,
		@apellidos varchar(35)=null,
		@nombre varchar(35)=null,
		@direccion varchar(75)=null,
		@telefono varchar(25)=null,
		@placa varchar(6),
		@modo char(1)
	AS

		IF @modo='I'
		BEGIN
			INSERT tb_Cliente VALUES(@docIdentidad,@tipoDocumento,@apellidos,@nombre,@direccion,@telefono,@placa)

		END

		IF @modo='U'
		BEGIN
			UPDATE tb_Cliente SET tipoDocumento=@tipoDocumento, apellidos=@apellidos, nombre=@nombre, 
				direccion=@direccion, telefono=@telefono 
			WHERE docIdentidad = @docIdentidad
		END

		IF @modo = 'D'
		BEGIN
			DELETE FROM tb_Cliente WHERE docIdentidad = @docIdentidad
		END;
		GO

/*INSERT */
EXECUTE usp_Cliente @modo= 'I', @docIdentidad='98765412' , @tipoDocumento='DNI',@apellidos='Torres Campos',
	@nombre= 'Juan Pedro',@direccion='Av.Las Palmeras',@telefono='994132657',@placa=''

/* UPDATE */
EXECUTE usp_Cliente @modo = 'U' , @docIdentidad='98765412' , @tipoDocumento='DNI',@apellidos='Murillo Gutierrez',
	@nombre= 'Jose ',@direccion='Av.Chavin',@telefono='994132657',@placa='';

/*DELETE */
EXECUTE usp_Cliente @modo = 'D', @docIdentidad ='98765412',@placa='';

	

	Select*From tb_Cliente;


	Insert Into tb_Agencia
	Values('1','Av. Naciones Unidas 1741, Cercado de Lima','994852123'),
	('2','Av. Brasil 1215, Jesús María','985263159'),
	('3','Av. Lima 3151, San Martin de Porres','944789523'),
	('4','Av. Javier Prado Este 2638, San Borja','977852698'),
	('5','Av. José Larco 497, Miraflores','945017245');
	Select*From tb_Agencia

	Insert Into tb_Marca
	Values('AU001','AUDI','Alemania'),
	('BM001','BMW','Alemania'),
	('CH001','CHEVROLET','Estados Unidos'),
	('FD001','FORD','Estados Unidos'),
	('HD001','HONDA','Japón'),
	('AS001','ASTON MARTIN','Reino Unido'),
	('MS001','MASERATI','Italia'),
	('LM001','LAMBORGHINI','Italia'),
	('NS001','NISSAN','Japón'),
	('HY001','HYUNDAI','Corea del Sur');
	Select*From tb_Marca

	Insert Into tb_Servicios
	Values('10001','Servicio Completo de Afinación','3000'),
	('10002','Carrocería y Pintura','545'),
	('10003','Cambiar Líquido de Tranmisión','320'),
	('10004','Servicio de Dirección Asistida','275'),
	('10005','Alquiler de Auto','200');
	Select*From tb_Servicios

	Insert Into tb_Cochera
	Values('101','1','Av. Naciones Unidas 1739, Cercado de Lima','6'),
	('102','2','Av. Brasil 1213, Jesús María','5'),
	('103','3','Av. Lima 3149, San Martin de Porres','5'),
	('104','4','Av. Javier Prado Este 2636, San Borja','4'),
	('105','5','Av. José Larco 495, Miraflores','8');
	Select*From tb_Cochera

	Insert Into tb_Auto
	values
	('UDM','103','CH001','CHEVROLET', 'Onix Turbo','2019','5400'),
	('OZC','104','FD001','FORD', 'Titanium','2021','9400'),
	('QCV','105','HD001','HONDA', 'Civic Sport','2020','8600'),
	('HKL','101','AS001','ASTON MARTIN','Vantage','2005','12300'),
	('EBN','102','MS001','MASERATI','Ghibli','2013','9900'),
	('IYS','103','LM001','LAMBORGHINI', 'Huracán','2016','15500'),
	('KTO','104','NS001','NISSAN','X-Trail','2022','7800'),
	('GVC','105','HY001','HYUNDAI','Ioniq Hibrido','2016','8700');

	Select*From tb_Auto

	Insert Into tb_Tratante
	values
	 (1001, '1', 'Angelina', 'Woolland', '79289 Jackson Hill', '858673299'),
	 (1002, '1', 'Kesley', 'Grainger', '55115 High Crossing Terrace', '758796167'),
	 (1003, '1', 'Jamesy', 'Berkley', '49516 Transport Street', '962282040'),
	 (1004, '2', 'Robinetta', 'Gadsdon', '1700 Golf View Crossing', '125947675'),
	 (1005, '2', 'Allin', 'Basley', '1 Atwood Place', '316833940'),
	 (1006, '2', 'Elbertina', 'Connal', '80 Hermina Place', '802657515'),
	 (1007, '3', 'Emmaline', 'Bogies', '9 Bobwhite Place', '430573957'),
	 (1008, '3', 'Laurens', 'Buddle', '73084 Lake View Place', '208242307'),
	 (1009, '3', 'Marla', 'Navan', '8 Hagan Center', '3978026062'),
	 (1010, '4', 'Bernadina', 'Brendeke', '84 Menomonie Hill', '395680212'),
	 (1011, '4', 'Alfonso', 'Oliphant', '37149 Gina Street', '537358334'),
	 (1012, '4', 'Holly-anne', 'Aylott', '94599 Jackson Court', '936140185'),
	 (1013, '5', 'Tommy', 'Habbergham', '22 Pine View Court', '155548557'),
	 (1014, '5', 'Essie', 'Kesey', '483 Cordelia Junction', '740590810'),
	 (1015, '5', 'Rosabel', 'Golagley', '44181 Westend Lane', '859534551');

	 select * from tb_Tratante;


