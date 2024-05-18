using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace user_app;

public partial class PostgresContext : DbContext
{
    public PostgresContext()
    {
    }

    public PostgresContext(DbContextOptions<PostgresContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Archive> Archives { get; set; }

    public virtual DbSet<Blueprint> Blueprints { get; set; }

    public virtual DbSet<Client> Clients { get; set; }

    public virtual DbSet<Component> Components { get; set; }

    public virtual DbSet<ComponentsProduction> ComponentsProductions { get; set; }

    public virtual DbSet<Contract> Contracts { get; set; }

    public virtual DbSet<Department> Departments { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<EmployeeFeedback> EmployeeFeedbacks { get; set; }

    public virtual DbSet<Extremesituation> Extremesituations { get; set; }

    public virtual DbSet<FireFightingEquipment> FireFightingEquipments { get; set; }

    public virtual DbSet<GetProductionManfucatureCount> GetProductionManfucatureCounts { get; set; }

    public virtual DbSet<Goal> Goals { get; set; }

    public virtual DbSet<HistoryOfUpdate> HistoryOfUpdates { get; set; }

    public virtual DbSet<ItAccess> ItAccesses { get; set; }

    public virtual DbSet<LawyerAcce> LawyerAcces { get; set; }

    public virtual DbSet<ManufacturedProduct> ManufacturedProducts { get; set; }

    public virtual DbSet<MedExam> MedExams { get; set; }

    public virtual DbSet<MedicalEquipment> MedicalEquipments { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<Position> Positions { get; set; }

    public virtual DbSet<Production> Productions { get; set; }

    public virtual DbSet<Project> Projects { get; set; }

    public virtual DbSet<ProjectProgress> ProjectProgresses { get; set; }

    public virtual DbSet<Requisition> Requisitions { get; set; }

    public virtual DbSet<Supplier> Suppliers { get; set; }

    public virtual DbSet<TechAccess> TechAccesses { get; set; }

    public virtual DbSet<Transport> Transports { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=postgres;Username=postgres;Password=12345");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.HasPostgresExtension("pg_catalog", "adminpack");

        modelBuilder.Entity<Archive>(entity =>
        {
            entity.HasKey(e => e.IdArchive).HasName("archive_pkey");

            entity.ToTable("archive");

            entity.Property(e => e.IdArchive).HasColumnName("idArchive");
            entity.Property(e => e.Type).HasMaxLength(45);
        });

        modelBuilder.Entity<Blueprint>(entity =>
        {
            entity.HasKey(e => e.IdBlueprints).HasName("blueprints_pkey");

            entity.ToTable("blueprints");

            entity.Property(e => e.IdBlueprints).HasColumnName("idBlueprints");
            entity.Property(e => e.ArchiveId).HasColumnName("ArchiveID");
            entity.Property(e => e.Description).HasMaxLength(45);

            entity.HasOne(d => d.Archive).WithMany(p => p.Blueprints)
                .HasForeignKey(d => d.ArchiveId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ArchiveID");

            entity.HasMany(d => d.IdProductions).WithMany(p => p.IdBlueprints)
                .UsingEntity<Dictionary<string, object>>(
                    "BlueprintProduction",
                    r => r.HasOne<Production>().WithMany()
                        .HasForeignKey("IdProduction")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("PrID"),
                    l => l.HasOne<Blueprint>().WithMany()
                        .HasForeignKey("IdBlueprint")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("BlID"),
                    j =>
                    {
                        j.HasKey("IdBlueprint", "IdProduction").HasName("blueprint_production_pkey");
                        j.ToTable("blueprint_production");
                    });
        });

        modelBuilder.Entity<Client>(entity =>
        {
            entity.HasKey(e => e.IdClients).HasName("clients_pkey");

            entity.ToTable("clients");

            entity.Property(e => e.IdClients).HasColumnName("idClients");
            entity.Property(e => e.Contact).HasMaxLength(45);
            entity.Property(e => e.NameOfClient).HasMaxLength(45);
        });

        modelBuilder.Entity<Component>(entity =>
        {
            entity.HasKey(e => e.IdComponents).HasName("components_pkey");

            entity.ToTable("components");

            entity.Property(e => e.IdComponents).HasColumnName("idComponents");
            entity.Property(e => e.Name).HasMaxLength(45);
        });

        modelBuilder.Entity<ComponentsProduction>(entity =>
        {
            entity.HasKey(e => new { e.IdProduct, e.IdComponent }).HasName("components_production_pkey");

            entity.ToTable("components_production");

            entity.Property(e => e.IdProduct).HasColumnName("idProduct");
            entity.Property(e => e.IdComponent).HasColumnName("idComponent");

            entity.HasOne(d => d.IdComponentNavigation).WithMany(p => p.ComponentsProductions)
                .HasForeignKey(d => d.IdComponent)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("idComponent");

            entity.HasOne(d => d.IdProductNavigation).WithMany(p => p.ComponentsProductions)
                .HasForeignKey(d => d.IdProduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("idProddd");
        });

        modelBuilder.Entity<Contract>(entity =>
        {
            entity.HasKey(e => e.IdContracts).HasName("contracts_pkey");

            entity.ToTable("contracts");

            entity.Property(e => e.IdContracts).HasColumnName("idContracts");
            entity.Property(e => e.ClientId).HasColumnName("ClientID");
            entity.Property(e => e.EmploId).HasColumnName("EmploID");
            entity.Property(e => e.Name).HasMaxLength(45);
            entity.Property(e => e.Status).HasMaxLength(45);

            entity.HasOne(d => d.Client).WithMany(p => p.Contracts)
                .HasForeignKey(d => d.ClientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("CliID");

            entity.HasOne(d => d.Emplo).WithMany(p => p.Contracts)
                .HasForeignKey(d => d.EmploId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("EmployID");
        });

        modelBuilder.Entity<Department>(entity =>
        {
            entity.HasKey(e => e.IdDepartments).HasName("departments_pkey");

            entity.ToTable("departments");

            entity.Property(e => e.IdDepartments).HasColumnName("idDepartments");
            entity.Property(e => e.Name).HasMaxLength(45);
            entity.Property(e => e.Specialization).HasMaxLength(45);
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasKey(e => e.IdEmployees).HasName("employees_pkey");

            entity.ToTable("employees");

            entity.Property(e => e.IdEmployees).HasColumnName("idEmployees");
            entity.Property(e => e.Adress).HasMaxLength(120);
            entity.Property(e => e.Bonus)
                .HasDefaultValue(0)
                .HasColumnName("bonus");
            entity.Property(e => e.Education).HasMaxLength(45);
            entity.Property(e => e.FamilyStatus)
                .HasMaxLength(45)
                .HasColumnName("Family_status");
            entity.Property(e => e.InsurancePolicy)
                .HasMaxLength(45)
                .HasColumnName("Insurance_policy");
            entity.Property(e => e.Lastname).HasMaxLength(45);
            entity.Property(e => e.Name).HasMaxLength(45);
            entity.Property(e => e.Phone).HasMaxLength(45);
            entity.Property(e => e.PositionId).HasColumnName("PositionID");
            entity.Property(e => e.Surname).HasMaxLength(45);

            entity.HasOne(d => d.DepartmentNavigation).WithMany(p => p.Employees)
                .HasForeignKey(d => d.Department)
                .HasConstraintName("Depid");

            entity.HasOne(d => d.Position).WithMany(p => p.Employees)
                .HasForeignKey(d => d.PositionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("PosID");

            entity.HasMany(d => d.IdProjects).WithMany(p => p.IdEmployees)
                .UsingEntity<Dictionary<string, object>>(
                    "ProjectEmpl",
                    r => r.HasOne<Project>().WithMany()
                        .HasForeignKey("IdProject")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idProj"),
                    l => l.HasOne<Employee>().WithMany()
                        .HasForeignKey("IdEmployee")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idEmp"),
                    j =>
                    {
                        j.HasKey("IdEmployee", "IdProject").HasName("project_empl_pkey");
                        j.ToTable("project_empl");
                        j.IndexerProperty<int>("IdEmployee").HasColumnName("idEmployee");
                        j.IndexerProperty<int>("IdProject").HasColumnName("idProject");
                    });

            entity.HasMany(d => d.Transports).WithMany(p => p.Employees)
                .UsingEntity<Dictionary<string, object>>(
                    "EmployeeTransport",
                    r => r.HasOne<Transport>().WithMany()
                        .HasForeignKey("TransportId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("TrID"),
                    l => l.HasOne<Employee>().WithMany()
                        .HasForeignKey("EmployeeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("EmID"),
                    j =>
                    {
                        j.HasKey("EmployeeId", "TransportId").HasName("employee_transport_pkey");
                        j.ToTable("employee_transport");
                        j.IndexerProperty<int>("EmployeeId").HasColumnName("EmployeeID");
                        j.IndexerProperty<int>("TransportId").HasColumnName("TransportID");
                    });
        });

        modelBuilder.Entity<EmployeeFeedback>(entity =>
        {
            entity.HasKey(e => e.IdFeedback).HasName("employee_feedback_pkey");

            entity.ToTable("employee_feedback");

            entity.Property(e => e.IdFeedback).HasColumnName("idFeedback");
            entity.Property(e => e.EmployeeId).HasColumnName("EmployeeID");

            entity.HasOne(d => d.Employee).WithMany(p => p.EmployeeFeedbacks)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_employee_feedback_employee_id");
        });

        modelBuilder.Entity<Extremesituation>(entity =>
        {
            entity.HasKey(e => e.IdExtremeSituations).HasName("extremesituations_pkey");

            entity.ToTable("extremesituations");

            entity.Property(e => e.IdExtremeSituations).HasColumnName("idExtremeSituations");
            entity.Property(e => e.Name).HasMaxLength(45);

            entity.HasMany(d => d.IdFireFightEqs).WithMany(p => p.IdExtremes)
                .UsingEntity<Dictionary<string, object>>(
                    "ExtremeFirefighteq",
                    r => r.HasOne<FireFightingEquipment>().WithMany()
                        .HasForeignKey("IdFireFightEq")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idFireEq"),
                    l => l.HasOne<Extremesituation>().WithMany()
                        .HasForeignKey("IdExtreme")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idExt"),
                    j =>
                    {
                        j.HasKey("IdExtreme", "IdFireFightEq").HasName("extreme_firefighteq_pkey");
                        j.ToTable("extreme_firefighteq");
                        j.IndexerProperty<int>("IdExtreme").HasColumnName("idExtreme");
                        j.IndexerProperty<int>("IdFireFightEq").HasColumnName("idFireFightEq");
                    });

            entity.HasMany(d => d.IdMedEqs).WithMany(p => p.IdExtremes)
                .UsingEntity<Dictionary<string, object>>(
                    "ExtremesitMedeq",
                    r => r.HasOne<MedicalEquipment>().WithMany()
                        .HasForeignKey("IdMedEq")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idMed"),
                    l => l.HasOne<Extremesituation>().WithMany()
                        .HasForeignKey("IdExtreme")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idEx"),
                    j =>
                    {
                        j.HasKey("IdExtreme", "IdMedEq").HasName("extremesit_medeq_pkey");
                        j.ToTable("extremesit_medeq");
                        j.IndexerProperty<int>("IdExtreme").HasColumnName("idExtreme");
                        j.IndexerProperty<int>("IdMedEq").HasColumnName("idMedEq");
                    });
        });

        modelBuilder.Entity<FireFightingEquipment>(entity =>
        {
            entity.HasKey(e => e.IdFireFightingEquipment).HasName("fire_fighting_equipment_pkey");

            entity.ToTable("fire_fighting_equipment");

            entity.Property(e => e.IdFireFightingEquipment).HasColumnName("idFire_fighting_equipment");
            entity.Property(e => e.Name).HasMaxLength(45);

            entity.HasOne(d => d.ResponsibleNavigation).WithMany(p => p.FireFightingEquipments)
                .HasForeignKey(d => d.Responsible)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ResID");
        });

        modelBuilder.Entity<GetProductionManfucatureCount>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("get_production_manfucature_count");

            entity.Property(e => e.Count).HasColumnName("count");
            entity.Property(e => e.NameOfProduction).HasMaxLength(45);
        });

        modelBuilder.Entity<Goal>(entity =>
        {
            entity.HasKey(e => e.IdMonthGoal).HasName("goals_pkey");

            entity.ToTable("goals");

            entity.Property(e => e.ContractId).HasColumnName("ContractID");
            entity.Property(e => e.IdManufacturedProd).HasColumnName("idManufacturedProd");
            entity.Property(e => e.ProductionId).HasColumnName("ProductionID");

            entity.HasOne(d => d.Contract).WithMany(p => p.Goals)
                .HasForeignKey(d => d.ContractId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ContractID");

            entity.HasOne(d => d.IdManufacturedProdNavigation).WithMany(p => p.Goals)
                .HasPrincipalKey(p => p.IndividualNumber)
                .HasForeignKey(d => d.IdManufacturedProd)
                .HasConstraintName("idManufacturedProduct");

            entity.HasOne(d => d.Production).WithMany(p => p.Goals)
                .HasForeignKey(d => d.ProductionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ProductionID");
        });

        modelBuilder.Entity<HistoryOfUpdate>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("history_of_updates");

            entity.Property(e => e.Dateofupdate).HasColumnName("dateofupdate");
            entity.Property(e => e.Idrecord).HasColumnName("idrecord");
            entity.Property(e => e.Idupdate)
                .ValueGeneratedOnAdd()
                .UseIdentityAlwaysColumn()
                .HasColumnName("idupdate");
            entity.Property(e => e.OperationType)
                .HasColumnType("character varying")
                .HasColumnName("operation_type");
            entity.Property(e => e.TableToupdate).HasColumnType("character varying");
        });

        modelBuilder.Entity<ItAccess>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("it_access");

            entity.Property(e => e.EmployeePassword)
                .HasColumnType("character varying")
                .HasColumnName("employee_password");
            entity.Property(e => e.Hash)
                .HasColumnType("character varying")
                .HasColumnName("hash");
            entity.Property(e => e.Idemployee).HasColumnName("idemployee");

            entity.HasOne(d => d.IdemployeeNavigation).WithMany()
                .HasForeignKey(d => d.Idemployee)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("it_access_employees_fk");
        });

        modelBuilder.Entity<LawyerAcce>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("lawyer_acces");

            entity.Property(e => e.EmployeePassword)
                .HasColumnType("character varying")
                .HasColumnName("employee_password");
            entity.Property(e => e.Hash)
                .HasColumnType("character varying")
                .HasColumnName("hash");
            entity.Property(e => e.Idemployee).HasColumnName("idemployee");

            entity.HasOne(d => d.IdemployeeNavigation).WithMany()
                .HasForeignKey(d => d.Idemployee)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("lawyer_acces_employees_fk");
        });

        modelBuilder.Entity<ManufacturedProduct>(entity =>
        {
            entity.HasKey(e => new { e.IdProduct, e.IndividualNumber }).HasName("manufactured_products_pkey");

            entity.ToTable("manufactured_products");

            entity.HasIndex(e => e.IndividualNumber, "unique_individual_number").IsUnique();

            entity.Property(e => e.IdProduct).HasColumnName("idProduct");

            entity.HasOne(d => d.IdProductNavigation).WithMany(p => p.ManufacturedProducts)
                .HasForeignKey(d => d.IdProduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("idProd");

            entity.HasOne(d => d.ResponsibleNavigation).WithMany(p => p.ManufacturedProducts)
                .HasForeignKey(d => d.Responsible)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("idEmployeer");
        });

        modelBuilder.Entity<MedExam>(entity =>
        {
            entity.HasKey(e => e.IdMedExam).HasName("med_exam_pkey");

            entity.ToTable("med_exam");

            entity.Property(e => e.IdMedExam).HasColumnName("idMed_exam");

            entity.HasOne(d => d.DoctorNavigation).WithMany(p => p.MedExamDoctorNavigations)
                .HasForeignKey(d => d.Doctor)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("DocID");

            entity.HasOne(d => d.IdEmployeeNavigation).WithMany(p => p.MedExamIdEmployeeNavigations)
                .HasForeignKey(d => d.IdEmployee)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_med_exam_employee_id");
        });

        modelBuilder.Entity<MedicalEquipment>(entity =>
        {
            entity.HasKey(e => e.IdMedicalEquipment).HasName("medical_equipment_pkey");

            entity.ToTable("medical_equipment");

            entity.Property(e => e.IdMedicalEquipment).HasColumnName("idMedical_equipment");
            entity.Property(e => e.Name).HasMaxLength(45);

            entity.HasOne(d => d.ResponsibleNavigation).WithMany(p => p.MedicalEquipments)
                .HasForeignKey(d => d.Responsible)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Responsible");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.IdOrder).HasName("orders_pkey");

            entity.ToTable("orders");

            entity.Property(e => e.IdOrder).HasColumnName("idOrder");
            entity.Property(e => e.ClientId).HasColumnName("ClientID");

            entity.HasOne(d => d.Client).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ClientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("CliID");
        });

        modelBuilder.Entity<Position>(entity =>
        {
            entity.HasKey(e => e.IdPositions).HasName("positions_pkey");

            entity.ToTable("positions");

            entity.Property(e => e.IdPositions).HasColumnName("idPositions");
            entity.Property(e => e.Name).HasMaxLength(45);
        });

        modelBuilder.Entity<Production>(entity =>
        {
            entity.HasKey(e => e.IdProduction).HasName("production_pkey");

            entity.ToTable("production");

            entity.Property(e => e.IdProduction).HasColumnName("idProduction");
            entity.Property(e => e.NameOfProduction).HasMaxLength(45);
        });

        modelBuilder.Entity<Project>(entity =>
        {
            entity.HasKey(e => e.IdProjects).HasName("projects_pkey");

            entity.ToTable("projects");

            entity.Property(e => e.IdProjects).HasColumnName("idProjects");
            entity.Property(e => e.NameOfProject).HasMaxLength(45);

            entity.HasMany(d => d.IdDepartments).WithMany(p => p.IdProjects)
                .UsingEntity<Dictionary<string, object>>(
                    "ProjectDepartment",
                    r => r.HasOne<Department>().WithMany()
                        .HasForeignKey("IdDepartment")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idDep"),
                    l => l.HasOne<Project>().WithMany()
                        .HasForeignKey("IdProject")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idProj"),
                    j =>
                    {
                        j.HasKey("IdProject", "IdDepartment").HasName("project_departments_pkey");
                        j.ToTable("project_departments");
                        j.IndexerProperty<int>("IdProject").HasColumnName("idProject");
                        j.IndexerProperty<int>("IdDepartment").HasColumnName("idDepartment");
                    });
        });

        modelBuilder.Entity<ProjectProgress>(entity =>
        {
            entity.HasKey(e => new { e.IdProject, e.IdProduction }).HasName("project_progress_pkey");

            entity.ToTable("project_progress");

            entity.Property(e => e.IdProject).HasColumnName("idProject");
            entity.Property(e => e.IdProduction).HasColumnName("idProduction");

            entity.HasOne(d => d.IdProductionNavigation).WithMany(p => p.ProjectProgresses)
                .HasForeignKey(d => d.IdProduction)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("idProd");

            entity.HasOne(d => d.IdProjectNavigation).WithMany(p => p.ProjectProgresses)
                .HasForeignKey(d => d.IdProject)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("idProjjj");
        });

        modelBuilder.Entity<Requisition>(entity =>
        {
            entity.HasKey(e => e.IdRequisition).HasName("requisitions_pkey");

            entity.ToTable("requisitions");

            entity.Property(e => e.IdRequisition).HasColumnName("idRequisition");
            entity.Property(e => e.NameOfRequisition).HasMaxLength(45);
            entity.Property(e => e.Type).HasMaxLength(45);

            entity.HasOne(d => d.ResponsibleNavigation).WithMany(p => p.Requisitions)
                .HasForeignKey(d => d.Responsible)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Respon");
        });

        modelBuilder.Entity<Supplier>(entity =>
        {
            entity.HasKey(e => e.IdSuppliers).HasName("suppliers_pkey");

            entity.ToTable("suppliers");

            entity.Property(e => e.IdSuppliers).HasColumnName("idSuppliers");
            entity.Property(e => e.ContactPerson).HasMaxLength(45);
            entity.Property(e => e.Email).HasMaxLength(45);
            entity.Property(e => e.LegalAddress).HasMaxLength(45);
            entity.Property(e => e.NameOfSupplier).HasMaxLength(45);
            entity.Property(e => e.Phone).HasMaxLength(45);

            entity.HasMany(d => d.IdComponents).WithMany(p => p.IdSuppliers)
                .UsingEntity<Dictionary<string, object>>(
                    "SuppliersComponent",
                    r => r.HasOne<Component>().WithMany()
                        .HasForeignKey("IdComponent")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idComp"),
                    l => l.HasOne<Supplier>().WithMany()
                        .HasForeignKey("IdSupplier")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("idSupp"),
                    j =>
                    {
                        j.HasKey("IdSupplier", "IdComponent").HasName("suppliers_components_pkey");
                        j.ToTable("suppliers_components");
                        j.IndexerProperty<int>("IdSupplier").HasColumnName("idSupplier");
                        j.IndexerProperty<int>("IdComponent").HasColumnName("idComponent");
                    });
        });

        modelBuilder.Entity<TechAccess>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("tech_access");

            entity.Property(e => e.EmployeePassword)
                .HasColumnType("character varying")
                .HasColumnName("employee_password");
            entity.Property(e => e.Hash)
                .HasColumnType("character varying")
                .HasColumnName("hash");
            entity.Property(e => e.Idemployee).HasColumnName("idemployee");

            entity.HasOne(d => d.IdemployeeNavigation).WithMany()
                .HasForeignKey(d => d.Idemployee)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("tech_access_employees_fk");
        });

        modelBuilder.Entity<Transport>(entity =>
        {
            entity.HasKey(e => e.IdTransport).HasName("transport_pkey");

            entity.ToTable("transport");

            entity.Property(e => e.IdTransport).HasColumnName("idTransport");
            entity.Property(e => e.Name).HasMaxLength(45);
            entity.Property(e => e.Type).HasMaxLength(45);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
