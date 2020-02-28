Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465CC17346D
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgB1JoW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 04:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgB1JoW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 04:44:22 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03408246B2
        for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2020 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582883061;
        bh=EY3N5ARkuQ2Fmd9dLsdkczWCpYQSSmA2gTdVVcCS6/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DDFiZ942ndAh4/uGo+flTje203xmGj7xn0NowQTvbLbY7+SQw33rROqAa5nibZGrJ
         XSfWGSTyfiKZL0a/vmlhmTKqCMrKbN0PCcuo98GLBVV3e1/LvTfdH9HmiR3rLlzYTC
         VtsGWYbncN4LRy5rVHDyA/PhCjVwK2G2KjwRXL1A=
Received: by mail-wm1-f54.google.com with SMTP id p9so2493480wmc.2
        for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2020 01:44:20 -0800 (PST)
X-Gm-Message-State: APjAAAV5BBy0VD15k8oGSY5UOlG0th0zWu3YB5Q6w2+cxfTZIGYtPw5Q
        wp35qES8C8m8KVV6rop53uJeit5iDQ6H/4G3YJcKwQ==
X-Google-Smtp-Source: APXvYqzQDeiE9uETc0v0SlldVjq0AbI0gGMk7x0p0dQwOWlkIdt6C1NHOKlKwQufolI6IQPaR0rg9t9cVXd31TKDLwI=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4334566wmk.68.1582883059353;
 Fri, 28 Feb 2020 01:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20200217113947.2070436-1-javierm@redhat.com> <0fd1b499-3a5e-c78e-0279-186a4c424217@redhat.com>
 <5c60e016-fb30-b33d-39c6-ea30a4f777cb@redhat.com> <30819cad-1a00-1ea7-13cf-d1d15c0fa96c@redhat.com>
 <CAKv+Gu869JovSC9AdCC1yvcKF_Qpa0U3dr_kF2_e3zZMaDDs+Q@mail.gmail.com> <0d8e7525-545d-23d5-dace-6804833447d2@redhat.com>
In-Reply-To: <0d8e7525-545d-23d5-dace-6804833447d2@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Feb 2020 10:44:08 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-OO_YiDWbF2pRBQTGe3FxC5CmjuxCnCwxJmnzRHhEz_g@mail.gmail.com>
Message-ID: <CAKv+Gu-OO_YiDWbF2pRBQTGe3FxC5CmjuxCnCwxJmnzRHhEz_g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] efi: Only print errors about failing to get
 certs if EFI vars are found
