Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80B6B2BAB
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 18:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCIRJ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 12:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCIRJF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 12:09:05 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47A38B4B;
        Thu,  9 Mar 2023 09:05:55 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 85F634077AED;
        Thu,  9 Mar 2023 17:05:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 85F634077AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678381553;
        bh=b2XgnDHn1+aMWReUUypi/+7x5JYxRSCx4y1jPSMeCXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h4P3eKOtp3alKWJ4qFjuXiaBDyeGxTNxIZqwzf9auOFpiTdg6dMIbzfFMnfLKkqiF
         pyhgewjJK+WcYDun9B0920lF/9m/t/tpWrbp/6mhAk1wcPKhNjxtPKMtvMJt0/ggBW
         EPJfqo7s6mLFyuvW7ptUGyxoXXJplBY4CBY5B+nE=
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 20:05:53 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 15/26] efi/x86: Support extracting kernel from libstub
In-Reply-To: <CAMj1kXH+vfZQMxfO+tZPnZrxaZX4ffxpzHrdCnTfP70DgO=YJQ@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <8945a9cd072754d8dda9961a5499fc7b0c2e8743.1671098103.git.baskov@ispras.ru>
 <CAMj1kXH+vfZQMxfO+tZPnZrxaZX4ffxpzHrdCnTfP70DgO=YJQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <4782b7f3ab858d51ab375b9fc52a1900@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-09 19:00, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Doing it that way allows setting up stricter memory attributes,
>> simplifies boot code path and removes potential relocation
>> of kernel image.
>> 
>> Wire up required interfaces and minimally initialize zero page
>> fields needed for it to function correctly.
>> 
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/head_32.S            |  50 ++++-
>>  arch/x86/boot/compressed/head_64.S            |  58 ++++-
>>  drivers/firmware/efi/Kconfig                  |   2 +
>>  drivers/firmware/efi/libstub/Makefile         |   2 +-
>>  .../firmware/efi/libstub/x86-extract-direct.c | 208 
>> ++++++++++++++++++
>>  drivers/firmware/efi/libstub/x86-stub.c       | 119 +---------
>>  drivers/firmware/efi/libstub/x86-stub.h       |  14 ++
>>  7 files changed, 338 insertions(+), 115 deletions(-)
>>  create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
>>  create mode 100644 drivers/firmware/efi/libstub/x86-stub.h
>> 
>> diff --git a/arch/x86/boot/compressed/head_32.S 
>> b/arch/x86/boot/compressed/head_32.S
>> index ead6007df1e5..0be75e5072ae 100644
>> --- a/arch/x86/boot/compressed/head_32.S
>> +++ b/arch/x86/boot/compressed/head_32.S
>> @@ -152,11 +152,57 @@ SYM_FUNC_END(startup_32)
>> 
>>  #ifdef CONFIG_EFI_STUB
>>  SYM_FUNC_START(efi32_stub_entry)
>> +/*
>> + * Calculate the delta between where we were compiled to run
>> + * at and where we were actually loaded at.  This can only be done
>> + * with a short local call on x86.  Nothing  else will tell us what
>> + * address we are running at.  The reserved chunk of the real-mode
>> + * data at 0x1e4 (defined as a scratch field) are used as the stack
>> + * for this calculation. Only 4 bytes are needed.
>> + */
> 
> Please drop this comment

Will do.

> 
>> +       call    1f
>> +1:     popl    %ebx
>> +       addl    $_GLOBAL_OFFSET_TABLE_+(.-1b), %ebx
> 
> Please drop this and ...
> 
>> +
>> +       /* Clear BSS */
>> +       xorl    %eax, %eax
>> +       leal    _bss@GOTOFF(%ebx), %edi
>> +       leal    _ebss@GOTOFF(%ebx), %ecx
> 
> just use (_bss - 1b) here (etc)

I was trying to be consistent with the code below, but it will
indeed be better to do this like that. I guess, this will be
fine to stop putting GOT address to the %ebx, since the extraction
code does not use calls via PLT?

> 
>> +       subl    %edi, %ecx
>> +       shrl    $2, %ecx
>> +       rep     stosl
>> +
>>         add     $0x4, %esp
>>         movl    8(%esp), %esi   /* save boot_params pointer */
>> +       movl    %edx, %edi      /* save GOT address */
> 
> What does this do?

Hmm... It seems to be a remnant of the previous implementation
that I forgot to remove. I will remove that in the v5.

> 
>>         call    efi_main
>> -       /* efi_main returns the possibly relocated address of 
>> startup_32 */
>> -       jmp     *%eax
>> +       movl    %eax, %ecx
>> +
>> +       /*
>> +        * efi_main returns the possibly
>> +        * relocated address of extracted kernel entry point.
>> +        */
>> +
>> +       cli
>> +
>> +       /* Load new GDT */
>> +       leal    gdt@GOTOFF(%ebx), %eax
>> +       movl    %eax, 2(%eax)
>> +       lgdt    (%eax)
>> +
>> +       /* Load segment registers with our descriptors */
>> +       movl    $__BOOT_DS, %eax
>> +       movl    %eax, %ds
>> +       movl    %eax, %es
>> +       movl    %eax, %fs
>> +       movl    %eax, %gs
>> +       movl    %eax, %ss
>> +
>> +       /* Zero EFLAGS */
>> +       pushl   $0
>> +       popfl
>> +
>> +       jmp     *%ecx
>>  SYM_FUNC_END(efi32_stub_entry)
>>  SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
>>  #endif
> ...

Thanks,
Evgeniy Baskov
