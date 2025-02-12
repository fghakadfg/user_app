PGDMP  !    -                |            postgres    16.2    16.2    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5    postgres    DATABASE     j   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3977                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    7            �           0    0    SCHEMA public    ACL     +   GRANT ALL ON SCHEMA public TO it_employee;
                   pg_database_owner    false    7                        1255    17099 $   get_employees_on_production(integer)    FUNCTION     �  CREATE FUNCTION public.get_employees_on_production(articul integer) RETURNS TABLE(idemployee integer, name character varying, lastname character varying)
    LANGUAGE plpgsql
    AS $$
begin
	
	return query
	
	select e."idEmployees" as id, e."Name" as nameEmployee, e."Lastname" as lastName from employees e 
	join manufactured_products mp on mp."Responsible"  = e."idEmployees" 
	where mp."IndividualNumber" = articul;
	
	
END
$$;
 C   DROP FUNCTION public.get_employees_on_production(articul integer);
       public          postgres    false    7            ,           1255    17134 ,   get_production_manfucature_count(date, date)    FUNCTION     �  CREATE FUNCTION public.get_production_manfucature_count(startdate date, enddate date) RETURNS TABLE(nameofproduction character varying, countprod bigint)
    LANGUAGE plpgsql
    AS $$
begin
	return query
	SELECT p."NameOfProduction",
    count(*) AS count
   FROM manufactured_products mp
   JOIN production p ON p."idProduction" = mp."idProduct"
   where mp."DateOfManufact" between startDate and endDate
   GROUP BY p."NameOfProduction";
	
	
END
$$;
 U   DROP FUNCTION public.get_production_manfucature_count(startdate date, enddate date);
       public          postgres    false    7            -           1255    17131    insert_check()    FUNCTION     �  CREATE FUNCTION public.insert_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	
	
	if new."Family_status" is null or new."Family_status" = '' then
		new."Family_status" := 'не указан';

	
		
	end if;

 
	INSERT INTO history_of_updates ("TableToupdate" , "operation_type" , "idrecord", "dateofupdate")
	values (TG_TABLE_NAME, TG_OP, new."idEmployees", now());

	return new;
end;


