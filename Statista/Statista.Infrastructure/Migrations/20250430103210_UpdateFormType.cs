using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class UpdateFormType : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "TypeId",
                table: "Form",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Form_TypeId",
                table: "Form",
                column: "TypeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Form_Classifier_TypeId",
                table: "Form",
                column: "TypeId",
                principalTable: "Classifier",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Form_Classifier_TypeId",
                table: "Form");

            migrationBuilder.DropIndex(
                name: "IX_Form_TypeId",
                table: "Form");

            migrationBuilder.DropColumn(
                name: "TypeId",
                table: "Form");
        }
    }
}
