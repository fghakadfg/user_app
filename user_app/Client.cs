using System;
using System.Collections.Generic;

namespace user_app;

public partial class Client
{
    public int IdClients { get; set; }

    public string NameOfClient { get; set; } = null!;

    public string Contact { get; set; } = null!;

    public virtual ICollection<Contract> Contracts { get; set; } = new List<Contract>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
