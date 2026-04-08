using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddFiles1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "PhotoId",
                table: "UserInfo",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserInfo_PhotoId",
                table: "UserInfo",
                column: "PhotoId");

            migrationBuilder.AddForeignKey(
                name: "FK_UserInfo_Files_PhotoId",
                table: "UserInfo",
                column: "PhotoId",
                principalTable: "Files",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserInfo_Files_PhotoId",
                table: "UserInfo");

            migrationBuilder.DropIndex(
                name: "IX_UserInfo_PhotoId",
                table: "UserInfo");

            migrationBuilder.DropColumn(
                name: "PhotoId",
                table: "UserInfo");
        }
    }
}
