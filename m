Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7952F0B7
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiETQcU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351655AbiETQcT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 12:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85975134E35
        for <linux-efi@vger.kernel.org>; Fri, 20 May 2022 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653064335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGJBElcZPrcyPm9iaZsEnyI0bOLSeVcTHjfVRje6MJg=;
        b=VvR56p1DMhvVIfBwTS5oLQV1WsAtsRxtrnHj5EejS52WRN5WRC6QPWOF38q521fLpuIZjX
        QpMKcGpT2kZFqPIKrHLaDaAhBdJSEBQdVM4Y0Oc8AxohXNq4mUBA3zQKNG4Hz8cJ/OA7bB
        j8tvkHVWFYFC+V7PedkLOCQCpjEzEHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-yt_GfhaIPLWNdhxVUQBlKw-1; Fri, 20 May 2022 12:32:14 -0400
X-MC-Unique: yt_GfhaIPLWNdhxVUQBlKw-1
Received: by mail-wm1-f72.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso3361832wma.1
        for <linux-efi@vger.kernel.org>; Fri, 20 May 2022 09:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FGJBElcZPrcyPm9iaZsEnyI0bOLSeVcTHjfVRje6MJg=;
        b=VTmhjNG1OK7p5mpmP9YnmWrAaUA4kQaeLtCfy39QNGo+f5ax+slbDPAm6ixfakR94j
         4cqiGduFGIOisefiBg29yQOVvwjnfWP9E/A8ETK25BPuWDNdasR0jIU7rJ3fvCewNfP7
         tVhLLjNIEtMSPXN3a7gyrNZ9pdiGw3BNAXJhTASrpQ5Vct3WniTNFfdQqEJEDQHyieR9
         gRzTqQzlhvhmjTuBvoFVJMz7PK87T4FR6oTOrh3YNF69FqZbq2NJ0VboYvuFwsNt1QEb
         rmLA7MhHRFpJWe+vLqseYHd851xTdchByegVB3NqJG4FDqcU7u1313MKJ+EWWOVRH5Go
         bGUA==
X-Gm-Message-State: AOAM531lAE3AHcMjpYe/QVP0aYjuJQMjAFupFay43GvfX/3aezWnwNc2
        mI5j3uiP6yVvA+WTf/N5G7eG18mA+WWOE7FXPAq4VrT0NxpRdyV0e9Tq3f8UchKzxIhwQq6cSP1
        s1Ejd9bNw57QGb+gC8Bw7
X-Received: by 2002:a5d:4988:0:b0:20d:9b8:e560 with SMTP id r8-20020a5d4988000000b0020d09b8e560mr9007672wrq.33.1653064333583;
        Fri, 20 May 2022 09:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGxw0Xn89Aa2qNKN8E38RWkK+y15l4x06OBHYokJ+KNOFPYErCxw/yS6hQL2c4SkQOKm3Qow==
X-Received: by 2002:a5d:4988:0:b0:20d:9b8:e560 with SMTP id r8-20020a5d4988000000b0020d09b8e560mr9007660wrq.33.1653064333363;
        Fri, 20 May 2022 09:32:13 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bce1a000000b003942a244f3fsm2669762wmc.24.2022.05.20.09.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:32:13 -0700 (PDT)
Message-ID: <256e0b82-5d0f-cf40-87c6-c2505d2a6d3b@redhat.com>
Date:   Fri, 20 May 2022 18:32:11 +0200
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAAhV-H7yKVWaiU_VKnc2YnCSeZPOwedRWMY8ZTS-VWwk+vE0AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/20/22 17:19, Huacai Chen wrote:
> Hi, Javier,

[snip]

>> Conversely, if the sysfb_init() is executed first then the platform device
>> will be registered and latter when the driver's init register the driver
>> this will match the already registered device.
> Yes, you are right, my consideration is too complex. The only real
> problem is a harmless error "efifb: a framebuffer is already
> registered" when both efifb and the native display driver are
> built-in.
>

But this shouldn't be a problem if you drop your register_gop_device() that
registers an "efi-framebuffer", since sysfb would either register a platform
device "simple-framebufer" or "efi-framebuffer", but never both. Those are
mutually exclusive.

I think what's happening now is that sysfb is registering a "simple-framebuffer"
but your register_gop_device() function is also registering an "efi-framebuffer".

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

