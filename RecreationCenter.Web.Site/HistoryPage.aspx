<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="HistoryPage.aspx.cs" Inherits="Cinema.Web.Site.HistoryTicketsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Заявки</title>
    <style>
        .form-container {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h4>История заявок</h4>
        <p style="text-align: center;">
            <asp:GridView
                ID="HistoryGridView"
                runat="server"
                HorizontalAlign="Center"
                CellPadding="8"
                BorderWidth="2"
                ForeColor="#996633"
                BackColor="White"
                EditRowStyle-BackColor="#ffccff"
                AlternatingRowStyle-BackColor="#ffccff"
                RowStyle-BackColor="#ffccff"
                AllowSorting="True"
                AutoGenerateColumns="False"
                DataKeyNames="ID_order"
                OnSelectedIndexChanged="ApplicationGridView_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" ControlStyle-ForeColor="Black" />
                    <asp:BoundField DataField="ID_order" HeaderText="ID заказа" InsertVisible="False" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="StartDate" HeaderText="Дата начала" DataFormatString="{0:dd.MM.yyyy}" HtmlEncode="false" />
                    <asp:BoundField DataField="StartTime" HeaderText="Время начала" DataFormatString="{0:hh\:mm}" HtmlEncode="false" />
                    <asp:BoundField DataField="EndDate" HeaderText="Дата окончания" DataFormatString="{0:dd.MM.yyyy}" HtmlEncode="false" />
                    <asp:BoundField DataField="EndTime" HeaderText="Время окончания" DataFormatString="{0:hh\:mm}" HtmlEncode="false" />
                    <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа" />
                    <asp:BoundField DataField="CountPeople" HeaderText="Кол-во людей" />
                    <asp:BoundField DataField="Days" HeaderText="Дней" />
                    <asp:BoundField DataField="DaysPrice" HeaderText="Стоимость аренды" DataFormatString="{0:C}" HtmlEncode="false" />
                    <asp:BoundField DataField="AddServicesCount" HeaderText="Кол-во доп. услуг" />
                    <asp:BoundField DataField="AddServicesPrice" HeaderText="Стоимость доп. услуг" DataFormatString="{0:C}" HtmlEncode="false" />
                    <asp:BoundField DataField="StatusName" HeaderText="Статус" />
                </Columns>
            </asp:GridView>
        </p>
        <p>
            <asp:DetailsView ID="ApplicationDetails" runat="server"
                AutoGenerateRows="False"
                DataKeyNames="ID_Cotage"
                Height="50px"
                Width="500px"
                CellPadding="8"
                HorizontalAlign="Center">
                <Fields>
                    <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа"  />
                    <asp:BoundField DataField="type" HeaderText="Тип коттеджа" />
                    <asp:BoundField DataField="Geo" HeaderText="Расположение"/>
                    <asp:BoundField DataField="Price" HeaderText="Цена на одну ночь" DataFormatString="{0:C}" HtmlEncode="false" />
                    <asp:BoundField DataField="Description" HeaderText="Описание" />
                    <asp:BoundField DataField="Capacity" HeaderText="Вместимость" />

                    <asp:BoundField DataField="StatusName" HeaderText="Статус" />
                    <asp:BoundField DataField="Comment" HeaderText="Комментарий к заявке" />
                </Fields>
            </asp:DetailsView>
        </p>
        <p style="text-align: center;">
            <asp:GridView ID="AdditionalServiceGridView" runat="server"
                HorizontalAlign="Center"
                CellPadding="8"
                BorderWidth="2"
                ForeColor="#66ffff"
                BackColor="White"
                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_More">
                <Columns>
                    <asp:CommandField ShowSelectButton="False" />
                    <asp:BoundField DataField="ID_More" HeaderText="ID_More" InsertVisible="False" ReadOnly="True" SortExpression="ID_More" Visible="False" />
                    <asp:BoundField DataField="Naming" HeaderText="Название услуги"/>
                    <asp:BoundField DataField="Description" HeaderText="Описание" />
                    <asp:BoundField DataField="Price" HeaderText="Цена"  DataFormatString="{0:C}" HtmlEncode="false" />
                </Columns>
            </asp:GridView>
        </p>
        <div style="text-align: center;">
            <asp:DropDownList  runat="server"  BackColor="White" ID="DropDownList_Service" DataTextField="ServiceInfo" DataValueField="ServiceInfo" Visible="false"></asp:DropDownList>
            <asp:Button BackColor="White" ForeColor="Black" ID="Add_ServicesBtn" runat="server" Text="Добавить доп услугу" OnClick="AddServicesClick" Visible="false"/>
        </div>
        <div style="text-align: center; margin-top: 15px;">
             <asp:Label ID="ErrorLabel" ForeColor="Red" runat="server"></asp:Label>
        </div>
    </div>
</asp:Content>
