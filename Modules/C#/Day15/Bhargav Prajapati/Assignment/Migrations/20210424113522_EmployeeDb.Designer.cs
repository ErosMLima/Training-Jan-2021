﻿// <auto-generated />
using System;
using Assignment.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace Assignment.Migrations
{
    [DbContext(typeof(EmployeeAssignmentContext))]
    [Migration("20210424113522_EmployeeDb")]
    partial class EmployeeDb
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.5")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("Assignment.Models.Assignments", b =>
                {
                    b.Property<int>("AssignmentsId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("AssigmentCategory")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("AssignmentNumber")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("EmployeesId")
                        .HasColumnType("int");

                    b.Property<DateTime>("EndData")
                        .HasColumnType("datetime2");

                    b.Property<string>("Grade")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("AssignmentsId");

                    b.HasIndex("EmployeesId");

                    b.ToTable("Assignments");
                });

            modelBuilder.Entity("Assignment.Models.Employees", b =>
                {
                    b.Property<int>("EmployeesId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Address")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("City")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FirstName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Gender")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LastName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("MaritalStatus")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("EmployeesId");

                    b.ToTable("Employees");
                });

            modelBuilder.Entity("Assignment.Models.Assignments", b =>
                {
                    b.HasOne("Assignment.Models.Employees", "Employees")
                        .WithMany("Assignments")
                        .HasForeignKey("EmployeesId");

                    b.Navigation("Employees");
                });

            modelBuilder.Entity("Assignment.Models.Employees", b =>
                {
                    b.Navigation("Assignments");
                });
#pragma warning restore 612, 618
        }
    }
}