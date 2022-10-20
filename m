Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC5606055
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJTMg7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJTMgw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 08:36:52 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4111CB61;
        Thu, 20 Oct 2022 05:36:38 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id BA98440D403D;
        Thu, 20 Oct 2022 12:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BA98440D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666269396;
        bh=rQamPvGDEetB3r4TT7S+AUKeiOtFcAxJF6/G1NYPpKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dM13woasCXDfsXNWpLdH4m3lFPJHq2aMSXd7sGNOjmRdnv7n4LUl3s/sd+1US9Sv1
         qWLP5bCUa/gaXVY/EPNu4b0kdhgjpNX2n/mub9JCn+09s0cMjIAm8MeP+lCEX3j/y+
         Lf0Nbf97RlU7RMhfrXisBYWhx5rkq9/9/bZC3abI=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 15:36:36 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 13/16] efi/x86: Support extracting kernel from libstub
In-Reply-To: <CAMj1kXH3BjwgeVrUED04HzqD=WQMtarsas9SH_+Au7bSC6w07g@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <502bf9da77574d6b2edeee0abec3df6b1510aaa0.1662459668.git.baskov@ispras.ru>
 <CAMj1kXH3BjwgeVrUED04HzqD=WQMtarsas9SH_+Au7bSC6w07g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <531f40fb580b98cb048d105f5edd381c@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-10-19 10:35, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Doing it that way allows setting up stricter memory attributes,
>> simplifies boot code path and removes potential relocation
>> of kernel image.
>> 
>> Wire up required interfaces and minimally initialize zero page
>> fields needed for it to function correctly.
>> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> 
>>  create mode 100644 arch/x86/include/asm/shared/extract.h
>>  create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
>> ---
>>  arch/x86/boot/compressed/head_32.S            |   6 +-
>>  arch/x86/boot/compressed/head_64.S            |  45 ++++
>>  arch/x86/include/asm/shared/extract.h         |  25 ++
>>  drivers/firmware/efi/Kconfig                  |  14 ++
>>  drivers/firmware/efi/libstub/Makefile         |   1 +
>>  drivers/firmware/efi/libstub/efistub.h        |   5 +
>>  .../firmware/efi/libstub/x86-extract-direct.c | 220 
>> ++++++++++++++++++
>>  drivers/firmware/efi/libstub/x86-stub.c       |  45 ++--
>>  8 files changed, 343 insertions(+), 18 deletions(-)
>>  create mode 100644 arch/x86/include/asm/shared/extract.h
>>  create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
>> 
>> diff --git a/arch/x86/boot/compressed/head_32.S 
>> b/arch/x86/boot/compressed/head_32.S
>> index b46a1c4109cf..d2866f06bc9f 100644
>> --- a/arch/x86/boot/compressed/head_32.S
>> +++ b/arch/x86/boot/compressed/head_32.S
>> @@ -155,7 +155,11 @@ SYM_FUNC_START(efi32_stub_entry)
>>         add     $0x4, %esp
>>         movl    8(%esp), %esi   /* save boot_params pointer */
>>         call    efi_main
>> -       /* efi_main returns the possibly relocated address of 
>> startup_32 */
>> +
>> +       /*
>> +        * efi_main returns the possibly
>> +        * relocated address of exteracted kernel entry point.
> 
> extracted

Thanks, will fix.
> 

...
>> diff --git a/arch/x86/include/asm/shared/extract.h 
>> b/arch/x86/include/asm/shared/extract.h
>> new file mode 100644
>> index 000000000000..163678145884
>> --- /dev/null
>> +++ b/arch/x86/include/asm/shared/extract.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef ASM_SHARED_EXTRACT_H
>> +#define ASM_SHARED_EXTRACT_H
>> +
>> +#define MAP_WRITE      0x02 /* Writable memory */
>> +#define MAP_EXEC       0x04 /* Executable memory */
>> +#define MAP_ALLOC      0x10 /* Range needs to be allocated */
>> +#define MAP_PROTECT    0x20 /* Set exact memory attributes for memory 
>> range */
>> +
>> +struct efi_iofunc {
>> +       void (*putstr)(const char *msg);
>> +       void (*puthex)(unsigned long x);
>> +       unsigned long (*map_range)(unsigned long start,
>> +                                  unsigned long end,
>> +                                  unsigned int flags);
> 
> This looks a bit random - having a map_range() routine as a member of
> the console I/O struct. Can we make this abstraction a bit more
> natural?

Hmm, I can either change the name of this stucture
to something more generic (like efi_extract_callbacks) or
split map_range separately as a separate function argument.
(Renaming seems simpler, so I will do that for now.)

>> +};
>> +
>> +void *efi_extract_kernel(struct boot_params *rmode,
>> +                        struct efi_iofunc *iofunc,
>> +                        unsigned char *input_data,
>> +                        unsigned long input_len,
>> +                        unsigned char *output,
>> +                        unsigned long output_len);
>> +
>> +#endif /* ASM_SHARED_EXTRACT_H */
>> diff --git a/drivers/firmware/efi/Kconfig 
>> b/drivers/firmware/efi/Kconfig
>> index 6cb7384ad2ac..2418402a0bda 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -91,6 +91,20 @@ config EFI_DXE_MEM_ATTRIBUTES
>>           Use DXE services to check and alter memory protection
>>           attributes during boot via EFISTUB to ensure that memory
>>           ranges used by the kernel are writable and executable.
>> +         This option also enables stricter memory attributes
>> +         on compressed kernel PE image.
>> +
>> +config EFI_STUB_EXTRACT_DIRECT
>> +       bool "Extract kernel directly from UEFI environment"
>> +       depends on EFI && EFI_STUB && X86_64
>> +       default y
> 
> What is the reason for making this configurable? Couldn't we just
> enable it unconditionally?
> 
When I first implemented it it was too hackish, but now it seems OK, so
I can make it unconditional, and it will make things simpler in several
places. Although making it work on x86_32 will require some additional 
work.

