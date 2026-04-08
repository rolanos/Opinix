using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class UpdateAvailableAnswers : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "PastAvailableAnswerId",
                table: "AvailableAnswer",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_AvailableAnswer_PastAvailableAnswerId",
                table: "AvailableAnswer",
                column: "PastAvailableAnswerId");

            migrationBuilder.AddForeignKey(
                name: "FK_AvailableAnswer_AvailableAnswer_PastAvailableAnswerId",
                table: "AvailableAnswer",
                column: "PastAvailableAnswerId",
                principalTable: "AvailableAnswer",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AvailableAnswer_AvailableAnswer_PastAvailableAnswerId",
                table: "AvailableAnswer");

            migrationBuilder.DropIndex(
                name: "IX_AvailableAnswer_PastAvailableAnswerId",
                table: "AvailableAnswer");

            migrationBuilder.DropColumn(
                name: "PastAvailableAnswerId",
                table: "AvailableAnswer");
        }
    }
}
