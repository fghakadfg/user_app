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
    /// Interaction logic for medWindow.xaml
    /// </summary>
    public partial class medWindow : Window
    {
        public medWindow()
        {
            InitializeComponent();

            using (var context = new PostgresContext())
            {

                dataEmloyees.ItemsSource = context.Employees.ToList();
                dataEmloyeesFeedback.ItemsSource = context.EmployeeFeedbacks.ToList();
                dataExtremeSitEq.ItemsSource = context.Extremesituations.ToList();
                dataMedEquipment.ItemsSource = context.MedicalEquipments.ToList();
                dataMedExams.ItemsSource = context.MedExams.ToList();

            }

        }
    }
}
