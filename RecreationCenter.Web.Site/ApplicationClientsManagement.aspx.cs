using System;
using System.Data.SqlClient;
using System.Globalization;
using System.Reflection;
using System.Web.UI.WebControls;

namespace Cinema.Web.Site
{
    public partial class ControlTicketClient : System.Web.UI.Page
    {
        private string GET_ALL_ORDERS = @"
            SELECT 
                O.ID_order,
	            CONCAT(U.Surname, ' ', U.FirstName) as Name,
                CONVERT(DATE, O.DatetimeStart) as StartDate,
                CONVERT(TIME, O.DatetimeStart) as StartTime,
                CONVERT(DATE, O.DatetimeStop) as EndDate,
                CONVERT(TIME, O.DatetimeStop) as EndTime,
                C.ID_Cotage,
                O.CountPeople,
                COUNT(OS.ID_More) AS AddServicesCount,
                DATEDIFF(day, O.DatetimeStart, O.DatetimeStop) as [Days],
                SO.Name AS StatusName
            FROM Orders O
            INNER JOIN Cotage C ON O.ID_Cotage = C.ID_Cotage
            INNER JOIN Client U On O.ID_Client = U.ID_Client
            INNER JOIN StatusOrder SO ON O.ID_Status = SO.ID_Status
            LEFT JOIN OrdersOtherServices OS ON O.ID_order = OS.ID_order
            LEFT JOIN OtherServices S ON OS.ID_More = S.ID_More
            GROUP BY
                O.ID_order,
                O.ID_Client,
	            U.Surname,
	            U.FirstName,
                C.ID_Cotage,
                C.[type],
                C.Geo,
                O.CountPeople,
                O.DatetimeStart,
                O.DatetimeStop,
                C.Price,
                SO.Name
            ORDER BY O.DatetimeStart ASC;";


        private string GET_ORDER = @"
            SELECT 
                O.ID_order,
                C.ID_Cotage,
	            C.type,
	            C.Geo,
	            C.Price,
	            C.Capacity,
                DATEDIFF(day, O.DatetimeStart, O.DatetimeStop) * C.Price AS DaysPrice,
                ISNULL(SUM(S.Price), 0) AS AddServicesPrice, 
	            (DATEDIFF(day, O.DatetimeStart, O.DatetimeStop) * C.Price) + ISNULL(SUM(S.Price), 0) as TotalPrice 
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
            WHERE O.ID_order = '{0}'
            GROUP BY
                O.ID_order,
                C.ID_Cotage,
                C.[type],
                C.Geo,
                O.DatetimeStart,
                O.DatetimeStop,
                C.Price,
	            C.Capacity,
                SO.Name
            ORDER BY O.DatetimeStart ASC;";


        private string GET_CLIENT = @"
            SELECT 
                Client.ID_Client,
                Concat(Surname, ' ', FirstName) as Name,
                NumberPhone,
                Email
            From Client
            INNER JOIN Orders ON Client.ID_Client = Orders.ID_Client
            WHERE Orders.ID_order = '{0}';";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack || Session["UserId"] == null)
                return;

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(GET_ALL_ORDERS);

