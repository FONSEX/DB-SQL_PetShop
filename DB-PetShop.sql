/*DOMINIOS*/
	
CREATE DOMAIN "dom_inteligencia" AS VARCHAR(8) 
	NOT NULL 
	CONSTRAINT dom_inteligencia_into CHECK (VALUE IN ('Bajo', 'Medio', 'Alto'));
	
CREATE DOMAIN "dom_contextura" AS VARCHAR(8) 
	NOT NULL
	CONSTRAINT dom_contextura_into CHECK (VALUE IN ('N', 'S'));
	
CREATE DOMAIN "dom_talla" AS VARCHAR(8) 
	NOT NULL
	CONSTRAINT dom_talla_into CHECK (VALUE IN ('P', 'M', 'G'));
	
CREATE DOMAIN "dom_sexo" AS VARCHAR(8) 
	NOT NULL
	CONSTRAINT dom_sexo_into CHECK (VALUE IN ('M', 'F'));

CREATE DOMAIN "dom_ajustes" AS VARCHAR(10)
	NOT NULL
	CONSTRAINT dom_ajustes_into CHECK (VALUE IN ('Faltante', 'Sobrante'));
	
CREATE DOMAIN "dom_servicios" AS VARCHAR(20)
	NOT NULL
	CONSTRAINT dom_servicios_into CHECK (VALUE IN ('Peluqueria', 'Spa', 'Pernocta', 'Veterinario'));
	
/*TABLAS*/

CREATE TABLE Encargado                                            
(
 cod_encargado integer CHECK (cod_encargado>0) NOT NULL,	
 nombreE varchar(255) NOT NULL,
 DireccionE varchar(255) NOT NULL,	
 TelefonoE varchar(255) NOT NULL,
 SueldoE integer CHECK (SueldoE>0) NOT NULL,
 Tiempo_Encargado date,	
 
 CONSTRAINT "encargado_pkey" PRIMARY KEY (cod_encargado)
);   

CREATE TABLE Franquicia                                           
(
 RIF varchar(255) NOT NULL,
 ciudad varchar(255) NOT NULL, 
 especializacion varchar(255) NOT NULL, 
 capacidad integer CHECK (capacidad>0) NOT NULL, 
 cod_encargado integer CHECK (cod_encargado>0) NOT NULL,
 
 CONSTRAINT "franquicia_pkey" PRIMARY KEY (RIF),
 
 CONSTRAINT Fk_detalleEncargado
	FOREIGN KEY (cod_encargado) REFERENCES encargado(cod_encargado)
	ON UPDATE CASCADE
	ON DELETE RESTRICT	
); 

CREATE TABLE Personal                                            
(
	
 cod_personal integer CHECK (cod_personal>0) NOT NULL,	
 nombreP varchar(255) NOT NULL,
 DireccionP varchar(255) NOT NULL,	
 TelefonoP varchar(255) NOT NULL,
 SueldoP integer CHECK (SueldoP>0) NOT NULL,
 
 CONSTRAINT "personal_pkey" PRIMARY KEY (cod_personal)
); 

