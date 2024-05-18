using System;
using System.Collections.Generic;

namespace user_app;

public partial class Extremesituation
{
    public int IdExtremeSituations { get; set; }

    public string Name { get; set; } = null!;

    public DateOnly? Date { get; set; }

    public virtual ICollection<FireFightingEquipment> IdFireFightEqs { get; set; } = new List<FireFightingEquipment>();

    public virtual ICollection<MedicalEquipment> IdMedEqs { get; set; } = new List<MedicalEquipment>();
}
