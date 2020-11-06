Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC12A8F88
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 07:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKFGkK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 01:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFGkJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Nov 2020 01:40:09 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7634A22201;
        Fri,  6 Nov 2020 06:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604644808;
        bh=SQKeBkZ2isgcvoxSo2OmHHl9Wlamd/5zewsvuW6C5aM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GjLbMaj35t1H45rqVLWoIpkjtWeZFUpvWaPcSfWuXgpXQrZFmy9ncOnFqD9OC+Uyj
         Erm0YEXwTj/V6l/EJYtdVIIUBJvvz0kcIu33vqPxpIKD6gXDp7GZtoz455Yd4M+sCe
         MZ6HEnWY6cOKMcl5351epBKPKhIFWL7O0lIJiHsA=
Received: by mail-ot1-f47.google.com with SMTP id j14so394736ots.1;
        Thu, 05 Nov 2020 22:40:08 -0800 (PST)
X-Gm-Message-State: AOAM5317GOLcVc1e3Z70kzpm4oxnl/LKD8fjCuQ6vJ/svKkq8TfgUpTU
        ZYlBvoPrXwRNUtUrNFXz+tdi4/z9lR90eQLm8+g=
X-Google-Smtp-Source: ABdhPJwrMmD9A+79eX7AnUYuMzeESBobMtgE80HoPemJxzHqomRuxEHk79KRmR5SnRJUN2E5E4zf1S+OMh17RA+aFXs=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr239034otk.108.1604644807584;
 Thu, 05 Nov 2020 22:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20201102223800.12181-1-ardb@kernel.org> <20201102223800.12181-3-ardb@kernel.org>
 <20201106034126.GA17818@linux-8mug>
In-Reply-To: <20201106034126.GA17818@linux-8mug>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 Nov 2020 07:39:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFYimf3vPp5N8xvrJTPf6AN-BCTLkGR4zYtNQWfF04OkA@mail.gmail.com>
Message-ID: <CAMj1kXFYimf3vPp5N8xvrJTPf6AN-BCTLkGR4zYtNQWfF04OkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ima: generalize x86/EFI arch glue for other EFI architectures
To:     Chester Lin <clin@suse.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 6 Nov 2020 at 04:41, Chester Lin <clin@suse.com> wrote:
>
> Hi Ard,
>
> On Mon, Nov 02, 2020 at 11:37:59PM +0100, Ard Biesheuvel wrote:
> > From: Chester Lin <clin@suse.com>
> >
> > Move the x86 IMA arch code into security/integrity/ima/ima_efi.c,
> > so that we will be able to wire it up for arm64 in a future patch.
> >
> > Co-developed-by: Chester Lin <clin@suse.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/include/asm/efi.h                                     |  3 ++
> >  arch/x86/kernel/Makefile                                       |  2 -
> >  security/integrity/ima/Makefile                                |  4 ++
> >  arch/x86/kernel/ima_arch.c => security/integrity/ima/ima_efi.c | 45 ++++++--------------
> >  4 files changed, 19 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > index 7673dc833232..c98f78330b09 100644
> > --- a/arch/x86/include/asm/efi.h
> > +++ b/arch/x86/include/asm/efi.h
> > @@ -380,4 +380,7 @@ static inline void efi_fake_memmap_early(void)
> >  }
> >  #endif
> >
> > +#define arch_ima_efi_boot_mode       \
> > +     ({ extern struct boot_params boot_params; boot_params.secure_boot; })
> > +
> >  #endif /* _ASM_X86_EFI_H */
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 68608bd892c0..5eeb808eb024 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -161,5 +161,3 @@ ifeq ($(CONFIG_X86_64),y)
> >       obj-$(CONFIG_MMCONF_FAM10H)     += mmconf-fam10h_64.o
> >       obj-y                           += vsmp_64.o
> >  endif
> > -
> > -obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_arch.o
> > diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> > index 67dabca670e2..2499f2485c04 100644
> > --- a/security/integrity/ima/Makefile
> > +++ b/security/integrity/ima/Makefile
> > @@ -14,3 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
> >  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> >  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
> >  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> > +
> > +ifeq ($(CONFIG_EFI),y)
> > +ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
> > +endif
> > diff --git a/arch/x86/kernel/ima_arch.c b/security/integrity/ima/ima_efi.c
> > similarity index 60%
> > rename from arch/x86/kernel/ima_arch.c
> > rename to security/integrity/ima/ima_efi.c
> > index 7dfb1e808928..233627a9d4b8 100644
> > --- a/arch/x86/kernel/ima_arch.c
> > +++ b/security/integrity/ima/ima_efi.c
> > @@ -5,50 +5,29 @@
> >  #include <linux/efi.h>
> >  #include <linux/module.h>
> >  #include <linux/ima.h>
> > +#include <asm/efi.h>
> >
> > -extern struct boot_params boot_params;
> > +#ifndef arch_ima_efi_boot_mode
> > +#define arch_ima_efi_boot_mode efi_secureboot_mode_unknown
>
> I think this should be "efi_secureboot_mode_unset" otherwise the get_sb_mode()
> will never be called. The others look good to me, thanks for your help.
>

Thanks Chester! I will fix that up.


> > +#endif
> >
> >  static enum efi_secureboot_mode get_sb_mode(void)
> >  {
> > -     efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> > -     efi_status_t status;
> > -     unsigned long size;
> > -     u8 secboot, setupmode;
> > -
> > -     size = sizeof(secboot);
> > +     enum efi_secureboot_mode mode;
> >
> >       if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> >               pr_info("ima: secureboot mode unknown, no efi\n");
> >               return efi_secureboot_mode_unknown;
> >       }
> >
> > -     /* Get variable contents into buffer */
> > -     status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> > -                               NULL, &size, &secboot);
> > -     if (status == EFI_NOT_FOUND) {
> > +     mode = efi_get_secureboot_mode(efi.get_variable);
> > +     if (mode == efi_secureboot_mode_disabled)
> >               pr_info("ima: secureboot mode disabled\n");
> > -             return efi_secureboot_mode_disabled;
> > -     }
> > -
> > -     if (status != EFI_SUCCESS) {
> > +     else if (mode == efi_secureboot_mode_unknown)
> >               pr_info("ima: secureboot mode unknown\n");
> > -             return efi_secureboot_mode_unknown;
> > -     }
> > -
> > -     size = sizeof(setupmode);
> > -     status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> > -                               NULL, &size, &setupmode);
> > -
> > -     if (status != EFI_SUCCESS)      /* ignore unknown SetupMode */
> > -             setupmode = 0;
> > -
> > -     if (secboot == 0 || setupmode == 1) {
> > -             pr_info("ima: secureboot mode disabled\n");
> > -             return efi_secureboot_mode_disabled;
> > -     }
> > -
> > -     pr_info("ima: secureboot mode enabled\n");
> > -     return efi_secureboot_mode_enabled;
> > +     else
> > +             pr_info("ima: secureboot mode enabled\n");
> > +     return mode;
> >  }
> >
> >  bool arch_ima_get_secureboot(void)
> > @@ -57,7 +36,7 @@ bool arch_ima_get_secureboot(void)
> >       static bool initialized;
> >
> >       if (!initialized && efi_enabled(EFI_BOOT)) {
> > -             sb_mode = boot_params.secure_boot;
> > +             sb_mode = arch_ima_efi_boot_mode;
> >
> >               if (sb_mode == efi_secureboot_mode_unset)
> >                       sb_mode = get_sb_mode();
> > --
> > 2.17.1
> >
>
