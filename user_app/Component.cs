using System;
using System.Collections.Generic;

namespace user_app;

public partial class Component
{
    public int IdComponents { get; set; }

    public string? Name { get; set; }

    public int Quantity { get; set; }

    public virtual ICollection<ComponentsProduction> ComponentsProductions { get; set; } = new List<ComponentsProduction>();

    public virtual ICollection<Supplier> IdSuppliers { get; set; } = new List<Supplier>();
}
