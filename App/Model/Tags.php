<?php namespace Entity\Mapper;
use Spot\Mapper;
class Post extends Mapper
{
    /**
     * Get 10 most recent posts for display on the sidebar
     *
     * @return \Spot\Query
     */
    public function tags()
    {
        return $this->where(['status' => 'active'])
            ->order(['date_created' => 'DESC'])
            ->limit(10);
    }
}
