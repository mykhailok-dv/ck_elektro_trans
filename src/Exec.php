<?php
declare(strict_types=1);


class Exec
{
    public function run()
    {
        $params = $_SERVER['argv'];
        array_shift($params);
        foreach ($params as $param) {
            $variables = explode('-',$param);
            $method = array_shift($variables);
            if (method_exists($this, $method)) {
                $this->{$method}($variables);
            }
            else {
                echo 'Method: ' . self::class . '::' . $method . '() doesn\'t exists.' . PHP_EOL;
                exit;
            }
        }
    }

    /**
     * @return bool
     */
    protected function clean(): bool
    {
        (new Fixtures())->cleanup();
        return true;
    }

    protected function createIndexes(): bool
    {
        (new Fixtures())->createIndexes();
        return true;
    }

    protected function dropIndexes(): bool
    {
        (new Fixtures())->dropIndexes();
        return true;
    }

    protected function homework(): bool
    {
        $params = func_get_args();
        (new Homework())->run($params[0][0]);
        return true;
    }

    protected function exit(): bool
    {
        exit;
    }
}
