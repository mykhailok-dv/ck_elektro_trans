<?php
declare(strict_types=1);

class Fixtures
{
    /**
     * @var PDO $connection
     */
    private static $connection;

    private $companyDob;

    /**
     * @return void
     */
    public function generate(): void
    {
        $connection = $this->getConnection();
        try {
            $connection->beginTransaction();
            $this->cleanup();
            $connection->commit();
            $connection->beginTransaction();
            $this->generatePosition();
            $this->generateTransports(50);
            $this->generateEmployees(50);
            $this->generateSalary();
            $this->generateEmployeesPositionTime();
            $this->generateTransportAccounting();

            $connection->commit();

            $this->getRowsCountFromTables();
        } catch (Exception $e) {
            $connection->rollBack();
            echo $e->getMessage();
        }
    }


    private function getRandomName(): string
    {
        static $randomNames = ['Norbert', 'Damon', 'Laverna', 'Annice', 'Brandie', 'Emogene', 'Cinthia', 'Magaret', 'Daria', 'Ellyn', 'Rhoda', 'Debbra', 'Reid', 'Desire', 'Sueann', 'Shemeka', 'Julian', 'Winona', 'Billie', 'Michaela', 'Loren', 'Zoraida', 'Jacalyn', 'Lovella', 'Bernice', 'Kassie', 'Natalya', 'Whitley', 'Katelin', 'Danica', 'Willow', 'Noah', 'Tamera', 'Veronique', 'Cathrine', 'Jolynn', 'Meridith', 'Moira', 'Vince', 'Fransisca', 'Irvin', 'Catina', 'Jackelyn', 'Laurine', 'Freida', 'Torri', 'Terese', 'Dorothea', 'Landon', 'Emelia'];
        return $randomNames[array_rand($randomNames)];
    }

    private function getRandomInfo(): string
    {
        return uniqid('', true);
    }

    /**
     * @return DateTime
     */
    private function getCompanyDob(): DateTime
    {
        try {
            $this->companyDob ?: $this->companyDob = (new DateTime())->setDate(2005, 07, 1);
            return $this->companyDob;
        } catch (Exception $e) {
            echo $e->getMessage();
            exit;
        }
    }

    /**
     * @return void
     */
    public function getRowsCountFromTables(): void
    {
        $connection = $this->getConnection();
        $tables = $connection->query('SHOW TABLES');
        $tables = $tables->fetchAll(PDO::FETCH_COLUMN);
        $max_char = 0;
        $buffer = [];
        foreach ($tables as $table) {
            $currentStrlen = strlen($table);
            $max_char = $currentStrlen > $max_char ? $currentStrlen : $max_char;
            $result = $connection->query('SELECT COUNT(*) FROM ' . $table)->fetchAll(PDO::FETCH_COLUMN);
            $buffer[$table] = array_shift($result);
        }
        ++$max_char;
        foreach ($buffer as $table => $result) {
            echo str_pad($table, $max_char) . ': ' . $result . PHP_EOL;
        }
    }

    /**
     * @return array
     */
    private function getPositions(): array
    {
        return ['Driver', 'Conductor', 'Accountant', 'Manager',];
    }

    /**
     * @return PDO
     */
    public function getConnection(): PDO
    {
        if (null === self::$connection) {
            self::$connection = new PDO('mysql:host=127.0.0.1:3357;dbname=ck_elektro_trans', 'ck_elektro_trans', 'ck_elektro_trans', []);
            self::$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }
        return self::$connection;
    }

    public function cleanup(): void
    {
        $connection = $this->getConnection();
        $connection->exec('DELETE FROM `employees_position_time`');
        $connection->exec('ALTER TABLE `employees_position_time` AUTO_INCREMENT = 1');

        $connection->exec('DELETE FROM `position`');
        $connection->exec('ALTER TABLE `position` AUTO_INCREMENT = 1');

        $connection->exec('DELETE FROM `salary`');
        $connection->exec('ALTER TABLE `salary` AUTO_INCREMENT = 1');

        $connection->exec('DELETE FROM `transport_accounting`');
        $connection->exec('ALTER TABLE `transport_accounting` AUTO_INCREMENT = 1');

        $connection->exec('DELETE FROM `transport`');
        $connection->exec('ALTER TABLE `transport` AUTO_INCREMENT = 1');

        $connection->exec('DELETE FROM `employee`');
        $connection->exec('ALTER TABLE `employee` AUTO_INCREMENT = 1');
    }

    public function createIndexes(): void
    {
        $connection = $this->getConnection();
        $createIndex = static function ($table, $column) {
            return 'CREATE INDEX ' . strtoupper($table) . '_' . strtoupper($column) . ' ON ' . $table . '(' . $column . ')';
        };

        $connection->exec($createIndex('salary', 'amount'));
        $connection->exec($createIndex('salary', 'pay_day'));

        $connection->exec($createIndex('employee', 'wage'));
        $connection->exec($createIndex('employee', 'lastname'));

        $connection->exec($createIndex('employees_position_time', 'start_date'));
        $connection->exec($createIndex('employees_position_time', 'end_date'));

        $connection->exec($createIndex('transport', 'title'));

        $connection->exec($createIndex('transport_accounting', 'date'));
    }

