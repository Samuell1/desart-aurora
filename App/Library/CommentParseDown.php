<?php

namespace App\Library;

use Parsedown;
use Spot\Mapper;
use Aurora\Helper\Url;
use App\Entity\User;

class CommentParseDown extends Parsedown
{
    /**
    * @var UsersRepository
    */
    private $UserMapper;
    private $NotificationMapper;
    private $Url;
    private $User;
    private $subjectId;

    function __construct(
        Mapper $UserMapper,
        Mapper $Notificationmapper,
        User $User,
        $subjectId,
        Url $Url
    ) {
        $this->InlineTypes['@'][] = 'UserTag';
        $this->inlineMarkerList  .= '@';
        $this->UserMapper         = $UserMapper;
        $this->User               = $User;
        $this->NotificationMapper = $Notificationmapper;
        $this->Url                = $Url;
        $this->subjectId                = $subjectId;
    }

    protected function inlineUserTag($Excerpt)
    {
        if (preg_match('/^@([^\s]+)/', $Excerpt['text'], $matches)) {
            $User = $this->UserMapper->select(["username", "id"])->where(['username' => $matches[1]])->first();

            if ($User) {
                $this->NotificationMapper->insert([
                    "connected_with" => 2,
                    "connected_id"   => $this->subjectId,
                    "type"           => 2,
                    "subject"        => $User->id,
                    "subject_type"   => 1,
                    "by_subject"     => $this->User->id,
                    "seen"           => 0
    			]);

                return array(
                    'extent' => strlen($matches[0]),
                    'element' => array(
                        'name' => 'a',
                        'text' => '@' . $matches[1],
                        'attributes' => array(
                            'href' => $this->Url->get("profile", [
                                "uid" => $matches[1]
                            ]),
                        ),
                    ),
                );
            }
        }
    }

    protected function inlineImage($Excerpt) {
        if ( ! isset($Excerpt['text'][1]) || $Excerpt['text'][1] !== '[') {
            return;
        }
        $Excerpt['text']= substr($Excerpt['text'], 1);
        $Link = $this->inlineLink($Excerpt);

        if ($Link === null) {
            return;
        }

        $Inline = [
            'extent' => $Link['extent'] + 1,
            'element' => [
                'name' => 'img',
                'attributes' => [
                    'src' => $Link['element']['attributes']['href'],
                    'alt' => $Link['element']['text'],
                ],
            ],
        ];

        $Inline['element']['attributes'] += $Link['element']['attributes'];
        $Inline['element']['attributes']["class"] = "image-responsive";

        unset($Inline['element']['attributes']['href']);
        return $Inline;
    }

}
