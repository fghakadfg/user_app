using System;
using System.Collections.Generic;

namespace user_app;

public partial class HistoryOfUpdate
{
    public short Idupdate { get; set; }

    public string? TableToupdate { get; set; }

    public string? OperationType { get; set; }

    public DateOnly? Dateofupdate { get; set; }

    public long? Idrecord { get; set; }
}
