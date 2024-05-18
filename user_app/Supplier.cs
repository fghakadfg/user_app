using System;
using System.Collections.Generic;

namespace user_app;

public partial class Supplier
{
    public int IdSuppliers { get; set; }

    public string NameOfSupplier { get; set; } = null!;

    public string LegalAddress { get; set; } = null!;

    public string ContactPerson { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Email { get; set; } = null!;

    public virtual ICollection<Component> IdComponents { get; set; } = new List<Component>();
}
