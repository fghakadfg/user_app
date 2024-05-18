using System;
using System.Collections.Generic;

namespace user_app;

public partial class ComponentsProduction
{
    public int IdProduct { get; set; }

    public int IdComponent { get; set; }

    public int Quantity { get; set; }

    public virtual Component IdComponentNavigation { get; set; } = null!;

    public virtual Production IdProductNavigation { get; set; } = null!;
}
