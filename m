Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F7585945
	for <lists+linux-efi@lfdr.de>; Sat, 30 Jul 2022 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiG3IzL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Jul 2022 04:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiG3IzK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Jul 2022 04:55:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B1F43;
        Sat, 30 Jul 2022 01:55:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id tk8so12115687ejc.7;
        Sat, 30 Jul 2022 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bxfY1htXxbYgZJF5B+dESeWX+UdX+4GjUNZm08CoJ8E=;
        b=YbS/lcslcbmkXpey5cpFq+X/ytIJj3qLqsAi5z2w3lorLorzgulYzXLv7skrAU7gN0
         EX8kGu++8KCaP8JbTGm7Bo3U8kDDvcQXkGjM1MLqVjThH9BjNQnNUYSsBpwGPt78mnIV
         OmvNjkD5/22LUnX3abOBs3Ip/74gtvYpkMEqaB47rKWbISEtyBK4LuIyQGvszb2bZdoL
         CgvYhVFbtXuOgKbSqVay5FL3qu2DJiuNMGh1IjG0TKwGsmXbUFFznpLlY3RbMcwjVw9M
         adMX/40d2nJLNi65Qz4IOrP2vL7GL5fg4YlumPSgmRc3Lgb1LQGlkLtbz97XAWPK/J7w
         FrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bxfY1htXxbYgZJF5B+dESeWX+UdX+4GjUNZm08CoJ8E=;
        b=QXCKSPv1a/lGjPkdu9538fZa3ZWu1gFi+KWhDhgH2AkJvxXrqUAb+H+jlhm4XCS4ms
         EF65XDo4YB1K229xJ4H1GMWiRMtYnDV3s7nx0BELxvSQOv3d9y4v/EsUDviE16/eigER
         S8OkqPxNWCvgeSx2imUMp0/msB27p8GNMG9/Dwpk6Zs/mMFz8IfI5edHOwBZ05FCiflr
         g9mGaroQtBBSoTvrAe9a811QQQDRgoaksGru54rG9ifnxhrezQNdl1//BpmynEYGtUvQ
         fxnskJXx9IPFkgCyezvuJJTt2cEvd77ULpeZMciDTFS3fcGZy1DnWPzhYT1P6uDzAsWf
         gYVg==
X-Gm-Message-State: AJIora8pZusH4ReJ3SYqcx0wcuYINDKf4vmey5oOlR+aBrXfHxHqvJJH
        I5vhqKwiwQS/h8JU7RcKFu0=
X-Google-Smtp-Source: AGRyM1sheQBaWBbZ2/dbYWLUaQqAMJRtzg5nrxQDGH46I4vLTxOvUd/Zbug1LN1Ia1i+sismD/uiGg==
X-Received: by 2002:a17:907:970c:b0:72e:e972:5c73 with SMTP id jg12-20020a170907970c00b0072ee9725c73mr5518137ejc.352.1659171307805;
        Sat, 30 Jul 2022 01:55:07 -0700 (PDT)
Received: from [0.0.0.0] ([81.17.18.61])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b0072b8fbc9be1sm2699005ejy.187.2022.07.30.01.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 01:55:07 -0700 (PDT)
Message-ID: <3c55e119-5b6f-25ab-99c9-2c99b1dfd9e9@gmail.com>
Date:   Sat, 30 Jul 2022 14:54:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Tony Lindgren <tony@atomide.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com>
 <CAHp75VdaDyyqRw9fAkUOhNjsyifeozVx6JuYXSU1HpoO+VHDNA@mail.gmail.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CAHp75VdaDyyqRw9fAkUOhNjsyifeozVx6JuYXSU1HpoO+VHDNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Andy,

