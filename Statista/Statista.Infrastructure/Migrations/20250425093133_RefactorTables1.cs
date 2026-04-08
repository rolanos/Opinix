using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class RefactorTables1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Form_User_CreatedById",
                table: "Form");

            migrationBuilder.DropForeignKey(
                name: "FK_Survey_User_CreatedById",
                table: "Survey");

            migrationBuilder.DropIndex(
                name: "IX_Survey_CreatedById",
                table: "Survey");

            migrationBuilder.DropIndex(
                name: "IX_Form_CreatedById",
                table: "Form");

            migrationBuilder.DropColumn(
                name: "CreatedById",
                table: "Survey");

            migrationBuilder.DropColumn(
                name: "CreatedById",
                table: "Form");

            migrationBuilder.AddColumn<Guid>(
                name: "SectionTypeId",
                table: "Sections",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "RoleId",
                table: "AdminGroup",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Sections_SectionTypeId",
                table: "Sections",
                column: "SectionTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_AdminGroup_RoleId",
                table: "AdminGroup",
                column: "RoleId");

            migrationBuilder.AddForeignKey(
                name: "FK_AdminGroup_Classifier_RoleId",
                table: "AdminGroup",
                column: "RoleId",
                principalTable: "Classifier",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Sections_Classifier_SectionTypeId",
                table: "Sections",
                column: "SectionTypeId",
                principalTable: "Classifier",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AdminGroup_Classifier_RoleId",
                table: "AdminGroup");

            migrationBuilder.DropForeignKey(
                name: "FK_Sections_Classifier_SectionTypeId",
                table: "Sections");

            migrationBuilder.DropIndex(
                name: "IX_Sections_SectionTypeId",
                table: "Sections");

            migrationBuilder.DropIndex(
                name: "IX_AdminGroup_RoleId",
                table: "AdminGroup");

            migrationBuilder.DropColumn(
                name: "SectionTypeId",
                table: "Sections");

            migrationBuilder.DropColumn(
                name: "RoleId",
                table: "AdminGroup");

            migrationBuilder.AddColumn<Guid>(
                name: "CreatedById",
                table: "Survey",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<Guid>(
                name: "CreatedById",
                table: "Form",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Survey_CreatedById",
                table: "Survey",
                column: "CreatedById");

            migrationBuilder.CreateIndex(
                name: "IX_Form_CreatedById",
                table: "Form",
                column: "CreatedById");

            migrationBuilder.AddForeignKey(
                name: "FK_Form_User_CreatedById",
                table: "Form",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Survey_User_CreatedById",
                table: "Survey",
                column: "CreatedById",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
