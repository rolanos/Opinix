using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class HotfixMigrations : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsModerated",
                table: "Question");

            migrationBuilder.AddColumn<Guid>(
                name: "ModerateStatusId",
                table: "Question",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Question_ModerateStatusId",
                table: "Question",
                column: "ModerateStatusId");

            migrationBuilder.AddForeignKey(
                name: "FK_Question_Classifier_ModerateStatusId",
                table: "Question",
                column: "ModerateStatusId",
                principalTable: "Classifier",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Question_Classifier_ModerateStatusId",
                table: "Question");

            migrationBuilder.DropIndex(
                name: "IX_Question_ModerateStatusId",
                table: "Question");

            migrationBuilder.DropColumn(
                name: "ModerateStatusId",
                table: "Question");

            migrationBuilder.AddColumn<bool>(
                name: "IsModerated",
                table: "Question",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }
    }
}
