Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8856D2808DF
	for <lists+linux-efi@lfdr.de>; Thu,  1 Oct 2020 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgJAU5U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Oct 2020 16:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgJAU5T (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 1 Oct 2020 16:57:19 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 044CE207FB;
        Thu,  1 Oct 2020 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601585839;
        bh=KlZU6JDzjRF28UWN2Q1zA7irgAccRi7hkXZ+HCnev7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iyq/nDS71g/0jZhjClQE07vEb8x3Pg0F1gAle9l+VW/Pey9PoBPrGTSHkYWi7S/3u
         2qmheQD6XCrnjb7nbIdMtUcay6xOk/smlAFItlqCld0GgbWIkgZf2BBg6p82hsVB9T
         cBb+CgETu2DMZ/exanYbpjMOB510m/EvO6JYeWPE=
Received: by mail-ot1-f53.google.com with SMTP id c2so75421otp.7;
        Thu, 01 Oct 2020 13:57:18 -0700 (PDT)
X-Gm-Message-State: AOAM5314HA4pJn1mFvw4EWWKKEm3YJEtAN86kX9J0NJXaymfqmQ5i6yi
        Of38aRXr9tTT+iVRPWK4BEgg3dNn3csIFuVMlwo=
X-Google-Smtp-Source: ABdhPJyOOLdA7jWUEtZBFDL23RTFxBrkUWqbZEFAKE4ZkSt+VXNgvBHPldjBfbu3uOml/MENyenVJzKXeu0JMfE4b0s=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr6707860otk.77.1601585838357;
 Thu, 01 Oct 2020 13:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200905013107.10457-1-lszubowi@redhat.com> <20200905013107.10457-2-lszubowi@redhat.com>
 <20201001174436.GA2622286@ubuntu-m3-large-x86>
In-Reply-To: <20201001174436.GA2622286@ubuntu-m3-large-x86>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Oct 2020 22:57:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFoCsO3YqvTZx4nU4mQOhoux1iS1vsa73AZhtc5Y8j59Q@mail.gmail.com>
Message-ID: <CAMj1kXFoCsO3YqvTZx4nU4mQOhoux1iS1vsa73AZhtc5Y8j59Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] efi: Support for MOK variable config table
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 1 Oct 2020 at 19:44, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> On Fri, Sep 04, 2020 at 09:31:05PM -0400, Lenny Szubowicz wrote:
> > Because of system-specific EFI firmware limitations, EFI volatile
> > variables may not be capable of holding the required contents of
> > the Machine Owner Key (MOK) certificate store when the certificate
> > list grows above some size. Therefore, an EFI boot loader may pass
> > the MOK certs via a EFI configuration table created specifically for
> > this purpose to avoid this firmware limitation.
> >
> > An EFI configuration table is a much more primitive mechanism
> > compared to EFI variables and is well suited for one-way passage
> > of static information from a pre-OS environment to the kernel.
> >
> > This patch adds initial kernel support to recognize, parse,
> > and validate the EFI MOK configuration table, where named
> > entries contain the same data that would otherwise be provided
> > in similarly named EFI variables.
> >
> > Additionally, this patch creates a sysfs binary file for each
> > EFI MOK configuration table entry found. These files are read-only
> > to root and are provided for use by user space utilities such as
> > mokutil.
> >
> > A subsequent patch will load MOK certs into the trusted platform
> > key ring using this infrastructure.
> >
> > Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
>
> I have not seen this reported yet but this breaks arm allyesconfig and
> allmodconfig when CPU_LITTLE_ENDIAN is force selected (because CONFIG_EFI
> will actually be enabled):
>
> $ cat le.config
> CONFIG_CPU_BIG_ENDIAN=n
>
> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- KCONFIG_ALLCONFIG=le.config allyesconfig drivers/firmware/efi/mokvar-table.o
> drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
> drivers/firmware/efi/mokvar-table.c:139:5: error: implicit declaration of function 'early_memunmap' [-Werror=implicit-function-declaration]
>   139 |     early_memunmap(va, map_size);
>       |     ^~~~~~~~~~~~~~
> drivers/firmware/efi/mokvar-table.c:148:9: error: implicit declaration of function 'early_memremap' [-Werror=implicit-function-declaration]
>   148 |    va = early_memremap(efi.mokvar_table, map_size);
>       |         ^~~~~~~~~~~~~~
> drivers/firmware/efi/mokvar-table.c:148:7: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   148 |    va = early_memremap(efi.mokvar_table, map_size);
>       |       ^
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:283: drivers/firmware/efi/mokvar-table.o] Error 1
>
> Cheers,
> Nathan

Hi Nathan,

Does adding

#include <asm/early_ioremap.h>

to drivers/firmware/efi/mokvar-table.c fix the issue?
