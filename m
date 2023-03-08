Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE46B0E3B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjCHQKb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 11:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjCHQKJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 11:10:09 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF55FA55;
        Wed,  8 Mar 2023 08:09:36 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0C94940737A9;
        Wed,  8 Mar 2023 16:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0C94940737A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678291775;
        bh=fjEJAf1XjRz8zobb5nJ/fvnnpKMaijcYYspk3G4Wetk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sGLN+QFfw08MteEgTzzMbCrRlS/Qx6jrhSRyGUgxeb4AuIwpzLDrhjttwEeujji9T
         pdvffLLsD2kahh/gxu4DoHZoSiq8RXP/2QgdlDa7n58vlEpgsZPmtjC8Jp3kY1rscH
         HTfV3J6Pnfro8TgCLs+gtqwg5fy60OpC8YQtzn8g=
MIME-Version: 1.0
Date:   Wed, 08 Mar 2023 19:09:34 +0300
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
Subject: Re: [PATCH v4 08/26] x86/boot: Map memory explicitly
In-Reply-To: <CAMj1kXGP1k-FoG6GQ2u9ZRiGnxogO=3bLWPfcyOEUOfZG3TRJw@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <760c19466ac26c09edb76e64d8c4812ff4aa7365.1671098103.git.baskov@ispras.ru>
 <CAMj1kXFtEZtso0Gcuj-PhGiK1QRhp9SDFLwouX3qdgSha=ACjA@mail.gmail.com>
 <CAMj1kXGP1k-FoG6GQ2u9ZRiGnxogO=3bLWPfcyOEUOfZG3TRJw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <6811318e7ea207a1037f337184dc19a6@ispras.ru>
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

On 2023-03-08 13:28, Ard Biesheuvel wrote:
> On Wed, 8 Mar 2023 at 10:38, Ard Biesheuvel <ardb@kernel.org> wrote:
>> 
>> On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> >
>> > Implicit mappings hide possible memory errors, e.g. allocations for
>> > ACPI tables were not included in boot page table size.
>> >
>> > Replace all implicit mappings from page fault handler with
>> > explicit mappings.
>> >
>> 
>> I agree with the motivation but this patch seems to break the boot
>> under SeaBIOS/QEMU, and I imagine other legacy BIOS boot scenarios as
>> well.
>> 
>> Naively, I would assume that there is simply a legacy BIOS region that
>> we fail to map here, but I am fairly clueless when it comes to non-EFI
>> x86 boot so take this with a grain of salt.
>> 
> 
> The below seems to help - not sure why exactly, but apparently legacy
> BIOS needs the bootparams struct to be mapped writable?

I think I got too eager adding mappings to everything.
In the process_efi_entries() bootparams should already be mapped, so
I will just remove the call. And AFAIK bootparams is indeed gets
written to.

> 
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -31,6 +31,7 @@
>  #include <linux/ctype.h>
>  #include <generated/utsversion.h>
>  #include <generated/utsrelease.h>
> +#include <asm/shared/pgtable.h>
> 
>  #define _SETUP
>  #include <asm/setup.h> /* For COMMAND_LINE_SIZE */
> @@ -688,7 +689,7 @@ process_efi_entries(unsigned long minimum,
> unsigned long image_size)
>         u32 nr_desc;
>         int i;
> 
> -       kernel_add_identity_map((unsigned long)e, (unsigned long)(e + 
> 1), 0);
> +       kernel_add_identity_map((unsigned long)e, (unsigned long)(e +
> 1), MAP_WRITE);
> 
>         signature = (char *)&e->efi_loader_signature;
>         if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&

Thanks,
Evgeniy Baskov
