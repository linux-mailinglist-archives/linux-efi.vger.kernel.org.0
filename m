Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262F845D59E
	for <lists+linux-efi@lfdr.de>; Thu, 25 Nov 2021 08:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhKYHlm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Nov 2021 02:41:42 -0500
Received: from mail.ispras.ru ([83.149.199.84]:38090 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237334AbhKYHji (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Nov 2021 02:39:38 -0500
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id C499440D403E;
        Thu, 25 Nov 2021 07:36:22 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 25 Nov 2021 10:36:22 +0300
From:   baskov@ispras.ru
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/5] Handle UEFI NX-restricted page tables
In-Reply-To: <CAMj1kXGzdMfj0bdNFODFZ8jfo0iMaZ5SOfueciwtY7Y4V5G2JQ@mail.gmail.com>
References: <20211110104613.23881-1-baskov@ispras.ru>
 <CAMj1kXGzdMfj0bdNFODFZ8jfo0iMaZ5SOfueciwtY7Y4V5G2JQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <1b013e77ec3d4c6288408b3caff093ef@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Hello,

I apologize for delayed reply.

The system in question runs in a firmware that tries to achieve
complete W^X protection. Both loader code and loader data
are not executable, so the suggested approach does not work.
If you would like to test this, you can set
the PcdDxeNxMemoryProtectionPolicy in any firmware available to you.

As a justification for the approach itself, I can use the fact that
UEFI specification says nothing about the ability to execute
self-allocated EfiLoaderCode or any other types besides the areas
allocated by the firmware for UEFI Images. In fact, Table 7-5
explicitly states that EfiLoaderCode is used for:

> The code portions of a loaded UEFI application.

While we do not think it should be interpreted as one cannot allocate
such areas at all, it is clear that there are no guarantees about the
other use cases and permissions of the allocations of this type besides
those stated by 2.3.4:

> Paging mode is enabled and any memory space defined by the UEFI memory
> map is identity mapped (virtual address equals physical address),
> although the attributes of certain regions may not have all read,
> write, and execute attributes or be unmarked for purposes of platform
> protection.

Long story short, the kernel is not allowed to allocate such areas and
assume they are executable, it should do paging itself, and the changes
here address that. For the reference, Windows adheres to this convention
and works fine on the target system.

Thanks,
Baskov Evgeniy

On 2021-11-10 14:11, Ard Biesheuvel wrote:
> On Wed, 10 Nov 2021 at 11:56, Baskov Evgeniy <baskov@ispras.ru> wrote:
>> 
>> Note, that this patch series is RFC, since it is yet untested
>> and possibly incompatible with AMD SEV and related extensions.
>> 
>> The UEFI specification states that certain memory regions may
>> not have every permission, i.e. may not be writable or executable.
>> 
>> Furthermore there exist some implementations (at least on i386/x86_64)
>> that restrict execution of memory regions expected by the kernel to
>> be executable. E.g. first megabyte of address space, where trampoline
>> for switching between 4/5 level paging is placed and memory regions,
>> allocated as loader data.
>> 
>> This patch series allows Linux kernel to boot on such UEFI
>> implementations on i386 and x86_64.
>> 
>> The simplest way to achieve that on i386 is to disable paging
>> before jumping to potentially relocated code.
>> 
>> x86_64, on the other hand, does not allow disabling paging so it
>> is required to build temporary page tables containing memory regions
>> required for Linux kernel to boot with appropriate access permissions.
>> 
> 
> Hello Baskov,
> 
> To be honest, I am truly not a fan of this approach.
> 
> Which systems is this issue occurring on? Did you try something like
> the below to allocate executable memory explicitly?
> 
> 
> diff --git a/drivers/firmware/efi/libstub/relocate.c
> b/drivers/firmware/efi/libstub/relocate.c
> index 8ee9eb2b9039..b73012a7bcdc 100644
> --- a/drivers/firmware/efi/libstub/relocate.c
> +++ b/drivers/firmware/efi/libstub/relocate.c
> @@ -80,7 +80,7 @@ efi_status_t efi_low_alloc_above(unsigned long size,
> unsigned long align,
>                         continue;
> 
>                 status = efi_bs_call(allocate_pages, 
> EFI_ALLOCATE_ADDRESS,
> -                                    EFI_LOADER_DATA, nr_pages, 
> &start);
> +                                    EFI_LOADER_CODE, nr_pages, 
> &start);
>                 if (status == EFI_SUCCESS) {
>                         *addr = start;
>                         break;
> @@ -146,7 +146,7 @@ efi_status_t efi_relocate_kernel(unsigned long 
> *image_addr,
>          */
>         nr_pages = round_up(alloc_size, EFI_ALLOC_ALIGN) / 
> EFI_PAGE_SIZE;
>         status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> -                            EFI_LOADER_DATA, nr_pages, &efi_addr);
> +                            EFI_LOADER_CODE, nr_pages, &efi_addr);
>         new_addr = efi_addr;
>         /*
>          * If preferred address allocation failed allocate as low as


