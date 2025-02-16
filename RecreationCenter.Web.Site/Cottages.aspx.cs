using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Relax.Web.Site
{
    public partial class Cottages : System.Web.UI.Page
    {
        string SQL_ALL = @"
            SELECT 
	            c.ID_Cotage,
	            c.[type],
	            c.Geo,
	            c.Price
            FROM Cotage c;";

        string SQL_DETAILS = @"
            SELECT 
	            c.ID_Cotage,
	            c.[type],
	            c.Geo,
	            c.Price,
                c.Description,
                c.Capacity
            FROM Cotage c WHERE (ID_Cotage = {0});";

        private const string SQL_COTTAGE_OPTIONS_TYPE = "SELECT DISTINCT [type] FROM Cotage;";

        private const string SQL_COTTAGE_OPTIONS_GEO = "SELECT DISTINCT [Geo] FROM Cotage;";

        private readonly SqlConnection connection =
            new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);


        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            connection.Open();

            SqlCommand cmd = new SqlCommand(SQL_ALL, connection);
            SqlDataReader reader = cmd.ExecuteReader();

            CottageGridView.DataSource = reader;
            CottageGridView.DataBind();

            connection.Close();

            connection.Open();

            SqlCommand cmd_type = new SqlCommand(SQL_COTTAGE_OPTIONS_TYPE, connection);
            SqlDataReader reader_type = cmd_type.ExecuteReader();

            DropDownList_Type.DataSource = reader_type;
            DropDownList_Type.DataBind();

            connection.Close();

            connection.Open();

            SqlCommand cmd_geo = new SqlCommand(SQL_COTTAGE_OPTIONS_GEO, connection);
            SqlDataReader reader_geo = cmd_geo.ExecuteReader();

            DropDownList1.DataSource = reader_geo;
            DropDownList1.DataBind();

            connection.Close();
        }
        protected void Date_Check(object sender, EventArgs e)
        {
            var type = DropDownList_Type.SelectedValue;
            var geo = DropDownList1.SelectedValue;

            string sqlCmd = SQL_ALL.Replace(";", "") + $" WHERE [type] = '{type}' AND [Geo] = '{geo}';";

            connection.Open();

            SqlCommand cmdDd = new SqlCommand(sqlCmd, connection);
            SqlDataReader readerDd = cmdDd.ExecuteReader();

            CottageGridView.DataSource = readerDd;
            CottageGridView.DataBind();

            connection.Close();
        }

        protected void Date_Check_Type(object sender, EventArgs e)
        {
            var type = DropDownList_Type.SelectedValue;
            string sqlCmd = SQL_ALL.Replace(";", "") + $" WHERE [type] = '{type}';";

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlCmd);
                CottageGridView.DataSource = reader;
                CottageGridView.DataBind();
            });
        }

        protected void Date_Check_Geo(object sender, EventArgs e)
        {
            var geo = DropDownList1.SelectedValue;
            string sqlCmd = SQL_ALL.Replace(";", "") + $" WHERE [Geo] = '{geo}';";

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlCmd);
                CottageGridView.DataSource = reader;
                CottageGridView.DataBind();
            });
        }

        protected void Reset_Click(object sender, EventArgs e)
        {
            CottageDetails.DataSource = "";
            CottageDetails.DataBind();

            connection.Open();

            SqlCommand cmdDd = new SqlCommand(SQL_ALL, connection);
            SqlDataReader readerDd = cmdDd.ExecuteReader();

            CottageGridView.DataSource = readerDd;
            CottageGridView.DataBind();

            connection.Close();

            BookingCottage.Visible = false;
            FormContainerPanel.Visible = false;
        }

        protected void CottageGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            var list = (GridView)sender;
            var value = (int)list.SelectedValue;

            string sqlSessionByID = string.Format(SQL_DETAILS, value);
            connection.Open();

            SqlCommand cmdDd = new SqlCommand(sqlSessionByID, connection);
            SqlDataReader reader = cmdDd.ExecuteReader();

            CottageDetails.DataSource = reader;
            CottageDetails.DataBind();

            connection.Close();

            var id = Session["UserId"];

            BookingCottage.Visible = (id != null);

            FormContainerPanel.Visible = false;
        }

        protected void BookingCottage_Click(object sender, EventArgs e)
        {
            FormContainerPanel.Visible = (Session["UserId"] != null);
        }


        protected void SubmitBooking_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || !Page.IsValid)
                return;

            var count = int.Parse(CottageDetails.Rows[5].Cells[1].Text);
            var number_cottage = CottageDetails.Rows[0].Cells[1].Text;

            if (int.Parse(CountPeopleBox.Text) > count)
            {
                ErrorLabelBookingDet.Text = "Количество людей превышает вместимость коттеджа";
                return;
            }

            var startDate = DateTime.Parse(StartDate.Text).ToString("yyyy-dd-MM HH:mm:ss.fff", CultureInfo.InvariantCulture);
            var endDate = DateTime.Parse(EndDate.Text).ToString("yyyy-dd-MM HH:mm:ss.fff", CultureInfo.InvariantCulture);
            var userId = Session["UserId"];

            var sqlInsert = $"INSERT INTO Orders VALUES (NEWID(), {CountPeopleBox.Text}, '{startDate}', '{endDate}', '{userId}', {number_cottage}, '88687995-16B1-40E4-A25D-4505BF4603C0', NULL);";

            var resultAdd = SqlUtils.ExecuteNotQuery(sqlInsert);

            if (resultAdd > 0)
            {
                Session["LabelMessage"] = "Вы успешно оформили заявку!";
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                ErrorLabelBookingDet.Text = "Ошибка оформления. Попробуйте снова";
                return;
            }
        }
    }
}