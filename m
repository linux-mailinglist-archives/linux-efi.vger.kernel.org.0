Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB0605FBB
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJTMHU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 08:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJTMHT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 08:07:19 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE018D469;
        Thu, 20 Oct 2022 05:07:18 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id AD524419E9CC;
        Thu, 20 Oct 2022 12:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AD524419E9CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666267636;
        bh=CLe/bnN98OW5tE8+acaQniHU65a/oz8vjoeS4/v74Gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lmiLgTujqQc2B0kY76LCiMZ/wsq2CuwSVFKokBNsY5RAwEkkN/puW/DKC7ZGX9Ev2
         GtBOKYRC/+mUjv6HdyK4VwEkpCMg4wqzNTW4DsI70J5xkpYHdtsPu7gQkOu2Mdrbvm
         OK/nx5m9hEnfQintilxIpwIOuM3LvelHmtSOfa3I=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 15:07:16 +0300
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
Subject: Re: [PATCH 06/16] x86/boot: Setup memory protection for bzImage code
In-Reply-To: <CAMj1kXG59mtzbJoREgr4GA9QJkORcYb-XuDr3VoZ-3XYLy7k2g@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <2fd61a79a1e6885dc47ec826b62a936dd88a0a16.1662459668.git.baskov@ispras.ru>
 <CAMj1kXG59mtzbJoREgr4GA9QJkORcYb-XuDr3VoZ-3XYLy7k2g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <e4774b9c13a2bbb9f976dd0e00bebd07@ispras.ru>
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

On 2022-10-19 10:17, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Use previously added code to use 4KB pages for mapping. Map compressed
>> and uncompressed kernel with appropriate memory protection attributes.
>> For compressed kernel set them up manually. For uncompressed kernel
>> used flags specified in ELF header.
>> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
...
>> 
>>  /*
>>   * Locally defined symbols should be marked hidden:
>> @@ -578,6 +578,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>>         pushq   %rsi
>>         call    load_stage2_idt
>> 
>> +       call    startup32_enable_nx_if_supported
>>         /* Pass boot_params to initialize_identity_maps() */
>>         movq    (%rsp), %rdi
>>         call    initialize_identity_maps
>> @@ -602,6 +603,28 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>>         jmp     *%rax
>>  SYM_FUNC_END(.Lrelocated)
>> 
>> +SYM_FUNC_START_LOCAL_NOALIGN(startup32_enable_nx_if_supported)
> 
> Why the startup32_ prefix for this function name?

Oh, right there is no reasons, I will remove it.
...
>>  /*
>>   * Adds the specified range to the identity mappings.
>>   */
>> -void kernel_add_identity_map(unsigned long start, unsigned long end)
>> +unsigned long kernel_add_identity_map(unsigned long start,
>> +                                     unsigned long end,
>> +                                     unsigned int flags)
>>  {
>>         int ret;
>> 
>>         /* Align boundary to 2M. */
>> -       start = round_down(start, PMD_SIZE);
>> -       end = round_up(end, PMD_SIZE);
>> +       start = round_down(start, PAGE_SIZE);
>> +       end = round_up(end, PAGE_SIZE);
>>         if (start >= end)
>> -               return;
>> +               return start;
>> +
>> +       /* Enforce W^X -- just stop booting with error on violation. 
>> */
>> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) &&
>> +           (flags & (MAP_EXEC | MAP_WRITE)) == (MAP_EXEC | 
>> MAP_WRITE))
>> +               error("Error: W^X violation\n");
>> +
> 
> Do we need to add a new failure mode here?

It seems reasonable to me to leave it here to avoid unintentionally 
introducing
RWX mappings. And this function can already fail on OOM situation.
I can change it to warning if failure is too harsh in this situation.
> 
>> +       bool nx = !(flags & MAP_EXEC) && has_nx;
>> +       bool ro = !(flags & MAP_WRITE);
>> +
...
>> -       kernel_add_identity_map((unsigned long)_head, (unsigned 
>> long)_end);
>> -       boot_params = rmode;
>> -       kernel_add_identity_map((unsigned long)boot_params, (unsigned 
>> long)(boot_params + 1));
>> +       extern char _head[], _ehead[];
> 
> Please move these extern declarations out of the function scope (at
> the very least)

I will move it to misc.h then, there are already some of these 
declarations present.

> 
>> +       kernel_add_identity_map((unsigned long)_head,
>> +                               (unsigned long)_ehead, MAP_EXEC | 
>> MAP_NOFLUSH);
>> +
>> +       extern char _compressed[], _ecompressed[];
>> +       kernel_add_identity_map((unsigned long)_compressed,
>> +                               (unsigned long)_ecompressed, MAP_WRITE 
>> | MAP_NOFLUSH);
>> +
>> +       extern char _text[], _etext[];
>> +       kernel_add_identity_map((unsigned long)_text,
>> +                               (unsigned long)_etext, MAP_EXEC | 
>> MAP_NOFLUSH);
>> +
>> +       extern char _rodata[], _erodata[];
>> +       kernel_add_identity_map((unsigned long)_rodata,
>> +                               (unsigned long)_erodata, MAP_NOFLUSH);
>> +
> 
> Same question as before: do we really need three different regions for
> rodata+text here?

As I already told, I think, its undesirable to leave compressed kernel 
blob
(and .rodata) executable, as it it will provide higher attack surface if 
some
control flow interception vulnerability in this code would be 
discovered,
and though I am not aware of such vulnerabilities to be present 
currently,
I think, additional security is not redundant, since it can be provided 
almost
for free.

I can merge these regions, if you think it does not worth it.

> 
...
>> +                       /*
>> +                        * Simultaneously readable and writable 
>> segments are
>> +                        * violating W^X, and should not be present in 
>> vmlinux image.
>> +                        */
>> +                       if ((phdr->p_flags & (PF_X | PF_W)) == (PF_X | 
>> PF_W))
>> +                               error("W^X violation for ELF 
>> segment");
>> +
> 
> Can we catch this at build time instead?

Thanks, thats great idea! I will implement that in tools/build.c

> 
...
>> +#else
>> +static inline unsigned long kernel_add_identity_map(unsigned long 
>> start,
>> +                                                   unsigned long end,
>> +                                                   unsigned int 
>> flags)
>> +{
>> +       (void)flags;
>> +       (void)end;
> 
> Why these (void) casts? Can we just drop them?
> 

Unused parameters used to cause warnings for me here somehow...
I will drop them.
