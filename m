Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20212BC6E
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 04:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfL1DZz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 22:25:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42751 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL1DZz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 22:25:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so12429463plk.9
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 19:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=L67rbP3Nbfdv5k0qA8nCQVBh53f3e3iYtfeBjtQ7swo=;
        b=fr1pzNOIemS+Hi4HKwurEnCKurWjnIXgK2WBWpg3iWm7SoD7j0hWX/l5PHnMOFb5Ca
         ZfS8NYC7Txb5fDrJrE8xxlOKeCspt7QhnJjJRYQLyocmW9zFWUxcBNAXwEwTPtL+okL+
         Um9t0JAN6B1EIhaHRzDLfFtkQhlkmhnSeZOvesSZ/JpoHAHJncRfC76uxZulPp5fvomL
         lOlj/OgIH4w/priqpmyDigssKdU1EPMo0qDyTbZZrvJaISqFbYZ50kWp+/FkHNL8g948
         4UdIDooST9xEse3hrHuRPEW8DbBj6jdQDtEYyYhim62AOymMhYAyOns1hyrfl28Z2NBl
         gYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=L67rbP3Nbfdv5k0qA8nCQVBh53f3e3iYtfeBjtQ7swo=;
        b=uTuvtlnci3/ZjKBADBXFbZg+cgQSFTZldnKxvM8RQBFIozLehEBKZJUZVQXzlwW7mh
         w4Dw5CeYBc+SQY87ogf20LGDTPZUyhu7L8RDKew3jxpZGcDsSCDrc+XSyROcHhenNWnt
         r6M4mMffb4JATYhOhgbd8yV/hAeoGzrP988DJCHb1oJqq86TRoAv1c3E60A1xSt0nPrM
         wWeWnngdYxKZ2bVbGjmynp04gNDL6TE6eRphyu/abDQrW5TRpmSAwVyLlZsAdfgpZpvl
         9rcNfTmlECFtAiI2huT8zJWEmCU4M4pxjKIU+3XwxKYx8WcxPUcdyrgxNS2THW/uuc/O
         0s3Q==
X-Gm-Message-State: APjAAAUF6CH2TDNH7zUdK/JGXwwmunc/jwNTYw0xQbAK8RNP71mz0PSY
        LReiBmVWa4aR26l3LPkQASI35g==
X-Google-Smtp-Source: APXvYqz+LQ3AZSsM9gXlQbCTMSXpofGwZRkdQfrKF+8Bkv8bMT6JKKjmSqgunhuZsU+B4SWuJnZ7Sw==
X-Received: by 2002:a17:90a:2729:: with SMTP id o38mr31327469pje.45.1577503554111;
        Fri, 27 Dec 2019 19:25:54 -0800 (PST)
Received: from [25.170.118.188] ([172.58.27.172])
        by smtp.gmail.com with ESMTPSA id h6sm38592670pgq.61.2019.12.27.19.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 19:25:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Date:   Sat, 28 Dec 2019 11:25:49 +0800
