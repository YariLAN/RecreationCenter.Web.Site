<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Cinema.Web.Site.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Профиль</title>
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
  <div class="form-container">
    <h4>Данные пользователя</h4>
    <table class="form-table">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" CssClass="form-label">Имя</asp:Label>
            </td>
            <td>
                <asp:TextBox BorderColor="Black" ID="NameBox" runat="server" CssClass="form-input"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredName" runat="server"
                    ErrorMessage="Имя и фамилия обязательны"
                    EnableClientScript="False"
                    ControlToValidate="NameBox" CssClass="form-error">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" CssClass="form-label">Электронная почта</asp:Label>
            </td>
            <td>
                <asp:TextBox BorderColor="Black" ReadOnly="true" TextMode="Email" ID="EmailBox" runat="server" CssClass="form-input"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label3" runat="server" CssClass="form-label">Мобильный телефон</asp:Label>
            </td>
            <td>
                <asp:TextBox BorderColor="Black" TextMode="Phone" ID="PhoneBox" runat="server" CssClass="form-input"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredPhone" runat="server"
                    ErrorMessage="Телефон обязателен"
                    EnableClientScript="False"
                    ControlToValidate="PhoneBox" CssClass="form-error">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Button BorderColor="Black" style="margin-top: 15px;" BackColor="White" ForeColor="Black" ID="SaveBtn" runat="server" 
                    Text="Сохранить" OnClick="SaveBtn_Click" />
            </td>
        </tr>
    </table>
    <asp:Label Font-Size="16px" ID="ErrorLabel" CssClass="form-error" runat="server"></asp:Label>
  </div>
</asp:Content>
