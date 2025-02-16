using System;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Web.UI.WebControls;

namespace Cinema.Web.Site
{
    public partial class HistoryTicketsPage : System.Web.UI.Page
    {
        private string SQL_BY_CLIENT = @"
            SELECT 
                O.ID_order,
	            CONVERT(DATE, O.DatetimeStart) as StartDate,
	            CONVERT(TIME, O.DatetimeStart) as StartTime,
	            CONVERT(DATE, O.DatetimeStop) as EndDate,
	            CONVERT(TIME, O.DatetimeStop) as EndTime,
                C.ID_Cotage,
                O.CountPeople,
	            DATEDIFF(day, O.DatetimeStart, O.DatetimeStop) as [Days],
                DATEDIFF(day, O.DatetimeStart, O.DatetimeStop) * C.Price AS DaysPrice,
                COUNT(OS.ID_More) AS AddServicesCount, -- Количество доп. услуг
                ISNULL(SUM(S.Price), 0) AS AddServicesPrice, -- Общая стоимость доп. услуг
                SO.Name AS StatusName
            FROM 
                Orders O
            INNER JOIN 
                Cotage C ON O.ID_Cotage = C.ID_Cotage
            INNER JOIN 
                StatusOrder SO ON O.ID_Status = SO.ID_Status
            LEFT JOIN 
                OrdersOtherServices OS ON O.ID_order = OS.ID_order
            LEFT JOIN 
                OtherServices S ON OS.ID_More = S.ID_More
            WHERE O.ID_Client = '{0}'
            GROUP BY
                O.ID_order,
                C.ID_Cotage,
                C.[type],
                C.Geo,
                O.CountPeople,
                O.DatetimeStart,
                O.DatetimeStop,
                C.Price,
                SO.Name
            ORDER BY O.DatetimeStart ASC;";

        private string SQL_DETAILS = @"
            SELECT 
                C.ID_Cotage,
	            C.[type],
	            C.Geo,
	            C.Price,
	            C.[Description],
	            C.Capacity,
                SO.Name AS StatusName,
	            ISNULL(O.Comment, '') as Comment 
            FROM 
                Orders O
            INNER JOIN 
                Cotage C ON O.ID_Cotage = C.ID_Cotage
            INNER JOIN 
                StatusOrder SO ON O.ID_Status = SO.ID_Status
            WHERE O.ID_order = '{0}';  
        ";

        private string sqlAddServices = @"
            SELECT
                S.ID_More,
                S.Naming,
	            S.[Description],
                S.Price
            FROM Orders O
            INNER JOIN 
                OrdersOtherServices OS ON O.ID_order = OS.ID_order
            INNER JOIN 
                OtherServices S ON OS.ID_More = S.ID_More
            WHERE O.ID_order = '{0}';";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack || Session["UserId"] == null) return;

            var userID = Session["UserId"];

            var getQuery = string.Format(SQL_BY_CLIENT, userID);

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(getQuery);
                HistoryGridView.DataSource = reader;
                HistoryGridView.DataBind();
            });

            var sqlServices = "SELECT  CONCAT(Naming, ' | ', Price, ' Руб.') AS ServiceInfo FROM OtherServices;";

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlServices);
                DropDownList_Service.DataSource = reader;
                DropDownList_Service.DataBind();
            });
        }

        protected void ApplicationGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            var list = (GridView)sender;
            var value = list.SelectedValue;

            string sqlApplicationDetails = string.Format(SQL_DETAILS, value);

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlApplicationDetails);
                ApplicationDetails.DataSource = reader;
                ApplicationDetails.DataBind();
            });                    
            
            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(string.Format(sqlAddServices, value));
                AdditionalServiceGridView.DataSource = reader;
                AdditionalServiceGridView.DataBind();
            });

            var indexRow = list.SelectedIndex;
            var status = list.Rows[indexRow].Cells[12].Text;

            Add_ServicesBtn.Visible = DropDownList_Service.Visible = (status == "Принято");
        }

        protected void AddServicesClick(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) return;

            var usluga = DropDownList_Service.SelectedValue.Split('|')[0].TrimEnd();

            var sqlGetUsluga = $"SELECT * FROM OtherServices WHERE Naming = '{usluga}'";
            Guid? uslugaId = SqlUtils.ExecuteScalar<Guid>(sqlGetUsluga);

            if (uslugaId is null)
                return;

            var orderId = (Guid)HistoryGridView.SelectedValue;

            var sqlInsert = $"INSERT INTO OrdersOtherServices VALUES ('{orderId}', '{uslugaId}');";

            var resultAdd = SqlUtils.ExecuteNotQuery(sqlInsert);

            if (resultAdd > 0)
            {
                Session["LabelMessage"] = "Вы успешно добавили доп. услугу!";
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                ErrorLabel.Text = "Ошибка добавления. Попробуйте снова";
                return;
            }
        }
    }
}