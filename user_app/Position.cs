using System;
using System.Collections.Generic;

namespace user_app;

public partial class Position
{
    public int IdPositions { get; set; }

    public string Name { get; set; } = null!;

    public double Salary { get; set; }

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();
}