    public function dropIndexes(): void
    {
        $connection = $this->getConnection();
        // ALTER TABLE salary DROP INDEX salary.salary_amount;
        $dropIndex = static function ($table, $column) {
            $table = strtolower($table);
            return 'ALTER TABLE ' . $table . ' DROP INDEX  ' . $table . '.' . $table . '_' . $column;
        };

        $connection->exec($dropIndex('salary', 'amount'));
        $connection->exec($dropIndex('salary', 'pay_day'));

        $connection->exec($dropIndex('employee', 'wage'));
        $connection->exec($dropIndex('employee', 'lastname'));

        $connection->exec($dropIndex('employees_position_time', 'start_date'));
        $connection->exec($dropIndex('employees_position_time', 'end_date'));

        $connection->exec($dropIndex('transport', 'title'));

        $connection->exec($dropIndex('transport_accounting', 'date'));
    }

    /**
     * @return void
     */
    public function generatePosition(): void
    {
        $connection = $this->getConnection();
        $start = microtime(true);
        $title = '';
        $statement = $connection->prepare(<<<SQL
    INSERT INTO position (title)
    VALUES (:title);
SQL
        );
        $statement->bindParam(':title', $title);

        foreach ($this->getPositions() as $position) {
            $title = $position;
            $statement->execute();
        }

        echo 'Create positions: ' . (microtime(true) - $start) . "\n";
    }

    /**
     * @param int $autoCount
     * @throws Exception
     */
    public function generateTransports(int $autoCount): void
    {
        $connection = $this->getConnection();
        $start = microtime(true);
        $title = $info = '';
        $statement = $connection->prepare(<<<SQL
    INSERT INTO transport (title, info)
    VALUES (:title, :info)
    ON DUPLICATE KEY UPDATE
    title=VALUES(title), info=VALUES(info)
SQL
        );
        $statement->bindParam(':title', $title);
        $statement->bindParam(':info', $info);
        for ($transportId = 1; $transportId <= $autoCount; $transportId++) {
            $title = 'Bogdan #' . random_int(1000, 9999);
            $info = 'Number: "CA ' . random_int(1000, 9999) . '"';
            $statement->execute();
        }
        echo 'Create transports: ' . (microtime(true) - $start) . "\n";
    }

    /**
     * @param int $usersCount
     * @throws Exception
     */
    public function generateEmployees(int $usersCount): void
    {
        $connection = $this->getConnection();
        $currentTimestamp = time();
        $start = microtime(true);
        $name = $lastName = $info = $dob = '';
        $minAgeTimestamp = $currentTimestamp - (31556952 * 45);
        $maxAgeTimestamp = $currentTimestamp - (31556952 * 16);
        $statement = $connection->prepare(<<<SQL
    INSERT INTO employee (name, lastname, info, dob, wage)
    VALUES (:name, :lastname, :info, :dob, :wage)
    ON DUPLICATE KEY UPDATE dob=VALUES(dob), info=VALUES(info);
SQL
        );
        $statement->bindParam(':name', $name);
        $statement->bindParam(':lastname', $lastName);
        $statement->bindParam(':info', $info);
        $statement->bindParam(':dob', $dob);
        $statement->bindParam(':wage', $wage);
        for ($userId = 1; $userId <= $usersCount; $userId++) {
            $name = $this->getRandomName();
            $lastName = $this->getRandomName();
            $info = $this->getRandomInfo();
            $timestamp = random_int($minAgeTimestamp, $maxAgeTimestamp);
            $dob = date('Y-m-d', $timestamp);
            $wage = random_int(2000, 20000);
            $statement->execute();
        }
        echo 'Create users: ' . (microtime(true) - $start) . "\n";
    }

    public function generateSalary(): void
    {
        $connection = $this->getConnection();
        $start = microtime(true);
        $startDate = $endDate = $amount = $employee_id = null;
        $statement = $connection->prepare(<<<SQL
    INSERT INTO salary (start_date, end_date, amount, employee_id, pay_day)
    VALUES (:start_date, :end_date, :amount, :employee_id, :end_date );
SQL
        );
        $statement->bindParam(':start_date', $startDate);
        $statement->bindParam(':end_date', $endDate);
        $statement->bindParam(':amount', $amount);
        $statement->bindParam(':employee_id', $employee_id, PDO::PARAM_INT);
        $employeeIds = $this->selectEmployeeIds();

        foreach ($employeeIds as $employeeId) {
            $coef = 1;
            $employee_id = (int)$employeeId;
            $generator = new DateGenerator();
            foreach ($generator->generatorRange($this->getCompanyDob(), DateGenerator::RANGE_MONTH) as $dateRange) {
                $coef *= 1.02;
                try {
                    $amount = $coef * random_int(270, 300);
                } catch (Exception $e) {
                    $amount = $coef * 270;
                }
                $startDate = $dateRange['firstDay'];
                $endDate = $dateRange['lastDay'];
                $statement->execute();
            }
        }

        echo 'Create salary: ' . (microtime(true) - $start) . "\n";
    }

