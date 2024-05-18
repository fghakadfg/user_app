using System;
using System.Collections.Generic;

namespace user_app;

public partial class Project
{
    public int IdProjects { get; set; }

    public string NameOfProject { get; set; } = null!;

    public DateOnly Start { get; set; }

    public DateOnly End { get; set; }

    public virtual ICollection<ProjectProgress> ProjectProgresses { get; set; } = new List<ProjectProgress>();

    public virtual ICollection<Department> IdDepartments { get; set; } = new List<Department>();

    public virtual ICollection<Employee> IdEmployees { get; set; } = new List<Employee>();
}
