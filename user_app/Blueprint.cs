using System;
using System.Collections.Generic;

namespace user_app;

public partial class Blueprint
{
    public int IdBlueprints { get; set; }

    public string Description { get; set; } = null!;

    public int ArchiveId { get; set; }

    public virtual Archive Archive { get; set; } = null!;

    public virtual ICollection<Production> IdProductions { get; set; } = new List<Production>();
}
