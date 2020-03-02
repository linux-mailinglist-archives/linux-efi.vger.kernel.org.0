Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C966175D92
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 15:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCBOwV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 09:52:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgCBOwU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Mar 2020 09:52:20 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8F62465E
        for <linux-efi@vger.kernel.org>; Mon,  2 Mar 2020 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583160740;
        bh=FpLJgWkkh8fCmPgOKqDhlneGC4YvaWwoXzMAYLaCZFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SGSSjUABSQVozTtC4IWs3ii/v+T7bjwhLiRSJ9WKhHMAbVymnYUgl6eLt2glMy+JQ
         1GVbHa/nmCYdBBcKMYo2Qm4GRvgRJaFHR81rzUoCHnVmF2MSkIQPuVY4ezpIX40JYM
         f4ynofaR4Q/5EBzsHz1lGGs/fus8RBXk16Fm644E=
Received: by mail-wr1-f54.google.com with SMTP id j16so27652wrt.3
        for <linux-efi@vger.kernel.org>; Mon, 02 Mar 2020 06:52:19 -0800 (PST)
X-Gm-Message-State: ANhLgQ0DGvlWEbB7uKrZ+h8MDCYFeOudXYVZW/31i9WUDBq5AD+7cHSv
        qixXbqjroncAgbqGI8g5oh0A81zPAvZXSt074SmKVQ==
X-Google-Smtp-Source: ADFU+vuD/JTTM+IbJxK5SJVF+H1KyJRiVk8Ouz9HW+yomY1Ty4oAkjWVxkJixOQT9AmMZ6uSsXE+x/HFSCoPrWL29PI=
X-Received: by 2002:a5d:6051:: with SMTP id j17mr2737207wrt.151.1583160738331;
 Mon, 02 Mar 2020 06:52:18 -0800 (PST)
MIME-Version: 1.0
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com> <1583160524.8544.91.camel@linux.ibm.com>
In-Reply-To: <1583160524.8544.91.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Mar 2020 15:52:07 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_E9O05xB7i2Y8KiMJUjtZoq54GxSbHnyTFePcF6fqQNA@mail.gmail.com>
Message-ID: <CAKv+Gu_E9O05xB7i2Y8KiMJUjtZoq54GxSbHnyTFePcF6fqQNA@mail.gmail.com>
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Mar 2020 at 15:48, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-02-26 at 14:10 -0500, Nayna Jain wrote:
> > Every time a new architecture defines the IMA architecture specific
> > functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> > include file needs to be updated. To avoid this "noise", this patch
> > defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> > the different architectures to select it.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  arch/powerpc/Kconfig           | 2 +-
> >  arch/s390/Kconfig              | 1 +
> >  arch/x86/Kconfig               | 1 +
> >  include/linux/ima.h            | 3 +--
> >  security/integrity/ima/Kconfig | 9 +++++++++
> >  5 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 497b7d0b2d7e..b8ce1b995633 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -246,6 +246,7 @@ config PPC
> >       select SYSCTL_EXCEPTION_TRACE
> >       select THREAD_INFO_IN_TASK
> >       select VIRT_TO_BUS                      if !PPC64
> > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if PPC_SECURE_BOOT
> >       #
> >       # Please keep this list sorted alphabetically.
> >       #
> > @@ -978,7 +979,6 @@ config PPC_SECURE_BOOT
> >       prompt "Enable secure boot support"
> >       bool
> >       depends on PPC_POWERNV
> > -     depends on IMA_ARCH_POLICY
> >       help
> >         Systems with firmware secure boot enabled need to define security
> >         policies to extend secure boot to the OS. This config allows a user
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 8abe77536d9d..90ff3633ade6 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -195,6 +195,7 @@ config S390
> >       select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> >       select SWIOTLB
> >       select GENERIC_ALLOCATOR
> > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT
> >
> >
> >  config SCHED_OMIT_FRAME_POINTER
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index beea77046f9b..cafa66313fe2 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -230,6 +230,7 @@ config X86
> >       select VIRT_TO_BUS
> >       select X86_FEATURE_NAMES                if PROC_FS
> >       select PROC_PID_ARCH_STATUS             if PROC_FS
> > +     select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI
>
> Not everyone is interested in enabling IMA or requiring IMA runtime
> policies.  With this patch, enabling IMA_ARCH_POLICY is therefore
> still left up to the person building the kernel.  As a result, I'm
> seeing the following warning, which is kind of cool.
>
> WARNING: unmet direct dependencies detected for
> IMA_SECURE_AND_OR_TRUSTED_BOOT
>   Depends on [n]: INTEGRITY [=y] && IMA [=y] && IMA_ARCH_POLICY [=n]
>   Selected by [y]:
>   - X86 [=y] && EFI [=y]
>
> Ard, Michael, Martin, just making sure this type of warning is
> acceptable before upstreaming this patch.  I would appreciate your
> tags.
>

Ehm, no, warnings like these are not really acceptable. It means there
is an inconsistency in the way the Kconfig dependencies are defined.

Does this help:

  select IMA_SECURE_AND_OR_TRUSTED_BOOT   if EFI && IMA_ARCH_POLICY

?


>
> >
> >  config INSTRUCTION_DECODER
> >       def_bool y
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 1659217e9b60..aefe758f4466 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
> >  extern void ima_add_kexec_buffer(struct kimage *image);
> >  #endif
> >
> > -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
> > -     || defined(CONFIG_PPC_SECURE_BOOT)
> > +#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
> >  extern bool arch_ima_get_secureboot(void);
> >  extern const char * const *arch_get_ima_policy(void);
> >  #else
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> > index 3f3ee4e2eb0d..d17972aa413a 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> >       depends on IMA_MEASURE_ASYMMETRIC_KEYS
> >       depends on SYSTEM_TRUSTED_KEYRING
> >       default y
> > +
> > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > +     bool
> > +     depends on IMA
> > +     depends on IMA_ARCH_POLICY
> > +     default n
> > +     help
> > +        This option is selected by architectures to enable secure and/or
> > +        trusted boot based on IMA runtime policies.
>
>
>
>
