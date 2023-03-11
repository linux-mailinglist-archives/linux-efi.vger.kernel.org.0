Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70E6B5D02
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCKOt0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 09:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCKOtY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 09:49:24 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C0510F85B;
        Sat, 11 Mar 2023 06:49:21 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8D5F940737C5;
        Sat, 11 Mar 2023 14:49:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8D5F940737C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678546159;
        bh=bXR0wVthFGOHXm8iZRJxzhw/jF3u2+uvzl6NREjvGaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yq1XRrO+G6JtjEfebIJeemsQswU3CCcPVpg31TCH2G0DfVJNRxHlxrCKebcdJXk+P
         VmYoidNqAj38GNnR/osfd5mHkmAoEnwP4WOzDN6Lz4ze75I/34Af5z74mc5muVgz+D
         imVX53ONtFKipc0oeX0dpCZn7GmtgysKntbGCFE8=
MIME-Version: 1.0
Date:   Sat, 11 Mar 2023 17:49:19 +0300
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
Subject: Re: [PATCH v4 17/26] x86/boot: Reduce size of the DOS stub
In-Reply-To: <CAMj1kXHnQZ2EDg1F_whTPHajYvqox7Ss35aqUyJuC8RLyiuCxg@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <cb62472011a0c4151276b6a05b83b60b1bf6f352.1671098103.git.baskov@ispras.ru>
 <CAMj1kXHnQZ2EDg1F_whTPHajYvqox7Ss35aqUyJuC8RLyiuCxg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <ec07e6f7af7b901ad3ff1aa9a8c8fbcb@ispras.ru>
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

On 2023-03-10 17:59, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> This is required to fit more sections in PE section tables,
>> since its size is restricted by zero page located at specific offset
>> after the PE header.
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> 
> I'd prefer to rip this out altogether.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=9510f6f04f579b9a3f54ad762c75ab2d905e37d8

Sounds great! Can I replace this patch with yours in v5?

> 
> (and refer to the other thread in linux-efi@)

Which thread exactly? The one about the removal of
real-mode code?

> 
>> ---
>>  arch/x86/boot/header.S | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> index 9338c68e7413..9fec80bc504b 100644
>> --- a/arch/x86/boot/header.S
>> +++ b/arch/x86/boot/header.S
>> @@ -59,17 +59,16 @@ start2:
>>         cld
>> 
>>         movw    $bugger_off_msg, %si
>> +       movw    $bugger_off_msg_size, %cx
>> 
>>  msg_loop:
>>         lodsb
>> -       andb    %al, %al
>> -       jz      bs_die
>>         movb    $0xe, %ah
>>         movw    $7, %bx
>>         int     $0x10
>> -       jmp     msg_loop
>> +       decw    %cx
>> +       jnz     msg_loop
>> 
>> -bs_die:
>>         # Allow the user to press a key, then reboot
>>         xorw    %ax, %ax
>>         int     $0x16
>> @@ -90,10 +89,9 @@ bs_die:
>> 
>>         .section ".bsdata", "a"
>>  bugger_off_msg:
>> -       .ascii  "Use a boot loader.\r\n"
>> -       .ascii  "\n"
>> -       .ascii  "Remove disk and press any key to reboot...\r\n"
>> -       .byte   0
>> +       .ascii  "Use a boot loader. "
>> +       .ascii  "Press a key to reboot"
>> +       .set    bugger_off_msg_size, . - bugger_off_msg
>> 
>>  #ifdef CONFIG_EFI_STUB
>>  pe_header:
>> --
>> 2.37.4
>> 