On 7/29/22 00:19, Andy Shevchenko wrote:
> On Thu, Jul 28, 2022 at 4:32 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>>
>> Add early console support for generic linear framebuffer devices.
>> This driver supports probing from cmdline early parameters
>> or from the device-tree using information in simple-framebuffer node.
>> The EFI functionality should be retained in whole.
>> The driver was disabled on ARM because of a bug in early_ioremap
>> implementation on ARM.
> 
> ...
> 
>> -               efifb,[options]
>> +               efifb
>>                          Start an early, unaccelerated console on the EFI
>> -                       memory mapped framebuffer (if available). On cache
>> -                       coherent non-x86 systems that use system memory for
>> -                       the framebuffer, pass the 'ram' option so that it is
>> -                       mapped with the correct attributes.
>> +                       memory mapped framebuffer (if available).
> 
> If somebody passes those (legacy) options, what will happen?

Those would be ignored. Instead it would be automatically determined if 
framebuffer is located in RAM or in the I/O space.

> 
> ...
> 
>>   config EFI_EARLYCON
>> -       def_bool y
>> -       depends on SERIAL_EARLYCON && !ARM && !IA64
>> -       select FONT_SUPPORT
>> -       select ARCH_USE_MEMREMAP_PROT
>> +       bool "EFI early console support"
>> +       depends on FB_EARLYCON && !IA64
> 
> This doesn't sound right. Previously on my configuration it was
> selected automatically, now I need to select it explicitly? I mean
> that for me EFI_EARLYCON should be selected by default as it was
> before.

The problem I had with EFI_EARLYCON selected by default was that it 
would also carry fbdev with itself. Luckily, that's solved if it's moved 
to console subsystem.

> 
> ...
> 
>> +static int __init simplefb_earlycon_remap_fb(void)
>> +{
>> +       int is_ram;
> 
> + blank line.
> 
>> +       /* bail if there is no bootconsole or it has been disabled already */
>> +       if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
>> +               return 0;
>> +
>> +       is_ram = region_intersects(info.phys_base, info.size,
>> +                                  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
>> +       is_ram = is_ram == REGION_INTERSECTS;
> 
> Was it in the original code? Otherwise, I would go with plain conditional:
> 
>    if (region_intersects())
>      base = ...
>    else
>      base = ...

It wasn't in original code. Original code assumed MEMREMAP_WC always
unless "ram" was specified as an option to efifb (e.g.
earlycon=efifb,ram). This code instead checks if the framebuffer is in 
RAM, and sets the mapping accordingly.

Another issue is that region_intersects() returns REGION_INTERSECTS 
(defined as 0) when true. I suppose we could use something like:

if (region_intersects() == REGION_INTERSECTS)
...

> 
>> +       info.virt_base = memremap(info.phys_base, info.size,
>> +                                 is_ram ? MEMREMAP_WB : MEMREMAP_WC);
>> +
>> +       return info.virt_base ? 0 : -ENOMEM;
>> +}
> 
> ...
> 
>> +static void simplefb_earlycon_write_char(u8 *dst, unsigned char c, unsigned int h)
>> +{
>> +       const u8 *src;
>> +       int m, n, bytes;
>> +       u8 x;
>> +
>> +       bytes = BITS_TO_BYTES(font->width);
>> +       src = font->data + c * font->height * bytes + h * bytes;
>> +
>> +       for (m = 0; m < font->width; m++) {
>> +               n = m % 8;
>> +               x = *(src + m / 8);
>> +               if ((x >> (7 - n)) & 1)
>> +                       memset(dst, 0xff, (info.depth / 8));
>> +               else
>> +                       memset(dst, 0, (info.depth / 8));
>> +               dst += (info.depth / 8);
>> +       }
>> +}
> 
> Wondering if we already have something like this in DRM/fbdev and can
> split into a generic helper.
> 
> ...
> 
>> +       ret = sscanf(device->options, "%u,%u,%u", &info.x, &info.y, &info.depth);
>> +       if (ret != 3)
>> +               return -ENODEV;
> 
> Don't we have some standard template of this, something like XxYxD,
> where X, Y, and D are respective decimal numbers?

I'm not aware of this.

> 

-Markuss
