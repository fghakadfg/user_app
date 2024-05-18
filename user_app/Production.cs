using System;
using System.Collections.Generic;

namespace user_app;

public partial class Production
{
    public int IdProduction { get; set; }

    public string NameOfProduction { get; set; } = null!;

    public virtual ICollection<ComponentsProduction> ComponentsProductions { get; set; } = new List<ComponentsProduction>();

    public virtual ICollection<Goal> Goals { get; set; } = new List<Goal>();

    public virtual ICollection<ManufacturedProduct> ManufacturedProducts { get; set; } = new List<ManufacturedProduct>();

    public virtual ICollection<ProjectProgress> ProjectProgresses { get; set; } = new List<ProjectProgress>();

    public virtual ICollection<Blueprint> IdBlueprints { get; set; } = new List<Blueprint>();
}
