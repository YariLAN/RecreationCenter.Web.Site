using System;
using System.Web.UI.WebControls;

namespace Relax.Web.Site
{
    public partial class Feadbacks : System.Web.UI.Page
    {
        private string SQL_ALL = @"
            SELECT 
	            f.ID_Feedback,
	            CONCAT(c.Surname, ' ', c.FirstName) as Name,
	            c.Email,
	            ct.ID_Cotage,
	            ct.[type],
	            ct.Geo
            FROM Feedbacks f
            INNER JOIN Client c on f.ID_Client = c.ID_Client
            INNER JOIN Cotage ct on f.ID_Cotage = ct.ID_Cotage;
        ";

        private string SQL_DETAILS = @"
            SELECT 
	            CONCAT(c.Surname, ' ', c.FirstName) as Name,
	            f.Description,
	            ct.ID_Cotage,
	            ct.[type],
	            ct.Geo,
                ct.Capacity
            FROM Feedbacks f
            INNER JOIN Client c on f.ID_Client = c.ID_Client
            INNER JOIN Cotage ct on f.ID_Cotage = ct.ID_Cotage
            WHERE ID_Feedback = '{0}';
        ";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(SQL_ALL);
                FeadbacksGridView.DataSource = reader;
                FeadbacksGridView.DataBind();
            });
        }

        protected void FeedBackGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            var list = (GridView)sender;
            var value = (Guid)list.SelectedValue;

            var sqlDetails = string.Format(SQL_DETAILS, value);

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlDetails);
                FeadbacksDetails.DataSource = reader;
                FeadbacksDetails.DataBind();
            });
        }
    }
}