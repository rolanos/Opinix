using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class ReportMigration2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Report_User_CreatedById",
                table: "Report");

            migrationBuilder.DropIndex(
                name: "IX_Report_CreatedById",
                table: "Report");

            migrationBuilder.DropColumn(
                name: "CreatedById",
                table: "Report");

            migrationBuilder.CreateIndex(
                name: "IX_Report_CreatedId",
                table: "Report",
                column: "CreatedId");

            migrationBuilder.AddForeignKey(
                name: "FK_Report_User_CreatedId",
                table: "Report",
                column: "CreatedId",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Report_User_CreatedId",
                table: "Report");

            migrationBuilder.DropIndex(
                name: "IX_Report_CreatedId",
                table: "Report");

            migrationBuilder.AddColumn<Guid>(
                name: "CreatedById",
                table: "Report",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Report_CreatedById",
                table: "Report",
                column: "CreatedById");

            migrationBuilder.AddForeignKey(
                name: "FK_Report_User_CreatedById",
                table: "Report",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
