using System;
using System.Collections.Generic;

namespace user_app;

public partial class EmployeeFeedback
{
    public int IdFeedback { get; set; }

    public int EmployeeId { get; set; }

    public string Comment { get; set; } = null!;

    public DateOnly Date { get; set; }

    public virtual Employee Employee { get; set; } = null!;
}
