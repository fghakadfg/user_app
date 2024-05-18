using System;
using System.Collections.Generic;

namespace user_app;

public partial class Transport
{
    public int IdTransport { get; set; }

    public string Name { get; set; } = null!;

    public string Type { get; set; } = null!;

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();
}
