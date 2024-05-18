using System;
using System.Collections.Generic;

namespace user_app;

public partial class MedExam
{
    public int IdMedExam { get; set; }

    public int IdEmployee { get; set; }

    public int Doctor { get; set; }

    public DateOnly Date { get; set; }

    public virtual Employee DoctorNavigation { get; set; } = null!;

    public virtual Employee IdEmployeeNavigation { get; set; } = null!;
}
