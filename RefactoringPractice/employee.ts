/* eslint-disable @typescript-eslint/explicit-function-return-type */
/* eslint-disable @typescript-eslint/no-parameter-properties */

class Employee {
    private _employeeType: EmployeeType;

    constructor(
        private _type: number,
        private _monthlySalary: number,
        private _commission: number,
        private _bonus: number
    ) {
        this._employeeType = EmployeeType.newType(this._type);
    }

    public get monthlySalary(): number {
        return this._monthlySalary;
    }

    public get commission(): number {
        return this._commission;
    }

    public get bonus(): number {
        return this._bonus;
    }

    public payAmount(): number {
        return this._employeeType.payAmount(this);
    }

    public hasRetirementPlan(): boolean {
        return this._employeeType.hasRetirementPlan();
    }

    public isBoardMember(): boolean {
        return this._employeeType.isBoardMember();
    }
}

abstract class EmployeeType {
    public static readonly ENGINEER: number = 0;
    public static readonly SALESMAN: number = 1;
    public static readonly MANAGER: number = 2;
    public static readonly SUPER_MANAGER: number = 3;

    abstract payAmount(employee: Employee): number;
    abstract hasRetirementPlan(): boolean;
    abstract isBoardMember(): boolean;

    public static newType(typeCode: number): EmployeeType {
        switch (typeCode) {
            case EmployeeType.ENGINEER:
                return new Engineer();
            case EmployeeType.SALESMAN:
                return new Salesman();
            case EmployeeType.MANAGER:
                return new Manager();
            case EmployeeType.SUPER_MANAGER:
                return new SuperManager();
            default:
                throw new Error("Invalid employee type");
        }
    }
}

class Engineer extends EmployeeType {
    public payAmount(employee: Employee) {
        return employee.monthlySalary;
    }

    public hasRetirementPlan() {
        return true;
    }

    public isBoardMember() {
        return false;
    }
}

class Salesman extends EmployeeType {
    public payAmount(employee: Employee) {
        return employee.monthlySalary + employee.commission;
    }

    public hasRetirementPlan() {
        return false;
    }

    public isBoardMember() {
        return false;
    }
}

class Manager extends EmployeeType {
    public payAmount(employee: Employee) {
        return employee.monthlySalary + employee.bonus;
    }

    public hasRetirementPlan() {
        return true;
    }

    public isBoardMember() {
        return true;
    }
}

class SuperManager extends EmployeeType {
    public payAmount(employee: Employee) {
        return employee.monthlySalary + employee.commission + employee.bonus;
    }

    public hasRetirementPlan() {
        return true;
    }

    public isBoardMember() {
        return true;
    }
}

export { Employee };

// const employee = new Employee(0, 300, 100, 50);
// console.log(employee.payAmount());
// console.log(employee.hasRetirementPlan());
// console.log(employee.isBoardMember());

