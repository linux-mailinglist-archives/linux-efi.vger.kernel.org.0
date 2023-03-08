Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484466B0E4D
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 17:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCHQPY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 11:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCHQPX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 11:15:23 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904A6586;
        Wed,  8 Mar 2023 08:15:22 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 98CF740737C6;
        Wed,  8 Mar 2023 16:15:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 98CF740737C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678292120;
        bh=6HCHXUJhJp0VIvr8sxomfDwRvRVkrxfUfl6ds5kRe8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M1NjzfVl3wVvCvZccFGigwqQSrSm4g6cN15uz2oilsnU0McX0b807Arj7OQYdC1ll
         Vcve7bZPLBGyRIbs+2rShB6JuuXQfJDic2vaWzZObqet5spYvzkHFuPCbgWs3ucwfr
         2iHptNIBm7Xp3E8di+148eO72nNijyAEveCV8fOU=
MIME-Version: 1.0
Date:   Wed, 08 Mar 2023 19:15:20 +0300
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
Subject: Re: [PATCH v4 06/26] x86/boot: Setup memory protection for bzImage
 code
In-Reply-To: <CAMj1kXFjQemVpHph2K+ysNO44uH3E7mjfc0o+JPV+gzi+mtoZA@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <63ea4796323a734c061ad774a68c88a47f5669a4.1671098103.git.baskov@ispras.ru>
 <CAMj1kXFjQemVpHph2K+ysNO44uH3E7mjfc0o+JPV+gzi+mtoZA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <5248590f6b1dad1732334af630035732@ispras.ru>
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

On 2023-03-08 13:47, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Use previously added code to use 4KB pages for mapping. Map compressed
>> and uncompressed kernel with appropriate memory protection attributes.
>> For compressed kernel set them up manually. For uncompressed kernel
>> used flags specified in ELF header.
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> 
> 
> This patch breaks the 'nokaslr' command line option (at least with
> SeaBIOS) unless I apply the hunk below:
> 

Oh, I didn't think of that option.. Thanks!
I will also add the check to the identity mapping,
so the warning won't be emitted with 'nokaslr'.

> 
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -329,7 +329,8 @@ static size_t parse_elf(void *output, unsigned
> long output_len,
> 
>         handle_relocations(output, output_len, virt_addr);
> 
> -       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE) ||
> +           cmdline_find_option_bool("nokaslr"))
>                 goto skip_protect;
> 
>         for (i = 0; i < ehdr.e_phnum; i++) {
> @@ -481,8 +482,10 @@ asmlinkage __visible void *extract_kernel(void
> *rmode, memptr heap,
>          * If KASLR is disabled input and output regions may overlap.
>          * In this case we need to map region excutable as well.
>          */
> -       unsigned long map_flags = MAP_ALLOC | MAP_WRITE |
> -                       (IS_ENABLED(CONFIG_RANDOMIZE_BASE) ? 0 : 
> MAP_EXEC);
> +       unsigned long map_flags = MAP_ALLOC | MAP_WRITE;
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE) ||
> +           cmdline_find_option_bool("nokaslr"))
> +               map_flags |= MAP_EXEC;
>         phys_addr = kernel_add_identity_map(phys_addr,
>                                             phys_addr + needed_size,
>                                             map_flags);
