<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="Cottages.aspx.cs" Inherits="Relax.Web.Site.Cottages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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

    <p style="text-align: center;">
        Список коттеджей
    </p>
    <div style="text-align:center">
        <div style="text-align:center; margin-bottom: 10px;">
            <asp:Label runat="server" Text="Тип коттеджа"></asp:Label>
            <asp:DropDownList  runat="server"  BackColor="White" ID="DropDownList_Type" DataTextField="type" DataValueField="type"></asp:DropDownList>
            <asp:Button BackColor="White" ForeColor="Black" ID="Button2" runat="server" Text="Поиск" OnClick="Date_Check_Type"/>
        </div>
        <div style="text-align:center; margin-bottom: 10px;">
            <asp:Label runat="server" Text="Расположение коттеджа"></asp:Label>
            <asp:DropDownList  runat="server"  BackColor="White" ID="DropDownList1" DataTextField="Geo" DataValueField="Geo"></asp:DropDownList>
            <asp:Button BackColor="White" ForeColor="Black" ID="Button3" runat="server" Text="Поиск" OnClick="Date_Check_Geo"/>
        </div>
        <asp:Button BackColor="White" ForeColor="Black" ID="Button1" runat="server" Text="Поиск по типу и расположению" OnClick="Date_Check"/>
        <asp:Button BackColor="White" ForeColor="Black" ID="ResetButton" runat="server" Text="Сброс" OnClick="Reset_Click"/>
    </div>
    <p style="text-align: center;">


        <asp:GridView
            ID="CottageGridView" runat="server"
            HorizontalAlign="Center"
            CellPadding="8"
            BorderWidth="2"
            ForeColor="#996633"
            BackColor="White"
            EditRowStyle-BackColor="#ffccff"
            AlternatingRowStyle-BackColor="#ffccff"
            RowStyle-BackColor="#ffccff"
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_Cotage" OnSelectedIndexChanged="CottageGridView_SelectedIndexChanged">
            <Columns>
             <asp:CommandField ShowSelectButton="True" ControlStyle-ForeColor="Black" />
             <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа" InsertVisible="False" ReadOnly="True" Visible="true" />
             <asp:BoundField DataField="type" HeaderText="Тип коттеджа" />
             <asp:BoundField DataField="Geo" HeaderText="Расположение"/>
             <asp:BoundField DataField="Price" HeaderText="Цена на одну ночь" />
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <asp:DetailsView ID="CottageDetails" runat="server"
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
                <asp:BoundField DataField="Price" HeaderText="Цена на одну ночь" />
                <asp:BoundField DataField="Description" HeaderText="Описание" />
                <asp:BoundField DataField="Capacity" HeaderText="Вместимость" />
            </Fields>
        </asp:DetailsView>
    </p>
    <p style="text-align: center; margin-top: 65px;">
        <asp:Button BackColor="White" ForeColor="Black" ID="BookingCottage" runat="server" Visible="false" Text="Забронировать" OnClick="BookingCottage_Click" ></asp:Button>
    </p>

    <asp:Panel ID="FormContainerPanel" runat="server" CssClass="form-container" Visible="false">
        <div class="form-table">
           <asp:Label ID="Label1" runat="server" CssClass="form-label">Количество людей</asp:Label>
           <asp:TextBox BorderColor="Black" TextMode="Number" min="1" ID="CountPeopleBox" runat="server" CssClass="form-input" />
           <asp:RequiredFieldValidator ID="RequiredName" runat="server"
               ErrorMessage="Поле обязательно"
               EnableClientScript="False"
               ControlToValidate="CountPeopleBox" CssClass="form-error">
           </asp:RequiredFieldValidator>
        </div>

        <div class="form-table">
            <asp:Label ID="Label3" runat="server" CssClass="form-label">Дата и время заезда</asp:Label>
            <asp:TextBox TextMode="DateTimeLocal" ID="StartDate" runat="server" CssClass="form-input"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
               ErrorMessage="Поле обязательно"
               EnableClientScript="False"
               ControlToValidate="StartDate" CssClass="form-error">
           </asp:RequiredFieldValidator>
        </div>

        <div class="form-table">
            <asp:Label ID="Label2" runat="server" CssClass="form-label">Дата и время выезда</asp:Label>
            <asp:TextBox TextMode="DateTimeLocal" ID="EndDate" runat="server" CssClass="form-input"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
               ErrorMessage="Поле обязательно"
               EnableClientScript="False"
               ControlToValidate="EndDate" CssClass="form-error">
           </asp:RequiredFieldValidator>
        </div>

        <div class="form-table">
            <asp:Button style="margin-top: 15px;" BackColor="White" ForeColor="Black" ID="SubmitBookingBtn" runat="server"
                Text="Подтвердить заявку"
                OnClick="SubmitBooking_Click"/>
        </div>
    </asp:Panel>

    <p style="text-align: center;">
        <asp:Label ID="ErrorLabelBookingDet" ForeColor="Red" runat="server"></asp:Label>
    </p>
</asp:Content>