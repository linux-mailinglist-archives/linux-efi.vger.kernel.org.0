Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7B6B5CD8
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 15:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCKOax (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 09:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCKOaw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 09:30:52 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BE9886B;
        Sat, 11 Mar 2023 06:30:50 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 89D5D44C1012;
        Sat, 11 Mar 2023 14:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 89D5D44C1012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678545047;
        bh=Nbq/lOJNuWDgNN1PyAkdV5e1xdYh+ryqImy0Jz9nAc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=efQFrC8rZeXevySnYIbJpAuK02kjHtTu/os7ic3mjrk16BzzpVOZb9GjQWH1nqHBh
         cIjizIIy3Jrn3UmiJ4T2cDCHuXPPnEBktshE4WpscKsVD2sYItLnMptxHJTLgsI4e0
         gWo6cJXzX9/gzDHjr5taLP2AWv/iFOHewx/JSEew=
MIME-Version: 1.0
Date:   Sat, 11 Mar 2023 17:30:47 +0300
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
Subject: Re: [PATCH v4 01/26] x86/boot: Align vmlinuz sections on page size
In-Reply-To: <CAMj1kXFPtA4f3kW1U2-LAQFEuOvLsis=Ursj40xRrg-cvtK=gA@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <8211c633eb5dceeabee2996a4db91cd971cf7c77.1671098103.git.baskov@ispras.ru>
 <CAMj1kXFPtA4f3kW1U2-LAQFEuOvLsis=Ursj40xRrg-cvtK=gA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <1df839eccd88063485d1702d5f98d5b8@ispras.ru>
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

On 2023-03-10 17:43, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> To protect sections on page table level each section
>> needs to be aligned on page size (4KB).
>> 
>> Set sections alignment in linker script.
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/vmlinux.lds.S | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S 
>> b/arch/x86/boot/compressed/vmlinux.lds.S
>> index 112b2375d021..6be90f1a1198 100644
>> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> @@ -27,21 +27,27 @@ SECTIONS
>>                 HEAD_TEXT
>>                 _ehead = . ;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
>>         .rodata..compressed : {
>> +               _compressed = .;
>>                 *(.rodata..compressed)
> 
> Can you just move this bit into the rodata section below?

I don't think that easily possible, as the layout need
to stay compatible with in-place extraction for non-UEFI boot.
For that execution path the code in .head.text moves everything
behind it to the end of the extraction buffer and extraction
code overwrites compressed kernel blob progressively during
extraction. And that is why we have effectively have two code
sections...

> 
>> +               _ecompressed = .;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
>>         .text : {
> 
> Please use
> 
> .text : ALIGN(PAGE_SIZE) {
> 
> which marks the section as being page aligned, rather than just being
> placed on a 4k boundary.

Will fix in v5.

> 
>>                 _text = .;      /* Text */
>>                 *(.text)
>>                 *(.text.*)
>>                 _etext = . ;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
>>         .rodata : {
>>                 _rodata = . ;
>>                 *(.rodata)       /* read-only data */
>>                 *(.rodata.*)
>>                 _erodata = . ;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
>>         .data : {
>>                 _data = . ;
>>                 *(.data)
>> --
>> 2.37.4
>> 
