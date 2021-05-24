Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B538E49D
	for <lists+linux-efi@lfdr.de>; Mon, 24 May 2021 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhEXKyY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 May 2021 06:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232513AbhEXKyX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 May 2021 06:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621853575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFtn2RHOEYss0CsLYkuce8tbA8oq7IWTJChBbEjpcfU=;
        b=FmxiKnjoxDtH4t1ypWkogl7Q/osBEvsedoq5oRAHfUTQ4Ru5ztR+S5vvO8kTrOBhcb36Ox
        wncHFzFaiol/1O2RLIJCmuUowLS5EV0JZkfzRmh9eyJv/4A8Otg2QK02nCQ0c1uPAQgp7O
        SPOkgh4taEzzgG25DevunLyslweYr5U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-0SMJKVPqOFa3-qeTi19hVA-1; Mon, 24 May 2021 06:52:53 -0400
X-MC-Unique: 0SMJKVPqOFa3-qeTi19hVA-1
Received: by mail-wr1-f70.google.com with SMTP id 22-20020adf82960000b02901115ae2f734so12930076wrc.5
        for <linux-efi@vger.kernel.org>; Mon, 24 May 2021 03:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFtn2RHOEYss0CsLYkuce8tbA8oq7IWTJChBbEjpcfU=;
        b=I0PIYyfg1LgccWlkKrKaWv3KF1Bal2/xf5Q4uy58tPzqpuyWqQiaAVSHFFrLZSq8/a
         e5ImyIL3nYp0GrAUAbjk8+IwYo7TlL6hNE4w46NPsnHDLThn1hIrsFMyD1yMP3yrGfym
         We7JUPcsrMKRaPWeuapmznwREAX2wdw3EqEY6Q3kfjF5jw9gIKmrF+IF/5MNKtzHP8RF
         vwk6GKOC9OIOlsLn/+b/FOwzUbt9KbRYpEhLU9zc+JBuPbRCCC78VAOlFbMWb1ywxWCx
         c3ztQ36KtezLInGd/+5cwpPK62yGrZ8Q52Vpr8wKQ/vRWCtAyv0A19RhXJ9pFBSnR+KR
         GMmw==
X-Gm-Message-State: AOAM530FgE8rYIlb5oIrs3oSRDGkVtLZa9A096LRpnOmObjZv9gLJuyD
        z/bfPz4EV9sB9xZ7tWh7S36iAuKNwFm1MfYMOflJ3UB2WOwayrW2+RoQ7jC1CjYPyPwthylJ58D
        2kfkB9ZORVDG8eo5pJnIa
X-Received: by 2002:adf:cd0b:: with SMTP id w11mr20622274wrm.178.1621853572523;
        Mon, 24 May 2021 03:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBBAfkXTMs2YQFUS4bUXgvPMEgtCieGtjpbUoBA1QSYRX/jn26s0lewHHOil8Ex/lxYcBBJg==
X-Received: by 2002:adf:cd0b:: with SMTP id w11mr20622252wrm.178.1621853572312;
        Mon, 24 May 2021 03:52:52 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id r11sm11966441wrp.46.2021.05.24.03.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 03:52:51 -0700 (PDT)
Subject: Re: [PATCH 0/2] allow the sysfb support to be used in non-x86 arches
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20210521192907.3040644-1-javierm@redhat.com>
 <CAMj1kXGrDm5yN5eRZJ0YAjCde=0Xw7hobC9Oz5CNovo0sWuM+g@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <0613bc6b-31b4-93f6-b111-4692778f76c0@redhat.com>
Date:   Mon, 24 May 2021 12:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGrDm5yN5eRZJ0YAjCde=0Xw7hobC9Oz5CNovo0sWuM+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard,

On 5/24/21 12:24 PM, Ard Biesheuvel wrote:

[snip]

>> Since this touches both arch/{x86,arm,arm64,riscv} and drivers/firmware, I
>> don't know how it should be merged. But I didn't find a way to split these.
>>
> 
> We could merge this via the EFI tree without too much risk of
> conflicts, I think.
>

Great, thanks.
 
> However, I'd like to see a better explanation of why this is an improvement.
> The diffstat does not show a huge net win, and it does not enable
> anything we didn't already have before, right?
> 
> 

I mentioned a little in the cover letter but you are correct that wasn't that
clear. My motivation was to use the simpledrm driver instead of efifb for the
early console, so I could boot without using fbdev at all.

The register_gop_device() in drivers/firmware/efi/efi-init.c only register an
"efi-frambuffer" platform device, which means that it will only allow to use
the efifb driver for the early framebuffer on EFI systems.
 
The "simple-framebuffer" platform device is only registered by OF if there's
a DT node with this compatible string, but it won't be registered for EFI.
 
So the simplefb or newly added simpledrm driver won't be matched and probed
with the current EFI support in aarch64 or riscv. In contrast, the x86 code
does register a "simple-framebuffer" device that uses the GOP framebuffer.
 
One option is to add the same logic in register_gop_device(), but that would
require even more code duplication. Another option would be to make the simple
drivers to match against "efi-framebuffer", but that would be an ugly solution.
 
But even without taking the lack of "simple-framebuffer" into account, I wonder
what would be the benefit of keeping two code paths that do basically the same.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