                GridViewOrders.DataSource = reader;
                GridViewOrders.DataBind();
            });
        }

        protected void OrderGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            var list = (GridView)sender;
            var value = (Guid)list.SelectedValue;

            var getOrderDetails = string.Format(GET_ORDER, value);

            var getClientDetails = string.Format(GET_CLIENT, value);

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(getOrderDetails);
                OrdersDetails.DataSource = reader;
                OrdersDetails.DataBind();
            });

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(getClientDetails);
                ClientDetails.DataSource = reader;
                ClientDetails.DataBind();
            });

            JournalCheckPanel.Visible = false;
            Label1.Visible = true;
            ClientLabel.Visible = true;
            Button3.Visible = (list.Rows[list.SelectedIndex].Cells[11].Text == "В обработке" );

        }

        protected void CloseDropDown_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                return;

        }

        protected void JournalCheck_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                return;

            int index = GridViewOrders.SelectedIndex;

            string startDateStr = GridViewOrders.Rows[index].Cells[3].Text; // Дата начала
            string startTimeStr = GridViewOrders.Rows[index].Cells[4].Text; // Время начала
            DateTime startDate = DateTime.ParseExact(startDateStr + " " + startTimeStr, "dd.MM.yyyy HH:mm", CultureInfo.InvariantCulture);

            // Извлекаем дату и время выезда
            string endDateStr = GridViewOrders.Rows[index].Cells[5].Text; // Дата окончания
            string endTimeStr = GridViewOrders.Rows[index].Cells[6].Text; // Время окончания
            DateTime endDate = DateTime.ParseExact(endDateStr + " " + endTimeStr, "dd.MM.yyyy HH:mm", CultureInfo.InvariantCulture);

            int cottageId = int.Parse(GridViewOrders.Rows[index].Cells[7].Text);

            var name = GridViewOrders.Rows[index].Cells[2].Text;

            // Проверяем занятость коттеджа
            CheckCottageAvailability(cottageId,
                startDate.ToString("yyyy-dd-MM HH:mm:ss.fff", CultureInfo.InvariantCulture),
                endDate.ToString("yyyy-dd-MM HH:mm:ss.fff", CultureInfo.InvariantCulture),
                name);

            JournalCheckPanel.Visible = true;
        }

        private void CheckCottageAvailability(int cottageId, string startDate, string endDate, string name)
        {
            string queryOrders = @"
                SELECT 
                    O.ID_order,
                    O.DatetimeStart,
                    O.DatetimeStop,
                    CONCAT(U.Surname, ' ', U.FirstName) AS ClientName
                FROM Orders O
                INNER JOIN Client U ON O.ID_Client = U.ID_Client
                WHERE O.ID_Cotage = {0} AND CONCAT(U.Surname, ' ', U.FirstName) != '{3}'
                  AND (
                      (O.DatetimeStart <= '{1}' AND O.DatetimeStop >= '{2}') -- Перекрытие периода
                  )
                ORDER BY O.DatetimeStart;";

            var sqlOrders = string.Format(queryOrders, cottageId, endDate, startDate, name);

            // Запрос для проверки занятости через BlockDates
            string queryBlockDates = @"
                SELECT 
                    B.ID_Cotage,
                    B.StartDate,
                    B.EndDate,
                    B.Reason
                FROM BlockDates B
                WHERE B.ID_Cotage = {0}
                  AND (
                      (B.StartDate <= '{1}' AND B.EndDate >= '{2}') -- Перекрытие периода
                  )
                ORDER BY B.StartDate;";

            var sqlBlockDates = string.Format(queryBlockDates, cottageId, endDate, startDate);

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlOrders);
                GridViewOrdersAvailability.DataSource = reader;
                GridViewOrdersAvailability.DataBind();
            });

            SqlUtils.CompleteConnect(() =>
            {
                var reader = SqlUtils.CleanExecuteReader(sqlBlockDates);
                GridViewBlockDatesAvailability.DataSource = reader;
                GridViewBlockDatesAvailability.DataBind();
            });
        }

        protected void Order_Update(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                return;

            var statusGuid = DropDownList_Status.SelectedItem.Value;
            var orderID = (Guid)GridViewOrders.SelectedValue;

            var sqlUpdate = $"UPDATE Orders SET ID_Status = '{statusGuid}', Comment = '{CommentBox.Text ?? ""}' WHERE ID_order = '{orderID}';";

            var resultUpd = SqlUtils.ExecuteNotQuery(sqlUpdate);

            if (resultUpd > 0)
            {
                Session["LabelMessage"] = $"Заявка получила статус '{DropDownList_Status.SelectedItem.Text}' !";
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