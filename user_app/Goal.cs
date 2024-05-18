using System;
using System.Collections.Generic;

namespace user_app;

public partial class Goal
{
    public int IdMonthGoal { get; set; }

    public int ProductionId { get; set; }

    public int ContractId { get; set; }

    public DateOnly DateOfPlanStart { get; set; }

    public DateOnly DateOfPlamEnd { get; set; }

    public int? IdManufacturedProd { get; set; }

    public virtual Contract Contract { get; set; } = null!;

    public virtual ManufacturedProduct? IdManufacturedProdNavigation { get; set; }

    public virtual Production Production { get; set; } = null!;
}
