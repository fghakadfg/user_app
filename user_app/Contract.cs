using System;
using System.Collections.Generic;

namespace user_app;

public partial class Contract
{
    public int IdContracts { get; set; }

    public string Name { get; set; } = null!;

    public DateOnly DateOfAgreement { get; set; }

    public int EmploId { get; set; }

    public int ClientId { get; set; }

    public string Status { get; set; } = null!;

    public virtual Client Client { get; set; } = null!;

    public virtual Employee Emplo { get; set; } = null!;

    public virtual ICollection<Goal> Goals { get; set; } = new List<Goal>();
}
