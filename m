Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D77147212
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2020 20:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWTtR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Jan 2020 14:49:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38352 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWTtR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Jan 2020 14:49:17 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so4710323qki.5
        for <linux-efi@vger.kernel.org>; Thu, 23 Jan 2020 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fYWv3gkaBG3PC7KY5b1PI2c9hwBzlBIPCdR2DcObPZc=;
        b=rcQkWff2IxD8g6voBRp5FFJKudPCu2/bWS9vjCC3BTh7jVw1+6wvrXtCMv/eqUU0K8
         Mtn8A4f095sTk9pGH5ytPPFt9+LXqUaeZtE9nMPgEh7FSyeI5cFpiERe1+xuDf8OHOuY
         paJRXyu7SboiwQAj090+qqt+509/rR2xRrOOeTqMuAA7HIpquqWj+5S0c77hRRCyRGYD
         QgBUeJSA4F62UvixJGNUKvET7PAedWRTqTH4ZmU8gmINuZoiXGlm5cu6QZaftJdgOF6M
         xDHukbohrGroDmu8d5773suxH+L7XI19X8EtKpNOT50+cc/lIZ5fEJcQYsnBP9Plr3PU
         io7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fYWv3gkaBG3PC7KY5b1PI2c9hwBzlBIPCdR2DcObPZc=;
        b=MqyqsIjhd/yt8KAX4LcsIhpxON8qEkwhISl5RmL9qj9d7VlD18NvDYMXTZg100ZL+d
         MSEfJOly0LZabvgJ024wzXh/A/vPSp8AJ4sKWpQ+6PXheljaUcIj8ciTEdSjdPLF4E/f
         48aTg71wJKGSQhRqMUv3LXUpHgG/pyij6ugU4/7HtOTVhHnwv8kjmSK7YyrvEJIT7B6n
         mN1P33zXGTxKs+99GK/FDenD51iOuxBbarYtK9iSz9sCLhX2VCssMCB84SLVh3JSa5ai
         D9XBKRMrCsXi+qep+59xB8RGmmA0mjstlG+hLuOSuAD/NDQf+JPOuozYMHXu/O91uQ28
         cknw==
X-Gm-Message-State: APjAAAXq3pVvjpZcDbMkIfb2wdMmY15m6T3VseDLaahzsej4VsPgBc2G
        aECep5FjdzeWmMRJ5wpAqx/yxQrmdvZy3Q==
X-Google-Smtp-Source: APXvYqx5v5NP0kCPnQiptjsW8R3LNoRZLqm+Mf0vqi2X+tunoECrfmNLbYLzVp4sOuFPwKFmDuOOMA==
X-Received: by 2002:a37:4dc4:: with SMTP id a187mr18136788qkb.436.1579808956541;
        Thu, 23 Jan 2020 11:49:16 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i90sm1516366qtd.49.2020.01.23.11.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:49:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
Date:   Thu, 23 Jan 2020 14:49:14 -0500
Cc:     Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10CCB37C-B91A-4A15-B9C0-5DBA5DD0BFD9@lca.pw>
References: <20200122191430.4888-1-cai@lca.pw>
 <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Jan 22, 2020, at 2:17 PM, Ard Biesheuvel =
<ard.biesheuvel@linaro.org> wrote:
>=20
> On Wed, 22 Jan 2020 at 20:15, Qian Cai <cai@lca.pw> wrote:
>>=20
>> x86_64 EFI systems are unable to boot due to a typo in the recent =
commit.
>>=20
>> EFI config tables not found.
>> -- System halted
>>=20
>> Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for =
efi_is_64bit()")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> arch/x86/boot/compressed/eboot.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/boot/compressed/eboot.c =
b/arch/x86/boot/compressed/eboot.c
>> index 82e26d0ff075..287393d725f0 100644
>> --- a/arch/x86/boot/compressed/eboot.c
>> +++ b/arch/x86/boot/compressed/eboot.c
>> @@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
>> {
>>        if (IS_ENABLED(CONFIG_EFI_MIXED))
>>                return efi_is64;
>> -       return IS_ENABLED(CONFIG_X64_64);
>> +       return IS_ENABLED(CONFIG_X86_64);
>> }
>>=20
>> static efi_status_t
>=20
> Apologies for the breakage - your fix is obviously correct. But I did
> test this code, so I am curious why I didn't see this problem. Are you
> booting via GRUB or from the UEFI shell? Can you share your .config
> please?

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

BTW, this will also trigger a compilation breakage,

ld: arch/x86/platform/efi/efi_64.o: in function =
`efi_set_virtual_address_map':
efi_64.c:(.init.text+0x1419): undefined reference to `__efi64_thunk'
ld: efi_64.c:(.init.text+0x1530): undefined reference to =
`efi_uv1_memmap_phys_prolog'
ld: efi_64.c:(.init.text+0x1706): undefined reference to =
`efi_uv1_memmap_phys_epilog=E2=80=99

Likely due to the commit =E2=80=9Cefi/x86: avoid KASAN false positives =
when accessing the 1:1 mapping=E2=80=9D

Looks like you are in process fixing that one as well.=
