Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B83129FAD
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLXJ3K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 04:29:10 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55809 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLXJ3K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Dec 2019 04:29:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so953923pjz.5
        for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2019 01:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=czDSzqRLBl5n27fwGhJOgwg3DRE7XOzxOBSe9aRwXXU=;
        b=vtOXVmNlTAUtjBpp6zjS6adZhPsvc/Ggndc6rb2Sokir8uFUUmPmWnQ1rUGtXNATvf
         ulOBc1VMA/hhzrXURLhHZjrClavBpphnDKAx6zED3ukA5DhtslQGPcVPL6ehEoe8k/J5
         Kcw2f0OGj+DYW80M93ZEXEhnxDbRtgrcd1Lh366mTDZ2cWkar4zDq/ckpNgDVKh2Ifse
         yILVzImDoSOq60jkjBjnvbQ6ydkD8n6PqGYmQ43oMCAYRVpkKyRNcZ2R5Wq+bJHa4dbA
         YoFMSji6Q7tUSbOLgoKWuvInl1T6ccd6lHPbYK173M3rAh5l1HI8PJ/DCy1Zz0SCzFM5
         vaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=czDSzqRLBl5n27fwGhJOgwg3DRE7XOzxOBSe9aRwXXU=;
        b=OfJ6h4h0iY8ucLT9j0GPs1ik9HLCW5HSJS6ZVAndlGDisz1uHtBL99XzbmSJ55yTbo
         yWjaVIeNk9VOwdzkhDxbjuqvF6dnerljwnxRLB0oSAii67kf2/S1AE5VNb/QpMtztxMg
         Yp58KQ27hSpJ/qFM1UxmgUdspljv7c7DGyjqW3nWGfSI28D7CX4r4dY1f6V+FzyTwxTb
         6C5TqAhTaL0hxdiH1kUlnnsKTapujYnsCHsF0i9nJhzmzt/9+BKjjSn1/xIzOXctZ1oB
         +EHShr21ZoLcPh8sCm3ST5UXcms79ADrLJrBWQB0BEm0gE1wJZlbIJQo5w40Xuqg7YCT
         ifKw==
X-Gm-Message-State: APjAAAUPZqlAIbo0DVDSsF7tudOAYdZ//aOkrKvMZxsXxjnoYMxSAQyZ
        cnsXCLyB1lu+QSGQrPmz7mPODQ==
X-Google-Smtp-Source: APXvYqzeVMR04c83xjEk0INwIcKZ7LC5zSzIHoqTUhvXOzbbNz4jVdhoaJ8/lMoq1ZdDYKlzuIN1Lw==
X-Received: by 2002:a17:90a:d783:: with SMTP id z3mr4519562pju.3.1577179749639;
        Tue, 24 Dec 2019 01:29:09 -0800 (PST)
Received: from [25.170.196.173] ([172.58.27.144])
        by smtp.gmail.com with ESMTPSA id g9sm28318857pfm.150.2019.12.24.01.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 01:29:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/efistub: disable paging at mixed mode entry
Date:   Tue, 24 Dec 2019 17:29:04 +0800
Message-Id: <61D1B491-EB08-40CA-9967-8A4F8DFE2826@amacapital.net>
References: <CAKv+Gu-v5jbD+62FKGXojU2ERp0tOpE6MSvUH+zpMu5rX-TJMw@mail.gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, X86 ML <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
In-Reply-To: <CAKv+Gu-v5jbD+62FKGXojU2ERp0tOpE6MSvUH+zpMu5rX-TJMw@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 24, 2019, at 3:50 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> =EF=BB=BFOn Tue, 24 Dec 2019 at 08:47, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>>=20
>>=20
>>=20
>>>> On Dec 24, 2019, at 3:38 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
>>>=20
>>> =EF=BB=BFOn Tue, 24 Dec 2019 at 03:15, Andy Lutomirski <luto@amacapital.=
net> wrote:
>>>>=20
>>>>> On Mon, Dec 23, 2019 at 7:23 AM Ard Biesheuvel <ardb@kernel.org> wrote=
:
>>>>>=20
>>>>> The EFI mixed mode entry code goes through the ordinary startup_32()
>>>>> routine before jumping into the kernel's EFI boot code in 64-bit
>>>>> mode. The 32-bit startup code must be entered with paging disabled,
>>>>> but this is not documented as a requirement for the EFI handover
>>>>> protocol, and so we should disable paging explicitly when entering
>>>>> the kernel from 32-bit EFI firmware.
>>>>=20
>>>> Does this mean that EFI is allowed to call the kernel with paging on
>>>> but the text identity-mapped?
>>>=20
>>> Yes. This is explicitly mentioned in the spec. Paging may be on or
>>> off, but all memory must be mapped 1:1
>>>=20
>>>> Have you seen this happen in practice?
>>>>=20
>>>=20
>>> Yes. GRUB and OVMF both implement the EFI handover protocol, but OVMF
>>> doesn't disable paging before calling the 32-bit entry point, and so
>>> it explodes in startup_32(). GRUB calls the EFI handover entrypoint
>>> with paging disabled, and so then everything works fine.
>>>=20
>>>> If the kernel is entered with paging on and the text not
>>>> identity-mapped, this is going to blow up badly.
>>>>=20
>>>=20
>>> Not just text: all of system memory is guaranteed to be 1:1 mapped if
>>> paging is on when entering the kernel from EFI, so this should be
>>> safe.
>>> Note that this change only affects mixed mode configurations that use
>>> OVMF instead of GRUB.
>>>=20
>>> We are using OVMF/qemu in kernelCI for test coverage of the EFI stub
>>> for all architectures, and this is the missing puzzle piece to get it
>>> working in x86 mixed mode as well.
>>=20
>> Sounds good to me, then.
>>=20
>> I admit to being a bit confused, since I would have sworn that I=E2=80=99=
ve personally tested mixed mode with OVMF.
>=20
> Interesting that you should say that. I thought exactly the same, but
> after noticing that it didn't work, I went back years testing old
> kernels and old builds of OVMF, and no combination that I tried would
> actually work without a change like the one in this patch. This is
> using both KVM and emulation, so it doesn't seem likely that this is
> caused by a change in QEMU.

It would have been a build from Red Hat or Fedora, possibly a prerelease I g=
ot from Peter Jones. And I reproduced a severe bug in the kernel that I had f=
ound by inspection, so it wasn=E2=80=99t totally my imagination. Maybe I act=
ually had OVMF chaining to GRUB?

The bug in question was that an NMI hitting EFI code would explode back when=
 EFI mixed mode worked by fiddling with EFER to exit long mode. I think I te=
sted by running perf while reading efivars.

I probably passed -kernel to QEMU while also telling QEMU to use OVMF.

Anyway, it=E2=80=99s okay if this mystery doesn=E2=80=99t get solved.=
