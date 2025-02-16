<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ApplicationClientsManagement.aspx.cs" Inherits="Cinema.Web.Site.ControlTicketClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .styled-add-button {
            background-color: #4CAF50; /* Зеленый цвет кнопки */
            color: white; /* Белый текст */
            border: none; /* Без границ */
            padding: 10px 20px; /* Отступы */
            font-size: 16px; /* Размер текста */
            cursor: pointer; /* Указатель */
            border-radius: 5px; /* Скругленные края */
            transition: 0.3s ease-in-out; /* Анимация при наведении */
        }
    
        .styled-add-button:hover {
            background-color: #45a049; /* Темнее на hover */
        }
    
        .form-container {
            text-align: center;
        }
    
        .form-table {
            margin: 0 auto;
            padding: 10px;
            border-collapse: separate;
            border-spacing: 10px;
        }
    
        .form-label {
            font-weight: bold;
            text-align: right;
        }
    
        .form-input {
            width: 330px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-input::placeholder {
            color: gainsboro;
            font-size: 14px;
            font-style: italic;
            opacity: 1;
        }
    
        .form-error {
            color: #FF3300;
            font-size: 12px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h4 style="text-align: center;">Заявки на бронь коттеджа</h4>
     <p style="text-align: center;">
        <asp:GridView 
            ID="GridViewOrders" 
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
            OnSelectedIndexChanged="OrderGridView_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ControlStyle-ForeColor="Black" />
                <asp:BoundField DataField="ID_order" HeaderText="ID_order" InsertVisible="False" ReadOnly="True" Visible="False" />
                <asp:BoundField DataField="Name" HeaderText="Клиент" />
                <asp:BoundField DataField="StartDate" HeaderText="Дата начала" DataFormatString="{0:dd.MM.yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="StartTime" HeaderText="Время начала" DataFormatString="{0:hh\:mm}" HtmlEncode="false" />
                <asp:BoundField DataField="EndDate" HeaderText="Дата окончания" DataFormatString="{0:dd.MM.yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="EndTime" HeaderText="Время окончания" DataFormatString="{0:hh\:mm}" HtmlEncode="false" />
                <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа" />
                <asp:BoundField DataField="CountPeople" HeaderText="Количество людей" />
                <asp:BoundField DataField="AddServicesCount" HeaderText="Кол-во доп. услуг" />
                <asp:BoundField DataField="Days" HeaderText="Дней" />
                <asp:BoundField DataField="StatusName" HeaderText="Статус" />
            </Columns>
        </asp:GridView>
    </p>
    <p style="text-align: center; margin-top: 20px;">
        <asp:Label runat="server" ID="Label1" Visible="false" Text="Данные заявки"></asp:Label>
    </p>
    <p style="text-align: center;">
        <asp:DetailsView ID="OrdersDetails" runat="server" 
            AutoGenerateRows="False" 
            DataKeyNames="ID_order"  
            Height="50px" 
            Width="500px"
            CellPadding="8"
            HorizontalAlign="Center">
            <Fields>
                <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа"  />
                <asp:BoundField DataField="type" HeaderText="Тип коттеджа" />
                <asp:BoundField DataField="Geo" HeaderText="Расположение"/>
                <asp:BoundField DataField="Price" HeaderText="Цена на одну ночь" DataFormatString="{0:C}" HtmlEncode="false" />
                <asp:BoundField DataField="Capacity" HeaderText="Вместимость" />

                <asp:BoundField DataField="DaysPrice" HeaderText="Стоимость аренды" DataFormatString="{0:C}" HtmlEncode="false" />
                <asp:BoundField DataField="AddServicesPrice" HeaderText="Стоимость доп. услуг" DataFormatString="{0:C}" HtmlEncode="false" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Общая сумма" DataFormatString="{0:C}" HtmlEncode="false" />
            </Fields>
        </asp:DetailsView>
    </p>

    <p style="text-align: center;">
        <asp:Label runat="server" ID="ClientLabel" Visible="false" Text="Данные о клиенте"></asp:Label>
    </p>
    <p style="text-align: center;">
        <asp:DetailsView ID="ClientDetails" runat="server" 
            AutoGenerateRows="False" 
            DataKeyNames="ID_Client"  
            Height="50px" 
            Width="500px"
            CellPadding="8"
            HorizontalAlign="Center">
            <Fields>
                <asp:BoundField DataField="Name" HeaderText="Полное имя" />
                <asp:BoundField DataField="NumberPhone" HeaderText="Номер телефона" />
                <asp:BoundField DataField="Email" HeaderText="Электронная почта" />
            </Fields>
        </asp:DetailsView>
    </p>
    <p style="text-align: center;">
        <asp:Button BackColor="White" ForeColor="Black" ID="Button3" runat="server" Text="Проверить журнал занятости коттеджа"  Visible="false" OnClick="JournalCheck_Click"/>
    </p>


    <asp:Panel CssClass="form-container" runat="server" ID="JournalCheckPanel" Visible="false">
        <h3 style="text-align: center;">Занятость через Orders</h3>
        
        <asp:GridView 
            ID="GridViewOrdersAvailability" 
            runat="server" 
            HorizontalAlign="Center"
            AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ID_order" HeaderText="ID заказа" />
                <asp:BoundField DataField="DatetimeStart" HeaderText="Дата начала" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                <asp:BoundField DataField="DatetimeStop" HeaderText="Дата окончания" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                <asp:BoundField DataField="ClientName" HeaderText="Клиент" />
            </Columns>
        </asp:GridView>
        

        <h3 style="text-align: center;">Занятость через BlockDates</h3>
        <asp:GridView 
            ID="GridViewBlockDatesAvailability" 
            runat="server" 
            HorizontalAlign="Center"
            AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа" />
                <asp:BoundField DataField="StartDate" HeaderText="Дата начала" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                <asp:BoundField DataField="EndDate" HeaderText="Дата окончания" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                <asp:BoundField DataField="Reason" HeaderText="Причина" />
            </Columns>
        </asp:GridView>
    </asp:Panel>

</asp:Content>
