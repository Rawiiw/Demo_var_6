using System;
using System.Windows;
using Demo_var_6_Lib;

namespace Demo_var_6
{
    public partial class Login : Window
    {
        public Login()
        {
            InitializeComponent();
        }


        private void NextBut_Click(object sender, RoutedEventArgs e)
        {
            string login = LoginBox.Text;
            string password = Password.Password;
            LoginManager.UserRole userRole;

            // Проверяем, что поля логина и пароля не пусты
            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Введите логин и пароль");
                return;
            }

            // Выполняем аутентификацию пользователя
            if (LoginManager.AuthenticateUser(login, password, out userRole))
            {
                // В зависимости от роли пользователя, открываем соответствующую страницу
                switch (userRole)
                {
                    case LoginManager.UserRole.Admin:
                      ModeratorPage moderatorPage = new ModeratorPage();
                        this.Hide();
                        moderatorPage.Show();
                        break;
                    case LoginManager.UserRole.Viewer:
                    case LoginManager.UserRole.Manager:
                        ViewPage watchPage = new ViewPage();
                        this.Hide();
                        watchPage.Show();
                        break;
                }
            }
            else
            {
                // Если аутентификация не удалась, выводим сообщение об ошибке
                MessageBox.Show("Неверный логин или пароль");
            }
        }

        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
    }
}
