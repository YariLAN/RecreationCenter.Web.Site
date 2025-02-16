using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Relax.Web.Site
{
    public partial class RegisterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
        }

        protected void RegisterBtn_Click(object sender, EventArgs e)
        {
            ErrorLabel.Text = "";

            if (!Page.IsValid)
            {
                return;
            }

            var login = LoginBox.Text;
            var email = EmailBox.Text;

            var sqlClient = $"SELECT * FROM Client WHERE login = '{login}' OR Email = '{email}'";

            var userId = SqlUtils.ExecuteScalar<Guid?>(sqlClient);

            if (userId != null)
            {
                ErrorLabel.Text = $"Пользователь с ником ({login}) или почтой ({email}) уже существует";
                return;
            }

            var names = NameBox.Text.Split(' ').ToList();

            if (names.Count <= 1)
            {
                ErrorLabel.Text = "Имя написано не полностью (не хватает фамилии или имени)";
                return;
            }

            var name = names[0];
            var surname = names[1];
            var password = PasswordBox.Text;

            var phone = PhoneBox.Text;

            string insertSQL = "INSERT INTO Client " +
                "(ID_Client, Surname, NumberPhone, login, password, IsAdmin, FirstName, Email) " +
             $"VALUES (NEWID(), '{surname}', '{phone}', '{login}', '{password}', '0', '{name}', '{email}')";

            var resultUpdated = SqlUtils.ExecuteNotQuery(insertSQL);

            if (resultUpdated > 0)
            {
                Session["LabelMessage"] = "Вы прошли регистрацию.";
                Response.Redirect("MainPage.aspx");
            }
            else
            {
                ErrorLabel.Text = "Ошибка регистрации. Попробуйте снова";
                return;
            }
        }
    }

    public class SqlUtils
    {
        private static SqlConnection _connection =
            new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        public static T ExecuteScalar<T>(string sqlCommand)
        {
            _connection.Open();

            SqlCommand cmd = new SqlCommand(sqlCommand, _connection);
            T result = (T)cmd.ExecuteScalar();

            _connection.Close();

            return result;
        }

        public static int ExecuteNotQuery(string insertCmd)
        {
            _connection.Open();

            SqlCommand cmd = new SqlCommand(insertCmd, _connection);
            int result = cmd.ExecuteNonQuery();

            _connection.Close();

            return result;
        }

        public static void CompleteConnect(Action action)
        {
            _connection.Open();
            action();
            _connection.Close();
        }

        public static SqlDataReader CompleteCommand(string sqlCommand)
        {
            SqlCommand cmd = new SqlCommand(sqlCommand, _connection);
            SqlDataReader reader = cmd.ExecuteReader();

            return !reader.Read() ? null : reader;
        }

        public static SqlDataReader CleanExecuteReader(string sqlCommand)
        {
            SqlCommand cmd = new SqlCommand(sqlCommand, _connection);
            SqlDataReader reader = cmd.ExecuteReader();

            return reader;
        }
    }
}