CREATE TABLE Servicio                                            
(
	
 cod_servicio integer CHECK (cod_servicio>0) NOT NULL,	
 nombreS varchar(255) NOT NULL,
 Disponibilidad integer CHECK (Disponibilidad>=0) NOT NULL,	
 DescripcionS varchar(255) NOT NULL,
 cod_personal integer CHECK (cod_personal>0) NOT NULL,
 
 
 CONSTRAINT "servicio_pkey" PRIMARY KEY (cod_servicio),

 CONSTRAINT check_asignaServicio  unique (cod_servicio),
 CONSTRAINT check_asignaServicio  unique (cod_personal),	
 
 CONSTRAINT Fk_detallePersonal
	FOREIGN KEY (cod_personal) REFERENCES personal(cod_personal)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 

CREATE TABLE Producto                                           
(
 cod_producto integer CHECK (cod_producto>0) NOT NULL,	
 descripcionP varchar(255) NOT NULL,
 costoP integer CHECK (costoP>0) NOT NULL,	
 nombreP varchar(255) NOT NULL,

 CONSTRAINT "producto_pkey" PRIMARY KEY (cod_producto),
 CONSTRAINT check_asignaProducto  unique (cod_producto)	   
); 

	
CREATE TABLE Actividad                                            
(
	
 Num_act integer CHECK (Num_act>0) NOT NULL,	
 cod_servicio integer CHECK (cod_servicio>0) NOT NULL,
 Descripcionact varchar(255) NOT NULL,	
 Capacidad_Atencion integer CHECK (Capacidad_Atencion>0) NOT NULL,
 
 CONSTRAINT "actividad_pkey" PRIMARY KEY (Num_act,cod_servicio),
 
 CONSTRAINT Fk_detalleServicio
 FOREIGN KEY (cod_servicio) REFERENCES  servicio(cod_servicio)
	ON UPDATE CASCADE
	ON DELETE RESTRICT		
); 

CREATE TABLE Reserva                                            
(
 num_reserva integer CHECK (num_reserva>0) NOT NULL,	
 fecha_reservacion date NOT NULL,
 monto_abonado integer CHECK (monto_abonado>0) NOT NULL,	
 fecha_act date NOT NULL,
 cod_servicio integer CHECK (cod_servicio>0) NOT NULL,	
 
 CONSTRAINT "reserva_pkey" PRIMARY KEY (num_reserva,cod_servicio),
	
 CONSTRAINT Fk_detalleServicio
	FOREIGN KEY (cod_servicio) REFERENCES servicio(cod_servicio)
	ON UPDATE CASCADE
	ON DELETE RESTRICT		
); 


CREATE TABLE FacturaServicio                                      
(
	
 cod_personal integer CHECK (cod_personal>0) NOT NULL,	
 cod_fact integer CHECK (cod_fact>0) NOT NULL,
 fecha_fact date NOT NULL,	
 monto_fact integer CHECK (monto_fact>0) NOT NULL,
 cod_modalidad integer CHECK (cod_modalidad>0) NOT NULL,	

 CONSTRAINT "FactServ_pkey" PRIMARY KEY (cod_fact),

	CONSTRAINT Fk_detalleResponsable
	FOREIGN KEY (cod_personal) REFERENCES servicio(cod_personal)
	ON UPDATE CASCADE
	ON DELETE RESTRICT	
	
	/* modalidad de pago 
	CONSTRAINT Fk_detalleServicio
	FOREIGN KEY (cod_personal) REFERENCES servicio(cod_personal)
	ON UPDATE CASCADE
	ON DELETE RESTRICT	*/
	
	
    

); 


CREATE TABLE OrdenDeUso
(
	
 cod_orden integer CHECK (cod_orden>0) NOT NULL,	
 cod_producto integer CHECK (cod_producto>0) NOT NULL,
 fecha_uso date NOT NULL,	
 cod_personal integer CHECK (cod_personal>0)NOT NULL,
 cod_servicio integer CHECK (cod_servicio>0) NOT NULL,	
 cant_producto integer CHECK (cant_producto>=0) NOT NULL,

 CONSTRAINT "ordenUso_pkey" PRIMARY KEY (cod_orden),
	
	CONSTRAINT Fk_detalleProducto
	FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,	
	
    CONSTRAINT Fk_detallePersonal
	FOREIGN KEY (cod_personal) REFERENCES servicio(cod_personal)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,	
	
	CONSTRAINT Fk_detalleServicio
	FOREIGN KEY (cod_servicio) REFERENCES servicio(cod_servicio)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE Animal                                            
(
	
 cod_animal integer CHECK (cod_animal>0) NOT NULL,	
 nombreA varchar(255) NOT NULL,
 descripcionA varchar(255) NOT NULL,	
 
 CONSTRAINT "animal_pkey" PRIMARY KEY (cod_animal)
); 

CREATE TABLE Alimento                                           
(
	
 cod_alimento integer CHECK (cod_alimento>0) NOT NULL,	
 costoAlimento integer CHECK (costoAlimento>0) NOT NULL,
 nombreAlimento varchar(255) NOT NULL,
 descripcionAlimento varchar(255) NOT NULL,
  
 CONSTRAINT "alimento_pkey" PRIMARY KEY (cod_alimento)
); 

CREATE TABLE Raza
(
	
 cod_raza integer NOT NULL CHECK (cod_raza>0) ,	
 cod_animal integer NOT NULL CHECK (cod_animal>0),
 nombreR varchar(255) NOT NULL,	
 descripcionR varchar(255) NOT NULL,
 paisOrigen varchar(255) NOT NULL,	
 nivel_inteligencia dom_inteligencia,
 contextura_fuerte dom_contextura,
 altura_min integer CHECK (altura_min>0) NOT NULL,
 altura_max integer CHECK (altura_max>0) NOT NULL,
 porcion_diaria integer CHECK (porcion_diaria>0) NOT NULL,
 talla dom_talla,
 color_pelaje varchar(255) NOT NULL,
 cod_alimento integer CHECK (cod_alimento>0) NOT NULL,
 
 CONSTRAINT "raza_pkey" PRIMARY KEY (cod_raza),
	
	CONSTRAINT Fk_detalleAnimal
	FOREIGN KEY (cod_animal) REFERENCES animal(cod_animal)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleAlimento
	FOREIGN KEY (cod_alimento) REFERENCES alimento(cod_alimento)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
);


CREATE TABLE Veterinario                                  
(
	
 cod_vet integer NOT NULL,	
 nombreV varchar(255) NOT NULL,
 telefonoV varchar(255) NOT NULL,

 CONSTRAINT "veterinario_pkey" PRIMARY KEY (cod_vet)
); 

CREATE TABLE Responsable                              
(
	
 cod_responsable integer NOT NULL,	
 nombreR varchar(255) NOT NULL,
 emailR varchar(255) NOT NULL,

 CONSTRAINT "responsable_pkey" PRIMARY KEY (cod_responsable)
); 



CREATE TABLE Mascota                                            
(
	
 cod_mascota integer CHECK (cod_mascota>0) NOT NULL,	
 cod_raza integer CHECK (cod_raza>0) NOT NULL,
 nombreM varchar(255) NOT NULL,	
 edadM integer CHECK (edadM>0) NOT NULL,
 sexoM dom_sexo,
 pesoM integer CHECK (pesoM>0) NOT NULL,
 cod_vet integer CHECK (cod_vet>0) NOT NULL, 
 fechaN date NOT NULL,	
 cod_responsable integer CHECK (cod_responsable>0) NOT NULL,
 
 
 CONSTRAINT "mascota_pkey" PRIMARY KEY (cod_mascota),
	
	
	CONSTRAINT Fk_detalleRaza
	FOREIGN KEY (cod_raza) REFERENCES raza(cod_raza)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleVet
	FOREIGN KEY (cod_vet) REFERENCES veterinario(cod_vet)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleResponsable
	FOREIGN KEY (cod_responsable) REFERENCES responsable(cod_responsable)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 



CREATE TABLE FichaRegistro                                   
(
	
 cod_ficha integer CHECK (cod_ficha>0) NOT NULL,	
 cod_mascota integer CHECK (cod_mascota>0) NOT NULL,
 cod_servicio integer CHECK (cod_servicio>0) NOT NULL,
 autorizado varchar(255) NOT NULL,	
 fechaEnt date NOT NULL,
 horaEnt time NOT NULL,	      
 horaSe time NOT NULL,
 fechaSr date NOT NULL, 
 horaSr time NOT NULL,	
 fechaSe date NOT NULL,	
 
 CONSTRAINT "fichaRegistro_pkey" PRIMARY KEY (cod_ficha),
	
	CONSTRAINT Fk_detalleMascota
	FOREIGN KEY (cod_mascota) REFERENCES mascota(cod_mascota)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleServicio
	FOREIGN KEY (cod_servicio) REFERENCES servicio(cod_servicio)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 



CREATE TABLE FacturaTienda     
(
	
 numFact integer CHECK (numFact>0) NOT NULL,	
 fecha date NOT NULL,
 cod_responsable integer CHECK (cod_responsable>0) NOT NULL,
 cod_modalidad integer CHECK (cod_modalidad>0) NOT NULL,

 CONSTRAINT "facturaTienda_pkey" PRIMARY KEY (numFact),

	CONSTRAINT Fk_detalleResponsable
	FOREIGN KEY (cod_responsable) REFERENCES responsable(cod_responsable)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
	
	/* if tal es null elige este sino este 
	CONSTRAINT Fk_detalleModalidad
	FOREIGN KEY (cod_modalidad) REFERENCES responsable(cod_modalidad)
	ON UPDATE CASCADE
	ON DELETE RESTRICT */
	
); 


CREATE TABLE ModalidadCheque        
(
	
 cod_modalidad integer CHECK (cod_modalidad>0) NOT NULL,	
 fecha_pago date NOT NULL,
 monto integer CHECK (monto>0) NOT NULL,
 nombre_banco varchar(255) NOT NULL,
 num_cheque integer CHECK (num_cheque>0) NOT NULL,
 
 CONSTRAINT "modalidadCheque_pkey" PRIMARY KEY (cod_modalidad)
); 


CREATE TABLE ModalidadTarjeta                          
(
	
 cod_modalidad integer CHECK (cod_modalidad>0) NOT NULL,	
 fecha_pagoT date NOT NULL,
 montoT integer CHECK (montoT>0) NOT NULL,
 nombreBancoT varchar(255) NOT NULL,
 num_tarjeta integer CHECK (num_tarjeta>0) NOT NULL,
 
 CONSTRAINT "modalidadTarjeta_pkey" PRIMARY KEY (cod_modalidad)
); 


CREATE TABLE ModalidadEfectivo 
(
	
 cod_modalidad integer CHECK (cod_modalidad>0) NOT NULL,	
 fecha_pagoE date NOT NULL,
 montoE integer CHECK (montoE>0) NOT NULL,

 CONSTRAINT "modalidadEfectivo_pkey" PRIMARY KEY (cod_modalidad)
); 


CREATE TABLE OrdenCompra 
(
	
 cod_compra integer CHECK (cod_compra>0) NOT NULL,	
 fechaComp date NOT NULL,
 RIF varchar(255) NOT NULL,
 
 CONSTRAINT "ordenCompra_pkey" PRIMARY KEY (cod_compra),
	
	CONSTRAINT Fk_detalleRif
	FOREIGN KEY (RIF) REFERENCES franquicia(RIF)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE FacturaProveedor
(
	
 n_fact integer CHECK (n_fact>0) NOT NULL,	
 fecha_factP date NOT NULL,
 montoTotalP integer CHECK (montoTotalP>0) NOT NULL,
 RIF varchar(255) NOT NULL,

 CONSTRAINT "factProv_pkey" PRIMARY KEY (n_fact),
	
	CONSTRAINT Fk_detalleRif
	FOREIGN KEY (RIF) REFERENCES franquicia(RIF)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE Inventario                                           
(
	
 cod_ajuste integer CHECK (cod_ajuste>0) NOT NULL,	
 fecha_ajuste date NOT NULL,
 cod_producto integer CHECK (cod_producto>0) NOT NULL,
 cantidadInv integer CHECK (cantidadInv>0) NOT NULL,
 tipoAjuste varchar(255) NOT NULL, 
 
 CONSTRAINT "inventario_pkey" PRIMARY KEY (cod_ajuste),

	CONSTRAINT Fk_detalleProducto
	FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE Vacuna                                            
(
	
 cod_vacuna integer CHECK (cod_vacuna>0) NOT NULL,	
 montoVacuna integer CHECK (montoVacuna>0) NOT NULL,
 nombreVacuna varchar(255) NOT NULL,
 descripcionVacuna varchar(255) NOT NULL,
 
 CONSTRAINT "vacuna_pkey" PRIMARY KEY (cod_vacuna)
); 

CREATE TABLE VacunaPorRaza   
(
	
 cod_vacuna integer CHECK (cod_vacuna>0) NOT NULL,
 cod_raza integer CHECK (cod_raza>0) NOT NULL,
 edadMin integer CHECK (edadMin>0) NOT NULL,
 edadMax integer CHECK (edadMax>0) NOT NULL,
 dosis float CHECK (dosis>0.0) NOT NULL,

 CONSTRAINT "vacunaPorRaza_pkey" PRIMARY KEY (cod_vacuna,cod_raza),

	CONSTRAINT Fk_detalleVacuna
	FOREIGN KEY (cod_vacuna) REFERENCES vacuna(cod_vacuna)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleRaza
	FOREIGN KEY (cod_raza) REFERENCES raza(cod_raza)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE ServiciosPorFacturaServicio
(
	
 cod_servicio integer CHECK (cod_servicio>0) NOT NULL,	
 cod_fact integer CHECK (cod_fact>0) NOT NULL,
 
 CONSTRAINT "servicioPorFacturaServicio_pkey" PRIMARY KEY (cod_servicio,cod_fact),
	
	CONSTRAINT Fk_detalleServicio
	FOREIGN KEY (Cod_servicio) REFERENCES servicio(Cod_servicio)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleFactura
	FOREIGN KEY (cod_fact) REFERENCES facturaservicio(cod_fact)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 

CREATE TABLE TelefonosResponsables
(
	
 cod_responsable integer CHECK (cod_responsable>0) NOT NULL,	
 Ntelefono integer CHECK (Ntelefono>0) NOT NULL,
 
 CONSTRAINT "telefonoResponsable_pkey" PRIMARY KEY (cod_responsable,Ntelefono),
	
	CONSTRAINT Fk_detalleResponsable
	FOREIGN KEY (cod_responsable) REFERENCES responsable(cod_responsable)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 

CREATE TABLE Enfermedades_Sufridas_Mascotas                                            
(
	
 nombreEnf varchar(255),	
 cod_mascota integer CHECK (cod_mascota>0) NOT NULL,
 
 CONSTRAINT "enfermedadesSufridasMascotas_pkey" PRIMARY KEY (nombreEnf,cod_mascota),
	
	CONSTRAINT Fk_detalleMascota
	FOREIGN KEY (cod_mascota) REFERENCES mascota(cod_mascota)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE Vacunas_Aplicadas_Mascotas                                           
(
	
 fechaAplicacion date,	
 cod_vacuna integer CHECK (cod_vacuna>0) NOT NULL,
 cod_mascota integer CHECK (cod_mascota>0) NOT NULL,
	
 CONSTRAINT "vacunasAplicadas_pkey" PRIMARY KEY (cod_vacuna,cod_mascota),
	
	CONSTRAINT Fk_detalleVacuna
	FOREIGN KEY (cod_vacuna) REFERENCES vacuna(cod_vacuna)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleMascota
	FOREIGN KEY (cod_mascota) REFERENCES mascota(cod_mascota)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE RelacionesMascota
(
	
 parentesco varchar(255),	
 cod_mascota integer CHECK (cod_mascota>0) NOT NULL,
 cod_mascotaRelacion integer CHECK (cod_mascotaRelacion>0) NOT NULL,
	
 CONSTRAINT "relacionesMascota_pkey" PRIMARY KEY (cod_mascota,cod_mascotaRelacion),
	
	CONSTRAINT Fk_detalleMascota
	FOREIGN KEY (cod_mascota) REFERENCES mascota(cod_mascota)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleMascotaParentesco
	FOREIGN KEY (cod_mascotaRelacion) REFERENCES mascota(cod_mascota)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE Productos_Factura_Tienda
(
		
 cod_producto integer CHECK (cod_producto>0) NOT NULL,
 numFact integer CHECK (numFact>0) NOT NULL,
 cantidad integer CHECK (cantidad>0) NOT NULL,
 precio float CHECK (precio>0.0) NOT NULL,
 descuento integer CHECK (descuento>0) NOT NULL,
	
 CONSTRAINT "productFactTienda_pkey" PRIMARY KEY (cod_producto,numFact),
	
	CONSTRAINT Fk_detalleProducto
	FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleFactTienda
	FOREIGN KEY (numFact) REFERENCES facturaTienda(numFact)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 

CREATE TABLE Productos_Orden_Compra
(
	
 cantidad integer CHECK (cantidad>0) NOT NULL,	
 cod_producto integer CHECK (cod_producto>0) NOT NULL,
 cod_compra integer CHECK (cod_compra>0) NOT NULL,
	
 CONSTRAINT "productosOrdenCompra_pkey" PRIMARY KEY (cod_producto,cod_compra),
	
	CONSTRAINT Fk_detalleProducto
	FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleCompra
	FOREIGN KEY (cod_compra) REFERENCES ordenCompra(cod_compra)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE Proveedor                                            
(
	
 RIFProveedor varchar(255) NOT NULL,
 nombreProv varchar(255) NOT NULL,
 direccionProv varchar(255) NOT NULL,
 telefonoLocalProv integer CHECK (telefonoLocalProv>0) NOT NULL,
 telefonoCelularProv integer CHECK (telefonoCelularProv>0) NOT NULL,
 personaContacto varchar(255) NOT NULL,
	
 CONSTRAINT "proveedor_pkey" PRIMARY KEY (RIFProveedor)
); 

CREATE TABLE Productos_Distribuidos_Proveedor
(
	
 RIFProveedor varchar(255) NOT NULL,
 cod_producto integer CHECK (cod_producto>0) NOT NULL,
 
	
 CONSTRAINT "productosDistribuidosProveedor_pkey" PRIMARY KEY (RIFProveedor,cod_producto),
	
	CONSTRAINT Fk_detalleRIFProveedor
	FOREIGN KEY (RIFProveedor) REFERENCES proveedor(RIFProveedor)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleProducto
	FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 


CREATE TABLE Productos_Factura_Proveedor                                            
(
	
 RIFProveedor varchar(255) NOT NULL,
 cod_producto integer CHECK (cod_producto>0) NOT NULL,
 cantidad integer CHECK (cantidad>0) NOT NULL,
 precio float CHECK (precio>0.0) NOT NULL,
	
 CONSTRAINT "productosFacturaProveedor_pkey" PRIMARY KEY (RIFProveedor,cod_producto),
	
	CONSTRAINT Fk_detalleRIFProveedor
	FOREIGN KEY (RIFProveedor) REFERENCES proveedor(RIFProveedor)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
	
	CONSTRAINT Fk_detalleProducto
	FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
); 
