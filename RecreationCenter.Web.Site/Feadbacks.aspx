<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="Feadbacks.aspx.cs" Inherits="Cinema.Web.Site.Feadbacks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Отзывы наших гостей</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="text-align: center;">Отзывы</p>
    <p style="text-align: center;">
        <asp:GridView ID="FeadbacksGridView" runat="server"
            HorizontalAlign="Center"
            CellPadding="8"
            BorderWidth="2"
            ForeColor="#66ffff"
            BackColor="White"
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_Feedback"
            OnSelectedIndexChanged="FeedBackGridView_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ControlStyle-ForeColor="Black" />
                <asp:BoundField DataField="ID_Feedback" HeaderText="ID_Feedback" InsertVisible="False" ReadOnly="True" SortExpression="ID_Feedback" Visible="False" />
                <asp:BoundField DataField="Name" HeaderText="Клиент"/>
                <asp:BoundField DataField="Email" HeaderText="Эл. почта клиента" />

                <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа" />
                <asp:BoundField DataField="type" HeaderText="Тип коттеджа" />
                <asp:BoundField DataField="Geo" HeaderText="Расположение" />
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <asp:DetailsView ID="FeadbacksDetails" runat="server"
            AutoGenerateRows="False"
            Height="50px"
            Width="500px"
            CellPadding="8"
            HorizontalAlign="Center">
            <Fields>
                <asp:BoundField DataField="Name" HeaderText="Клиент"/>
                <asp:BoundField DataField="Description" HeaderText="Описание" />
                <asp:BoundField DataField="ID_Cotage" HeaderText="Номер коттеджа"  />
                <asp:BoundField DataField="type" HeaderText="Тип коттеджа" />
                <asp:BoundField DataField="Geo" HeaderText="Расположение"/>
                <asp:BoundField DataField="Capacity" HeaderText="Вместимость" />
            </Fields>
        </asp:DetailsView>
    </p>
</asp:Content>