To:     David Hildenbrand <david@redhat.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Eric Richter <erichte@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Feb 2020 at 10:43, David Hildenbrand <david@redhat.com> wrote:
>
> On 28.02.20 10:39, Ard Biesheuvel wrote:
> > On Fri, 28 Feb 2020 at 10:35, David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 28.02.20 10:31, David Hildenbrand wrote:
> >>> On 28.02.20 10:19, David Hildenbrand wrote:
> >>>> On 17.02.20 12:39, Javier Martinez Canillas wrote:
> >>>>> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
> >>>>> from the db, dbx and MokListRT EFI variables into the appropriate keyrings.
> >>>>>
> >>>>> But it just assumes that the variables will be present and prints an error
> >>>>> if the certs can't be loaded, even when is possible that the variables may
> >>>>> not exist. For example the MokListRT variable will only be present if shim
> >>>>> is used.
> >>>>>
> >>>>> So only print an error message about failing to get the certs list from an
> >>>>> EFI variable if this is found. Otherwise these printed errors just pollute
> >>>>> the kernel log ring buffer with confusing messages like the following:
> >>>>>
> >>>>> [    5.427251] Couldn't get size: 0x800000000000000e
> >>>>> [    5.427261] MODSIGN: Couldn't get UEFI db list
> >>>>> [    5.428012] Couldn't get size: 0x800000000000000e
> >>>>> [    5.428023] Couldn't get UEFI MokListRT
> >>>>>
> >>>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
> >>>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >>>>> Tested-by: Hans de Goede <hdegoede@redhat.com>
> >>>>
> >>>> This patch seems to break a very basic x86-64 QEMU setup (booting
> >>>> upstream kernel with a F31 initrd - are you running basic boot tests?).
> >>>> Luckily, it only took me 5 minutes to identify this patch. Reverting
> >>>> this patch from linux-next fixes it for me.
> >>>>
> >>>>
> >>>> [    1.042766] Loaded X.509 cert 'Build time autogenerated kernel key: 6625d6e34255935276d2c9851e2458909a4bcd69'
> >>>> [    1.044314] zswap: loaded using pool lzo/zbud
> >>>> [    1.045663] Key type ._fscrypt registered
> >>>> [    1.046154] Key type .fscrypt registered
> >>>> [    1.046524] Key type fscrypt-provisioning registered
> >>>> [    1.051178] Key type big_key registered
> >>>> [    1.055108] Key type encrypted registered
> >>>> [    1.055513] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>>> [    1.056172] #PF: supervisor instruction fetch in kernel mode
> >>>> [    1.056706] #PF: error_code(0x0010) - not-present page
> >>>> [    1.057367] PGD 0 P4D 0
> >>>> [    1.057729] Oops: 0010 [#1] SMP NOPTI
> >>>> [    1.058249] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc3-next-20200228+ #79
> >>>> [    1.059167] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
> >>>> [    1.060230] RIP: 0010:0x0
> >>>> [    1.060478] Code: Bad RIP value.
> >>>> [    1.060786] RSP: 0018:ffffbc7880637d98 EFLAGS: 00010246
> >>>> [    1.061281] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffbc7880637dc8
> >>>> [    1.061954] RDX: 0000000000000000 RSI: ffffbc7880637df0 RDI: ffffffffa73c40be
> >>>> [    1.062611] RBP: ffffbc7880637e20 R08: ffffbc7880637dac R09: ffffa0238f4ba6c0
> >>>> [    1.063278] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> >>>> [    1.063956] R13: ffffa024bdd6f660 R14: 0000000000000000 R15: 0000000000000000
> >>>> [    1.064609] FS:  0000000000000000(0000) GS:ffffa023fdd00000(0000) knlGS:0000000000000000
> >>>> [    1.065360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [    1.065900] CR2: ffffffffffffffd6 CR3: 00000000b1610000 CR4: 00000000000006e0
> >>>> [    1.066562] Call Trace:
> >>>> [    1.066803]  load_uefi_certs+0xc8/0x2bb
> >>>> [    1.067171]  ? get_cert_list+0xfb/0xfb
> >>>> [    1.067523]  do_one_initcall+0x5d/0x2f0
> >>>> [    1.067894]  ? rcu_read_lock_sched_held+0x52/0x80
> >>>> [    1.068337]  kernel_init_freeable+0x243/0x2c2
> >>>> [    1.068751]  ? rest_init+0x23a/0x23a
> >>>> [    1.069095]  kernel_init+0xa/0x106
> >>>> [    1.069416]  ret_from_fork+0x27/0x50
> >>>> [    1.069759] Modules linked in:
> >>>> [    1.070050] CR2: 0000000000000000
> >>>> [    1.070361] ---[ end trace fcce9bb4feb21d99 ]---
> >>>>
> >>>>
> >>>
> >>> Sorry, wrong mail identified, the patch is actually
> >>>
> >>> commit 6b75d54d5258ccd655387a00bbe1b00f92f4d965
> >>> Author: Ard Biesheuvel <ardb@kernel.org>
> >>> Date:   Sun Feb 16 19:46:25 2020 +0100
> >>>
> >>>     integrity: Check properly whether EFI GetVariable() is available
> >>>
> >>>     Testing the value of the efi.get_variable function pointer is not
> >>>
> >>> which made it work. (not even able to find that patch on lkml ...)
> >>
> >> To clarify for Ard, your patch breaks a basic QEMU setup (see above,
> >> NULL pointer dereference). Reverting your patch from linux-next makes it
> >> work again.
> >>
> >
> > Does this fix it?
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 41269a95ff85..d1746a579c99 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -300,12 +300,12 @@ static int __init efisubsys_init(void)
> >  {
> >         int error;
> >
> > -       if (!efi_enabled(EFI_BOOT))
> > -               return 0;
> > -
> >         if (!efi_enabled(EFI_RUNTIME_SERVICES))
> >                 efi.runtime_supported_mask = 0;
> >
> > +       if (!efi_enabled(EFI_BOOT))
> > +               return 0;
> > +
> >         if (efi.runtime_supported_mask) {
> >                 /*
> >                  * Since we process only one efi_runtime_service() at a time, an
> >
>
> Yes, does the trick!
>

Thanks, David. I'll get this out and into -next asap.
