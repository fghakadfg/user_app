using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace user_app
{
    /// <summary>
    /// Interaction logic for AccountantWindow.xaml
    /// </summary>
    public partial class AccountantWindow : Window
    {
        public AccountantWindow()
        {
            InitializeComponent();

            using (var context = new PostgresContext())
            {

                dataClients.ItemsSource = context.Clients.ToList();
                dataContracts.ItemsSource = context.Contracts.ToList();
                dataEmployees.ItemsSource = context.Employees.ToList();
                dataOrders.ItemsSource = context.Orders.ToList();
                dataReqs.ItemsSource = context.Requisitions.ToList();

            }


        }
    }
}
