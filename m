Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC116551BB
	for <lists+linux-efi@lfdr.de>; Fri, 23 Dec 2022 15:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiLWO6i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Dec 2022 09:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiLWO6h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Dec 2022 09:58:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A11A049;
        Fri, 23 Dec 2022 06:58:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h7so4799688wrs.6;
        Fri, 23 Dec 2022 06:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmvBHq2/9NF220RtIhTYhX1TAkXINfaY4qHf9+DiZSU=;
        b=cftQtPSbMb3WwKxw9PnrrQxoONvByrVntLcAFFx/eodAs43YCS919XO0m6wNvkCcsk
         h3pa6qid4EGkMCDJakXQNYixl8jrufFqwl/MCoUkW/IHOoBmEGC2+eTn54M6THDDoDe/
         Glj9Imo1J4OpXPz8Kz53mXkG1nXtySIN25bMK2NiVJ//e8IoTofq2ekQjQakBqrFkmaX
         twXIVKjk+4NtAHnpRsg6knp7BJE8pNV+nHMvio/1d47YiKkaEWZiyVt/e6vs8URghTE7
         CHxEv3OCWNwii8NAPQUChs25eTEhqkAWMbbetLL00qyPbcqpbC2lHxqOcCBcB1XvGJCB
         pvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmvBHq2/9NF220RtIhTYhX1TAkXINfaY4qHf9+DiZSU=;
        b=Y5GZNmRuAYFJd21fsHXinZ4V6NJfFBP3qNZnnsJrt1hcDCN/1n+dcyy/b8uGmL1UTt
         wjBe9L6MnCww72VMtGFi0HNDRkcZTiZz5zJ9Z/4m1V2NDVqiGfM+VUiwc0srhQXtldUd
         5sMhm91FhhdhQ/timBWvGGrkyUjravb7h6KIUev0on9Mu2RPH7yjQKUb74vXQAk68tPc
         gzYdFL2CZwl3TpbYe/dk6/JFMUwo/XOEJCZWmlTf0KFwYqBC68V3g/Yaw9ZNXHXzNdZX
         Rky7XAq3FdaEUndtWkumpGXhFI7kuOO4PyZCjLxqdQbpxnVFxoBBPCohP6SAN4hQLoKB
         808Q==
X-Gm-Message-State: AFqh2kpbEcO+e8wYtqAjsXwljwtfLat16rkMYm4MpwzKVDIsUaTl+dGX
        l7MfwpN00rKG7dS6IWQR9kU=
X-Google-Smtp-Source: AMrXdXsyxBxdUeqfa/v6cGXhdhmkoJoLysIKux7E0NzZ4vrTQekRoxK2ddB8vZnleXLB1EmWuFZ07g==
X-Received: by 2002:a5d:5606:0:b0:242:5ae0:5b38 with SMTP id l6-20020a5d5606000000b002425ae05b38mr5422529wrv.8.1671807514712;
        Fri, 23 Dec 2022 06:58:34 -0800 (PST)
Received: from [192.168.1.16] ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d468d000000b00275970a85f4sm823864wrq.74.2022.12.23.06.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 06:58:34 -0800 (PST)
Message-ID: <97639381-2558-4cf5-75b0-7f80f0393b16@gmail.com>
Date:   Fri, 23 Dec 2022 16:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/3] Add generic framebuffer support to EFI earlycon
 driver
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Jami Kettunen <jami.kettunen@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221221105402.6598-1-markuss.broks@gmail.com>
 <CAMj1kXGUC7dsSwVEUsAMeAoqDYtbqrM7SDOJTXbPfi-LrcSk9g@mail.gmail.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CAMj1kXGUC7dsSwVEUsAMeAoqDYtbqrM7SDOJTXbPfi-LrcSk9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On 12/23/22 16:42, Ard Biesheuvel wrote:
