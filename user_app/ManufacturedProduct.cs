using System;
using System.Collections.Generic;

namespace user_app;

public partial class ManufacturedProduct
{
    public int IdProduct { get; set; }

    public int IndividualNumber { get; set; }

    public int Responsible { get; set; }

    public DateOnly DateOfManufact { get; set; }

    public virtual ICollection<Goal> Goals { get; set; } = new List<Goal>();

    public virtual Production IdProductNavigation { get; set; } = null!;

    public virtual Employee ResponsibleNavigation { get; set; } = null!;
}
