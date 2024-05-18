using System;
using System.Collections.Generic;

namespace user_app;

public partial class Department
{
    public int IdDepartments { get; set; }

    public string Name { get; set; } = null!;

    public string Specialization { get; set; } = null!;

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    public virtual ICollection<Project> IdProjects { get; set; } = new List<Project>();
}
