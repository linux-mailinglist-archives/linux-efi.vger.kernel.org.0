Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD16DBBB7
	for <lists+linux-efi@lfdr.de>; Sat,  8 Apr 2023 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDHPFQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Apr 2023 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHPFQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Apr 2023 11:05:16 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197AD53E;
        Sat,  8 Apr 2023 08:05:15 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5A2FE44C1018;
        Sat,  8 Apr 2023 15:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5A2FE44C1018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1680966313;
        bh=5pfmOwkZJsBqDgGx/UlUrDPqAhjWm7/tgfo16oqs+Qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BnRhXaPtVmpocFe98xrQuu5lDo0cvkyQeiT0s9QbLbGVRYzyIrMW47CZYqsrPlHtk
         rcMHdkhm7+3F/ZmBh0529Yuf7ZdfSl1S9fOw8ZFhErrWQZ+owmLsTcCURT43YkrILk
         trnErhltmh9ylLvg7ZVioHl+BRzWh13kIA22ll1Y=
MIME-Version: 1.0
Date:   Sat, 08 Apr 2023 18:05:13 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 02/27] x86/build: Remove RWX sections and align on 4KB
In-Reply-To: <20230405174059.GEZC2yq9WiXFsICyEy@fat_crate.local>
References: <cover.1678785672.git.baskov@ispras.ru>
 <edf3afbdcd87cb6c61815068084ac6de35be15a2.1678785672.git.baskov@ispras.ru>
 <20230405174059.GEZC2yq9WiXFsICyEy@fat_crate.local>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <7e59eaf5da2338b71d1c188e784e2ef8@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-04-05 20:40, Borislav Petkov wrote:
> On Tue, Mar 14, 2023 at 01:13:29PM +0300, Evgeniy Baskov wrote:
>> Avoid creating sections simultaneously writable and readable to 
>> prepare
>> for W^X implementation for the kernel itself (not the decompressor).
>> Align kernel sections on page size (4KB) to allow protecting them in 
>> the
>> page tables.
>> 
>> Split init code form ".init" segment into separate R_X ".inittext"
> 
> s/form/from/

Thanks!

> 
>> segment and make ".init" segment non-executable.
> 
> "... and make the .init segment RW_."

Will fix.

> 
>> Also add these segments to x86_32 architecture for consistency.
> 
> Same comment as before: please refrain from talking about the *what* in
> a commit message but about the *why*.
> 
> And considering the matter, you have a *lot* of *why* to talk about. 
> :-)
> 
> Pls check your whole set.

I'll try do make descriptions of patches more elaborate and to better
reflect the reasoning behind the changes before resubmitting, thanks.

> 
>> Currently paging is disabled in x86_32 in compressed kernel, so
>> protection is not applied anyways, but .init code was incorrectly
>> placed in non-executable ".data" segment. This should not change
>> anything meaningful in memory layout now, but might be required in 
>> case
>> memory protection will also be implemented in compressed kernel for
>> x86_32.
> 
> I highly doubt that - no one cares about 32-bit x86 anymore.
> 

True, but in theory it's still possible and also the change
makes things more correct.

>> @@ -226,9 +225,10 @@ SECTIONS
>>  #endif
>> 
>>  	INIT_TEXT_SECTION(PAGE_SIZE)
>> -#ifdef CONFIG_X86_64
>> -	:init
>> -#endif
>> +	:inittext
>> +
>> +	. = ALIGN(PAGE_SIZE);
>> +
>> 
>>  	/*
>>  	 * Section for code used exclusively before alternatives are run. 
>> All
>> @@ -240,6 +240,7 @@ SECTIONS
>>  	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
>>  		*(.altinstr_aux)
>>  	}
>> +	:init
> 
> Why isn't this placed after inittext but here?

Because, AFAIK, :init is a part of a section syntax so it must
come after the brace, at least according to the documentation:

https://sourceware.org/binutils/docs/ld/PHDRS.html

> 
> I'm thinking you wanna have:
> 
> 	:inittext
> 	. = ALIGN..
> 	:init
> 	<rest>
> 
> Thx.
