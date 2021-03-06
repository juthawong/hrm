﻿ /********************************************************************************
Copyright (C) MixERP Inc. (http://mixof.org).
This file is part of MixERP.
MixERP is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 2 of the License.
MixERP is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with MixERP.  If not, see <http://www.gnu.org/licenses/>.
***********************************************************************************/

EXECUTE dbo.drop_schema 'hrm';
GO
CREATE SCHEMA hrm;
GO


CREATE TABLE hrm.week_days
(
    week_day_id                             integer NOT NULL CHECK(week_day_id> = 1 AND week_day_id<=7) PRIMARY KEY,
    week_day_code                           national character varying(12) NOT NULL UNIQUE,
    week_day_name                           national character varying(50) NOT NULL UNIQUE,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX week_days_week_day_code_uix
ON hrm.week_days(week_day_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX week_days_week_day_name_uix
ON hrm.week_days(week_day_name)
WHERE deleted = 0;

CREATE TABLE hrm.identification_types
(
    identification_type_code                national character varying(12) NOT NULL PRIMARY KEY,
    identification_type_name                national character varying(100) NOT NULL UNIQUE,
    can_expire                              bit NOT NULL DEFAULT(0),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE UNIQUE INDEX identification_types_identification_type_code_uix
ON hrm.identification_types(identification_type_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX identification_types_identification_type_name_uix
ON hrm.identification_types(identification_type_name)
WHERE deleted = 0;

CREATE TABLE hrm.social_networks
(
    social_network_name                     national character varying(128) NOT NULL PRIMARY KEY,
    semantic_css_class                      national character varying(128),
    base_url                                national character varying(128) DEFAULT(''),
    profile_url                             national character varying(128) DEFAULT(''),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE TABLE hrm.departments
(
    department_id                           integer IDENTITY PRIMARY KEY,
    department_code                         national character varying(12) NOT NULL,
    department_name                         national character varying(50) NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX departments_department_code_uix
ON hrm.departments(department_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX departments_department_name_uix
ON hrm.departments(department_name)
WHERE deleted = 0;

CREATE TABLE hrm.roles
(
    role_id                                   integer IDENTITY PRIMARY KEY,
    role_code                                 national character varying(12) NOT NULL,
    role_name                                 national character varying(50) NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX roles_role_code_uix
ON hrm.roles(role_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX roles_role_name_uix
ON hrm.roles(role_name)
WHERE deleted = 0;

CREATE TABLE hrm.nationalities
(
    nationality_code                        national character varying(12) PRIMARY KEY,
    nationality_name                        national character varying(50) NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX nationalities_nationality_code_uix
ON hrm.nationalities(nationality_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX nationalities_nationality_name_uix
ON hrm.nationalities(nationality_name)
WHERE deleted = 0;

CREATE TABLE hrm.education_levels
(
    education_level_id                      integer IDENTITY NOT NULL PRIMARY KEY,
    education_level_name                    national character varying(50) NOT NULL UNIQUE,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX education_levels_education_level_name
ON hrm.education_levels(education_level_name)
WHERE deleted = 0;

CREATE TABLE hrm.employment_status_codes
(
    employment_status_code_id               integer NOT NULL PRIMARY KEY,
    status_code                             national character varying(12) NOT NULL UNIQUE,
    status_code_name                        national character varying(100) NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX employment_status_codes_status_code_uix
ON hrm.employment_status_codes(status_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX employment_status_codes_status_code_name_uix
ON hrm.employment_status_codes(status_code_name)
WHERE deleted = 0;

CREATE TABLE hrm.employment_statuses
(
    employment_status_id                    integer IDENTITY NOT NULL PRIMARY KEY,
    employment_status_code                  national character varying(12) NOT NULL UNIQUE,
    employment_status_name                  national character varying(100) NOT NULL,
    is_contract                             bit NOT NULL DEFAULT(0),
    default_employment_status_code_id       integer NOT NULL REFERENCES hrm.employment_status_codes,
    description                             national character varying(1000) DEFAULT(''),    
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX employment_statuses_employment_status_code_uix
ON hrm.employment_statuses(employment_status_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX employment_statuses_employment_status_name_uix
ON hrm.employment_statuses(employment_status_name)
WHERE deleted = 0;

CREATE TABLE hrm.job_titles
(
    job_title_id                            integer IDENTITY NOT NULL PRIMARY KEY,
    job_title_code                          national character varying(12) NOT NULL UNIQUE,
    job_title_name                          national character varying(100) NOT NULL,
    description                             national character varying(1000) DEFAULT(''),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX job_titles_job_title_code_uix
ON hrm.job_titles(job_title_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX job_titles_job_title_name_uix
ON hrm.job_titles(job_title_name)
WHERE deleted = 0;

CREATE TABLE hrm.pay_grades
(
    pay_grade_id                            integer IDENTITY NOT NULL PRIMARY KEY,
    pay_grade_code                          national character varying(12) NOT NULL UNIQUE,
    pay_grade_name                          national character varying(100) NOT NULL,
    minimum_salary                          numeric(30, 6) NOT NULL,
    maximum_salary                          numeric(30, 6) NOT NULL,
                                            CHECK(maximum_salary >= minimum_salary),
    description                             national character varying(1000) DEFAULT(''),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX pay_grades_pay_grade_code_uix
ON hrm.pay_grades(pay_grade_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX pay_grades_pay_grade_name_uix
ON hrm.pay_grades(pay_grade_name)
WHERE deleted = 0;

CREATE TABLE hrm.shifts
(
    shift_id                                integer IDENTITY NOT NULL PRIMARY KEY,
    shift_code                              national character varying(12) NOT NULL UNIQUE,
    shift_name                              national character varying(100) NOT NULL,
    begins_from                             time NOT NULL,
    ends_on                                 time NOT NULL,
    description                             national character varying(1000) DEFAULT(''),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX shifts_shift_code_uix
ON hrm.shifts(shift_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX shifts_shift_name_uix
ON hrm.shifts(shift_name)
WHERE deleted = 0;

CREATE TABLE hrm.leave_types
(
    leave_type_id                           integer IDENTITY NOT NULL PRIMARY KEY,
    leave_type_code                         national character varying(12) NOT NULL UNIQUE,
    leave_type_name                         national character varying(100) NOT NULL,
    description                             national character varying(1000) DEFAULT(''),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX leave_types_leave_type_code_uix
ON hrm.leave_types(leave_type_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX leave_types_leave_type_name_uix
ON hrm.leave_types(leave_type_name)
WHERE deleted = 0;

CREATE TABLE hrm.office_hours
(
    office_hour_id                          integer IDENTITY NOT NULL PRIMARY KEY,
    office_id                               integer NOT NULL REFERENCES core.offices(office_id),
    shift_id                                integer NOT NULL REFERENCES hrm.shifts,
    week_day_id                             integer NOT NULL REFERENCES hrm.week_days(week_day_id),
    begins_from                             time NOT NULL,
    ends_on                                 time NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE TABLE hrm.leave_benefits
(
    leave_benefit_id                        integer IDENTITY NOT NULL PRIMARY KEY,
    leave_benefit_code                      national character varying(12) NOT NULL UNIQUE,
    leave_benefit_name                      national character varying(128) NOT NULL,
    total_days                              integer NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX leave_benefits_leave_benefit_code_uix
ON hrm.leave_benefits(leave_benefit_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX leave_benefits_leave_benefit_name_uix
ON hrm.leave_benefits(leave_benefit_name)
WHERE deleted = 0;

CREATE TABLE hrm.employee_types
(
    employee_type_id                        integer IDENTITY NOT NULL PRIMARY KEY,
    employee_type_code                      national character varying(12) NOT NULL UNIQUE,
    employee_type_name                      national character varying(128) NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX employee_types_employee_type_code_uix
ON hrm.employee_types(employee_type_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX employee_types_employee_type_name_uix
ON hrm.employee_types(employee_type_name)
WHERE deleted = 0;

CREATE TABLE hrm.employees
(
    employee_id                             integer IDENTITY NOT NULL PRIMARY KEY,
    employee_code                           national character varying(12) NOT NULL UNIQUE,
    first_name                              national character varying(50) NOT NULL,
    middle_name                             national character varying(50) DEFAULT(''),
    last_name                               national character varying(50) DEFAULT(''),
    employee_name                           national character varying(160) NOT NULL,
    gender_code                             national character varying(4) NOT NULL 
                                            REFERENCES core.genders(gender_code),
    marital_status_id                       integer NOT NULL REFERENCES core.marital_statuses(marital_status_id),
    joined_on                               date NULL,
    office_id                               integer NOT NULL REFERENCES core.offices(office_id),
    user_id                                 integer REFERENCES account.users(user_id),
    employee_type_id                        integer NOT NULL REFERENCES hrm.employee_types(employee_type_id),
    current_department_id                   integer NOT NULL REFERENCES hrm.departments(department_id),
    current_role_id                         integer REFERENCES hrm.roles(role_id),
    current_employment_status_id            integer NOT NULL REFERENCES hrm.employment_statuses(employment_status_id),
    current_job_title_id                    integer NOT NULL REFERENCES hrm.job_titles(job_title_id),
    current_pay_grade_id                    integer NOT NULL REFERENCES hrm.pay_grades(pay_grade_id),
    current_shift_id                        integer NOT NULL REFERENCES hrm.shifts(shift_id),
    nationality_code                        national character varying(12) REFERENCES hrm.nationalities(nationality_code),
    date_of_birth                           date,
    photo                                   dbo.photo,
    bank_account_number                     national character varying(128) DEFAULT(''),
    bank_name                               national character varying(128) DEFAULT(''),
    bank_branch_name                        national character varying(128) DEFAULT(''),
    bank_reference_number                   national character varying(128) DEFAULT(''),
    zip_code                                national character varying(128) DEFAULT(''),
    address_line_1                          national character varying(128) DEFAULT(''),
    address_line_2                          national character varying(128) DEFAULT(''),
    street                                  national character varying(128) DEFAULT(''),
    city                                    national character varying(128) DEFAULT(''),
    state                                   national character varying(128) DEFAULT(''),    
    country_code                            national character varying(12) REFERENCES core.countries,
    phone_home                              national character varying(128) DEFAULT(''),
    phone_cell                              national character varying(128) DEFAULT(''),
    phone_office_extension                  national character varying(128) DEFAULT(''),
    phone_emergency                         national character varying(128) DEFAULT(''),
    phone_emergency_2                       national character varying(128) DEFAULT(''),
    email_address                           national character varying(128) DEFAULT(''),
    website                                 national character varying(128) DEFAULT(''),
    blog                                    national character varying(128) DEFAULT(''),
    is_smoker                               bit,
    is_alcoholic                            bit,
    with_disabilities                       bit,
    low_vision                              bit,
    uses_wheelchair                         bit,
    hard_of_hearing                         bit,
    is_aphonic                              bit,
    is_cognitively_disabled                 bit,
    is_autistic                             bit,
    service_ended_on                        date NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX employees_employee_code_uix
ON hrm.employees(employee_code)
WHERE deleted = 0;

CREATE TABLE hrm.employee_identification_details
(
    employee_identification_detail_id       bigint IDENTITY NOT NULL PRIMARY KEY,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    identification_type_code                national character varying(12) NOT NULL 
                                            REFERENCES hrm.identification_types,
    identification_number                   national character varying(128) NOT NULL,
    expires_on                              date,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)                                  
);

CREATE UNIQUE INDEX employee_identification_details_employee_id_itc_uix
ON hrm.employee_identification_details(employee_id, identification_type_code)
WHERE deleted = 0;

CREATE TABLE hrm.employee_social_network_details
(
    employee_social_network_detail_id       bigint IDENTITY NOT NULL PRIMARY KEY,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    social_network_name                     national character varying(128) NOT NULL
                                            REFERENCES hrm.social_networks(social_network_name),
    social_network_id                       national character varying(128) NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE hrm.contracts
(
    contract_id                             bigint IDENTITY NOT NULL PRIMARY KEY,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    office_id                               integer NOT NULL REFERENCES core.offices(office_id),
    department_id                           integer NOT NULL REFERENCES hrm.departments(department_id),
    role_id                                 integer REFERENCES hrm.roles(role_id),
    leave_benefit_id                        integer REFERENCES hrm.leave_benefits(leave_benefit_id),
    began_on                                date,
    ended_on                                date,
    employment_status_code_id               integer NOT NULL REFERENCES hrm.employment_status_codes(employment_status_code_id),
    verification_status_id                  smallint NOT NULL REFERENCES core.verification_statuses(verification_status_id),
    verified_by_user_id                     integer REFERENCES account.users(user_id),
    verified_on                             date,
    verification_reason                     national character varying(128) NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE hrm.employee_experiences
(
    employee_experience_id                  bigint IDENTITY NOT NULL PRIMARY KEY,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    organization_name                       national character varying(128) NOT NULL,
    title                                   national character varying(128) NOT NULL,
    started_on                              date,
    ended_on                                date,
    details                                 national character varying(1000),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE hrm.employee_qualifications
(
    employee_qualification_id               bigint IDENTITY NOT NULL PRIMARY KEY,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    education_level_id                      integer NOT NULL REFERENCES hrm.education_levels(education_level_id),
    institution                             national character varying(128) NOT NULL,
    majors                                  national character varying(128) NOT NULL,
    total_years                             integer,
    score                                   numeric(30, 6),
    started_on                              date,
    completed_on                            date,
    details                                 national character varying(1000),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE hrm.leave_applications
(
    leave_application_id                    bigint IDENTITY NOT NULL PRIMARY KEY,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    leave_type_id                           integer NOT NULL REFERENCES hrm.leave_types(leave_type_id),
    entered_by                              integer NOT NULL REFERENCES account.users(user_id),
    applied_on                              date DEFAULT(GETUTCDATE()),
    reason                                  national character varying(1000),
    start_date                              date,
    end_date                                date,
    verification_status_id                  smallint NOT NULL REFERENCES core.verification_statuses(verification_status_id),
    verified_by_user_id                     integer REFERENCES account.users(user_id),
    verified_on                             date,
    verification_reason                     national character varying(128) NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE hrm.resignations
(
    resignation_id                          integer IDENTITY NOT NULL PRIMARY KEY,
    entered_by                              integer NOT NULL REFERENCES account.users(user_id),
    notice_date                             date NOT NULL,
    desired_resign_date                     date NOT NULL,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    forward_to                              integer REFERENCES hrm.employees(employee_id),
    reason                                  national character varying(128) NOT NULL,
    details                                 national character varying(1000),
    verification_status_id                  smallint NOT NULL REFERENCES core.verification_statuses(verification_status_id),
    verified_by_user_id                     integer REFERENCES account.users(user_id),
    verified_on                             date,
    verification_reason                     national character varying(128) NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE hrm.terminations
(
    termination_id                          integer IDENTITY NOT NULL PRIMARY KEY,
    notice_date                             date NOT NULL,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id) UNIQUE,
    forward_to                              integer REFERENCES hrm.employees(employee_id),
    change_status_to                        integer NOT NULL REFERENCES hrm.employment_statuses(employment_status_id),
    reason                                  national character varying(128) NOT NULL,
    details                                 national character varying(1000),
    service_end_date                        date NOT NULL,
    verification_status_id                  smallint NOT NULL REFERENCES core.verification_statuses(verification_status_id),
    verified_by_user_id                     integer REFERENCES account.users(user_id),
    verified_on                             date,
    verification_reason                     national character varying(128) NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
    
);

CREATE TABLE hrm.exit_types
(
    exit_type_id                            integer IDENTITY NOT NULL PRIMARY KEY,
    exit_type_code                          national character varying(12) NOT NULL UNIQUE,
    exit_type_name                          national character varying(128) NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE UNIQUE INDEX exit_types_exit_type_code_uix
ON hrm.exit_types(exit_type_code)
WHERE deleted = 0;

CREATE UNIQUE INDEX exit_types_exit_type_name_uix
ON hrm.exit_types(exit_type_name)
WHERE deleted = 0;

CREATE TABLE hrm.exits
(
    exit_id                                 bigint IDENTITY NOT NULL PRIMARY KEY,
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    forward_to                              integer REFERENCES hrm.employees(employee_id),
    change_status_to                        integer NOT NULL REFERENCES hrm.employment_statuses(employment_status_id),
    exit_type_id                            integer NOT NULL REFERENCES hrm.exit_types(exit_type_id),
    exit_interview_details                  national character varying(1000),
    reason                                  national character varying(128) NOT NULL,
    details                                 national character varying(1000),
    verification_status_id                  smallint NOT NULL REFERENCES core.verification_statuses(verification_status_id),
    verified_by_user_id                     integer REFERENCES account.users(user_id),
    verified_on                             date,
    verification_reason                     national character varying(128) NULL,
    service_end_date                        date NOT NULL,
    audit_user_id                           integer NULL REFERENCES account.users(user_id),    
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                    bit DEFAULT(0)
);


CREATE TABLE hrm.attendances
(
    attendance_id                           bigint IDENTITY NOT NULL PRIMARY KEY,
    office_id                               integer NOT NULL REFERENCES core.offices(office_id),
    employee_id                             integer NOT NULL REFERENCES hrm.employees(employee_id),
    attendance_date                         date NOT NULL,
    was_present                             bit NOT NULL,
    check_in_time                           time NULL,
    check_out_time                          time NULL,
    overtime_hours                          numeric(30, 6) NOT NULL,
    was_absent                              bit NOT NULL,
                                            CHECK(was_absent != was_present),
    reason_for_absenteeism                  national character varying(1000),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETUTCDATE()),
    deleted                                 bit DEFAULT(0)
);

CREATE UNIQUE INDEX attendance_date_employee_id_uix
ON hrm.attendances(attendance_date, employee_id)
WHERE deleted = 0;


GO
