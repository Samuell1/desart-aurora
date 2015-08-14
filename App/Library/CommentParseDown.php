<?php

namespace App\Library;
use Parsedown;
use Spot\Mapper;
use Aurora\Helper\Url;

class CommentParseDown extends Parsedown
{
    /**
     * @var UsersRepository
     */
    private $UserMapper;
    private $Url;

    function __construct(Mapper $UserMapper, Url $Url)
    {
        $this->InlineTypes['@'][]= 'UserTag';

        $this->inlineMarkerList .= '@';

        $this->UserMapper = $UserMapper;
        $this->Url = $Url;
    }

    protected function inlineUserTag($Excerpt)
    {
        if (preg_match('/^@([^\s]+)/', $Excerpt['text'], $matches)) {
            $User = $this->UserMapper->select(["username"])
                ->where(['username' => $matches[1]]);

            if ($User) {
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

    # Fenced Code
    protected function blockFencedCode($Line)
    {
        if (preg_match('/^(['.$Line['text'][0].']{3,})[ ]*([\w-]+)?[ ]*$/', $Line['text'], $matches)) {
            $Element = [
                'name' => 'code',
                'text' => '',
                "attributes" => [
                    "class" => "prettycode"
                ]
            ];
            if (isset($matches[2])) {
                $Element['attributes'] = [
                    'class' => $matches[2]." prettycode",
                ];
            }
            $Block = [
                'char' => $Line['text'][0],
                'element' => [
                'name' => 'pre',
                "attributes" => [
                    "class" => "code-pre"
                ],
                'handler' => 'element',
                'text' => $Element,
            ],
            ];

            return $Block;
        }
    }

    protected function blockFencedCodeContinue($Line, $Block)
    {
        if (isset($Block['complete'])) {
            return;
        }
        if (isset($Block['interrupted'])) {
            $Block['element']['text']['text'] .= "\n";
            unset($Block['interrupted']);
        }

        $Block['element']['text']['attributes']['class'] = "prettycode";
        $Block['element']['attributes']['class'] = "code-pre";
        $Block['element']["text"]['attributes']['class'] = "code-pre";

        if (preg_match('/^'.$Block['char'].'{3,}[ ]*$/', $Line['text'])){
            $Block['element']['text']['text'] = substr($Block['element']['text']['text'], 1);
            $Block['complete'] = true;
            return $Block;
        }
        $Block['element']['text']['text'] .= "\n".$Line['body'];

        return $Block;
    }

    protected function blockFencedCodeComplete($Block)
    {
        $text = $Block['element']['text']['text'];
        $text = htmlspecialchars($text, ENT_NOQUOTES, 'UTF-8');

        $Block['element']['attributes']['class'] = "code-pre";
        $Block['element']['text']['text'] = $text;
        $Block['element']['text']['attributes']['class'] = "prettycode";

        return $Block;
    }

    protected function blockCode($Line, $Block = null)
    {
        if (isset($Block) && !isset($Block['type']) && !isset($Block['interrupted'])) {
            return;
        }

        if ($Line['indent'] >= 4) {
            $text = substr($Line['body'], 4);
            $Block = [
                'element' => [
                    'name' => 'pre',
                    "attributes" => [
                        "class" => "code-pre"
                    ],
                    'handler' => 'element',
                    'text' => [
                        'name' => 'code',
                        'text' => $text,
                        "attributes" => [
                            "class" => "prettycode"
                        ],
                    ],
                ],
            ];

            return $Block;
        }
    }

    protected function blockCodeContinue($Line, $Block)
    {
        if ($Line['indent'] >= 4) {
            if (isset($Block['interrupted'])) {
                $Block['element']['text']['text'] .= "\n";
                unset($Block['interrupted']);
            }
            $Block['element']['text']['text'] .= "\n";
            $text = substr($Line['body'], 4);
            $Block['element']['text']['text'] .= $text;

            return $Block;
        }
    }

    protected function blockCodeComplete($Block)
    {
        $text = $Block['element']['text']['text'];
        $text = htmlspecialchars($text, ENT_NOQUOTES, 'UTF-8');
        $Block['element']['text']['text'] = $text;

        return $Block;
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
