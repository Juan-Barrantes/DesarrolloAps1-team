CREATE DATABASE bd_NegocioAutos;
go

Use bd_NegocioAutos;

 Create Table tb_Agencia(
	codAgencia smallint not null PRIMARY KEY,
	direccion varchar(75) not null,
	telefono varchar(25) not null);

CREATE TABLE tb_Marca(
	codMarca smallint not null PRIMARY KEY,
	nomMarca varchar(20) not null,
	paisOrg varchar(20) not null);

CREATE TABLE tb_Servicios(
	codServicio smallint not null PRIMARY KEY,
	tipoServ varchar(20) not null,
	precio money not null);
	

Create Table tb_Cochera(
	codCochera smallint not null PRIMARY KEY,
	codAgencia smallint not null FOREIGN KEY REFERENCES tb_Agencia,
	direccion varchar(75) not null,
	capacidad smallint not null);

Create Table tb_Auto(
	placa char(6) not null PRIMARY KEY,
	codCochera smallint not null FOREIGN KEY REFERENCES tb_Cochera,
	codMarca smallint not null FOREIGN KEY REFERENCES tb_Marca,
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

Create Table tb_Agencia(
	codAgencia smallint not null PRIMARY KEY,
	direccion varchar(75) not null,
	telefono varchar(25) not null);

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