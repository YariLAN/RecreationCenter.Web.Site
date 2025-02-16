<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="AdditionalServices.aspx.cs" Inherits="Cinema.Web.Site.AdditionalServices" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="text-align: center;">Дополнительные услуги</p>
    <div style="text-align: center;">
        
        <asp:TextBox BorderColor="Black" TextMode="Number" ID="PriceBox" runat="server" min="1" CssClass="form-input"></asp:TextBox>
        <asp:TextBox BorderColor="Black" TextMode="Number" ID="ToPriceBox" runat="server" min="1" CssClass="form-input"></asp:TextBox>
    </div>
    <div style="text-align: center; margin-top: 10px;">
        <asp:Button BackColor="White" ForeColor="Black" ID="Button1" runat="server" Text="Поиск" OnClick="PriceFilter"/>
        <asp:Button BackColor="White" ForeColor="Black" ID="ResetButton" runat="server" Text="Сброс" OnClick="Reset_Click"/>
    </div>

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
                <asp:BoundField DataField="Price" HeaderText="Цена" />
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
