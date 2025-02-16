using System;
using System.Web.UI.WebControls;

namespace Cinema.Web.Site
{
    public partial class AddTicket : System.Web.UI.Page
    {
        private string SQL_ALL = @"
            SELECT 
	            c.ID_Cotage,
	            c.[type],
	            c.Geo,
	            c.Price
            FROM Cotage c;";

        private string SQL_ALL_SERVICES = @"
            SELECT
                ID_More,
                Price,
                Description,
                Naming
            FROM OtherServices;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack || Session["UserId"] == null)
                return;

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(SQL_ALL);
                CottageGridView.DataSource = reader;
                CottageGridView.DataBind();
            });

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(SQL_ALL_SERVICES);
                AdditionalServiceGridView.DataSource = reader;
                AdditionalServiceGridView.DataBind();
            });

            ErrorLabel.Visible = false;
        }

        protected void CottageGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) return;

            var list = (GridView)sender;
            var value = (int)list.SelectedValue;

            var sqlGetCottage = SQL_ALL.Replace(";", $" WHERE ID_Cotage = '{value}';");

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlGetCottage);

                if (reader.Read())
                {
                    EditPriceCottageBox.Text = reader.GetInt32(3).ToString();
                }
            });

            EditPriceCottagePanel.Visible = true;
        }  

        protected void ServiceGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) return;

            var list = (GridView)sender;
            var value = (Guid)list.SelectedValue;

            var sqlGetCottage = SQL_ALL_SERVICES.Replace(";", $" WHERE ID_More = '{value}';");

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlGetCottage);

                if (reader.Read())
                {
                    TextBox1.Text = reader.GetInt32(1).ToString();
                }
            });

            Panel1.Visible = true;
        }


        protected void CancelEdit_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] is null) return;

            EditPriceCottagePanel.Visible = false;
        }  
        
        protected void CancelEdit_Click2(object sender, EventArgs e)
        {
            if (Session["UserId"] is null) return;

            Panel1.Visible = false;
        }

        protected void UpdatePriceCottageBtn_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] is null)
                return;

            var cottageID = (int)CottageGridView.SelectedValue;
            var priceCottage = EditPriceCottageBox.Text;


            var sqlUpdate = $"UPDATE Cotage SET Price = {priceCottage} WHERE ID_Cotage = {cottageID};";

            var resultUpd = SqlUtils.ExecuteNotQuery(sqlUpdate);

            if (resultUpd > 0)
            {
                Session["LabelMessage"] = $"Вы успешно обновили прайс коттеджа под номером {cottageID}!";
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                ErrorLabel.Visible = true;
                ErrorLabel.Text = "Ошибка обновления. Попробуйте снова";
                return;
            }
        }  

        protected void UpdatePriceServiceBtn_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] is null)
                return;

            var serviceID = (Guid)AdditionalServiceGridView.SelectedValue;
            var price = TextBox1.Text;

            var sqlUpdate = $"UPDATE OtherServices SET Price = {price} WHERE ID_More = '{serviceID}';";

            var resultUpd = SqlUtils.ExecuteNotQuery(sqlUpdate);

            if (resultUpd > 0)
            {
                Session["LabelMessage"] = $"Вы успешно обновили прайс одной из услуг!";
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                ErrorLabel.Visible = true;
                ErrorLabel.Text = "Ошибка обновления. Попробуйте снова";
                return;
            }
        }
    }                         
}