> (cc Andy)
>
>
> On Wed, 21 Dec 2022 at 11:54, Markuss Broks <markuss.broks@gmail.com> wrote:
>> Make the EFI earlycon driver be suitable for any linear framebuffers.
>> This should be helpful for early porting of boards with no other means of
>> output, like smartphones/tablets. There seems to be an issue with early_ioremap
>> function on ARM32, but I am unable to find the exact cause. It appears the mappings
>> returned by it are somehow incorrect, thus the driver is disabled on ARM.
> The reason that this driver is disabled on ARM is because the struct
> screen_info is not populated early enough, as it is retrieved from a
> UEFI configuration table.

I believe I must be hitting some other bug then, since my driver should 
not use `struct screen_info` when the arguments are specified manually 
(e.g. in device-tree or in kernel command line options), and it still is 
broken on ARM when they are. I got it to work on ARM when I moved the 
early console initialization later into the kernel booting process, but 
that mostly defeats the purpose of early console driver, I believe. I've 
been thinking that it could be some stuff not getting initialized early 
enough indeed, but I've got no clue what could it be.

>
> early_ioremap() works fine on ARM as long as they mapping is torn down
> before paging_init()
>
>> EFI early
>> console was disabled on IA64 previously because of missing early_memremap_prot,
>> and this is inherited to this driver.
>>
>> This patch also changes
> "This patch also changes ..." is usually a strong hint to self that
> the patches need to be split up.
>
>> behavior on EFI systems, by selecting the mapping type
>> based on if the framebuffer region intersects with system RAM. If it does, it's
>> common sense that it should be in RAM as a whole, and so the system RAM mapping is
>> used. It was tested to be working on my PC (Intel Z490 platform), as well as several
>> ARM64 boards (Samsung Galaxy S9 (Exynos), iPad Air 2, Xiaomi Mi Pad 4, ...).
>>
>> Markuss Broks (2):
>>    drivers: serial: earlycon: Pass device-tree node
>>    efi: earlycon: Add support for generic framebuffers and move to fbdev
>>      subsystem
>>
>>
>> v1 -> v2:
>>
>> - a new patch correcting serial/earlycon.c argument name to "offset" instead
>>    of "node"
>> - move IA64 exclusion from EFI earlycon Kconfig to earlycon driver Kconfig
>>    (IA64 has no early_memremap_prot)
>> - move driver from fbdev to console subsystem
>> - select EFI earlycon by default
>> - fetch stride manually from device-tree, as on some devices it seems stride
>>    doesn't match the horizontal resolution * bpp.
>> - use saner format (e.g. 1920x1080x32 instead of 1920,1080,32).
>>
>>
>> Markuss Broks (3):
>>    drivers: serial: earlycon: Pass device-tree node
>>    efi: earlycon: move to video/console to prepare for changes
>>    efi: earlycon: Add support for generic framebuffers
>>
>>   .../admin-guide/kernel-parameters.txt         |  12 +-
>>   MAINTAINERS                                   |   5 +
>>   drivers/firmware/efi/Kconfig                  |   7 +-
>>   drivers/firmware/efi/Makefile                 |   1 -
>>   drivers/firmware/efi/earlycon.c               | 246 --------------
>>   drivers/tty/serial/earlycon.c                 |   3 +
>>   drivers/video/console/Kconfig                 |  11 +
>>   drivers/video/console/Makefile                |   1 +
>>   drivers/video/console/earlycon.c              | 305 ++++++++++++++++++
>>   include/linux/serial_core.h                   |   1 +
>>   10 files changed, 336 insertions(+), 256 deletions(-)
>>   delete mode 100644 drivers/firmware/efi/earlycon.c
>>   create mode 100644 drivers/video/console/earlycon.c
>>
>> --
>> 2.39.0
>>
- Markuss


P.S. Just noticed I forgot to Ctrl^S the cover letter before saving... 
The main change v3 does is separate the moving action and edit action 
into two separate commits, I don't think there're more major changes. 
With v4 I'd try to attach the proper version log.

