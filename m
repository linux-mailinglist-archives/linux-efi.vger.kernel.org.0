Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29E6B5CDA
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCKObt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 09:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCKObs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 09:31:48 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613739BA7C;
        Sat, 11 Mar 2023 06:31:47 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id D497E40737A9;
        Sat, 11 Mar 2023 14:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D497E40737A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678545105;
        bh=46KXPcpWJeBRUYX0NYuLLZ+/sY00b3jrDW80RjYVVhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQsYjIN4R5qJ290VufJajvqheM7crhZ6HrWbqSIV0anVBDZ/CnRhIbd+tKYQiyTWz
         2iJYqUiFXeWs2TWPlRVGzbIFQ9ihaCXysHvaagdtDd7wH+vgaSVRDQ7S7afFBmVlWG
         LbEyAzW4LqgDXW+bT7pPVVyL7t+h586TuML4VMc8=
MIME-Version: 1.0
Date:   Sat, 11 Mar 2023 17:31:45 +0300
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
Subject: Re: [PATCH v4 02/26] x86/build: Remove RWX sections and align on 4KB
In-Reply-To: <CAMj1kXEdD8UT5SMU+3RH1qoNGcAOSF7fWnJS=Svy0EUB76FYng@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <721b5c42e0e79d307d5bcb08f9c8402f5067ded0.1671098103.git.baskov@ispras.ru>
 <CAMj1kXEdD8UT5SMU+3RH1qoNGcAOSF7fWnJS=Svy0EUB76FYng@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <94de9f7c8a26d98be778619d4104d232@ispras.ru>
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

On 2023-03-10 17:45, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Avoid creating sections simultaneously writable and readable
>> to prepare for W^X implementation. Align sections on page size (4KB) 
>> to
>> allow protecting them in the page tables.
>> 
>> Split init code form ".init" segment into separate R_X ".inittext"
>> segment and make ".init" segment non-executable.
>> 
>> Also add these segments to x86_32 architecture for consistency.
>> Currently paging is disabled in x86_32 in compressed kernel, so
>> protection is not applied anyways, but .init code was incorrectly
>> placed in non-executable ".data" segment. This should not change
>> anything meaningful in memory layout now, but might be required in 
>> case
>> memory protection will also be implemented in compressed kernel for
>> x86_32.
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
> One nit: the series modifies both the decompressor linker script and
> the core kernel one, so please make it very explicit in the commit log
> which one is being modified, and why it matters for this particular
> context.
> 

Thanks! I'll amend the log.
> 
>> ---
>>  arch/x86/kernel/vmlinux.lds.S | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/x86/kernel/vmlinux.lds.S 
>> b/arch/x86/kernel/vmlinux.lds.S
>> index 2e0ee14229bf..2e56d694c491 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -102,12 +102,11 @@ jiffies = jiffies_64;
>>  PHDRS {
>>         text PT_LOAD FLAGS(5);          /* R_E */
>>         data PT_LOAD FLAGS(6);          /* RW_ */
>> -#ifdef CONFIG_X86_64
>> -#ifdef CONFIG_SMP
>> +#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
>>         percpu PT_LOAD FLAGS(6);        /* RW_ */
>>  #endif
>> -       init PT_LOAD FLAGS(7);          /* RWE */
>> -#endif
>> +       inittext PT_LOAD FLAGS(5);      /* R_E */
>> +       init PT_LOAD FLAGS(6);          /* RW_ */
>>         note PT_NOTE FLAGS(0);          /* ___ */
>>  }
>> 
>> @@ -227,9 +226,10 @@ SECTIONS
>>  #endif
>> 
>>         INIT_TEXT_SECTION(PAGE_SIZE)
>> -#ifdef CONFIG_X86_64
>> -       :init
>> -#endif
>> +       :inittext
>> +
>> +       . = ALIGN(PAGE_SIZE);
>> +
>> 
>>         /*
>>          * Section for code used exclusively before alternatives are 
>> run. All
>> @@ -241,6 +241,7 @@ SECTIONS
>>         .altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
>>                 *(.altinstr_aux)
>>         }
>> +       :init
>> 
>>         INIT_DATA_SECTION(16)
>> 
>> --
>> 2.37.4
>> 
