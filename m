Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0352FA2B
	for <lists+linux-efi@lfdr.de>; Sat, 21 May 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbiEUJGa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 May 2022 05:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiEUJG3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 May 2022 05:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B999C3DDEE
        for <linux-efi@vger.kernel.org>; Sat, 21 May 2022 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653123986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9LHz14wFa2/WI+cnfgVklfc1muOyIoWusP/XZeOz08=;
        b=Mq8xHTn92c1YO2I8aPgP2FBk6nAkCDJ1BJA3VpUAbxDP+k3nMdkqWYYFdImy1KDoc9GBWv
        sdhjFB67YBwaDd8MnoNbrr/pfQsgCLYG+VsY8LvuJ9IZW7KE77uEedrWgze7TvCcHR3/Yz
        po9Rxe3DNoi/U4AyoHAosWPb8PwqWBA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-_gXW3NQdMUut19lU4wggcw-1; Sat, 21 May 2022 05:06:24 -0400
X-MC-Unique: _gXW3NQdMUut19lU4wggcw-1
Received: by mail-wm1-f71.google.com with SMTP id r11-20020a1c440b000000b00397335edc7dso2826367wma.7
        for <linux-efi@vger.kernel.org>; Sat, 21 May 2022 02:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e9LHz14wFa2/WI+cnfgVklfc1muOyIoWusP/XZeOz08=;
        b=56Q+rb8HJbvzLIV5o72rJz/DJPyK5VeIHrlJmL2LTSwxAuyg4kCmPlhW9sTk3eQxWH
         RFVXZLulVDAOeItz+m3rD8Clr67xxnMKLODP5dKzsg5sDR9d7sq7orfFauMqUiNJi9sU
         yNrxUAvPwsvrv6SBYOEbKaXdCxkqL4/Yxr9CgZD1j/zzLcJyF1GTRtNqkmJ/TK3l23zJ
         FLmHOAb7PwCFUq+O27sL8tEN6nBqVh7ogp2VCkhmTAWKjE62UCj2qxZ/ym06aradOlTH
         wfLJcAdXajkQQp/5hSCgCF/jgnL/9QFIx76YFNSYWw2d8t38/VaXd6b+f2g4MLCDqBmt
         9fCg==
X-Gm-Message-State: AOAM533rPSB6mCf7AyN8l3wx7q7pltKlUGW/oG5vlI/s1OUVbQ0Yj5Ea
        7tZhkDtwx34Ad3NXZPo3fp0VPYudDGP8q8QsJBwNY16RH7n0OHdvGtw+zVUIuQOotZv0+9K+4Wu
        iOjvEZqkTkOkAqUm2j/Q2
X-Received: by 2002:a05:600c:1986:b0:394:867f:984c with SMTP id t6-20020a05600c198600b00394867f984cmr12146583wmq.20.1653123983675;
        Sat, 21 May 2022 02:06:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTeDbWSfdAJKkl4YczGM0UAl7TEZvciQfkOJv5cOIeHM43M+qHKKLXGP9/j3dj+RKra7iq3w==
X-Received: by 2002:a05:600c:1986:b0:394:867f:984c with SMTP id t6-20020a05600c198600b00394867f984cmr12146563wmq.20.1653123983458;
        Sat, 21 May 2022 02:06:23 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z13-20020a7bc7cd000000b0039456fb80b3sm3750711wmk.43.2022.05.21.02.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 02:06:23 -0700 (PDT)
Message-ID: <7caec251-20e7-4a8c-93ee-b28558ec580f@redhat.com>
Date:   Sat, 21 May 2022 11:06:21 +0200
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAAhV-H4UxkyHr=NQGFAAjCXwXHXDLsN_CV-tSCn6oonOSSjb0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Huacai,

On 5/21/22 09:37, Huacai Chen wrote:

[snip]

>>
>> A problem with moving to subsys_initcall_sync() is that this will delay
>> more when a display is available in the system, and just to cope up with
>> a corner case (as mentioned the common case is native drivers as module).
> OK, your method seems better, but I think moving to
> subsys_initcall_sync() can make the screen display as early as
> possible.
>

But it doesn't cover all cases. For example, you will get the same error
if for example your native driver is built-in and efifb built as module.
 
So my opinion is that instead of playing with the init call levels, is
just better for you to build your native driver as a module instead of
making it built-in.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

