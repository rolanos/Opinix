using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class UpdateHierarchy : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PastQuestionId",
                table: "Question");

            migrationBuilder.AddColumn<int>(
                name: "Order",
                table: "Question",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Order",
                table: "AvailableAnswer",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Order",
                table: "Question");

            migrationBuilder.DropColumn(
                name: "Order",
                table: "AvailableAnswer");

            migrationBuilder.AddColumn<Guid>(
                name: "PastQuestionId",
                table: "Question",
                type: "uuid",
                nullable: true);
        }
    }
}
