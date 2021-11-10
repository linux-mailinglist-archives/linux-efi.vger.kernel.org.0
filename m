Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D856444BFF3
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 12:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhKJLOs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 06:14:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhKJLOs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 06:14:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C074461260;
        Wed, 10 Nov 2021 11:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636542720;
        bh=DIrmlhsVEMMjbUD6J6MA4EEMmL5c5dsr4gEIm6JRuE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rLcl9A8wgQZaKtXsd4UP9JkpSGygklkGDJgkcM5mosz985OjAfomwCSwJvu5J5o3S
         L5tobzS2ctJ5niu3hvFMLVdrI75YXTQ8luvBfHeKPxyRNozalQn+DzKTcDBcrf8Y8e
         P0teyts6MgC+hqJWg39YbG7rsZm/nDWb+MrKbrlHiYfhepUQQYEiPwEQAnINfSSsBe
         P9d3ECTEUtjRF5CZz7fk0XxvLuGczQLn8MtknDx+d0ZnjQ8uc9iVfai2GjASsBQsz+
         5SBeHiy1mHWzrdqeQtTlR+RsBFS2YzK+d6T8uZxB5R/FeqmQkpS8hqi2ZrGioWDxJu
         vfsxoKvuBpqGA==
Received: by mail-oi1-f178.google.com with SMTP id bf8so4542499oib.6;
        Wed, 10 Nov 2021 03:12:00 -0800 (PST)
X-Gm-Message-State: AOAM5324YDiRGVs2RbV+eO10pjuTau+Bv0pktSzXj7UYJBGnx9QD/yHb
        5CyaUWMbfSiVMWV3kzprVR5wG4rmOo1MWPobBYA=
X-Google-Smtp-Source: ABdhPJwZN/UIu9H2q1yELhLB2lhxVrfqstOPvAxUoM8BigcKPQsBOaOrSGEq6k43AYdy8vOKjGvcPVCaR0Yur1M9MnE=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr12159740oib.33.1636542720032;
 Wed, 10 Nov 2021 03:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20211110104613.23881-1-baskov@ispras.ru>
In-Reply-To: <20211110104613.23881-1-baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 Nov 2021 12:11:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGzdMfj0bdNFODFZ8jfo0iMaZ5SOfueciwtY7Y4V5G2JQ@mail.gmail.com>
Message-ID: <CAMj1kXGzdMfj0bdNFODFZ8jfo0iMaZ5SOfueciwtY7Y4V5G2JQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] Handle UEFI NX-restricted page tables
To:     Baskov Evgeniy <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 10 Nov 2021 at 11:56, Baskov Evgeniy <baskov@ispras.ru> wrote:
>
> Note, that this patch series is RFC, since it is yet untested
> and possibly incompatible with AMD SEV and related extensions.
>
> The UEFI specification states that certain memory regions may
> not have every permission, i.e. may not be writable or executable.
>
> Furthermore there exist some implementations (at least on i386/x86_64)
> that restrict execution of memory regions expected by the kernel to
> be executable. E.g. first megabyte of address space, where trampoline
> for switching between 4/5 level paging is placed and memory regions,
> allocated as loader data.
>
> This patch series allows Linux kernel to boot on such UEFI
> implementations on i386 and x86_64.
>
> The simplest way to achieve that on i386 is to disable paging
> before jumping to potentially relocated code.
>
> x86_64, on the other hand, does not allow disabling paging so it
> is required to build temporary page tables containing memory regions
> required for Linux kernel to boot with appropriate access permissions.
>

Hello Baskov,

To be honest, I am truly not a fan of this approach.

Which systems is this issue occurring on? Did you try something like
the below to allocate executable memory explicitly?


diff --git a/drivers/firmware/efi/libstub/relocate.c
b/drivers/firmware/efi/libstub/relocate.c
index 8ee9eb2b9039..b73012a7bcdc 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -80,7 +80,7 @@ efi_status_t efi_low_alloc_above(unsigned long size,
unsigned long align,
                        continue;

                status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-                                    EFI_LOADER_DATA, nr_pages, &start);
+                                    EFI_LOADER_CODE, nr_pages, &start);
                if (status == EFI_SUCCESS) {
                        *addr = start;
                        break;
@@ -146,7 +146,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
         */
        nr_pages = round_up(alloc_size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
        status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-                            EFI_LOADER_DATA, nr_pages, &efi_addr);
+                            EFI_LOADER_CODE, nr_pages, &efi_addr);
        new_addr = efi_addr;
        /*
         * If preferred address allocation failed allocate as low as



-- 
Ard.
