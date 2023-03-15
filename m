Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13396BB490
	for <lists+linux-efi@lfdr.de>; Wed, 15 Mar 2023 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCONZv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Mar 2023 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCONZu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Mar 2023 09:25:50 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652D7273B;
        Wed, 15 Mar 2023 06:25:47 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 935B640737A0;
        Wed, 15 Mar 2023 13:25:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 935B640737A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678886745;
        bh=5igAFA4dKdE8mXj3pZN7Akkxtzzw4a9m5+AgebeEnvQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IRt/7dZjLZW6Y7nbnNLrY8RSlpplYbxUbGbrNTRr0yTvQMzmCoNwn22mnt1fBI2si
         lyA+XjYveVqzvpRjgQLDYhqAl7hl5t6YQZ1xnE/4lAzIHImnf7FqL5BELrvUGofWgb
         sTA1htYkCubTQqqOX+fpGadWSMT6Egmg9yQw73Sg=
MIME-Version: 1.0
Date:   Wed, 15 Mar 2023 16:25:45 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 09/27] x86/boot: Remove mapping from page fault handler
In-Reply-To: <259a1148-faf0-4765-b777-6f36459c9307@app.fastmail.com>
References: <cover.1678785672.git.baskov@ispras.ru>
 <dab948690a74db1bb75d95aa7e0362deeca6dbf4.1678785672.git.baskov@ispras.ru>
 <259a1148-faf0-4765-b777-6f36459c9307@app.fastmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <909bd8fed79cfc295a269539e7c77a98@ispras.ru>
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

On 2023-03-14 23:33, Andy Lutomirski wrote:
> On Tue, Mar 14, 2023, at 3:13 AM, Evgeniy Baskov wrote:
>> After every implicit mapping is removed, this code is no longer 
>> needed.
>> 
>> Remove memory mapping from page fault handler to ensure that there are
>> no hidden invalid memory accesses.
> 
> This patch is *by far* the scariest of the bunch in my boot.  And it
> violates a basic principle of kernel development: it's better to run
> in degraded mode than to fail outright unless running in degraded mode
> is dangerous for some reason.
> 
> And this boot code is not actually meaningfully exposed to attack.
> Anyone who can get the boot code to consume garbage likely *already*
> controls the system, including anything that we might write to TPM or
> any other verification mechanism.
> 
> So I think this should log an error, set a flag to make sure we print
> an even louder error after full boot, but still add the mapping and
> keep trying.

Good point. This patch can be dropped and replaced by the loud warning,
since it is not required for the functioning of the rest of the series
it is here mainly to indicate bugs in the kernel rather than for the
increased protection. But I would not expect anything in the working
systems, I made my best to map all the things explicitly. And since
no code but the extraction code is supposed to be run (interrupts
are disabled and we are not using any UEFI services there), this should
be practically save to remove the implicit mapping.

And at least this allowed me to find out about the insufficient size of
the boot page tables which did not account for the ACPI and UEFI
mappings. (patch 4 "x86/boot: Increase boot page table size")

If this patch is dropped now, I can send the follow up patch later
adding the warning.

Thanks,
Evgeniy Baskov

> 
> --Andy
> 
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/ident_map_64.c | 26 
>> ++++++++++---------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>> 
...
