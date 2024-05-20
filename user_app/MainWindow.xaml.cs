using System.Configuration;
using System.IO;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Security.Cryptography;


namespace user_app
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        private int tries = 0;

        public MainWindow()
        {
            InitializeComponent();
        }


      

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            int userId = int.Parse(userIdBox.Text);

            String userPassword = userPasswordBox.Text;

            String userRole = userRoleBox.Text;

            switch (userRole)
            {
                case "Старший инженер":

                    try
                    {
                        using (var context = new PostgresContext())
                        {

                            var entity = context.TechAccesses.FirstOrDefault(e => e.Idemployee == userId);
                            string hash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    userPassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                hash = builder.ToString();

                            }
                            String[] strings = new string[] { "Не прошел", "Ошибка", "Попробуй 12345", "Взламываешь?", "Может позовешь кого-нибудь", "Не верные данные" };


                            string employeeHash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    entity.EmployeePassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                employeeHash = builder.ToString();

                            }


                            if (entity != null && employeeHash == hash )
                            {

                                passLabel.Content = "Passed";

                                passLabel.Visibility = Visibility.Visible;



                                TechleadWindow tech = new TechleadWindow();



                                string filePath = "example.txt";

                                using (StreamWriter writer = new StreamWriter(filePath))
                                {

                                    String str = userId.ToString();



                                    writer.WriteLine(str);

                                }


                                tech.Show();
                                MainWindow main = new MainWindow();
                                this.Close();
                            }
                            else
                            {


                                passLabel.Foreground = new SolidColorBrush(Colors.Red);

                                passLabel.Content = strings[tries];
                                passLabel.Visibility = Visibility.Visible;
                                if (tries >= 5)
                                {

                                }
                                else
                                {
                                    tries++;
                                }
                            }

                        }
                    }
                    catch(Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }


                    break;
                case "Инженер":

                    try
                    {
                        using (var context = new PostgresContext())
                        {
                            string hash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    userPassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                hash = builder.ToString();

                            }
                            var entity = context.TechAccesses.FirstOrDefault(e => e.Idemployee == userId);

                            String[] strings = new string[] { "Не прошел", "Ошибка", "Попробуй 12345", "Взламываешь?", "Может позовешь кого-нибудь", "Не верные данные" };

                            string employeeHash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    entity.EmployeePassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                employeeHash = builder.ToString();

                            }

                            if (entity != null && employeeHash == hash)
                            {

                                passLabel.Content = "Passed";

                                passLabel.Visibility = Visibility.Visible;

                                string filePath = "example.txt";

                                using (StreamWriter writer = new StreamWriter(filePath))
                                {

                                    String str = userId.ToString();



                                    writer.WriteLine(str);

                                }
                                Tech tech = new Tech();

                                tech.Show();
                                MainWindow main = new MainWindow();
                                this.Close();
                            }
                            else
                            {


                                passLabel.Foreground = new SolidColorBrush(Colors.Red);

                                passLabel.Content = strings[tries];
                                passLabel.Visibility = Visibility.Visible;
                                if (tries >= 5)
                                {

                                }
                                else
                                {
                                    tries++;
                                }
                            }

                        }
                    }

                    catch(Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }

                    break;

                case "Бухгалтер":

                    try
                    {
                        using (var context = new PostgresContext())
                        {

                            string hash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    userPassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                hash = builder.ToString();

                            }
                            String[] strings = new string[] { "Не прошел", "Ошибка", "Попробуй 12345", "Взламываешь?", "Может позовешь кого-нибудь", "Не верные данные" };

                            var entity = context.LawyerAcces.FirstOrDefault(e => e.Idemployee == userId);
                            string employeeHash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    entity.EmployeePassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                employeeHash = builder.ToString();

                            }

                            if (entity != null && employeeHash == hash)
                            {

                                passLabel.Content = "Passed";

                                passLabel.Visibility = Visibility.Visible;
                                string filePath = "example.txt";

                                using (StreamWriter writer = new StreamWriter(filePath))
                                {

                                    String str = userId.ToString();



                                    writer.WriteLine(str);

                                }
                                AccountantWindow accountant = new AccountantWindow();

                                accountant.Show();
                                MainWindow main = new MainWindow();
                                this.Close();
                            }
                            else
                            {


                                passLabel.Foreground = new SolidColorBrush(Colors.Red);

                                passLabel.Content = strings[tries];
                                passLabel.Visibility = Visibility.Visible;
                                if (tries >= 5)
                                {

                                }
                                else
                                {
                                    tries++;
                                }
                            }

                        }
                    }

                    catch(Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }


                    break;

                case "Юрист":

                    try
                    {
                        using (var context = new PostgresContext())
                        {

                            var entity = context.LawyerAcces.FirstOrDefault(e => e.Idemployee == userId);
                            string hash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    userPassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                hash = builder.ToString();

                            }
                            String[] strings = new string[] { "Не прошел", "Ошибка", "Попробуй 12345", "Взламываешь?", "Может позовешь кого-нибудь", "Не верные данные" };
                            string employeeHash = "";
                            using (SHA256 sha256Hash = SHA256.Create())
                            {
                                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(
                                    entity.EmployeePassword));

                                // Конвертируем байты в строку
                                StringBuilder builder = new StringBuilder();
                                for (int i = 0; i < bytes.Length; i++)
                                {
                                    builder.Append(bytes[i].ToString("x2"));
                                }

                                employeeHash = builder.ToString();

                            }

                            if (entity != null && employeeHash == hash)
                            {

                                passLabel.Content = "Passed";

                                passLabel.Visibility = Visibility.Visible;
                                string filePath = "example.txt";

                                using (StreamWriter writer = new StreamWriter(filePath))
                                {

                                    String str = userId.ToString();



                                    writer.WriteLine(str);

                                }
                                LawyerWindow lawyer = new LawyerWindow();

                                lawyer.Show();
                                MainWindow main = new MainWindow();
                                this.Close();
                            }
                            else
                            {


                                passLabel.Foreground = new SolidColorBrush(Colors.Red);

                                passLabel.Content = strings[tries];
                                passLabel.Visibility = Visibility.Visible;
                                if (tries >= 5)
                                {
                                    tries = tries;
                                }
                                else
                                {
                                    tries++;
                                }
                            }

                        }
                    }
                    catch(Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    break;


               

                default:
                    break;

            }

            

        }
    }
}