Also kernel with EFI_STUB_EXTRACT_DIRECT disabled breaks boot process 
with Mu
firmware when W^X enabled, as pointed out by Peter.

So, I guess, I will just remove the switch.

>> 
>> +#ifdef CONFIG_X86
>> +unsigned long extract_kernel_direct(struct boot_params *boot_params);
>> +void startup_32(struct boot_params *boot_params);
>> +#endif
>> +
> 
> Please put this somewhere else
> 

Will adding little x86-specific header file for these be appropriate?

>> +
>> +#include "efistub.h"
>> +
>> +static void do_puthex(unsigned long value);
>> +static void do_putstr(const char *msg);
>> +
> 
> Can we get rid of these forward declarations?
> 

Yes, I will move those functions here and remove declarations.

...
>> +       /* First page of trampoline is a top level page table */
>> +       efi_adjust_memory_range_protection(trampoline_start,
>> +                                          PAGE_SIZE,
>> +                                          EFI_MEMORY_XP);
>> +
>> +       /* Second page of trampoline is the code (with a padding) */
>> +       status = efi_get_memory_map(&map);
> 
> efi_get_memory_map() has been updated in the mean time, so this needs a 
> rewrite.

Yep, it needs a rebase now.
> 
...
>>  setup_memory_protection(unsigned long image_base, unsigned long 
>> image_size)
>>  {
>>         /*
>> -        * Allow execution of possible trampoline used
>> -        * for switching between 4- and 5-level page tables
>> -        * and relocated kernel image.
>> -        */
>> +       * Allow execution of possible trampoline used
>> +       * for switching between 4- and 5-level page tables
>> +       * and relocated kernel image.
>> +       */
>> 
> 
> Drop this hunk please

That was unintentional, thanks.

