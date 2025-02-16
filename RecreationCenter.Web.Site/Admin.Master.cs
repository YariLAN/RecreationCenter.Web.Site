using System;

namespace Relax.Web.Site
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                AdminLabel.Text = $"Привет, {Session["UserName"]}";
            }

            if (Session["LabelMessage"] != null)
            {
                LabelMessage.Text = Session["LabelMessage"].ToString();
                Session.Remove("LabelMessage");
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("PriceListManagement.aspx");
        }

        protected void Exit_Click(object sender, EventArgs e)
        {
            AdminLabel.Text = "";

            Session.Remove("UserId");
            Session.Remove("UserName");

            Response.Redirect("MainPage.aspx");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApplicationClientsManagement.aspx");
        }    

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            Response.Redirect("JournalEmployment.aspx");
        }
    }
}