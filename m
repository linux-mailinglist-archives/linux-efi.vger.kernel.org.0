Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02473D0817
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 07:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhGUE3H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 00:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232735AbhGUE2z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jul 2021 00:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626844169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+zWfy2tC40xUQfOhENAkA+DP5zrQupivowwlpIU07g=;
        b=OKvQMBfJdOMJzGla1xXeLHAtj4kHE/ygi2s72aJf/7lRxWF/gVycMHi7Wwj8MJKvAUnRBH
        47oeUp6V4Uheu25aj9ej3rvcFZMRke6yRQZm04PVlHVFORP7/TMlcvBJ5URYCWi1WSQjwb
        XdEA7jKEhWxophxmjn9EX0gKAE1LNk0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-y5kERe5OMvac2NeSUPHh_Q-1; Wed, 21 Jul 2021 01:09:27 -0400
X-MC-Unique: y5kERe5OMvac2NeSUPHh_Q-1
Received: by mail-wr1-f72.google.com with SMTP id y15-20020a5d614f0000b029013cd60e9baaso425167wrt.7
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 22:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S+zWfy2tC40xUQfOhENAkA+DP5zrQupivowwlpIU07g=;
        b=uP19jw9inSpUfSPaM8q9jmdtQ4SD6bvrXnUEhEPrhCnwt7FqjS5HiHqW6twenoWE1b
         4OtSZdeHgAt9yGThA3G1AQVCzPANldAJbWNDLTCm3etvm6hmFGLWkMnoo50INqdjwLqO
         Ukt2YxbiBMdOrFjIAoWJpseARPqB3x+CAOMhDzkrR4HGmI33b5Tx2o94MfEafSFEC6cY
         bJ03bcDerMQ+Dw01yj1diQ+IgS+Dv2QdoW6wzP7kUakTrsc8CP/NaHpgS8hgN/dohAdt
         ZXgk6nSyRH9NR2aqAAS6yCEyrbWvN5eEelDfhMLBVT6e/qMBGMZ1arrecP+vd1STbGMc
         VZtQ==
X-Gm-Message-State: AOAM531mFGHVpUoNcovrBtXbMS8XNlxFaIrZPNYxUg9zBwVruEbc8dmi
        XQ2SfWxpcSN7LYbjfEy33pgmfQiDp/rvdUNmbcTZflriVOz38eg4mpFWtZjYcm96YS4Xmuur9QY
        8KyLb8KosSm9q4KmiZN4S
X-Received: by 2002:a7b:c747:: with SMTP id w7mr2031958wmk.148.1626844166554;
        Tue, 20 Jul 2021 22:09:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCxXonukubT9gJL2Rc7x0XVeUSko96/DCQuDEhTryxASNBDgCxR12O8zMwgWe3dBuGqn9kQg==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr2031926wmk.148.1626844166269;
        Tue, 20 Jul 2021 22:09:26 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id k24sm26722409wrh.30.2021.07.20.22.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 22:09:25 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
 <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
 <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
 <YPbWrV/cIODdgu6A@phenom.ffwll.local>
 <37e05f02-b810-0cb1-cc4f-95711cd148d9@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <44a75f18-e3a6-f764-b0ec-ce3ac05805a9@redhat.com>
Date:   Wed, 21 Jul 2021 07:09:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <37e05f02-b810-0cb1-cc4f-95711cd148d9@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Thomas,

On 7/20/21 8:38 PM, Thomas Zimmermann wrote:
> Am 20.07.21 um 15:59 schrieb Daniel Vetter:
>> On Tue, Jul 20, 2021 at 03:42:45PM +0200, Javier Martinez Canillas wrote:
>>> On 7/20/21 3:01 PM, Daniel Vetter wrote:
>>>> On Mon, Jul 19, 2021 at 09:10:52AM +0200, Ard Biesheuvel wrote:
>>>>> On Mon, 19 Jul 2021 at 04:59, Dave Airlie <airlied@gmail.com> wrote:

[snip]

>>>>>> Can we just merge via drm-misc and make sure the acks are present and
>>>>>> I'll deal with the fallout if any.
>>>>>>
>>>>>
>>>>> Fine with me. Could you stick it on a separate branch so I can double
>>>>> check whether there are any issues wrt the EFI tree?
>>>>
>>>> It'll pop up in linux-next for integration testing or you can pick up the
>>>> patch here for test-merge if you want.
>>>>

This is what Daniel said...

>>>
>>> Thanks a lot Dave and Daniel!
>>
>> Oh I haven't merged them, I'm assuming Thomas will do that. Just figured
> 
> Can I simply put the patches in to drm-misc-next? There was some talk 
> about a topic branch?
>

... which AFAIU means that there's no need for a topic branch, since the
patches will be present in linux-next. And the EFI folks can use that to
check if there are any integration issues or regressions caused by these.
 
> Best regards
> Thomas
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

