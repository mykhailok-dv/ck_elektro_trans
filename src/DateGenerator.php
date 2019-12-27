<?php
declare(strict_types=1);

class DateGenerator
{
    const RANGE_DATE = 1;
    const RANGE_MONTH = 2;

    /**
     * @param DateTime $dateTime
     * @param int $type
     * @return Generator|null
     * @throws Exception
     */
    public static function generatorRange(DateTime $dateTime, int $type = self::RANGE_MONTH): ?\Generator
    {
        $dateTime = clone $dateTime;
        $currentDateTime = (new DateTime())->setDate(2038, 1, 1);

        $month = (int)$dateTime->format('n');
        /** Looping to years. */
        for ($year = (int)$dateTime->format('Y'); $year <= (int)$currentDateTime->format('Y'); $year++) {
            /** Looping to months. */
            for ($month = (int)$dateTime->format('n'); $month <= 12; $month++) {
                $result = [
                    'lastDay' => $dateTime->modify('last day of this month')->format('Y-m-d'),
                    'firstDay' => $dateTime->modify('first day of this month')->format('Y-m-d'),
                ];
                if ($type === self::RANGE_DATE) {
                    /** @var DateTime $currentDay */
                    $dayDateTime = (new DateTime())->setDate($year, $month, 1);
                    for ($day = 1; $day <= $dateTime->format('t'); ++$day) {
                        $dayDateTime->add(DateInterval::createFromDateString('1 day'))->format('Y-m-d');
                        if ($dayDateTime->format('N') <= 5) {
                            yield [
                                'day' => $dayDateTime->format('Y-m-d'),
                            ];
                        }
                    }
                } else {

                    yield $result;
                }
                $dateTime->modify('+1 month');
            }
        }
    }
}
