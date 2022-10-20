Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3294F605E98
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJTLPl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJTLP2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 07:15:28 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34315A325;
        Thu, 20 Oct 2022 04:15:23 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 34561419E9C7;
        Thu, 20 Oct 2022 11:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 34561419E9C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666264521;
        bh=tnQUIpaUoSUhMRbn1sP4W0MAUNcif6nai7PaNRHEOr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IxmYSXRnzxe7iuap7CBMtX62Wsuc9pl7UGw2DXTlQRb9dfAbLBjApGqS8EeMo9yJP
         zfRtv+uu+SnOL1oW54rBSiEFuoIVOPj/PVS/FMAGA5ITbewlUzF/Qen2Fl4N1cwy3r
         skqQ7TgGDQfapGocShrStSpXiAQcYp4/z8COA360=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 14:15:21 +0300
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
Subject: Re: [PATCH 02/16] x86/build: Remove RWX sections and align on 4KB
In-Reply-To: <CAMj1kXFyZJD5FnjWDEZbpzZM=T-676Z4q7nzEQAxp=zBAFGktw@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <aac3ce7c5aa706269d468fbe16129ee383deac2e.1662459668.git.baskov@ispras.ru>
 <CAMj1kXFyZJD5FnjWDEZbpzZM=T-676Z4q7nzEQAxp=zBAFGktw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <3261d02e8e6175a3cb122467b1fd0063@ispras.ru>
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

On 2022-10-19 10:04, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:41, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Avoid creating sections with maximal privileges to prepare for W^X
> 
> privileges
> 
>> implementation. Align sections on page size (4KB) to allow protecting
>> them in page table.
>> 
> 
> in the page tables.
> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/kernel/vmlinux.lds.S | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/x86/kernel/vmlinux.lds.S 
>> b/arch/x86/kernel/vmlinux.lds.S
>> index 15f29053cec4..6587e0201b50 100644
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
> 
> Please explain in the commit log how this change affects X86_32
> 
>>         note PT_NOTE FLAGS(0);          /* ___ */
>>  }
>> 
>> @@ -226,9 +225,10 @@ SECTIONS
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
>> @@ -240,6 +240,7 @@ SECTIONS
>>         .altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
>>                 *(.altinstr_aux)
>>         }
>> +       :init
>> 
>>         INIT_DATA_SECTION(16)
>> 
>> --
>> 2.35.1
>> 

Thanks for pointing you, I'll fix all mentioned nitpicks before sending
this again.
