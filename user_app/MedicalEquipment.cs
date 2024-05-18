using System;
using System.Collections.Generic;

namespace user_app;

public partial class MedicalEquipment
{
    public int IdMedicalEquipment { get; set; }

    public string Name { get; set; } = null!;

    public int Quantity { get; set; }

    public int Responsible { get; set; }

    public virtual Employee ResponsibleNavigation { get; set; } = null!;

    public virtual ICollection<Extremesituation> IdExtremes { get; set; } = new List<Extremesituation>();
}