Message-Id: <9CF0A0F3-DEA8-410B-A042-0A4F8BF543F2@amacapital.net>
References: <CAKv+Gu-LeDgMFU-Hfuc7wDgNRmq2n0goJTuK6f8oahB_MGCc-g@mail.gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAKv+Gu-LeDgMFU-Hfuc7wDgNRmq2n0goJTuK6f8oahB_MGCc-g@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 28, 2019, at 2:13 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> =EF=BB=BFOn Fri, 27 Dec 2019 at 19:08, Arvind Sankar <nivedita@alum.mit.ed=
u> wrote:
>>=20
>>> On Fri, Dec 27, 2019 at 12:51:56PM -0500, Arvind Sankar wrote:
>>> On Thu, Dec 26, 2019 at 04:14:05PM +0100, Ard Biesheuvel wrote:
>>>> The efi_call() wrapper used to invoke EFI runtime services serves
>>>> a number of purposes:
>>>> - realign the stack to 16 bytes
>>>> - preserve FP register state
>>>> - translate from SysV to MS calling convention.
>>>>=20
>>>> Preserving the FP register state is redundant in most cases, since
>>>> efi_call() is almost always used from within the scope of a pair of
>>>> kernel_fpu_begin()/_end() calls, with the exception of the early
>>>> call to SetVirtualAddressMap() and the SGI UV support code. So let's
>>>> add a pair of kernel_fpu_begin()/_end() calls there as well, and
>>>> remove the unnecessary code from the assembly implementation of
>>>> efi_call(), and only keep the pieces that deal with the stack
>>>> alignment and the ABI translation.
>>>>=20
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>> arch/x86/platform/efi/efi_64.c      |  4 +++
>>>> arch/x86/platform/efi/efi_stub_64.S | 36 ++------------------
>>>> arch/x86/platform/uv/bios_uv.c      |  7 ++--
>>>> 3 files changed, 11 insertions(+), 36 deletions(-)
>>>>=20
>>>> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi=
_64.c
>>>> index 03c2ed3c645c..3690df1d31c6 100644
>>>> --- a/arch/x86/platform/efi/efi_64.c
>>>> +++ b/arch/x86/platform/efi/efi_64.c
>>>> @@ -84,6 +84,7 @@ pgd_t * __init efi_call_phys_prolog(void)
>>>>=20
>>>>    if (!efi_enabled(EFI_OLD_MEMMAP)) {
>>>>            efi_switch_mm(&efi_mm);
>>>> +           kernel_fpu_begin();
>>>>            return efi_mm.pgd;
>>>>    }
>>>>=20
>>>> @@ -141,6 +142,7 @@ pgd_t * __init efi_call_phys_prolog(void)
>>>>    }
>>>>=20
>>>>    __flush_tlb_all();
>>>> +   kernel_fpu_begin();
>>>>    return save_pgd;
>>>> out:
>>>>    efi_call_phys_epilog(save_pgd);
>>>> @@ -158,6 +160,8 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
>>>>    p4d_t *p4d;
>>>>    pud_t *pud;
>>>>=20
>>>> +   kernel_fpu_end();
>>>> +
>>>>    if (!efi_enabled(EFI_OLD_MEMMAP)) {
>>>>            efi_switch_mm(efi_scratch.prev_mm);
>>>>            return;
>>>=20
>>> Does kernel_fpu_begin/kernel_fpu_end need to be outside the efi_switch_m=
m?
>>>=20
>>> If there's an error in efi_call_phys_prolog during the old memmap code,
>>> it will call efi_call_phys_epilog without having called
>>> kernel_fpu_begin, which will cause an unbalanced kernel_fpu_end. Looks
>>> like the next step will be a panic anyway though.
>>=20
>> Do we even need to save/restore the fpu state at this point in boot? The
>> mixed-mode code path doesn't appear to be saving/restoring the XMM
>> registers during SetVirtualAddressMap.
>=20
> That is an excellent question, and I was hoping Andy or Ingo could
> shed some light on that.
>=20
> I tested without and it booted fine, and it does seem to me that there
> should be very little to preserve given how early this call happens
> (from efi_enter_virtual_mode() which gets called from start_kernel())


Unless you=E2=80=99re somehow calling it from interrupt context, I doubt sav=
ing FP regs is needed. Certainly kernel_fpu_begin() doesn=E2=80=99t do anyth=
ing that matters if we=E2=80=99re in the (misnamed) init task. If you=E2=80=99=
re calling it really really early, there=E2=80=99s a different potential iss=
ue: FP might not be fully initialized. We could have CR0.TS still set, or we=
 might not have all the various =E2=80=9COS supports such-and-such regs=E2=80=
=9D flags set.

Does the UEFI spec explicitly state what FP state can be used by the EFI fun=
ctions?=
