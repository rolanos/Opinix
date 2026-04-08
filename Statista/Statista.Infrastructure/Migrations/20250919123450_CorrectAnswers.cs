using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class CorrectAnswers : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "RespondentId",
                table: "Answer",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Answer_RespondentId",
                table: "Answer",
                column: "RespondentId");

            migrationBuilder.AddForeignKey(
                name: "FK_Answer_AspNetUsers_RespondentId",
                table: "Answer",
                column: "RespondentId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Answer_AspNetUsers_RespondentId",
                table: "Answer");

            migrationBuilder.DropIndex(
                name: "IX_Answer_RespondentId",
                table: "Answer");

            migrationBuilder.DropColumn(
                name: "RespondentId",
                table: "Answer");
        }
    }
}
