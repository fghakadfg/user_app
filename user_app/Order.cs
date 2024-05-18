using System;
using System.Collections.Generic;

namespace user_app;

public partial class Order
{
    public int IdOrder { get; set; }

    public DateOnly DateOfOrder { get; set; }

    public DateOnly DateOfDelivery { get; set; }

    public DateOnly DateOfPaid { get; set; }

    public double SumOfOrder { get; set; }

    public int ClientId { get; set; }

    public virtual Client Client { get; set; } = null!;
}
