using System;
using System.Collections.Generic;

namespace user_app;

public partial class ItAccess
{
    public int Idemployee { get; set; }

    public string? EmployeePassword { get; set; }

    public string? Hash { get; set; }

    public virtual Employee IdemployeeNavigation { get; set; } = null!;
}
