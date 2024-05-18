using System;
using System.Collections.Generic;

namespace user_app;

public partial class Requisition
{
    public int IdRequisition { get; set; }

    public string NameOfRequisition { get; set; } = null!;

    public DateOnly DateOfRec { get; set; }

    public int Responsible { get; set; }

    public string Type { get; set; } = null!;

    public virtual Employee ResponsibleNavigation { get; set; } = null!;
}
