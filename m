Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7914E52FA66
	for <lists+linux-efi@lfdr.de>; Sat, 21 May 2022 11:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiEUJoH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 May 2022 05:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiEUJn7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 May 2022 05:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26EEF5D649
        for <linux-efi@vger.kernel.org>; Sat, 21 May 2022 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653126238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQakkrlXQRKntd0RRpdtvvmaPsTow/BNKvunF/X2S4o=;
        b=Drs+euNcA9RhCcViZLBlKNLhg0oRcZm6yLx8wth9kUO2xZZZJVQ2s5D5NlFL5RbnCB8R9g
        Pc0bVmM2w93QDd3fFZv8DtuJOmtMphvCsoadbdh/IVxXBXZllX/vTa5wLo7asfZojP6nBY
        0nibLRg9yXGS8y/mJSBSCNsAt6fv7VI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-ADAgTNh-OGCGoaWmu8Vp5A-1; Sat, 21 May 2022 05:43:51 -0400
X-MC-Unique: ADAgTNh-OGCGoaWmu8Vp5A-1
Received: by mail-wm1-f72.google.com with SMTP id i64-20020a1c3b43000000b00397330faf1dso3211165wma.0
        for <linux-efi@vger.kernel.org>; Sat, 21 May 2022 02:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dQakkrlXQRKntd0RRpdtvvmaPsTow/BNKvunF/X2S4o=;
        b=xG5Zd1IEozg9Q8C03z2kCy9ThhD8YvXkExcUsqz6MNfwoxs44C4P9NOpNJBSjuJp0A
         BDRRzBqLHb2M3WWaPA7plgzUlqQpRvGNGwpKwO26SIJ1sNLx8U3P/wDQgILK6P5BKnHS
         D90JMS58IVjUna14bxB8D3JRytvVucPnw5jYkfJQfs8TlaLcXDqhrvjmnmgEG2Cr2AGN
         zfp3GkgbkqwnLHNBSRyyddBsGqJUxF2JMejTOxwRSpHy+dJ2yqRTszikzCkd/CEguMqX
         j6il2ydP1UJzHuaVK+5jf6nZqN88nsP7iYgy5r/3UA1gfjQzQFsa5yYNj0AledXixPnd
         i8ug==
X-Gm-Message-State: AOAM532fhpAu0dAd0z9J8GbzDWTXXyUMB/L/LN3CKH2dq0UBbyBoNyQI
        83q6a5FbF6VyXS4PjKPcUG9kq59Kkc5Y1NcC/y/Pn75DTaYBOSyk+1lEsaDxrLGPJm+2/ywIwo/
        xG1GHgfLtu5PCvUxArq9h
X-Received: by 2002:a05:6000:144e:b0:20e:6719:c376 with SMTP id v14-20020a056000144e00b0020e6719c376mr11371518wrx.715.1653126230196;
        Sat, 21 May 2022 02:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNY4l0J3NU0fU5ldjpTVsJKjUF0HOYrRkkJ7veXmwkg/db0qArtoiGUueey/Ksa0YlGIw9oQ==
X-Received: by 2002:a05:6000:144e:b0:20e:6719:c376 with SMTP id v14-20020a056000144e00b0020e6719c376mr11371508wrx.715.1653126229992;
        Sat, 21 May 2022 02:43:49 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d21-20020adf9b95000000b0020d06e7c16fsm4529325wrc.84.2022.05.21.02.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 02:43:49 -0700 (PDT)
Message-ID: <20bde9a2-592d-30a8-8cdc-03bdf1bf3e93@redhat.com>
Date:   Sat, 21 May 2022 11:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V11 09/22] LoongArch: Add boot and setup routines
Content-Language: en-US
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn>
 <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
 <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com>
 <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
 <cdbb002a-9f0a-caa9-445e-4ba20328171a@redhat.com>
 <CAAhV-H7yKVWaiU_VKnc2YnCSeZPOwedRWMY8ZTS-VWwk+vE0AA@mail.gmail.com>
 <256e0b82-5d0f-cf40-87c6-c2505d2a6d3b@redhat.com>
 <CAAhV-H7bJv5V5UKJCWgEbOdOWZhnma3_3eAXbbY1MX_uKodjgg@mail.gmail.com>
 <859d5489-9361-3db0-1da4-1417ed2fad6c@redhat.com>
 <CAAhV-H4UxkyHr=NQGFAAjCXwXHXDLsN_CV-tSCn6oonOSSjb0A@mail.gmail.com>
 <7caec251-20e7-4a8c-93ee-b28558ec580f@redhat.com>
 <CAAhV-H6pfv4OQ5PhSfzG9YM_q5DYdgZ0DHVT7Aac9sppXGgnaA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAAhV-H6pfv4OQ5PhSfzG9YM_q5DYdgZ0DHVT7Aac9sppXGgnaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Huacai,

On 5/21/22 11:13, Huacai Chen wrote:
> Hi, Javier,
> 
> On Sat, May 21, 2022 at 5:06 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Hello Huacai,
>>
>> On 5/21/22 09:37, Huacai Chen wrote:
>>
>> [snip]
>>
>>>>
>>>> A problem with moving to subsys_initcall_sync() is that this will delay
>>>> more when a display is available in the system, and just to cope up with
>>>> a corner case (as mentioned the common case is native drivers as module).
>>> OK, your method seems better, but I think moving to
>>> subsys_initcall_sync() can make the screen display as early as
>>> possible.
>>>
>>
>> But it doesn't cover all cases. For example, you will get the same error
>> if for example your native driver is built-in and efifb built as module.
>>
>> So my opinion is that instead of playing with the init call levels, is
>> just better for you to build your native driver as a module instead of
>> making it built-in.
> I mean moving to subsys_initcall_sync() on top of your patchset, not
> replacing them (Just for display earlier).
>

Ah, I see what you mean. Yes, that makes sense indeed.

Feel free to post a patch proposing that. If you do, please also include
Thomas Zimmermann <tzimmermann@suse.de> to the Cc list. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

