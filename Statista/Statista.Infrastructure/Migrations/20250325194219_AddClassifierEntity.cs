using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Statista.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddClassifierEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Classifier",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    ParentId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Classifier", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Classifier_Classifier_ParentId",
                        column: x => x.ParentId,
                        principalTable: "Classifier",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Classifier_ParentId",
                table: "Classifier",
                column: "ParentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Classifier");
        }
    }
}
