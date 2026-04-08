using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class UpdateAnalitic : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "AnswerMeaning",
                table: "Answer",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<Guid>(
                name: "AvailableAnswerId",
                table: "AnaliticalFact",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_AnaliticalFact_AvailableAnswerId",
                table: "AnaliticalFact",
                column: "AvailableAnswerId");

            migrationBuilder.AddForeignKey(
                name: "FK_AnaliticalFact_AvailableAnswer_AvailableAnswerId",
                table: "AnaliticalFact",
                column: "AvailableAnswerId",
                principalTable: "AvailableAnswer",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AnaliticalFact_AvailableAnswer_AvailableAnswerId",
                table: "AnaliticalFact");

            migrationBuilder.DropIndex(
                name: "IX_AnaliticalFact_AvailableAnswerId",
                table: "AnaliticalFact");

            migrationBuilder.DropColumn(
                name: "AnswerMeaning",
                table: "Answer");

            migrationBuilder.DropColumn(
                name: "AvailableAnswerId",
                table: "AnaliticalFact");
        }
    }
}
