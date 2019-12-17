Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE11122F8A
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2019 16:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfLQPBw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Dec 2019 10:01:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35592 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQPBw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Dec 2019 10:01:52 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so10343253iol.2;
        Tue, 17 Dec 2019 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LO4BnDBVJtYXqePP2HLV29992kA+WWFsut1HNzWeNg=;
        b=B9paQZOl1hZMuylgrJwTYPdgpFngbMoVZ5G8HQ4IOiosvkCE6KQnW5kWgBYiAToY0P
         lYwSYZg86e0xcgPRXYRXw8HUDIFtKPpP+M0ICWE34wzJaHCTzI38xAFwJ9dC+ntDIRBH
         w38rLBixTPZomKkbPNkPxR4Tp5/pPj1FpFKhqHuMI2f0ZjMRvIcYVohAQBQ11W0kAYKy
         kfE0OvxcRK0dA1DFuJqTHOOSpIfCTeVuEucXuFMHbc9pSgWe4rPWeAsLeLEnGfW3Qy4i
         hbYa6aBLjuT9xm0iA2yCNfBr7WbOlWr81ALiyvlduf5XEZoQMx9vBYBZbrCVw5zlomQT
         1sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LO4BnDBVJtYXqePP2HLV29992kA+WWFsut1HNzWeNg=;
        b=OfEpgqDrDu3N1GWQevCt2wwmPUx0/2zZ2dLA53AVYnbiZ2XoBLyFH3KHdqzvIsH54c
         HmJXspJaHMHF05ACFpfY+GbOXdU150+/gVnPfWcnBg1dA4UJEmpGs+FiTuUx6zgCTRWx
         tIoRnZqvbvIGHk5hO0dA7tsQuv8LXM6g1PXAzW+jlLYXU5UFXJg7RtHItxIQ7L4rwLFU
         IKlxP+qQ9At1NIu5VDuso+tjuHRZhVH0FRwTYKZSZ/c+k2VP8gBN2d60VRNkPkpNcfVz
         Xfpl9VFVlcYdwCxldvT2falcoQ8DJ2TAFIeER/3WCoKZEa/kHY9mVmRMjPFnpuv+E92m
         ZqrA==
X-Gm-Message-State: APjAAAVy+8UnfLf4RhoIM97pHxUbMcHSfrPo8P6Ah61bkcuJ4dVKSXmf
        cPU01A95DxhAIOKxO2ZYxUnNEee8VzOJuEtLcg==
X-Google-Smtp-Source: APXvYqwxyWhZ1goetVsgpi3HdFnEyoecxMsKxN0qC0xTb9oPD9987C/QkkoC6cl4Y4t0qwRP+qLZtTzPL38kIVz31RY=
X-Received: by 2002:a6b:b717:: with SMTP id h23mr4081674iof.273.1576594911720;
 Tue, 17 Dec 2019 07:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-10-ardb@kernel.org>
In-Reply-To: <20191214175735.22518-10-ardb@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 17 Dec 2019 10:01:40 -0500
Message-ID: <CAMzpN2jni66jDPobSSP_2Bg9k_rJx8ENBB7-Lkz7hxFYGPe4xQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi/libstub: annotate firmware routines as __efiapi
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 1:00 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Annotate all the firmware routines (boot services, runtime services and
> protocol methods) called in the boot context as __efiapi, and make
> it expand to __attribute__((ms_abi)) on 64-bit x86. This allows us
> to use the compiler to generate the calls into firmware that use the
> MS calling convention instead of the SysV one.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Kconfig                      |   1 +
>  arch/x86/boot/compressed/eboot.h      |   4 +-
>  drivers/firmware/efi/libstub/random.c |   8 +-
>  include/linux/efi.h                   | 130 +++++++++++---------
>  4 files changed, 79 insertions(+), 64 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e8949953660..8ba81036a7ef 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1993,6 +1993,7 @@ config EFI
>  config EFI_STUB
>         bool "EFI stub support"
>         depends on EFI && !X86_USE_3DNOW
> +       depends on $(cc-option,-mabi=ms)
>         select RELOCATABLE
>         ---help---
>            This kernel feature allows a bzImage to be loaded directly
> diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
> index 318531f128c2..512d2143a94f 100644
> --- a/arch/x86/boot/compressed/eboot.h
> +++ b/arch/x86/boot/compressed/eboot.h
> @@ -19,8 +19,8 @@ typedef struct {
>  } efi_uga_draw_protocol_32_t;
>
>  typedef struct efi_uga_draw_protocol {
> -       efi_status_t (*get_mode)(struct efi_uga_draw_protocol *,
> -                                u32*, u32*, u32*, u32*);
> +       efi_status_t (__efiapi *get_mode)(struct efi_uga_draw_protocol *,
> +                                         u32*, u32*, u32*, u32*);
>         void *set_mode;
>         void *blt;
>  } efi_uga_draw_protocol_t;
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index 3b85883fb312..872d2de3eaaf 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -17,10 +17,10 @@ typedef struct {
>  } efi_rng_protocol_32_t;
>
>  struct efi_rng_protocol {
> -       efi_status_t (*get_info)(struct efi_rng_protocol *,
> -                                unsigned long *, efi_guid_t *);
> -       efi_status_t (*get_rng)(struct efi_rng_protocol *,
> -                               efi_guid_t *, unsigned long, u8 *out);
> +       efi_status_t (__efiapi *get_info)(struct efi_rng_protocol *,
> +                                         unsigned long *, efi_guid_t *);
> +       efi_status_t (__efiapi *get_rng)(struct efi_rng_protocol *,
> +                                        efi_guid_t *, unsigned long, u8 *out);
>  };
>
>  efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7f1a99bd2c05..2ba13d901055 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -48,6 +48,12 @@ typedef u16 efi_char16_t;            /* UNICODE character */
>  typedef u64 efi_physical_addr_t;
>  typedef void *efi_handle_t;
>
> +#ifdef CONFIG_X86_64
> +#define __efiapi __attribute__((ms_abi))
> +#else
> +#define __efiapi

I think it would be better to explicitly use the regparm(0) attribute
for 32-bit, even though that is currently the default.

--
Brian Gerst
