using System;
using System.Globalization;

namespace Relax.Web.Site
{
    public partial class JournalEmployment : System.Web.UI.Page
    {
        private string SQL_ALL = @"
          SELECT
	        ID_BlockDates,
	        CONVERT(DATE, StartDate) as StartDate,
	        CONVERT(TIME, StartDate) as StartTime,
	        CONVERT(DATE, EndDate) as EndDate,
	        CONVERT(TIME, EndDate) as EndTime,
	        c.ID_Cotage,
	        c.type,
	        c.Geo,
	        Reason
          FROM BlockDates
          INNER JOIN Cotage c ON BlockDates.ID_Cotage = c.ID_Cotage
          ORdER BY StartDate ASC";

        private string DROP_COTTAGE = @"
            SELECT
	            CONCAT(ID_Cotage, ' | ', [type], ' | ', Geo, ' | ', Price) as Name
            FROM Cotage;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack || Session["UserId"] == null)
                return;

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(SQL_ALL);

                JournalGridView.DataSource = reader;
                JournalGridView.DataBind();
            });            
            
            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(DROP_COTTAGE);

                CottageDropList.DataSource = reader;
                CottageDropList.DataBind();
            });
        }

        protected void AddJournal_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] is null) return;

            AddPanel.Visible = true;
        }

        protected void CloseSaveBtn_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] is null)
                return;

            AddPanel.Visible = false;
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || Session["UserId"] is null)
            {
                return;
            }

            var startDate = DateTime.Parse(StartDate.Text).ToString("yyyy-dd-MM HH:mm:ss.fff", CultureInfo.InvariantCulture);
            var endDate = DateTime.Parse(EndDate.Text).ToString("yyyy-dd-MM HH:mm:ss.fff", CultureInfo.InvariantCulture);
            var cottageID = CottageDropList.SelectedValue.Split('|')[0].Trim();
            var reason = TextBox1.Text ?? "";

            var insertPet = $"INSERT INTO BlockDates VALUES (NEWID(), '{startDate}', '{cottageID}', '{endDate}', '{reason}');";

            var rowsAdded = SqlUtils.ExecuteNotQuery(insertPet);

            if (rowsAdded > 0)
            {
                Response.Redirect(Request.RawUrl);
                return;
            }
            else
            {
                ErrorLabel.Text = "Ошибка добавления. Попробуйте снова";
                return;
            }
        }
    }
}