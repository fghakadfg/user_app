using System;
using System.Collections.Generic;

namespace user_app;

public partial class Archive
{
    public int IdArchive { get; set; }

    public string Type { get; set; } = null!;

    public int Volume { get; set; }

    public virtual ICollection<Blueprint> Blueprints { get; set; } = new List<Blueprint>();
}
