using System;
using System.Collections.Generic;

namespace user_app;

public partial class Employee
{
    public int IdEmployees { get; set; }

    public string Lastname { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string? Surname { get; set; }

    public int PositionId { get; set; }

    public string Phone { get; set; } = null!;

    public long Passport { get; set; }

    public string? Education { get; set; }

    public string Adress { get; set; } = null!;

    public string? FamilyStatus { get; set; }

    public string InsurancePolicy { get; set; } = null!;

    public int? Department { get; set; }

    public int? Bonus { get; set; }

    public virtual ICollection<Contract> Contracts { get; set; } = new List<Contract>();

    public virtual Department? DepartmentNavigation { get; set; }

    public virtual ICollection<EmployeeFeedback> EmployeeFeedbacks { get; set; } = new List<EmployeeFeedback>();

    public virtual ICollection<FireFightingEquipment> FireFightingEquipments { get; set; } = new List<FireFightingEquipment>();

    public virtual ICollection<ManufacturedProduct> ManufacturedProducts { get; set; } = new List<ManufacturedProduct>();

    public virtual ICollection<MedExam> MedExamDoctorNavigations { get; set; } = new List<MedExam>();

    public virtual ICollection<MedExam> MedExamIdEmployeeNavigations { get; set; } = new List<MedExam>();

    public virtual ICollection<MedicalEquipment> MedicalEquipments { get; set; } = new List<MedicalEquipment>();

    public virtual Position Position { get; set; } = null!;

    public virtual ICollection<Requisition> Requisitions { get; set; } = new List<Requisition>();

    public virtual ICollection<Project> IdProjects { get; set; } = new List<Project>();

    public virtual ICollection<Transport> Transports { get; set; } = new List<Transport>();
}