$$;
 %   DROP FUNCTION public.insert_check();
       public          postgres    false    7            I           1255    17217 ,   insert_it_access(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.insert_it_access(IN idempl integer, IN emplpassword character varying)
    LANGUAGE plpgsql
    AS $$
	BEGIN
	
	if (select e."PositionID" from employees e where e."idEmployees" = idempl) = 14 then 
		INSERT INTO it_access (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
		
	elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 3 then 
		INSERT INTO it_access (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
    elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 7 then 
		INSERT INTO it_access (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
	else
		raise notice 'нет айтишник';
	end if;
		
	end;
$$;
 ^   DROP PROCEDURE public.insert_it_access(IN idempl integer, IN emplpassword character varying);
       public          postgres    false    7            H           1255    17216 0   insert_lawyer_access(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.insert_lawyer_access(IN idempl integer, IN emplpassword character varying)
    LANGUAGE plpgsql
    AS $$
	BEGIN
	
	if (select e."PositionID" from employees e where e."idEmployees" = idempl) = 6 then 
		INSERT INTO lawyer_acces (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
		
	elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 1 then 
		INSERT INTO lawyer_acces (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
    elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 11 then 
		INSERT INTO lawyer_acces (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
	elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 12 then 
		INSERT INTO lawyer_acces (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
	elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 15 then 
		INSERT INTO lawyer_acces (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
    elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 2 then 
		INSERT INTO lawyer_acces (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
	else
		raise notice 'нет бумажная должность';
	end if;
		
	end;
$$;
 b   DROP PROCEDURE public.insert_lawyer_access(IN idempl integer, IN emplpassword character varying);
       public          postgres    false    7            G           1255    17178 .   insert_tech_access(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.insert_tech_access(IN idempl integer, IN emplpassword character varying)
    LANGUAGE plpgsql
    AS $$
	BEGIN
	
	if (select e."PositionID" from employees e where e."idEmployees" = idempl) = 4 then 
		INSERT INTO tech_access (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
		
	elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 5 then 
		INSERT INTO tech_access (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
    elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 13 then 
		INSERT INTO tech_access (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));
	elsif (select e."PositionID" from employees e where e."idEmployees" = idempl) = 9 then 
		INSERT INTO tech_access (idemployee, employee_password , hash)
    	VALUES (idempl, emplpassword, concat(digest(emplpassword, 'sha256'), gen_salt('md5')));

	else
		raise notice 'нет тех специалист';
	end if;
		
	end;
$$;
 `   DROP PROCEDURE public.insert_tech_access(IN idempl integer, IN emplpassword character varying);
       public          postgres    false    7            *           1255    17124    log_table_changes()    FUNCTION       CREATE FUNCTION public.log_table_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 
   
	INSERT INTO history_of_updates ("TableToupdate" , "operation_type" , "idrecord", "dateofupdate")
	values (TG_TABLE_NAME, TG_OP, new."idEmployees", now());

    RETURN NEW;

END;
$$;
 *   DROP FUNCTION public.log_table_changes();
       public          postgres    false    7            J           1255    17102 '   update_employee_bonus(integer, integer) 	   PROCEDURE       CREATE PROCEDURE public.update_employee_bonus(IN id_empl integer, IN articul integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    date_of_manufact date;
    plan_date_of_manufact date;
BEGIN
    SELECT mp."DateOfManufact" INTO date_of_manufact 
    FROM manufactured_products mp
    JOIN employees e ON e."idEmployees" = mp."Responsible"
    WHERE mp."IndividualNumber" = articul;
    
    SELECT g."DateOfPlamEnd" INTO plan_date_of_manufact 
    FROM goals g
    WHERE g."idManufacturedProd" = articul;
    
    IF date_of_manufact < plan_date_of_manufact THEN
        UPDATE employees 
        SET bonus = 15000
        WHERE "idEmployees" = id_empl;
    ELSE
        UPDATE employees 
        SET bonus = 0
        WHERE "idEmployees" = id_empl;
    END IF;
END;
$$;
 U   DROP PROCEDURE public.update_employee_bonus(IN id_empl integer, IN articul integer);
       public          postgres    false    7            �           0    0 G   PROCEDURE update_employee_bonus(IN id_empl integer, IN articul integer)    ACL     m   GRANT ALL ON PROCEDURE public.update_employee_bonus(IN id_empl integer, IN articul integer) TO "Accountant";
          public          postgres    false    330            �            1259    16411    archive    TABLE     �   CREATE TABLE public.archive (
    "idArchive" integer NOT NULL,
    "Type" character varying(45) NOT NULL,
    "Volume" integer NOT NULL
);
    DROP TABLE public.archive;
       public         heap    postgres    false    7            �            1259    16410    archive_idArchive_seq    SEQUENCE     �   CREATE SEQUENCE public."archive_idArchive_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."archive_idArchive_seq";
       public          postgres    false    7    219            �           0    0    archive_idArchive_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."archive_idArchive_seq" OWNED BY public.archive."idArchive";
          public          postgres    false    218                       1259    16844    blueprint_production    TABLE     v   CREATE TABLE public.blueprint_production (
    "IdBlueprint" integer NOT NULL,
    "IdProduction" integer NOT NULL
);
 (   DROP TABLE public.blueprint_production;
       public         heap    postgres    false    7            �           0    0    TABLE blueprint_production    ACL     �   GRANT SELECT ON TABLE public.blueprint_production TO "Techician_lead";
GRANT SELECT ON TABLE public.blueprint_production TO "Technicican";
          public          postgres    false    260            �            1259    16418 
   blueprints    TABLE     �   CREATE TABLE public.blueprints (
    "idBlueprints" integer NOT NULL,
    "Description" character varying(45) NOT NULL,
    "ArchiveID" integer NOT NULL
);
    DROP TABLE public.blueprints;
       public         heap    postgres    false    7            �           0    0    TABLE blueprints    ACL     w   GRANT SELECT ON TABLE public.blueprints TO "Techician_lead";
GRANT SELECT ON TABLE public.blueprints TO "Technicican";
          public          postgres    false    221            �            1259    16417    blueprints_idBlueprints_seq    SEQUENCE     �   CREATE SEQUENCE public."blueprints_idBlueprints_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."blueprints_idBlueprints_seq";
       public          postgres    false    221    7            �           0    0    blueprints_idBlueprints_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."blueprints_idBlueprints_seq" OWNED BY public.blueprints."idBlueprints";
          public          postgres    false    220            �            1259    16430    clients    TABLE     �   CREATE TABLE public.clients (
    "idClients" integer NOT NULL,
    "NameOfClient" character varying(45) NOT NULL,
    "Contact" character varying(45) NOT NULL
);
    DROP TABLE public.clients;
       public         heap    postgres    false    7            �           0    0    TABLE clients    ACL     m   GRANT SELECT ON TABLE public.clients TO lawyer;
GRANT SELECT,INSERT ON TABLE public.clients TO "Accountant";
          public          postgres    false    223            �            1259    16429    clients_idClients_seq    SEQUENCE     �   CREATE SEQUENCE public."clients_idClients_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."clients_idClients_seq";
       public          postgres    false    7    223            �           0    0    clients_idClients_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."clients_idClients_seq" OWNED BY public.clients."idClients";
          public          postgres    false    222            �            1259    16437 
   components    TABLE     �   CREATE TABLE public.components (
    "idComponents" integer NOT NULL,
    "Name" character varying(45),
    "Quantity" integer NOT NULL
);
    DROP TABLE public.components;
       public         heap    postgres    false    7            �           0    0    TABLE components    ACL     w   GRANT SELECT ON TABLE public.components TO "Techician_lead";
GRANT SELECT ON TABLE public.components TO "Technicican";
          public          postgres    false    225            �            1259    16436    components_idComponents_seq    SEQUENCE     �   CREATE SEQUENCE public."components_idComponents_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."components_idComponents_seq";
       public          postgres    false    225    7            �           0    0    components_idComponents_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."components_idComponents_seq" OWNED BY public.components."idComponents";
          public          postgres    false    224                       1259    16958    components_production    TABLE     �   CREATE TABLE public.components_production (
    "idProduct" integer NOT NULL,
    "idComponent" integer NOT NULL,
    "Quantity" integer NOT NULL
);
 )   DROP TABLE public.components_production;
       public         heap    postgres    false    7            �           0    0    TABLE components_production    ACL     �   GRANT SELECT ON TABLE public.components_production TO "Techician_lead";
GRANT SELECT ON TABLE public.components_production TO "Technicican";
          public          postgres    false    262            �            1259    16776 	   contracts    TABLE       CREATE TABLE public.contracts (
    "idContracts" integer NOT NULL,
    "Name" character varying(45) NOT NULL,
    "DateOfAgreement" date NOT NULL,
    "EmploID" integer NOT NULL,
    "ClientID" integer NOT NULL,
    "Status" character varying(45) NOT NULL
);
    DROP TABLE public.contracts;
       public         heap    postgres    false    7            �           0    0    TABLE contracts    ACL     q   GRANT SELECT ON TABLE public.contracts TO lawyer;
GRANT SELECT,INSERT ON TABLE public.contracts TO "Accountant";
          public          postgres    false    255            �            1259    16775    contracts_idContracts_seq    SEQUENCE     �   CREATE SEQUENCE public."contracts_idContracts_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."contracts_idContracts_seq";
       public          postgres    false    7    255            �           0    0    contracts_idContracts_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."contracts_idContracts_seq" OWNED BY public.contracts."idContracts";
          public          postgres    false    254            �            1259    16456    departments    TABLE     �   CREATE TABLE public.departments (
    "idDepartments" integer NOT NULL,
    "Name" character varying(45) NOT NULL,
    "Specialization" character varying(45) NOT NULL
);
    DROP TABLE public.departments;
       public         heap    postgres    false    7            �            1259    16455    departments_idDepartments_seq    SEQUENCE     �   CREATE SEQUENCE public."departments_idDepartments_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public."departments_idDepartments_seq";
       public          postgres    false    7    227            �           0    0    departments_idDepartments_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public."departments_idDepartments_seq" OWNED BY public.departments."idDepartments";
          public          postgres    false    226                       1259    17055    employee_feedback    TABLE     �   CREATE TABLE public.employee_feedback (
    "idFeedback" integer NOT NULL,
    "EmployeeID" integer NOT NULL,
    "Comment" text NOT NULL,
    "Date" date NOT NULL
);
 %   DROP TABLE public.employee_feedback;
       public         heap    postgres    false    7            �           0    0    TABLE employee_feedback    ACL     M  GRANT INSERT ON TABLE public.employee_feedback TO "Techician_lead";
GRANT INSERT ON TABLE public.employee_feedback TO "Technicican";
GRANT INSERT ON TABLE public.employee_feedback TO lawyer;
GRANT SELECT,INSERT ON TABLE public.employee_feedback TO med_employee;
GRANT SELECT,INSERT ON TABLE public.employee_feedback TO "Accountant";
          public          postgres    false    267            
           1259    17054     employee_feedback_idFeedback_seq    SEQUENCE     �   CREATE SEQUENCE public."employee_feedback_idFeedback_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."employee_feedback_idFeedback_seq";
       public          postgres    false    267    7            �           0    0     employee_feedback_idFeedback_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."employee_feedback_idFeedback_seq" OWNED BY public.employee_feedback."idFeedback";
          public          postgres    false    266                        1259    16792    employee_transport    TABLE     r   CREATE TABLE public.employee_transport (
    "EmployeeID" integer NOT NULL,
    "TransportID" integer NOT NULL
);
 &   DROP TABLE public.employee_transport;
       public         heap    postgres    false    7            �            1259    16648 	   employees    TABLE     "  CREATE TABLE public.employees (
    "idEmployees" integer NOT NULL,
    "Lastname" character varying(45) NOT NULL,
    "Name" character varying(45) NOT NULL,
    "Surname" character varying(45),
    "PositionID" integer NOT NULL,
    "Phone" character varying(45) NOT NULL,
    "Passport" bigint NOT NULL,
    "Education" character varying(45),
    "Adress" character varying(120) NOT NULL,
    "Family_status" character varying(45),
    "Insurance_policy" character varying(45) NOT NULL,
    "Department" integer,
    bonus integer DEFAULT 0
);
    DROP TABLE public.employees;
       public         heap    postgres    false    7            �           0    0    TABLE employees    ACL     �   GRANT SELECT ON TABLE public.employees TO lawyer;
GRANT SELECT ON TABLE public.employees TO med_employee;
GRANT SELECT,INSERT ON TABLE public.employees TO "Accountant";
          public          postgres    false    243            �            1259    16647    employees_idEmployees_seq    SEQUENCE     �   CREATE SEQUENCE public."employees_idEmployees_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."employees_idEmployees_seq";
       public          postgres    false    7    243            �           0    0    employees_idEmployees_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."employees_idEmployees_seq" OWNED BY public.employees."idEmployees";
          public          postgres    false    242                       1259    16829    extreme_firefighteq    TABLE     t   CREATE TABLE public.extreme_firefighteq (
    "idExtreme" integer NOT NULL,
    "idFireFightEq" integer NOT NULL
);
 '   DROP TABLE public.extreme_firefighteq;
       public         heap    postgres    false    7                       1259    16973    extremesit_medeq    TABLE     k   CREATE TABLE public.extremesit_medeq (
    "idExtreme" integer NOT NULL,
    "idMedEq" integer NOT NULL
);
 $   DROP TABLE public.extremesit_medeq;
       public         heap    postgres    false    7            �           0    0    TABLE extremesit_medeq    ACL     F   GRANT SELECT,INSERT ON TABLE public.extremesit_medeq TO med_employee;
          public          postgres    false    263            �            1259    16480    extremesituations    TABLE     �   CREATE TABLE public.extremesituations (
    "idExtremeSituations" integer NOT NULL,
    "Name" character varying(45) NOT NULL,
    "Date" date
);
 %   DROP TABLE public.extremesituations;
       public         heap    postgres    false    7            �            1259    16479 )   extremesituations_idExtremeSituations_seq    SEQUENCE     �   CREATE SEQUENCE public."extremesituations_idExtremeSituations_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public."extremesituations_idExtremeSituations_seq";
       public          postgres    false    7    229            �           0    0 )   extremesituations_idExtremeSituations_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public."extremesituations_idExtremeSituations_seq" OWNED BY public.extremesituations."idExtremeSituations";
          public          postgres    false    228                       1259    16818    fire_fighting_equipment    TABLE     �   CREATE TABLE public.fire_fighting_equipment (
    "idFire_fighting_equipment" integer NOT NULL,
    "Name" character varying(45) NOT NULL,
    "Quantity" integer NOT NULL,
    "Responsible" integer NOT NULL
);
 +   DROP TABLE public.fire_fighting_equipment;
       public         heap    postgres    false    7                       1259    16817 5   fire_fighting_equipment_idFire_fighting_equipment_seq    SEQUENCE     �   CREATE SEQUENCE public."fire_fighting_equipment_idFire_fighting_equipment_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 N   DROP SEQUENCE public."fire_fighting_equipment_idFire_fighting_equipment_seq";
       public          postgres    false    258    7            �           0    0 5   fire_fighting_equipment_idFire_fighting_equipment_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public."fire_fighting_equipment_idFire_fighting_equipment_seq" OWNED BY public.fire_fighting_equipment."idFire_fighting_equipment";
          public          postgres    false    257                       1259    16901    manufactured_products    TABLE     �   CREATE TABLE public.manufactured_products (
    "idProduct" integer NOT NULL,
    "IndividualNumber" integer NOT NULL,
    "Responsible" integer NOT NULL,
    "DateOfManufact" date NOT NULL
);
 )   DROP TABLE public.manufactured_products;
       public         heap    postgres    false    7            �           0    0    TABLE manufactured_products    ACL     �   GRANT SELECT,INSERT ON TABLE public.manufactured_products TO "Techician_lead";
GRANT SELECT ON TABLE public.manufactured_products TO "Technicican";
          public          postgres    false    261            �            1259    16721 
   production    TABLE        CREATE TABLE public.production (
    "idProduction" integer NOT NULL,
    "NameOfProduction" character varying(45) NOT NULL
);
    DROP TABLE public.production;
       public         heap    postgres    false    7            �           0    0    TABLE production    ACL     w   GRANT SELECT ON TABLE public.production TO "Techician_lead";
GRANT SELECT ON TABLE public.production TO "Technicican";
          public          postgres    false    249                       1259    17111     get_production_manfucature_count    VIEW     �   CREATE VIEW public.get_production_manfucature_count AS
 SELECT p."NameOfProduction",
    count(*) AS count
   FROM (public.manufactured_products mp
     JOIN public.production p ON ((p."idProduction" = mp."idProduct")))
  GROUP BY p."NameOfProduction";
 3   DROP VIEW public.get_production_manfucature_count;
       public          postgres    false    249    261    249    7            	           1259    17015    goals    TABLE     �   CREATE TABLE public.goals (
    "IdMonthGoal" integer NOT NULL,
    "ProductionID" integer NOT NULL,
    "ContractID" integer NOT NULL,
    "DateOfPlanStart" date NOT NULL,
    "DateOfPlamEnd" date NOT NULL,
    "idManufacturedProd" integer
);
    DROP TABLE public.goals;
       public         heap    postgres    false    7                       1259    17014    goals_IdMonthGoal_seq    SEQUENCE     �   CREATE SEQUENCE public."goals_IdMonthGoal_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."goals_IdMonthGoal_seq";
       public          postgres    false    7    265            �           0    0    goals_IdMonthGoal_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public."goals_IdMonthGoal_seq" OWNED BY public.goals."IdMonthGoal";
          public          postgres    false    264                       1259    17116    history_of_updates    TABLE     �   CREATE TABLE public.history_of_updates (
    idupdate smallint NOT NULL,
    "TableToupdate" character varying,
    operation_type character varying,
    dateofupdate date,
    idrecord bigint
);
 &   DROP TABLE public.history_of_updates;
       public         heap    postgres    false    7                       1259    17115    history_of_updates_idupdate_seq    SEQUENCE     �   ALTER TABLE public.history_of_updates ALTER COLUMN idupdate ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.history_of_updates_idupdate_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    7    270                       1259    17159 	   it_access    TABLE     �   CREATE TABLE public.it_access (
    idemployee integer NOT NULL,
    employee_password character varying,
    hash character varying
);
    DROP TABLE public.it_access;
       public         heap    postgres    false    7                       1259    17149    lawyer_acces    TABLE     �   CREATE TABLE public.lawyer_acces (
    idemployee integer NOT NULL,
    employee_password character varying,
    hash character varying
);
     DROP TABLE public.lawyer_acces;
       public         heap    postgres    false    7            �            1259    16692    med_exam    TABLE     �   CREATE TABLE public.med_exam (
    "idMed_exam" integer NOT NULL,
    "IdEmployee" integer NOT NULL,
    "Doctor" integer NOT NULL,
    "Date" date NOT NULL
);
    DROP TABLE public.med_exam;
       public         heap    postgres    false    7            �           0    0    TABLE med_exam    ACL     >   GRANT SELECT,INSERT ON TABLE public.med_exam TO med_employee;
          public          postgres    false    245            �            1259    16691    med_exam_idMed_exam_seq    SEQUENCE     �   CREATE SEQUENCE public."med_exam_idMed_exam_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."med_exam_idMed_exam_seq";
       public          postgres    false    245    7            �           0    0    med_exam_idMed_exam_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."med_exam_idMed_exam_seq" OWNED BY public.med_exam."idMed_exam";
          public          postgres    false    244            �            1259    16709    medical_equipment    TABLE     �   CREATE TABLE public.medical_equipment (
    "idMedical_equipment" integer NOT NULL,
    "Name" character varying(45) NOT NULL,
    "Quantity" integer NOT NULL,
    "Responsible" integer NOT NULL
);
 %   DROP TABLE public.medical_equipment;
       public         heap    postgres    false    7            �           0    0    TABLE medical_equipment    ACL     G   GRANT SELECT,INSERT ON TABLE public.medical_equipment TO med_employee;
          public          postgres    false    247            �            1259    16708 )   medical_equipment_idMedical_equipment_seq    SEQUENCE     �   CREATE SEQUENCE public."medical_equipment_idMedical_equipment_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public."medical_equipment_idMedical_equipment_seq";
       public          postgres    false    7    247            �           0    0 )   medical_equipment_idMedical_equipment_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public."medical_equipment_idMedical_equipment_seq" OWNED BY public.medical_equipment."idMedical_equipment";
          public          postgres    false    246            �            1259    16513    orders    TABLE     �   CREATE TABLE public.orders (
    "idOrder" integer NOT NULL,
    "DateOfOrder" date NOT NULL,
    "DateOfDelivery" date NOT NULL,
    "DateOfPaid" date NOT NULL,
    "SumOfOrder" double precision NOT NULL,
    "ClientID" integer NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false    7            �           0    0    TABLE orders    ACL     k   GRANT SELECT,INSERT ON TABLE public.orders TO lawyer;
GRANT SELECT ON TABLE public.orders TO "Accountant";
          public          postgres    false    231            �            1259    16512    orders_idOrder_seq    SEQUENCE     �   CREATE SEQUENCE public."orders_idOrder_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."orders_idOrder_seq";
       public          postgres    false    7    231            �           0    0    orders_idOrder_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."orders_idOrder_seq" OWNED BY public.orders."idOrder";
          public          postgres    false    230            �            1259    16525 	   positions    TABLE     �   CREATE TABLE public.positions (
    "idPositions" integer NOT NULL,
    "Name" character varying(45) NOT NULL,
    "Salary" double precision NOT NULL
);
    DROP TABLE public.positions;
       public         heap    postgres    false    7            �            1259    16524    positions_idPositions_seq    SEQUENCE     �   CREATE SEQUENCE public."positions_idPositions_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."positions_idPositions_seq";
       public          postgres    false    7    233            �           0    0    positions_idPositions_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."positions_idPositions_seq" OWNED BY public.positions."idPositions";
          public          postgres    false    232            �            1259    16720    production_idProduction_seq    SEQUENCE     �   CREATE SEQUENCE public."production_idProduction_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."production_idProduction_seq";
       public          postgres    false    249    7            �           0    0    production_idProduction_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public."production_idProduction_seq" OWNED BY public.production."idProduction";
          public          postgres    false    248            �            1259    16545    project_departments    TABLE     s   CREATE TABLE public.project_departments (
    "idProject" integer NOT NULL,
    "idDepartment" integer NOT NULL
);
 '   DROP TABLE public.project_departments;
       public         heap    postgres    false    7            �            1259    16732    project_empl    TABLE     j   CREATE TABLE public.project_empl (
    "idEmployee" integer NOT NULL,
    "idProject" integer NOT NULL
);
     DROP TABLE public.project_empl;
       public         heap    postgres    false    7            �            1259    16747    project_progress    TABLE     �   CREATE TABLE public.project_progress (
    "idProject" integer NOT NULL,
    "idProduction" integer NOT NULL,
    "Percent" integer NOT NULL
);
 $   DROP TABLE public.project_progress;
       public         heap    postgres    false    7            �           0    0    TABLE project_progress    ACL     C   GRANT SELECT ON TABLE public.project_progress TO "Techician_lead";
          public          postgres    false    251            �            1259    16539    projects    TABLE     �   CREATE TABLE public.projects (
    "idProjects" integer NOT NULL,
    "NameOfProject" character varying(45) NOT NULL,
    "Start" date NOT NULL,
    "End" date NOT NULL
);
    DROP TABLE public.projects;
       public         heap    postgres    false    7            �           0    0    TABLE projects    ACL     ;   GRANT SELECT ON TABLE public.projects TO "Techician_lead";
          public          postgres    false    235            �            1259    16538    projects_idProjects_seq    SEQUENCE     �   CREATE SEQUENCE public."projects_idProjects_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."projects_idProjects_seq";
       public          postgres    false    7    235            �           0    0    projects_idProjects_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."projects_idProjects_seq" OWNED BY public.projects."idProjects";
          public          postgres    false    234            �            1259    16764    requisitions    TABLE     �   CREATE TABLE public.requisitions (
    "idRequisition" integer NOT NULL,
    "NameOfRequisition" character varying(45) NOT NULL,
    "DateOfRec" date NOT NULL,
    "Responsible" integer NOT NULL,
    "Type" character varying(45) NOT NULL
);
     DROP TABLE public.requisitions;
       public         heap    postgres    false    7            �           0    0    TABLE requisitions    ACL     B   GRANT SELECT,INSERT ON TABLE public.requisitions TO "Accountant";
          public          postgres    false    253            �            1259    16763    requisitions_idRequisition_seq    SEQUENCE     �   CREATE SEQUENCE public."requisitions_idRequisition_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public."requisitions_idRequisition_seq";
       public          postgres    false    7    253            �           0    0    requisitions_idRequisition_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public."requisitions_idRequisition_seq" OWNED BY public.requisitions."idRequisition";
          public          postgres    false    252            �            1259    16583 	   suppliers    TABLE     :  CREATE TABLE public.suppliers (
    "idSuppliers" integer NOT NULL,
    "NameOfSupplier" character varying(45) NOT NULL,
    "LegalAddress" character varying(45) NOT NULL,
    "ContactPerson" character varying(45) NOT NULL,
    "Phone" character varying(45) NOT NULL,
    "Email" character varying(45) NOT NULL
);
    DROP TABLE public.suppliers;
       public         heap    postgres    false    7            �           0    0    TABLE suppliers    ACL     2   GRANT SELECT ON TABLE public.suppliers TO lawyer;
          public          postgres    false    238            �            1259    16589    suppliers_components    TABLE     t   CREATE TABLE public.suppliers_components (
    "idSupplier" integer NOT NULL,
    "idComponent" integer NOT NULL
);
 (   DROP TABLE public.suppliers_components;
       public         heap    postgres    false    7            �            1259    16582    suppliers_idSuppliers_seq    SEQUENCE     �   CREATE SEQUENCE public."suppliers_idSuppliers_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."suppliers_idSuppliers_seq";
       public          postgres    false    7    238            �           0    0    suppliers_idSuppliers_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."suppliers_idSuppliers_seq" OWNED BY public.suppliers."idSuppliers";
          public          postgres    false    237                       1259    17139    tech_access    TABLE     �   CREATE TABLE public.tech_access (
    idemployee integer NOT NULL,
    employee_password character varying,
    hash character varying
);
    DROP TABLE public.tech_access;
       public         heap    postgres    false    7            �            1259    16605 	   transport    TABLE     �   CREATE TABLE public.transport (
    "idTransport" integer NOT NULL,
    "Name" character varying(45) NOT NULL,
    "Type" character varying(45) NOT NULL
);
    DROP TABLE public.transport;
       public         heap    postgres    false    7            �            1259    16604    transport_idTransport_seq    SEQUENCE     �   CREATE SEQUENCE public."transport_idTransport_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."transport_idTransport_seq";
       public          postgres    false    241    7            �           0    0    transport_idTransport_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."transport_idTransport_seq" OWNED BY public.transport."idTransport";
          public          postgres    false    240            B           2604    16414    archive idArchive    DEFAULT     z   ALTER TABLE ONLY public.archive ALTER COLUMN "idArchive" SET DEFAULT nextval('public."archive_idArchive_seq"'::regclass);
 B   ALTER TABLE public.archive ALTER COLUMN "idArchive" DROP DEFAULT;
       public          postgres    false    219    218    219            C           2604    16421    blueprints idBlueprints    DEFAULT     �   ALTER TABLE ONLY public.blueprints ALTER COLUMN "idBlueprints" SET DEFAULT nextval('public."blueprints_idBlueprints_seq"'::regclass);
 H   ALTER TABLE public.blueprints ALTER COLUMN "idBlueprints" DROP DEFAULT;
       public          postgres    false    221    220    221            D           2604    16433    clients idClients    DEFAULT     z   ALTER TABLE ONLY public.clients ALTER COLUMN "idClients" SET DEFAULT nextval('public."clients_idClients_seq"'::regclass);
 B   ALTER TABLE public.clients ALTER COLUMN "idClients" DROP DEFAULT;
       public          postgres    false    222    223    223            E           2604    16440    components idComponents    DEFAULT     �   ALTER TABLE ONLY public.components ALTER COLUMN "idComponents" SET DEFAULT nextval('public."components_idComponents_seq"'::regclass);
 H   ALTER TABLE public.components ALTER COLUMN "idComponents" DROP DEFAULT;
       public          postgres    false    225    224    225            S           2604    16779    contracts idContracts    DEFAULT     �   ALTER TABLE ONLY public.contracts ALTER COLUMN "idContracts" SET DEFAULT nextval('public."contracts_idContracts_seq"'::regclass);
 F   ALTER TABLE public.contracts ALTER COLUMN "idContracts" DROP DEFAULT;
       public          postgres    false    254    255    255            F           2604    16459    departments idDepartments    DEFAULT     �   ALTER TABLE ONLY public.departments ALTER COLUMN "idDepartments" SET DEFAULT nextval('public."departments_idDepartments_seq"'::regclass);
 J   ALTER TABLE public.departments ALTER COLUMN "idDepartments" DROP DEFAULT;
       public          postgres    false    226    227    227            V           2604    17058    employee_feedback idFeedback    DEFAULT     �   ALTER TABLE ONLY public.employee_feedback ALTER COLUMN "idFeedback" SET DEFAULT nextval('public."employee_feedback_idFeedback_seq"'::regclass);
 M   ALTER TABLE public.employee_feedback ALTER COLUMN "idFeedback" DROP DEFAULT;
       public          postgres    false    266    267    267            M           2604    16651    employees idEmployees    DEFAULT     �   ALTER TABLE ONLY public.employees ALTER COLUMN "idEmployees" SET DEFAULT nextval('public."employees_idEmployees_seq"'::regclass);
 F   ALTER TABLE public.employees ALTER COLUMN "idEmployees" DROP DEFAULT;
       public          postgres    false    242    243    243            G           2604    16483 %   extremesituations idExtremeSituations    DEFAULT     �   ALTER TABLE ONLY public.extremesituations ALTER COLUMN "idExtremeSituations" SET DEFAULT nextval('public."extremesituations_idExtremeSituations_seq"'::regclass);
 V   ALTER TABLE public.extremesituations ALTER COLUMN "idExtremeSituations" DROP DEFAULT;
       public          postgres    false    228    229    229            T           2604    16821 1   fire_fighting_equipment idFire_fighting_equipment    DEFAULT     �   ALTER TABLE ONLY public.fire_fighting_equipment ALTER COLUMN "idFire_fighting_equipment" SET DEFAULT nextval('public."fire_fighting_equipment_idFire_fighting_equipment_seq"'::regclass);
 b   ALTER TABLE public.fire_fighting_equipment ALTER COLUMN "idFire_fighting_equipment" DROP DEFAULT;
       public          postgres    false    258    257    258            U           2604    17018    goals IdMonthGoal    DEFAULT     z   ALTER TABLE ONLY public.goals ALTER COLUMN "IdMonthGoal" SET DEFAULT nextval('public."goals_IdMonthGoal_seq"'::regclass);
 B   ALTER TABLE public.goals ALTER COLUMN "IdMonthGoal" DROP DEFAULT;
       public          postgres    false    265    264    265            O           2604    16695    med_exam idMed_exam    DEFAULT     ~   ALTER TABLE ONLY public.med_exam ALTER COLUMN "idMed_exam" SET DEFAULT nextval('public."med_exam_idMed_exam_seq"'::regclass);
 D   ALTER TABLE public.med_exam ALTER COLUMN "idMed_exam" DROP DEFAULT;
       public          postgres    false    244    245    245            P           2604    16712 %   medical_equipment idMedical_equipment    DEFAULT     �   ALTER TABLE ONLY public.medical_equipment ALTER COLUMN "idMedical_equipment" SET DEFAULT nextval('public."medical_equipment_idMedical_equipment_seq"'::regclass);
 V   ALTER TABLE public.medical_equipment ALTER COLUMN "idMedical_equipment" DROP DEFAULT;
       public          postgres    false    246    247    247            H           2604    16516    orders idOrder    DEFAULT     t   ALTER TABLE ONLY public.orders ALTER COLUMN "idOrder" SET DEFAULT nextval('public."orders_idOrder_seq"'::regclass);
 ?   ALTER TABLE public.orders ALTER COLUMN "idOrder" DROP DEFAULT;
       public          postgres    false    230    231    231            I           2604    16528    positions idPositions    DEFAULT     �   ALTER TABLE ONLY public.positions ALTER COLUMN "idPositions" SET DEFAULT nextval('public."positions_idPositions_seq"'::regclass);
 F   ALTER TABLE public.positions ALTER COLUMN "idPositions" DROP DEFAULT;
       public          postgres    false    233    232    233            Q           2604    16724    production idProduction    DEFAULT     �   ALTER TABLE ONLY public.production ALTER COLUMN "idProduction" SET DEFAULT nextval('public."production_idProduction_seq"'::regclass);
 H   ALTER TABLE public.production ALTER COLUMN "idProduction" DROP DEFAULT;
       public          postgres    false    248    249    249            J           2604    16542    projects idProjects    DEFAULT     ~   ALTER TABLE ONLY public.projects ALTER COLUMN "idProjects" SET DEFAULT nextval('public."projects_idProjects_seq"'::regclass);
 D   ALTER TABLE public.projects ALTER COLUMN "idProjects" DROP DEFAULT;
       public          postgres    false    235    234    235            R           2604    16767    requisitions idRequisition    DEFAULT     �   ALTER TABLE ONLY public.requisitions ALTER COLUMN "idRequisition" SET DEFAULT nextval('public."requisitions_idRequisition_seq"'::regclass);
 K   ALTER TABLE public.requisitions ALTER COLUMN "idRequisition" DROP DEFAULT;
       public          postgres    false    252    253    253            K           2604    16586    suppliers idSuppliers    DEFAULT     �   ALTER TABLE ONLY public.suppliers ALTER COLUMN "idSuppliers" SET DEFAULT nextval('public."suppliers_idSuppliers_seq"'::regclass);
 F   ALTER TABLE public.suppliers ALTER COLUMN "idSuppliers" DROP DEFAULT;
       public          postgres    false    237    238    238            L           2604    16608    transport idTransport    DEFAULT     �   ALTER TABLE ONLY public.transport ALTER COLUMN "idTransport" SET DEFAULT nextval('public."transport_idTransport_seq"'::regclass);
 F   ALTER TABLE public.transport ALTER COLUMN "idTransport" DROP DEFAULT;
       public          postgres    false    240    241    241            N          0    16411    archive 
   TABLE DATA           @   COPY public.archive ("idArchive", "Type", "Volume") FROM stdin;
    public          postgres    false    219   U      w          0    16844    blueprint_production 
   TABLE DATA           M   COPY public.blueprint_production ("IdBlueprint", "IdProduction") FROM stdin;
    public          postgres    false    260   �U      P          0    16418 
   blueprints 
   TABLE DATA           P   COPY public.blueprints ("idBlueprints", "Description", "ArchiveID") FROM stdin;
    public          postgres    false    221   �U      R          0    16430    clients 
   TABLE DATA           I   COPY public.clients ("idClients", "NameOfClient", "Contact") FROM stdin;
    public          postgres    false    223   W      T          0    16437 
   components 
   TABLE DATA           H   COPY public.components ("idComponents", "Name", "Quantity") FROM stdin;
    public          postgres    false    225   �X      y          0    16958    components_production 
   TABLE DATA           W   COPY public.components_production ("idProduct", "idComponent", "Quantity") FROM stdin;
    public          postgres    false    262   �Y      r          0    16776 	   contracts 
   TABLE DATA           n   COPY public.contracts ("idContracts", "Name", "DateOfAgreement", "EmploID", "ClientID", "Status") FROM stdin;
    public          postgres    false    255   Z      V          0    16456    departments 
   TABLE DATA           P   COPY public.departments ("idDepartments", "Name", "Specialization") FROM stdin;
    public          postgres    false    227   ^[      ~          0    17055    employee_feedback 
   TABLE DATA           Z   COPY public.employee_feedback ("idFeedback", "EmployeeID", "Comment", "Date") FROM stdin;
    public          postgres    false    267   \      s          0    16792    employee_transport 
   TABLE DATA           I   COPY public.employee_transport ("EmployeeID", "TransportID") FROM stdin;
    public          postgres    false    256   �\      f          0    16648 	   employees 
   TABLE DATA           �   COPY public.employees ("idEmployees", "Lastname", "Name", "Surname", "PositionID", "Phone", "Passport", "Education", "Adress", "Family_status", "Insurance_policy", "Department", bonus) FROM stdin;
    public          postgres    false    243   �\      v          0    16829    extreme_firefighteq 
   TABLE DATA           K   COPY public.extreme_firefighteq ("idExtreme", "idFireFightEq") FROM stdin;
    public          postgres    false    259   c      z          0    16973    extremesit_medeq 
   TABLE DATA           B   COPY public.extremesit_medeq ("idExtreme", "idMedEq") FROM stdin;
    public          postgres    false    263   Ic      X          0    16480    extremesituations 
   TABLE DATA           R   COPY public.extremesituations ("idExtremeSituations", "Name", "Date") FROM stdin;
    public          postgres    false    229   rc      u          0    16818    fire_fighting_equipment 
   TABLE DATA           q   COPY public.fire_fighting_equipment ("idFire_fighting_equipment", "Name", "Quantity", "Responsible") FROM stdin;
    public          postgres    false    258   !d      |          0    17015    goals 
   TABLE DATA           �   COPY public.goals ("IdMonthGoal", "ProductionID", "ContractID", "DateOfPlanStart", "DateOfPlamEnd", "idManufacturedProd") FROM stdin;
    public          postgres    false    265   �d      �          0    17116    history_of_updates 
   TABLE DATA           o   COPY public.history_of_updates (idupdate, "TableToupdate", operation_type, dateofupdate, idrecord) FROM stdin;
    public          postgres    false    270   �e      �          0    17159 	   it_access 
   TABLE DATA           H   COPY public.it_access (idemployee, employee_password, hash) FROM stdin;
    public          postgres    false    273   �f      �          0    17149    lawyer_acces 
   TABLE DATA           K   COPY public.lawyer_acces (idemployee, employee_password, hash) FROM stdin;
    public          postgres    false    272   gg      x          0    16901    manufactured_products 
   TABLE DATA           q   COPY public.manufactured_products ("idProduct", "IndividualNumber", "Responsible", "DateOfManufact") FROM stdin;
    public          postgres    false    261   �g      h          0    16692    med_exam 
   TABLE DATA           P   COPY public.med_exam ("idMed_exam", "IdEmployee", "Doctor", "Date") FROM stdin;
    public          postgres    false    245   +h      j          0    16709    medical_equipment 
   TABLE DATA           e   COPY public.medical_equipment ("idMedical_equipment", "Name", "Quantity", "Responsible") FROM stdin;
    public          postgres    false    247   ih      Z          0    16513    orders 
   TABLE DATA           t   COPY public.orders ("idOrder", "DateOfOrder", "DateOfDelivery", "DateOfPaid", "SumOfOrder", "ClientID") FROM stdin;
    public          postgres    false    231   4i      \          0    16525 	   positions 
   TABLE DATA           D   COPY public.positions ("idPositions", "Name", "Salary") FROM stdin;
    public          postgres    false    233   �i      l          0    16721 
   production 
   TABLE DATA           H   COPY public.production ("idProduction", "NameOfProduction") FROM stdin;
    public          postgres    false    249   �j      _          0    16545    project_departments 
   TABLE DATA           J   COPY public.project_departments ("idProject", "idDepartment") FROM stdin;
    public          postgres    false    236   �k      m          0    16732    project_empl 
   TABLE DATA           A   COPY public.project_empl ("idEmployee", "idProject") FROM stdin;
    public          postgres    false    250   l      n          0    16747    project_progress 
   TABLE DATA           R   COPY public.project_progress ("idProject", "idProduction", "Percent") FROM stdin;
    public          postgres    false    251   5l      ^          0    16539    projects 
   TABLE DATA           Q   COPY public.projects ("idProjects", "NameOfProject", "Start", "End") FROM stdin;
    public          postgres    false    235   jl      p          0    16764    requisitions 
   TABLE DATA           p   COPY public.requisitions ("idRequisition", "NameOfRequisition", "DateOfRec", "Responsible", "Type") FROM stdin;
    public          postgres    false    253   �l      a          0    16583 	   suppliers 
   TABLE DATA           w   COPY public.suppliers ("idSuppliers", "NameOfSupplier", "LegalAddress", "ContactPerson", "Phone", "Email") FROM stdin;
    public          postgres    false    238   dm      b          0    16589    suppliers_components 
   TABLE DATA           K   COPY public.suppliers_components ("idSupplier", "idComponent") FROM stdin;
    public          postgres    false    239   o      �          0    17139    tech_access 
   TABLE DATA           J   COPY public.tech_access (idemployee, employee_password, hash) FROM stdin;
    public          postgres    false    271   9o      d          0    16605 	   transport 
   TABLE DATA           B   COPY public.transport ("idTransport", "Name", "Type") FROM stdin;
    public          postgres    false    241   �o      �           0    0    archive_idArchive_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."archive_idArchive_seq"', 3, true);
          public          postgres    false    218            �           0    0    blueprints_idBlueprints_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."blueprints_idBlueprints_seq"', 3, true);
          public          postgres    false    220            �           0    0    clients_idClients_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."clients_idClients_seq"', 6, true);
          public          postgres    false    222            �           0    0    components_idComponents_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."components_idComponents_seq"', 6, true);
          public          postgres    false    224            �           0    0    contracts_idContracts_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."contracts_idContracts_seq"', 3, true);
          public          postgres    false    254            �           0    0    departments_idDepartments_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public."departments_idDepartments_seq"', 6, true);
          public          postgres    false    226            �           0    0     employee_feedback_idFeedback_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public."employee_feedback_idFeedback_seq"', 3, true);
          public          postgres    false    266            �           0    0    employees_idEmployees_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."employees_idEmployees_seq"', 24, true);
          public          postgres    false    242            �           0    0 )   extremesituations_idExtremeSituations_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public."extremesituations_idExtremeSituations_seq"', 6, true);
          public          postgres    false    228            �           0    0 5   fire_fighting_equipment_idFire_fighting_equipment_seq    SEQUENCE SET     f   SELECT pg_catalog.setval('public."fire_fighting_equipment_idFire_fighting_equipment_seq"', 15, true);
          public          postgres    false    257            �           0    0    goals_IdMonthGoal_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."goals_IdMonthGoal_seq"', 9, true);
          public          postgres    false    264            �           0    0    history_of_updates_idupdate_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.history_of_updates_idupdate_seq', 61, true);
          public          postgres    false    269            �           0    0    med_exam_idMed_exam_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."med_exam_idMed_exam_seq"', 18, true);
          public          postgres    false    244            �           0    0 )   medical_equipment_idMedical_equipment_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public."medical_equipment_idMedical_equipment_seq"', 6, true);
          public          postgres    false    246            �           0    0    orders_idOrder_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."orders_idOrder_seq"', 3, true);
          public          postgres    false    230            �           0    0    positions_idPositions_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."positions_idPositions_seq"', 10, true);
          public          postgres    false    232            �           0    0    production_idProduction_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."production_idProduction_seq"', 12, true);
          public          postgres    false    248            �           0    0    projects_idProjects_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."projects_idProjects_seq"', 6, true);
          public          postgres    false    234            �           0    0    requisitions_idRequisition_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."requisitions_idRequisition_seq"', 9, true);
          public          postgres    false    252            �           0    0    suppliers_idSuppliers_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."suppliers_idSuppliers_seq"', 6, true);
          public          postgres    false    237            �           0    0    transport_idTransport_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."transport_idTransport_seq"', 6, true);
          public          postgres    false    240            X           2606    16416    archive archive_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY ("idArchive");
 >   ALTER TABLE ONLY public.archive DROP CONSTRAINT archive_pkey;
       public            postgres    false    219            �           2606    16848 .   blueprint_production blueprint_production_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.blueprint_production
    ADD CONSTRAINT blueprint_production_pkey PRIMARY KEY ("IdBlueprint", "IdProduction");
 X   ALTER TABLE ONLY public.blueprint_production DROP CONSTRAINT blueprint_production_pkey;
       public            postgres    false    260    260            Z           2606    16423    blueprints blueprints_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.blueprints
    ADD CONSTRAINT blueprints_pkey PRIMARY KEY ("idBlueprints");
 D   ALTER TABLE ONLY public.blueprints DROP CONSTRAINT blueprints_pkey;
       public            postgres    false    221            \           2606    16435    clients clients_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY ("idClients");
 >   ALTER TABLE ONLY public.clients DROP CONSTRAINT clients_pkey;
       public            postgres    false    223            ^           2606    16442    components components_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY ("idComponents");
 D   ALTER TABLE ONLY public.components DROP CONSTRAINT components_pkey;
       public            postgres    false    225            �           2606    16962 0   components_production components_production_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_production
    ADD CONSTRAINT components_production_pkey PRIMARY KEY ("idProduct", "idComponent");
 Z   ALTER TABLE ONLY public.components_production DROP CONSTRAINT components_production_pkey;
       public            postgres    false    262    262            �           2606    16781    contracts contracts_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY ("idContracts");
 B   ALTER TABLE ONLY public.contracts DROP CONSTRAINT contracts_pkey;
       public            postgres    false    255            `           2606    16461    departments departments_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY ("idDepartments");
 F   ALTER TABLE ONLY public.departments DROP CONSTRAINT departments_pkey;
       public            postgres    false    227            �           2606    17062 (   employee_feedback employee_feedback_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.employee_feedback
    ADD CONSTRAINT employee_feedback_pkey PRIMARY KEY ("idFeedback");
 R   ALTER TABLE ONLY public.employee_feedback DROP CONSTRAINT employee_feedback_pkey;
       public            postgres    false    267            �           2606    16796 *   employee_transport employee_transport_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.employee_transport
    ADD CONSTRAINT employee_transport_pkey PRIMARY KEY ("EmployeeID", "TransportID");
 T   ALTER TABLE ONLY public.employee_transport DROP CONSTRAINT employee_transport_pkey;
       public            postgres    false    256    256            r           2606    16653    employees employees_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY ("idEmployees");
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    243            �           2606    16833 ,   extreme_firefighteq extreme_firefighteq_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.extreme_firefighteq
    ADD CONSTRAINT extreme_firefighteq_pkey PRIMARY KEY ("idExtreme", "idFireFightEq");
 V   ALTER TABLE ONLY public.extreme_firefighteq DROP CONSTRAINT extreme_firefighteq_pkey;
       public            postgres    false    259    259            �           2606    16977 &   extremesit_medeq extremesit_medeq_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.extremesit_medeq
    ADD CONSTRAINT extremesit_medeq_pkey PRIMARY KEY ("idExtreme", "idMedEq");
 P   ALTER TABLE ONLY public.extremesit_medeq DROP CONSTRAINT extremesit_medeq_pkey;
       public            postgres    false    263    263            b           2606    16485 (   extremesituations extremesituations_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.extremesituations
    ADD CONSTRAINT extremesituations_pkey PRIMARY KEY ("idExtremeSituations");
 R   ALTER TABLE ONLY public.extremesituations DROP CONSTRAINT extremesituations_pkey;
       public            postgres    false    229            �           2606    16823 4   fire_fighting_equipment fire_fighting_equipment_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.fire_fighting_equipment
    ADD CONSTRAINT fire_fighting_equipment_pkey PRIMARY KEY ("idFire_fighting_equipment");
 ^   ALTER TABLE ONLY public.fire_fighting_equipment DROP CONSTRAINT fire_fighting_equipment_pkey;
       public            postgres    false    258            �           2606    17020    goals goals_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY ("IdMonthGoal");
 :   ALTER TABLE ONLY public.goals DROP CONSTRAINT goals_pkey;
       public            postgres    false    265            �           2606    16905 0   manufactured_products manufactured_products_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.manufactured_products
    ADD CONSTRAINT manufactured_products_pkey PRIMARY KEY ("idProduct", "IndividualNumber");
 Z   ALTER TABLE ONLY public.manufactured_products DROP CONSTRAINT manufactured_products_pkey;
       public            postgres    false    261    261            t           2606    16697    med_exam med_exam_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.med_exam
    ADD CONSTRAINT med_exam_pkey PRIMARY KEY ("idMed_exam");
 @   ALTER TABLE ONLY public.med_exam DROP CONSTRAINT med_exam_pkey;
       public            postgres    false    245            v           2606    16714 (   medical_equipment medical_equipment_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.medical_equipment
    ADD CONSTRAINT medical_equipment_pkey PRIMARY KEY ("idMedical_equipment");
 R   ALTER TABLE ONLY public.medical_equipment DROP CONSTRAINT medical_equipment_pkey;
       public            postgres    false    247            d           2606    16518    orders orders_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY ("idOrder");
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    231            f           2606    16530    positions positions_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY ("idPositions");
 B   ALTER TABLE ONLY public.positions DROP CONSTRAINT positions_pkey;
       public            postgres    false    233            x           2606    16726    production production_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.production
    ADD CONSTRAINT production_pkey PRIMARY KEY ("idProduction");
 D   ALTER TABLE ONLY public.production DROP CONSTRAINT production_pkey;
       public            postgres    false    249            j           2606    16549 ,   project_departments project_departments_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.project_departments
    ADD CONSTRAINT project_departments_pkey PRIMARY KEY ("idProject", "idDepartment");
 V   ALTER TABLE ONLY public.project_departments DROP CONSTRAINT project_departments_pkey;
       public            postgres    false    236    236            z           2606    16736    project_empl project_empl_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.project_empl
    ADD CONSTRAINT project_empl_pkey PRIMARY KEY ("idEmployee", "idProject");
 H   ALTER TABLE ONLY public.project_empl DROP CONSTRAINT project_empl_pkey;
       public            postgres    false    250    250            |           2606    16751 &   project_progress project_progress_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.project_progress
    ADD CONSTRAINT project_progress_pkey PRIMARY KEY ("idProject", "idProduction");
 P   ALTER TABLE ONLY public.project_progress DROP CONSTRAINT project_progress_pkey;
       public            postgres    false    251    251            h           2606    16544    projects projects_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY ("idProjects");
 @   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
       public            postgres    false    235            ~           2606    16769    requisitions requisitions_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.requisitions
    ADD CONSTRAINT requisitions_pkey PRIMARY KEY ("idRequisition");
 H   ALTER TABLE ONLY public.requisitions DROP CONSTRAINT requisitions_pkey;
       public            postgres    false    253            n           2606    16593 .   suppliers_components suppliers_components_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.suppliers_components
    ADD CONSTRAINT suppliers_components_pkey PRIMARY KEY ("idSupplier", "idComponent");
 X   ALTER TABLE ONLY public.suppliers_components DROP CONSTRAINT suppliers_components_pkey;
       public            postgres    false    239    239            l           2606    16588    suppliers suppliers_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY ("idSuppliers");
 B   ALTER TABLE ONLY public.suppliers DROP CONSTRAINT suppliers_pkey;
       public            postgres    false    238            p           2606    16610    transport transport_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.transport
    ADD CONSTRAINT transport_pkey PRIMARY KEY ("idTransport");
 B   ALTER TABLE ONLY public.transport DROP CONSTRAINT transport_pkey;
       public            postgres    false    241            �           2606    17013 .   manufactured_products unique_individual_number 
   CONSTRAINT     w   ALTER TABLE ONLY public.manufactured_products
    ADD CONSTRAINT unique_individual_number UNIQUE ("IndividualNumber");
 X   ALTER TABLE ONLY public.manufactured_products DROP CONSTRAINT unique_individual_number;
       public            postgres    false    261            �           2620    17125    employees table_changes_trigger    TRIGGER     �   CREATE TRIGGER table_changes_trigger AFTER DELETE OR UPDATE ON public.employees FOR EACH ROW EXECUTE FUNCTION public.log_table_changes();
 8   DROP TRIGGER table_changes_trigger ON public.employees;
       public          postgres    false    298    243            �           2620    17132    employees table_insert_trigger    TRIGGER     {   CREATE TRIGGER table_insert_trigger BEFORE INSERT ON public.employees FOR EACH ROW EXECUTE FUNCTION public.insert_check();
 7   DROP TRIGGER table_insert_trigger ON public.employees;
       public          postgres    false    301    243            �           2606    16424    blueprints ArchiveID    FK CONSTRAINT     �   ALTER TABLE ONLY public.blueprints
    ADD CONSTRAINT "ArchiveID" FOREIGN KEY ("ArchiveID") REFERENCES public.archive("idArchive");
 @   ALTER TABLE ONLY public.blueprints DROP CONSTRAINT "ArchiveID";
       public          postgres    false    219    221    3672            �           2606    16849    blueprint_production BlID    FK CONSTRAINT     �   ALTER TABLE ONLY public.blueprint_production
    ADD CONSTRAINT "BlID" FOREIGN KEY ("IdBlueprint") REFERENCES public.blueprints("idBlueprints");
 E   ALTER TABLE ONLY public.blueprint_production DROP CONSTRAINT "BlID";
       public          postgres    false    260    221    3674            �           2606    16519    orders CliID    FK CONSTRAINT     {   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "CliID" FOREIGN KEY ("ClientID") REFERENCES public.clients("idClients");
 8   ALTER TABLE ONLY public.orders DROP CONSTRAINT "CliID";
       public          postgres    false    3676    223    231            �           2606    16782    contracts CliID    FK CONSTRAINT     ~   ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT "CliID" FOREIGN KEY ("ClientID") REFERENCES public.clients("idClients");
 ;   ALTER TABLE ONLY public.contracts DROP CONSTRAINT "CliID";
       public          postgres    false    255    3676    223            �           2606    17021    goals ContractID    FK CONSTRAINT     �   ALTER TABLE ONLY public.goals
    ADD CONSTRAINT "ContractID" FOREIGN KEY ("ContractID") REFERENCES public.contracts("idContracts");
 <   ALTER TABLE ONLY public.goals DROP CONSTRAINT "ContractID";
       public          postgres    false    3712    255    265            �           2606    16654    employees Depid    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT "Depid" FOREIGN KEY ("Department") REFERENCES public.departments("idDepartments");
 ;   ALTER TABLE ONLY public.employees DROP CONSTRAINT "Depid";
       public          postgres    false    227    3680    243            �           2606    16698    med_exam DocID    FK CONSTRAINT        ALTER TABLE ONLY public.med_exam
    ADD CONSTRAINT "DocID" FOREIGN KEY ("Doctor") REFERENCES public.employees("idEmployees");
 :   ALTER TABLE ONLY public.med_exam DROP CONSTRAINT "DocID";
       public          postgres    false    243    3698    245            �           2606    16797    employee_transport EmID    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_transport
    ADD CONSTRAINT "EmID" FOREIGN KEY ("EmployeeID") REFERENCES public.employees("idEmployees");
 C   ALTER TABLE ONLY public.employee_transport DROP CONSTRAINT "EmID";
       public          postgres    false    3698    243    256            �           2606    16787    contracts EmployID    FK CONSTRAINT     �   ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT "EmployID" FOREIGN KEY ("EmploID") REFERENCES public.employees("idEmployees");
 >   ALTER TABLE ONLY public.contracts DROP CONSTRAINT "EmployID";
       public          postgres    false    255    3698    243            �           2606    16659    employees PosID    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT "PosID" FOREIGN KEY ("PositionID") REFERENCES public.positions("idPositions");
 ;   ALTER TABLE ONLY public.employees DROP CONSTRAINT "PosID";
       public          postgres    false    3686    233    243            �           2606    16854    blueprint_production PrID    FK CONSTRAINT     �   ALTER TABLE ONLY public.blueprint_production
    ADD CONSTRAINT "PrID" FOREIGN KEY ("IdProduction") REFERENCES public.production("idProduction");
 E   ALTER TABLE ONLY public.blueprint_production DROP CONSTRAINT "PrID";
       public          postgres    false    3704    249    260            �           2606    17031    goals ProductionID    FK CONSTRAINT     �   ALTER TABLE ONLY public.goals
    ADD CONSTRAINT "ProductionID" FOREIGN KEY ("ProductionID") REFERENCES public.production("idProduction");
 >   ALTER TABLE ONLY public.goals DROP CONSTRAINT "ProductionID";
       public          postgres    false    249    3704    265            �           2606    16824    fire_fighting_equipment ResID    FK CONSTRAINT     �   ALTER TABLE ONLY public.fire_fighting_equipment
    ADD CONSTRAINT "ResID" FOREIGN KEY ("Responsible") REFERENCES public.employees("idEmployees");
 I   ALTER TABLE ONLY public.fire_fighting_equipment DROP CONSTRAINT "ResID";
       public          postgres    false    3698    258    243            �           2606    16770    requisitions Respon    FK CONSTRAINT     �   ALTER TABLE ONLY public.requisitions
    ADD CONSTRAINT "Respon" FOREIGN KEY ("Responsible") REFERENCES public.employees("idEmployees");
 ?   ALTER TABLE ONLY public.requisitions DROP CONSTRAINT "Respon";
       public          postgres    false    3698    243    253            �           2606    16715    medical_equipment Responsible    FK CONSTRAINT     �   ALTER TABLE ONLY public.medical_equipment
    ADD CONSTRAINT "Responsible" FOREIGN KEY ("Responsible") REFERENCES public.employees("idEmployees");
 I   ALTER TABLE ONLY public.medical_equipment DROP CONSTRAINT "Responsible";
       public          postgres    false    247    3698    243            �           2606    16802    employee_transport TrID    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_transport
    ADD CONSTRAINT "TrID" FOREIGN KEY ("TransportID") REFERENCES public.transport("idTransport");
 C   ALTER TABLE ONLY public.employee_transport DROP CONSTRAINT "TrID";
       public          postgres    false    3696    256    241            �           2606    17063 2   employee_feedback fk_employee_feedback_employee_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_feedback
    ADD CONSTRAINT fk_employee_feedback_employee_id FOREIGN KEY ("EmployeeID") REFERENCES public.employees("idEmployees");
 \   ALTER TABLE ONLY public.employee_feedback DROP CONSTRAINT fk_employee_feedback_employee_id;
       public          postgres    false    3698    243    267            �           2606    17068     med_exam fk_med_exam_employee_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.med_exam
    ADD CONSTRAINT fk_med_exam_employee_id FOREIGN KEY ("IdEmployee") REFERENCES public.employees("idEmployees");
 J   ALTER TABLE ONLY public.med_exam DROP CONSTRAINT fk_med_exam_employee_id;
       public          postgres    false    245    243    3698            �           2606    16594    suppliers_components idComp    FK CONSTRAINT     �   ALTER TABLE ONLY public.suppliers_components
    ADD CONSTRAINT "idComp" FOREIGN KEY ("idComponent") REFERENCES public.components("idComponents");
 G   ALTER TABLE ONLY public.suppliers_components DROP CONSTRAINT "idComp";
       public          postgres    false    3678    239    225            �           2606    16963 !   components_production idComponent    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_production
    ADD CONSTRAINT "idComponent" FOREIGN KEY ("idComponent") REFERENCES public.components("idComponents");
 M   ALTER TABLE ONLY public.components_production DROP CONSTRAINT "idComponent";
       public          postgres    false    262    3678    225            �           2606    16550    project_departments idDep    FK CONSTRAINT     �   ALTER TABLE ONLY public.project_departments
    ADD CONSTRAINT "idDep" FOREIGN KEY ("idDepartment") REFERENCES public.departments("idDepartments");
 E   ALTER TABLE ONLY public.project_departments DROP CONSTRAINT "idDep";
       public          postgres    false    236    227    3680            �           2606    16737    project_empl idEmp    FK CONSTRAINT     �   ALTER TABLE ONLY public.project_empl
    ADD CONSTRAINT "idEmp" FOREIGN KEY ("idEmployee") REFERENCES public.employees("idEmployees");
 >   ALTER TABLE ONLY public.project_empl DROP CONSTRAINT "idEmp";
       public          postgres    false    3698    243    250            �           2606    16906 !   manufactured_products idEmployeer    FK CONSTRAINT     �   ALTER TABLE ONLY public.manufactured_products
    ADD CONSTRAINT "idEmployeer" FOREIGN KEY ("Responsible") REFERENCES public.employees("idEmployees");
 M   ALTER TABLE ONLY public.manufactured_products DROP CONSTRAINT "idEmployeer";
       public          postgres    false    243    3698    261            �           2606    16978    extremesit_medeq idEx    FK CONSTRAINT     �   ALTER TABLE ONLY public.extremesit_medeq
    ADD CONSTRAINT "idEx" FOREIGN KEY ("idExtreme") REFERENCES public.extremesituations("idExtremeSituations");
 A   ALTER TABLE ONLY public.extremesit_medeq DROP CONSTRAINT "idEx";
       public          postgres    false    229    3682    263            �           2606    16834    extreme_firefighteq idExt    FK CONSTRAINT     �   ALTER TABLE ONLY public.extreme_firefighteq
    ADD CONSTRAINT "idExt" FOREIGN KEY ("idExtreme") REFERENCES public.extremesituations("idExtremeSituations");
 E   ALTER TABLE ONLY public.extreme_firefighteq DROP CONSTRAINT "idExt";
       public          postgres    false    229    3682    259            �           2606    16839    extreme_firefighteq idFireEq    FK CONSTRAINT     �   ALTER TABLE ONLY public.extreme_firefighteq
    ADD CONSTRAINT "idFireEq" FOREIGN KEY ("idFireFightEq") REFERENCES public.fire_fighting_equipment("idFire_fighting_equipment");
 H   ALTER TABLE ONLY public.extreme_firefighteq DROP CONSTRAINT "idFireEq";
       public          postgres    false    258    3716    259            �           2606    17026    goals idManufacturedProduct    FK CONSTRAINT     �   ALTER TABLE ONLY public.goals
    ADD CONSTRAINT "idManufacturedProduct" FOREIGN KEY ("idManufacturedProd") REFERENCES public.manufactured_products("IndividualNumber");
 G   ALTER TABLE ONLY public.goals DROP CONSTRAINT "idManufacturedProduct";
       public          postgres    false    265    261    3724            �           2606    16983    extremesit_medeq idMed    FK CONSTRAINT     �   ALTER TABLE ONLY public.extremesit_medeq
    ADD CONSTRAINT "idMed" FOREIGN KEY ("idMedEq") REFERENCES public.medical_equipment("idMedical_equipment");
 B   ALTER TABLE ONLY public.extremesit_medeq DROP CONSTRAINT "idMed";
       public          postgres    false    247    263    3702            �           2606    16757    project_progress idProd    FK CONSTRAINT     �   ALTER TABLE ONLY public.project_progress
    ADD CONSTRAINT "idProd" FOREIGN KEY ("idProduction") REFERENCES public.production("idProduction");
 C   ALTER TABLE ONLY public.project_progress DROP CONSTRAINT "idProd";
       public          postgres    false    3704    249    251            �           2606    16911    manufactured_products idProd    FK CONSTRAINT     �   ALTER TABLE ONLY public.manufactured_products
    ADD CONSTRAINT "idProd" FOREIGN KEY ("idProduct") REFERENCES public.production("idProduction");
 H   ALTER TABLE ONLY public.manufactured_products DROP CONSTRAINT "idProd";
       public          postgres    false    3704    249    261            �           2606    16968    components_production idProddd    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_production
    ADD CONSTRAINT "idProddd" FOREIGN KEY ("idProduct") REFERENCES public.production("idProduction");
 J   ALTER TABLE ONLY public.components_production DROP CONSTRAINT "idProddd";
       public          postgres    false    249    3704    262            �           2606    16555    project_departments idProj    FK CONSTRAINT     �   ALTER TABLE ONLY public.project_departments
    ADD CONSTRAINT "idProj" FOREIGN KEY ("idProject") REFERENCES public.projects("idProjects");
 F   ALTER TABLE ONLY public.project_departments DROP CONSTRAINT "idProj";
       public          postgres    false    236    235    3688            �           2606    16742    project_empl idProj    FK CONSTRAINT     �   ALTER TABLE ONLY public.project_empl
    ADD CONSTRAINT "idProj" FOREIGN KEY ("idProject") REFERENCES public.projects("idProjects");
 ?   ALTER TABLE ONLY public.project_empl DROP CONSTRAINT "idProj";
       public          postgres    false    235    3688    250            �           2606    16752    project_progress idProjjj    FK CONSTRAINT     �   ALTER TABLE ONLY public.project_progress
    ADD CONSTRAINT "idProjjj" FOREIGN KEY ("idProject") REFERENCES public.projects("idProjects");
 E   ALTER TABLE ONLY public.project_progress DROP CONSTRAINT "idProjjj";
       public          postgres    false    235    3688    251            �           2606    16599    suppliers_components idSupp    FK CONSTRAINT     �   ALTER TABLE ONLY public.suppliers_components
    ADD CONSTRAINT "idSupp" FOREIGN KEY ("idSupplier") REFERENCES public.suppliers("idSuppliers");
 G   ALTER TABLE ONLY public.suppliers_components DROP CONSTRAINT "idSupp";
       public          postgres    false    3692    238    239            �           2606    17164     it_access it_access_employees_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.it_access
    ADD CONSTRAINT it_access_employees_fk FOREIGN KEY (idemployee) REFERENCES public.employees("idEmployees");
 J   ALTER TABLE ONLY public.it_access DROP CONSTRAINT it_access_employees_fk;
       public          postgres    false    3698    243    273            �           2606    17154 &   lawyer_acces lawyer_acces_employees_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lawyer_acces
    ADD CONSTRAINT lawyer_acces_employees_fk FOREIGN KEY (idemployee) REFERENCES public.employees("idEmployees");
 P   ALTER TABLE ONLY public.lawyer_acces DROP CONSTRAINT lawyer_acces_employees_fk;
       public          postgres    false    3698    272    243            �           2606    17144 $   tech_access tech_access_employees_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.tech_access
    ADD CONSTRAINT tech_access_employees_fk FOREIGN KEY (idemployee) REFERENCES public.employees("idEmployees");
 N   ALTER TABLE ONLY public.tech_access DROP CONSTRAINT tech_access_employees_fk;
       public          postgres    false    3698    271    243            N   i   x�U�A@0��u{
 ���a"��"� �W�w#�+]�����J�I�8�d2b��ag�*�1�����M�z,����
��+;��Tu�.����?ߴ���� U2      w   <   x��� !��&�-d̕�Ǳ��Ֆ!�.�dh05YZlm�~�qʉ[������n:	�      P   *  x�uR[r�0�&��	:u)}��=L��>z��:SCs�F])��J�#iW���	}R�k��s\�Kj(���/�����-t���G3s�L�"���w";�vx( 43�h� v�x�f�T
=��J~2�Wx���2��s�P
�:�l��\H�aN"_`!*���*y5�
�T(����M�p
�-��$��;���-��]܇��u���5:I:Q��#�7��� �"F�l�?)d������#��ج�>���P9��C�>��"p�++�1�F1�NQ��E����      R   �  x�uSmJ�@��=����~�D��4E�`�E�E��md�&�
�7r�K��A	,�ffv޼�A/�}?������.F�Ǹ��3f����r��^o�����9A#�g�-��P�\�W�yA�G��H�����E%�k�������n0UH�43�	V>䚐}P�#%j�'��V��iM\nuXk<s뛈��>2�Ē�|H����T��+=�Iႜ�v�j����kBvh˚��RdB����?�yIsw���_y+��Kşh*s����9if�5�"N[����`��?h�_Zk�f�F�}҂4�>��<��Jb��L4o'i([b{�4S��s���I��c8��v�>K�M]��vz�~(]�KB������21&hL�g91�Geuc�%󠷄�+�Ʒ��m�f5�V$�'�!�_����Ŏ1���zW      T   �   x�u�1n1D��Spd{q��aЮ"A!EJC��$ mv����el�!"ŷ�����	^1 i�;	�/8���3�8K���B�L��b�7��˷%1��R�=N������5+z��3T�6g�
�n�]I��<U'x�)��I���N��{F�������̘t���3no4E��l���`oF��;T
�I1�.qœx=7�� T��1      y   X   x����0���0h�]��5�"�C��-,]m1��u+Yn-�*h��Hݶ���g��k!��JQx�FI�&$F�7uN{:S�%����      r   7  x�}��m�0E��)���m�g��<��G�.��F�8vV 7ʕb�A%��"/)&�~h�%�HӞΤ%��`�@Ξ�'��4�U'JT"�-�EF�\E�����D�PY@-2� +^#���qN/cՈ&P��a�0 �#�M)����)>�Tx�2 i�]mO��:�I¥yg���������V�WD�p-c�஥˃S�*��8upd-�mz5.���N�=rzM2��[i2[@3oݒ��Q6 6��j?���%��{J<��7���c�n�W'�v����?���|�KK2���oQ� }S��      V   �   x�m���0D��*� �_7Cr��	4`B>V�f;����x���y�1�k�-ƕ�`ѧ���� gp�GGݣ���"��#|�p�Qs6ZP�a� ��Y08��*�����V�q��L�c<������Cf�;)]��L6KX�9��"2_��[      ~   �   x�E���@�v�@�B����s 7:��T�HY	-<w�ˉ��y�)�&xY��Xmt� b�F/|�2_e�k����9a��:ǳXo�=	WF��4�Z�C���n��u�!R�X���S)�ֹ�߃K�      s   "   x�36�4�26f �DqqY1z\\\ W�      f   ?  x��Y�n�F}��B�Z�.�?�/���r�Q[nѤ��h����lK�l]��Թ�\JKs���$J���9;3gf�Y�>�[5VK�R���RS=ԃ@]��@ݩ)��U3}���Y��H�7�8Iw����t�����Ӈ�F��v��B���z����}5�{��/���=5��G���ts�����*��(	ðE��D��H=������a�go�i�Hw�\�%PBS5S5�kb���;̜H��}���� ��- &3�ȨE�Ƨ}� ,��=<��Rhl� ��f��$�g�ҜL͐L�SכYT��
���l�5�D����$�}��c	��)w�8:,B_q�*�������r���֝�c�?�'g�?1���0b�1��,&GI�1���`w H!���l�5i8IZ�d�*i��3����iW�nw��% ^؋�)`K�{xviy�7NI0�Z��&���V�Q���3���#p:���rR����������-TdbFT�Jb�x��7Xu	w�!5�S�>Q�!�z|
�Q�NL��<�ʰ���&�iP��Î�W�6��"��ҏ���9���^\2���.�e��{����|R+�,��޳�e��RA�E�m��{Z�.��%gI�Y+�</%����sMM�D0���F#?6x�6��> yQ
�+��U��1+CC������+,r�!�����n2"� 5�R���:0���KZa���?��Q��n������N��F�>�Sr.�P�C�A��0޽�͖A�-	��P�h�:�g��/����2c�3�6�B�`@Y���d�_�@�$��;�^r{ �
��>G&������d{@m6�nH�=���_�n�H��3�7��ǈ���V�l�Ҵ(�^L��â��:ۜ�圔s=h��h�]�7�)4�Bg�-��-@U���g����
��֍��8��.+I���B����>���}��Շ�U�0���/��C�rC��A��f���L ��|��\R(u�F�*e:�#X��ta[��5����gU(�H��aqD9�-�����0���J�:�a� B6�=%�&�拏�t(X,(屳��,-�	�_���66� �D�[G��,)�^�5�(뱤��!�|�"-~�x�l��_��ƷB^ l�J�`W��;8Ŭ`����,���E�/��[(G8��#3W7�����D!�^��N_d��o����!Z�-H�pJY2T���}e�ތ.��V�/rî,�sY��qb�c�dz+����p���FO�Q�qle�1�(?��1�},����}sԨ8g�(P�i�;:_Y�ivE�aK�`�+�zĉ��C\琰��x͉Ϭq�:X�y}�\��J5������b�EW�f�����	u��Ķ��#@�� .q���y_�� "T�s��LG��<˛��Q`Fi�i=��4 ��	�|���X%7���N��<�WYl�ig�j8�V�x� �?@��~6���:�_G�5����4iEJ�m)�U����ܛ���h��شr�T2�: �b�������������z���)      v      x�3�44�2�44�2�44����� 7�      z      x�3�4�2�4�2�4����� �      X   �   x�e�1�@E�Sx̲.�)<�Z+51�4A��+����4S��o�G���dd�u�qQ�pB��B�^�7�N���pV}�/�dRJ��%�#\�<0ꏔxO8�ӛ#�Ǆ��M+t����+�-�!��RmCx�D3��j�f�l�n�      u   �   x�}QI
�@<ϼ�HV�1>�$���<{�YL��Y����M-tմ�+����G�BOm�(\a$A�bOm4E7��T�J&'Ԓ�B'�a�rFc��C��+��%g�
-�=�#%6T��F�=Fr��)��F�s���`�)L�
����L8���בT,���7"v��0�n(�6�vk��3��      |   �   x�m���0D�a�T�;^�d�9z�8�R��:��q&���P-����׫�IU;J
Pm<q�FU��
d,�׿��7ÛZ^_Y�%��%^I���=�H>]��4�vK��.�;��~��n)�%8̧Oxb��������"1��n�ՠ�����oC��������G&��׋�?c�R�      �   8  x����N�@Ek�	�y��).�P� tiӁ@���ٍ)�N�G+�ў�L�����gz9?^�I����Ac�������zݟ��8�p�::fq��	'
h��q^����n��������D���FU!\��p��ҩ�N�t��S�*���^C]qh2	thk�(`0��Æ-�@��-�@�[޾���1os&1||���F䨅͜��̥��gn�Be�s��x�+����i��N3W�N3W�N3W�N3W/�hnr�T;�;�������	1z%�a�+�7p�&n����!�Qs����9r��q{ �9��      �   Y   x��+�0@ݞ���_��#p5I��`�p|�]d��Mk�p.H�E	]'�h�8x:���5!g�]H5A"�K���9�Ӷ�Z�~Y      �   X   x��;� ��A�I��Bg�x����s|w����Z��T�X���d�Ma�0��I��h�:!����+Ы�`&	f9�������H�      x   L   x�E���0D�3Ӌ# �^��&�����$zR���Ɩ��N�7�h����7���o�V/���-ճ�u��	�F      h   .   x�34�4��4202�50�52�24�@1�2�@Qcl����� �	_      j   �   x�M�Q
�PD��[�+��4�K�Q� ����S���[�������̛��Z�N�F�0�A��R����z<ёy��֣�F����Rw41��e#�N++���U��Q��3][c����"�� d6��u�6�Н��=�{f�����;R������s8n27��d��g��^����9�/���      Z   D   x�m�1�0g�F@b�3��;Z��J7�0�.~�A�1#I��6��t�]�1���KYOb�� ��0-      \   !  x�]QKN�@[��"'@I���.&M,`b���X�@���+xn�߼Ɇ,"���gϔ�G�������2��%����K�#�RV
�ϦC�T/�:ό�8b�;��a��y�G�����7��'j{��ji�L�Nt��2幑��͜��H�v���0�V)zv8�P�\�s��uE#�0%�R���+�a��1�G���i�Am�sǀ���J1�:��h&:N�g�_h�%��'��D�a���ޖ)xa���U��o�T�΅8z+E�t>��?*���Y�$��      l     x�uP9N�@��_���]Μg�ۋd�E"�ڀp����/T���Y�	 �����.��+MQ��� �'|�&8�����@@+K�G�$n	�~���r�pO���@N�F����'���4�LNimK�S�9��u氙���/t0�F��dyI�j�h䂄���B�w	�eXb��lRG�-+���;�^����������6�΃L���L���j�GTkH1_����[�3����}��ܗ�����C���ϵ�c�S͍����� �S��PD� �EE      _      x�3�4�2�4�2�4����� �      m      x�3�4��4�2�4����� |'      n   %   x�3�44�45�2�44�47�2�44�4������ =2�      ^   R   x�3�0�bÅ}�^�u�I���Ѐ����D��T���44�56�2EUidn�60C�4�4CUinhSiU	2�2F��� )�      p   �   x�m�A�0E�3����`лx,K,qA<C56i���ȑ�	)˙��˯<i0c��a�� 5�$��[�,G�����2K�Ij}�'Di�&kHK�-
�ϙ/b�����r�evYv�)]w�3��q�      a   �  x���KK�@�ϛO�G�&4i��M�A<{�좁�)i*���Qo"�J�m0}�_a�9����.d��3?��Q	a	c��}�.����oJ`�Pxà�����,1�
>�!�s0S�N�YT`&�	��HT-��y� K�,�ZF˫��]s�:;f�nZL�rlI#��MW0���d�����c`�%���FѤ��H�'_| �hûX􎐓=�y��fI� j��Iq�K�-�y9�a]��'mӪ���s�c�iX�n��P>R��{�G�E�6��1�p���#Ld|� �ʨ��#,�ED��a���f��ir���gZ��u��Z�`o���o��GG�8��{���M�ez�q�Z^
G���f�\!F�h�ffձ�l抵K�b�X�T
l��]��y����R�$�ɑ�#      b      x�3�4�2�4�2�4����� A      �   j   x���1�0������u���R�|'+b@���}x�W�r�eLp�#���Wq�'F<48��bZ$xL�JRU��=��g>�kx�1}o�$���D��0U      d   x   x�3�0�b����/컰��P�]��e�ya���6_�R���¦�M@� �Զ�b�*.c�󁌭@��p^�d�s��\�w�Ho���b7P�	1%�!f$8$F��� �1�&     