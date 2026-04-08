using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddModerateQuestion : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "CreatedById",
                table: "Question",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsModerated",
                table: "Question",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.CreateIndex(
                name: "IX_Question_CreatedById",
                table: "Question",
                column: "CreatedById");

            migrationBuilder.AddForeignKey(
                name: "FK_Question_AspNetUsers_CreatedById",
                table: "Question",
                column: "CreatedById",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Question_AspNetUsers_CreatedById",
                table: "Question");

            migrationBuilder.DropIndex(
                name: "IX_Question_CreatedById",
                table: "Question");

            migrationBuilder.DropColumn(
                name: "CreatedById",
                table: "Question");

            migrationBuilder.DropColumn(
                name: "IsModerated",
                table: "Question");
        }
    }
}
