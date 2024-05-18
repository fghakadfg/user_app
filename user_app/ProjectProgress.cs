using System;
using System.Collections.Generic;

namespace user_app;

public partial class ProjectProgress
{
    public int IdProject { get; set; }

    public int IdProduction { get; set; }

    public int Percent { get; set; }

    public virtual Production IdProductionNavigation { get; set; } = null!;

    public virtual Project IdProjectNavigation { get; set; } = null!;
}
