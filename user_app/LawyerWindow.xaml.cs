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
    /// Interaction logic for LawyerWindow.xaml
    /// </summary>
    public partial class LawyerWindow : Window
    {
        public LawyerWindow()
        {
            InitializeComponent();
            using (var context = new PostgresContext())
            {
                dataClients.ItemsSource = context.Clients.ToList();
                dataContracts.ItemsSource = context.Contracts.ToList();
                dataEmployees.ItemsSource = context.Employees.ToList();
                dataOrders.ItemsSource = context.Orders.ToList();
                dataSuppliers.ItemsSource = context.Suppliers.ToList();

            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            String userText = userTextBox.Text;

            EmployeeFeedback ef = new EmployeeFeedback();

            ef.AddNote(userText);

        }
    }
}
