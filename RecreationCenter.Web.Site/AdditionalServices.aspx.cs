using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Cinema.Web.Site
{
    public partial class AdditionalServices : System.Web.UI.Page
    {
        private string sqlALL = @"
            SELECT
                ID_More,
                Price,
                Description,
                Naming
            FROM OtherServices;";

        private readonly SqlConnection connection = 
            new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlALL);
                AdditionalServiceGridView.DataSource = reader;
                AdditionalServiceGridView.DataBind();
            });

            PriceBox.Attributes["placeholder"] = "Цена от";
            ToPriceBox.Attributes["placeholder"] = "Цена до";
        }

        protected void PriceFilter(object sender, EventArgs e)
        {
            var price1 = string.IsNullOrEmpty(PriceBox.Text) ? "0" : PriceBox.Text;
            var price2 = string.IsNullOrEmpty(ToPriceBox.Text) ? int.MaxValue.ToString() : ToPriceBox.Text;

            var sqlFilter = sqlALL.Replace(";", "") + $" WHERE Price Between {price1} AND {price2}";

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlFilter);
                AdditionalServiceGridView.DataSource = reader;
                AdditionalServiceGridView.DataBind();
            });
        }


        protected void Reset_Click(object sender, EventArgs e)
        {
            connection.Open();

            PriceBox.Text = null;
            ToPriceBox.Text = null;

            SqlCommand cmdDd = new SqlCommand(sqlALL, connection);
            SqlDataReader readerDd = cmdDd.ExecuteReader();

            AdditionalServiceGridView.DataSource = readerDd;
            AdditionalServiceGridView.DataBind();

            connection.Close();
        }
    }
}