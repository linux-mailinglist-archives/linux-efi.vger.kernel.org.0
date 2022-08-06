Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1045B58B6CE
	for <lists+linux-efi@lfdr.de>; Sat,  6 Aug 2022 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiHFQ0y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Aug 2022 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiHFQ0k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Aug 2022 12:26:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A811805;
        Sat,  6 Aug 2022 09:26:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b96so6823452edf.0;
        Sat, 06 Aug 2022 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ORTACdD1UW9t4Zw+2hPKbY3+gRbBdfvtSFXUJvzJI0g=;
        b=gKqaCN0iMjSZA6LUkwAJEZ4Tct5Zbw0Py7JVP0F55ez3/3bnw5zck2VnzIBkF6zCSR
         iFpBJ4WCt5no7HkW4DDiTSc+NvQjHog77T/RctapssG8fPsFmYAmiIkMqjNzBFM35SYD
         bb1zMd6OHg9N6JjuHUcPGY/tSWDD2zizDGid9Z+EIsWFMSD6oOQKBgHh+5iH33Ox4fNR
         eiAXn7PGctPdoT9zTGnrT1rFeWWSEI2ewhTgyzuac83DOpbC9ln+lYJQReP1doiv8kV5
         0X1ngZ6F4qlgUW/UBp6kamtPZAQbx8A51zga2Kx782KDHiT3wiPsEElpPSfa7SGiMTz3
         0agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ORTACdD1UW9t4Zw+2hPKbY3+gRbBdfvtSFXUJvzJI0g=;
        b=gQeqXIT2slWMZ3qIE3Y3sajArbSKo3Zt55XRtLXbMJzGmK6lo4y2zo9Kwd0lmKBiTO
         Pamj/6dkLqmSudaEAvSAH+A1d8fi1747GHXKrvVII4OCOGwY+d2CgBvOyliURE8kQ+1t
         pn3Q0N7b3uyDMlFDrYaofyxGFTC13hQ1WPLutUtLZbWIL/ESVuu7fVkR+gpa6T8q1WML
         XWa5pZjIidi4L010o3VZHYHhfQ+i0EkxL6GXdFF+7q18MNbKIIug3bXENjKuRf5CoNmt
         +t5mIHETiWB1Y9Xbt3AeGRO1d3tJedhz6/4tL70vb8QaUGm6Ru/+hChhTSuxgldEdWSE
         o6/Q==
X-Gm-Message-State: ACgBeo1gf9ofHb+qw90MJRbf/fvfbPbj3fOmFfduOvdm8fXygGYNs5zL
        cPuR7FaQj/LH9bck00KR/WaTSP9M7lQ=
X-Google-Smtp-Source: AA6agR7+6RjICx//F5Wg18tQ05niWDE34yGNmMysb+FYhy/e2rrFtB5IKDoqwlj03I0XZsw2ObdVYA==
X-Received: by 2002:a05:6402:190b:b0:43d:d001:2cce with SMTP id e11-20020a056402190b00b0043dd0012ccemr11094395edz.326.1659803184703;
        Sat, 06 Aug 2022 09:26:24 -0700 (PDT)
Received: from [192.168.3.10] (tor-exit-50.for-privacy.net. [185.220.101.50])
        by smtp.gmail.com with ESMTPSA id e12-20020a50fb8c000000b0043a78236cd2sm1663625edq.89.2022.08.06.09.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 09:26:24 -0700 (PDT)
Message-ID: <27b40940-b8a7-2755-1ef5-e97d6b35dd2a@gmail.com>
Date:   Sat, 6 Aug 2022 19:26:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com> <YuKfnAjB4gV0ki4A@kroah.com>
 <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com> <YuKkxb7u3piHytJ8@kroah.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <YuKkxb7u3piHytJ8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Greg,

On 7/28/22 18:01, Greg Kroah-Hartman wrote:
> On Thu, Jul 28, 2022 at 05:52:04PM +0300, Markuss Broks wrote:
>> Hi Greg,
>>
>> On 7/28/22 17:39, Greg Kroah-Hartman wrote:
>>> On Thu, Jul 28, 2022 at 05:28:19PM +0300, Markuss Broks wrote:
>>>> Add early console support for generic linear framebuffer devices.
>>>> This driver supports probing from cmdline early parameters
>>>> or from the device-tree using information in simple-framebuffer node.
>>>> The EFI functionality should be retained in whole.
>>>> The driver was disabled on ARM because of a bug in early_ioremap
>>>> implementation on ARM.
>>>>
>>>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         |  12 +-
>>>>    MAINTAINERS                                   |   5 +
>>>>    drivers/firmware/efi/Kconfig                  |   6 +-
>>>>    drivers/firmware/efi/Makefile                 |   1 -
>>>>    drivers/firmware/efi/earlycon.c               | 246 --------------
>>>>    drivers/video/fbdev/Kconfig                   |  11 +
>>>>    drivers/video/fbdev/Makefile                  |   1 +
>>>>    drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
>>>>    8 files changed, 327 insertions(+), 256 deletions(-)
>>>>    delete mode 100644 drivers/firmware/efi/earlycon.c
>>>>    create mode 100644 drivers/video/fbdev/earlycon.c
>>>
>>> That should be a rename, not a delete/create, right?
>>
>> Should this change be split into two separate commits,
>> one for moving the file and the second for making changes?
> 
> Git will show a rename and modification properly, if you use -M to git
> format-patch, so it should be fine.

It appears that there are so many changes Git would refuse to make it a 
"move" no matter what I do. What should be done here: should it be two 
separate commits for move/change or should it just be kept as delete/create?

- Markuss
