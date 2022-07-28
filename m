Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B36584230
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiG1OwO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiG1OwM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:52:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE915D0C0;
        Thu, 28 Jul 2022 07:52:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so1545108wrp.0;
        Thu, 28 Jul 2022 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mD3MJdwe1M/MeC+R1sdMr+F5YiHskPdcW+5CKgvwmK4=;
        b=iUGg/CrWW+MiUyA/mg1p5vzybXCg3jUouFcnlHWaVGqFxrhWwizVOpH2IkQW7szJma
         iOC8pfSoe7ZZfKyDF4gvUHQ1mUov9IdU4wV/+Mk1J7/6KN37cdUlC+pfFtyERNyzfFQj
         XuXVRdDr902PQSnkrr2MmHMUyQOnyMt+G6aCUtLTlLNZevb2z6wAE/CSG6KVdMXRmpm8
         ED78UkYZK4M8/tXowcNICLq+pGO/J8ezajSuCEvi2D0KxuSH13LKj59MYbAgyvHaYjcX
         0YwhkT39e7Dt+m1ZkNZv8VMP/qameaFdsVlmPPWo0SK5lvvQBzhpDyw+irGhUosn662C
         rCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mD3MJdwe1M/MeC+R1sdMr+F5YiHskPdcW+5CKgvwmK4=;
        b=bkvfragGHb5C/unm0I+wN/tyBhvCcqwbl0jfWiFoVDwJKnOTmtvN8jNS3B2ZWPUQBK
         coQUcnzK+lM00aoFM/4YdOqNInaIZ3YKxbjlfW3q/VeXQIXaCm+YpcDmwaRDEsrS00Ay
         RrY+ALc+psF+YKibTNOURFfcmLJGoA1+jbMLLByM5mEqG038WExtK7wZkGzGBhWRR+8+
         tYLjv3rUO/ZlsrmVc7w+q1gsz68bCSRv+LmJQtFYl6S0Z7CpcBjyoD7Xx2Yi1TgI/+Zt
         LZOKgEtRsv4rxdZEfOljRUEuV12S64rgsajdMZFvatLfcHc6gir8vidqVku6CaT9CWxS
         fFSw==
X-Gm-Message-State: AJIora/GtUbQecyp0m4dfE6gsfvP2JboJx5qU2HzWBHWGSdmJfm9qQ/6
        gJWb4v0LsGTQfov6hS48h2c=
X-Google-Smtp-Source: AGRyM1sGc5o3vzAllmoqiOc4kg6oAhY9pYH2gIOcTuw0tQ66DwxqCUNnE+4m3BL7R0boMJmgLYXsBg==
X-Received: by 2002:a05:6000:1f0e:b0:21e:87c9:6b55 with SMTP id bv14-20020a0560001f0e00b0021e87c96b55mr13834716wrb.326.1659019929483;
        Thu, 28 Jul 2022 07:52:09 -0700 (PDT)
Received: from [0.0.0.0] ([185.246.188.60])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b0021d7b41255esm1122958wrr.98.2022.07.28.07.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:52:09 -0700 (PDT)
Message-ID: <30ce6f21-0a91-81cb-8b03-5acff17c59ee@gmail.com>
Date:   Thu, 28 Jul 2022 17:52:04 +0300
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
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <YuKfnAjB4gV0ki4A@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Greg,

On 7/28/22 17:39, Greg Kroah-Hartman wrote:
> On Thu, Jul 28, 2022 at 05:28:19PM +0300, Markuss Broks wrote:
>> Add early console support for generic linear framebuffer devices.
>> This driver supports probing from cmdline early parameters
>> or from the device-tree using information in simple-framebuffer node.
>> The EFI functionality should be retained in whole.
>> The driver was disabled on ARM because of a bug in early_ioremap
>> implementation on ARM.
>>
>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  12 +-
>>   MAINTAINERS                                   |   5 +
>>   drivers/firmware/efi/Kconfig                  |   6 +-
>>   drivers/firmware/efi/Makefile                 |   1 -
>>   drivers/firmware/efi/earlycon.c               | 246 --------------
>>   drivers/video/fbdev/Kconfig                   |  11 +
>>   drivers/video/fbdev/Makefile                  |   1 +
>>   drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
>>   8 files changed, 327 insertions(+), 256 deletions(-)
>>   delete mode 100644 drivers/firmware/efi/earlycon.c
>>   create mode 100644 drivers/video/fbdev/earlycon.c
> 
> That should be a rename, not a delete/create, right?

Should this change be split into two separate commits,
one for moving the file and the second for making changes?

> 
> thanks,
> 
> greg k-h

- Markuss