    public function generateTransportAccounting(): void
    {
        $connection = $this->getConnection();
        $start = microtime(true);

        $statement = $connection->prepare(<<<SQL
    INSERT INTO transport_accounting (date, income, employee_id, transport_id)
    VALUES (:date, :income, :employee_id, :transport_id);
SQL
        );
        $statement->bindParam(':date', $date);
        $statement->bindParam(':income', $income);
        $statement->bindParam(':employee_id', $employee_id, PDO::PARAM_INT);
        $statement->bindParam(':transport_id', $transport_id, PDO::PARAM_INT);

        $driverIds = $this->selectDriverIds();

        $generator = new DateGenerator();
        $coef = 1;
        foreach ($generator->generatorRange($this->getCompanyDob(), DateGenerator::RANGE_DATE) as $day) {
            $transportIds = $this->selectTransportIds();
            $coef *= 1.0005;
            /** Looping for drivers. For each driver.*/
            foreach ($driverIds as $driverId) {
                $date = $day['day'];

                /** The driver was sick or had vacancy or anything | 4% from all days. */
                try {
                    if (random_int(1, 100) < 5) {
                        break;
                    }
                } catch (Exception $e) {}
                try {
                    $income = $coef * random_int(80, 100);
                } catch (Exception $e) {
                    $income = $coef * 80;
                }
                $employee_id = $driverId;

                // Take from an array $transportIds random transport.
                $transportIdsKey = array_rand($transportIds, 1);
                $transport_id = $transportIds[$transportIdsKey];
                if ($transport_id === null) {
                    break;
                }
                // Delete $transportIds key that was takes.
                unset($transportIds[$transportIdsKey]);

                $statement->execute();
            }
        }

        echo 'Create transport accounting: ' . (microtime(true) - $start) . "\n";
    }

    /**
     * @return void
     * @throws Exception
     */
    public function generateEmployeesPositionTime(): void
    {
        $connection = $this->getConnection();
        $start = microtime(true);

        $statement = $connection->prepare(<<<SQL
    INSERT INTO employees_position_time (start_date, end_date, position_id, employee_id)
    VALUES (:start_date, :end_date, :position_id, :employee_id);
SQL
        );
        $statement->bindParam(':start_date', $start_date);
        $statement->bindParam(':end_date', $end_date);
        $statement->bindParam(':employee_id', $employee_id, PDO::PARAM_INT);
        $statement->bindParam(':position_id', $position_id, PDO::PARAM_INT);

        $employeeIds = $this->selectEmployeeIds();
        $positionIds = $this->selectPositionIds();
        foreach ($employeeIds as $employeeId) {
            $start_date = $this->getCompanyDob();
            $end_date = time();
            $start_date_timestamp = random_int($start_date->getTimestamp(), $end_date);
            $end_date_timestamp = random_int($start_date_timestamp, $end_date);
            $start_date = (new DateTime())->setTimestamp($start_date_timestamp)->format('Y-m-d');
            $end_date = random_int(0, 1) ? (new DateTime())->setTimestamp($end_date_timestamp)->format('Y-m-d') : null;

            $employee_id = $employeeId;
            $position_id = $positionIds[array_rand($positionIds, 1)];
            $statement->execute();
        }

        echo 'Create employees position time: ' . (microtime(true) - $start) . "\n";
    }


    /**
     * Get employee ids.
     * @return array
     */
    public function selectEmployeeIds(): array
    {
        return $this->getConnection()
            ->query('SELECT id FROM employee')
            ->fetchAll(PDO::FETCH_COLUMN);
    }

    /**
     * Get transport ids.
     * @return array
     */
    public function selectTransportIds(): array
    {
        return $this->getConnection()
            ->query('SELECT id FROM transport')
            ->fetchAll(PDO::FETCH_COLUMN);
    }

    /**
     * Get all employees which have a Driver position from relation `employees_position_time`
     * @return array
     */
    public function selectDriverIds(): array
    {
        return $this->getConnection()
            ->query(<<<SQL
SELECT e.id
FROM employee AS `e`
         INNER JOIN employees_position_time AS `ept`
                   ON e.id = ept.employee_id
         INNER JOIN position AS `p`
                   ON ept.position_id = p.id
WHERE p.title = 'Driver';
SQL
            )
            ->fetchAll(PDO::FETCH_COLUMN);
    }

    public function selectPositionIds(): array
    {
        return $this->getConnection()
            ->query('SELECT id FROM position')
            ->fetchAll(PDO::FETCH_COLUMN);
    }
}
