<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="PriceListManagement.aspx.cs" Inherits="Cinema.Web.Site.AddTicket" %>
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
    <h4 style="text-align: center;">Прайс-лист</h4>

    <p style="text-align: center;">
        <asp:Label ID="ErrorLabel" ForeColor="Red" runat="server"></asp:Label>
    </p>

    <h3 style="text-align: center;">Прайс-лист коттеджей</h3>
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

    <asp:Panel ID="EditPriceCottagePanel" runat="server" Visible="false">
        <h4 style="text-align: center;">Редактирование цены</h4>
        <table class="form-table">
            <tr>
                <td>
                    <asp:Label ID="LabelEditDate" runat="server" CssClass="form-label">Цена одной ночи</asp:Label>
                </td>
                <td>
                    <asp:TextBox BorderColor="Black" TextMode="Number" min="1" ID="EditPriceCottageBox" runat="server" CssClass="form-input" DataFormatString="{0:C}" HtmlEncode="false"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ErrorMessage="Поле обязательно"
                        EnableClientScript="False"
                        ControlToValidate="EditPriceCottageBox" CssClass="form-error">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="UpdatePriceCottageBtn" runat="server" Text="Обновить" OnClick="UpdatePriceCottageBtn_Click"  CssClass="styled-add-button" />
                    <asp:Button ID="CancelEditBtn" runat="server" Text="Отмена" OnClick="CancelEdit_Click" CssClass="styled-add-button" />
                </td>
            </tr>
        </table>
    </asp:Panel>

    <h3 style="text-align: center;">Прайс-лист доп. услуг</h3>
    <p style="text-align: center;">
        <asp:GridView ID="AdditionalServiceGridView" runat="server" 
            HorizontalAlign="Center"
            CellPadding="8" 
            BorderWidth="2" 
            ForeColor="#66ffff" 
            BackColor="White"
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_More" OnSelectedIndexChanged="ServiceGridView_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ControlStyle-ForeColor="Black"/>
                <asp:BoundField DataField="ID_More" HeaderText="ID_More" InsertVisible="False" ReadOnly="True" SortExpression="ID_More" Visible="False" />
                <asp:BoundField DataField="Naming" HeaderText="Название услуги"/>
                <asp:BoundField DataField="Description" HeaderText="Описание" />
                <asp:BoundField DataField="Price" HeaderText="Цена" />
            </Columns>
        </asp:GridView>
    </p>
    <asp:Panel ID="Panel1" runat="server" Visible="false">
        <h4 style="text-align: center;">Редактирование цены</h4>
        <table class="form-table">
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" CssClass="form-label">Цена услуги</asp:Label>
                </td>
                <td>
                    <asp:TextBox BorderColor="Black" TextMode="Number" min="1" ID="TextBox1" runat="server" CssClass="form-input" DataFormatString="{0:C}" HtmlEncode="false"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ErrorMessage="Поле обязательно"
                        EnableClientScript="False"
                        ControlToValidate="TextBox1" CssClass="form-error">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Обновить" OnClick="UpdatePriceServiceBtn_Click"  CssClass="styled-add-button" />
                    <asp:Button ID="Button2" runat="server" Text="Отмена" OnClick="CancelEdit_Click2" CssClass="styled-add-button" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
