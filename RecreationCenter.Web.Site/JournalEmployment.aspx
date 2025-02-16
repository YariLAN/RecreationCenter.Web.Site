<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="JournalEmployment.aspx.cs" Inherits="Relax.Web.Site.JournalEmployment" %>
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

    </style>
    <title>Журнал</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="text-align: center;">
        Журнал занятости коттеджей
    </p>

        <div style="margin-bottom: 80px; margin-top: 10px;">
        <p style="display: flex; justify-content: center; align-items: center;">
            <asp:Button 
                ID="AddJournalButton" 
                runat="server" 
                Text="Добавить занятость коттеджа" 
                CssClass="styled-add-button" 
                OnClick="AddJournal_Click"/>
        </p>
        <asp:Panel ID="AddPanel" runat="server" Visible="false">
            <table class="form-table">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" CssClass="form-label">Дата закрытия</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox TextMode="DateTimeLocal" ID="StartDate" runat="server" CssClass="form-input"></asp:TextBox>
                    </td>
                    <td>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                           ErrorMessage="Поле обязательно"
                           EnableClientScript="False"
                           ControlToValidate="StartDate" CssClass="form-error">
                       </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                         <asp:Label ID="Label4" runat="server" CssClass="form-label">Дата открытия для брони</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox TextMode="DateTimeLocal" ID="EndDate" runat="server" CssClass="form-input"></asp:TextBox>
                    </td>
                    <td>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ErrorMessage="Поле обязательно"
                            EnableClientScript="False"
                            ControlToValidate="EndDate" CssClass="form-error">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" CssClass="form-label">Выбор коттеджа</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="CottageDropList" runat="server" AutoPostBack="True" DataTextField="Name" DataValueField="Name" CssClass="form-input"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                       <asp:Label ID="Label2" runat="server" CssClass="form-label">Причина блокировки</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-input"></asp:TextBox>
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
                    <td colspan="1">
                        <asp:Button style="margin-top: 15px;" BackColor="White" ForeColor="Black" ID="SaveBtn" runat="server" 
                            Text="Сохранить" OnClick="SaveBtn_Click" />

                        <asp:Button style="margin-top: 15px;" BackColor="White" ForeColor="Black" ID="CloseSaveBtn" runat="server" 
                            Text="Скрыть" OnClick="CloseSaveBtn_Click" />
                    </td>
                    <td></td>
                </tr>
            </table>
            <asp:Label Font-Size="16px" ID="ErrorLabel" CssClass="form-error" runat="server"></asp:Label>
        </asp:Panel>
    </div>

    <p style="text-align: center;"> 
        <asp:GridView
            ID="JournalGridView" runat="server"
            HorizontalAlign="Center"
            CellPadding="8"
            BorderWidth="2"
            ForeColor="#996633"
            BackColor="White"
            EditRowStyle-BackColor="#ffccff"
            AlternatingRowStyle-BackColor="#ffccff"
            RowStyle-BackColor="#ffccff"
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_BlockDates">
            <Columns>
             <asp:CommandField ShowSelectButton="False" ControlStyle-ForeColor="Black" />
             <asp:BoundField DataField="ID_BlockDates" HeaderText="ID_BlockDates" InsertVisible="False" ReadOnly="True" Visible="False" />
             <asp:BoundField DataField="StartDate" HeaderText="Дата начала" DataFormatString="{0:dd.MM.yyyy}" HtmlEncode="false" />
             <asp:BoundField DataField="StartTime" HeaderText="Время начала" DataFormatString="{0:hh\:mm}" HtmlEncode="false" />
             <asp:BoundField DataField="EndDate" HeaderText="Дата окончания" DataFormatString="{0:dd.MM.yyyy}" HtmlEncode="false" />
             <asp:BoundField DataField="EndTime" HeaderText="Время окончания" DataFormatString="{0:hh\:mm}" HtmlEncode="false" />

             <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа" />
             <asp:BoundField DataField="type" HeaderText="Тип коттеджа" />
             <asp:BoundField DataField="Geo" HeaderText="Расположение"/>

             <asp:BoundField DataField="Reason" HeaderText="Причина бронирования" />
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
