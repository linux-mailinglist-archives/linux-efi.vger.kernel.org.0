Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1156458426E
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiG1O6b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiG1O61 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:58:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80B10F3;
        Thu, 28 Jul 2022 07:58:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf4so3625945ejc.3;
        Thu, 28 Jul 2022 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tTSXNaw/6JZLwn2P0PGnuQ0WLB4Qu3elZxHzblM8fpU=;
        b=c1vY1amK3SSb5Sk378Tzj2r3I4dfUYqRyR9XZ9mgTFi9sNzZ23GuRdYijNYiu2eX53
         fdsboL/PunLjY5acbyZT/0UEAs/liP15aCEuppzTzwjXwLcsMMG5jUeuBECGpO9nnuUX
         zXpoNt5vlZnf/4pVrX/7785OC8FVRcxwc0TqmFIbS3cqjDUejPDzp/8oEdwWPd363GbD
         0+UmnBhekSdZkddQnF1bwWpmJ7EQAIdBvhqlsKgwl01vpePNvsgcCfHirsTZTdhj3Ady
         NAWy/pA/+lGohtpaER7TXv1dWORYSk4JeTwNjJx2pzEAFaZ8Yj+Nqowj9RPJbPa7Qiaw
         HazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tTSXNaw/6JZLwn2P0PGnuQ0WLB4Qu3elZxHzblM8fpU=;
        b=s6F7Zmp294qtsm2h1ZfBixL4+zzDGEz1JY0mIur2HPLg1I9onFMreYl0u5Ni1/mdwb
         nxPa+ejm2WfYkiWg0dnHp9fMhxkcCIpmS4/BpjAfUYp4VYM9rCbijyqYc/qoZuZjUJkP
         osz/4LxEcv/HJ4Dio13nkCZDWzbp9hWp17UcALJh3Dc17+l/vREGccUB1lTeLXLvS2uy
         qknuLzb9GXuR5iaQpmpEme0xQ2elVPkxtFrKCISFXbQyKXQ/lyQ+vX3byOzK63hGfWJm
         E4SgOm+o7DsR+r5hQee9ejn9bcLF1U/6OgvkN5xdCxImVrzZEFLE7JHPMPF8VTMQBLdO
         3C+Q==
X-Gm-Message-State: AJIora8hC0YE7FZ7FNksR2RxDtVIytXmvgSZ00X2H5f8GLzM1TBdfuNv
        cUai5ke/A3Wp4emKcO1DHqM=
X-Google-Smtp-Source: AGRyM1upxJMWgGwceVicP+qb2cN5gr+enz0dwc0rY8PAmdQ62kOzzpZJEXUWQxNPjQhxhTMGjnE7kA==
X-Received: by 2002:a17:907:6818:b0:72b:5bac:c3a3 with SMTP id qz24-20020a170907681800b0072b5bacc3a3mr20623516ejc.139.1659020301357;
        Thu, 28 Jul 2022 07:58:21 -0700 (PDT)
Received: from [0.0.0.0] (tor-exit-60.for-privacy.net. [185.220.101.60])
        by smtp.gmail.com with ESMTPSA id cq3-20020a056402220300b0043bc300c499sm827109edb.79.2022.07.28.07.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:58:21 -0700 (PDT)
Message-ID: <8e694cb6-c3dc-74e3-6804-fc532f108523@gmail.com>
Date:   Thu, 28 Jul 2022 17:57:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
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
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com>
 <CAK8P3a2fZ9O6vSEyxY1KW71pG_Oyvwxp3zTbW2GuaSD6aj+Qfw@mail.gmail.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CAK8P3a2fZ9O6vSEyxY1KW71pG_Oyvwxp3zTbW2GuaSD6aj+Qfw@mail.gmail.com>
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

Hi Arnd,

On 7/28/22 17:48, Arnd Bergmann wrote:
> On Thu, Jul 28, 2022 at 4:28 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>>
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
> 
> It looks like this is not actually related to fbdev, and since drivers are
> moving from fbdev/simplefb towards drm/simpledrm, maybe it would be
> better to put this into either drivers/gpu/drm/tiny/ or possibly
> drivers/video/console to let this be used without enabling fbdev?

Ideally this shouldn't depend on anything, because it isn't utilizing 
any of fbdev code and won't be utilizing any of drm/console code. I 
agree that either of those would be a better place for it, but which one 
do you think would suit more for this driver?

> 
>          Arnd

- Markuss
