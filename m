Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CEE6BB48F
	for <lists+linux-efi@lfdr.de>; Wed, 15 Mar 2023 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCONZu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Mar 2023 09:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCONZt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Mar 2023 09:25:49 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD2C67D;
        Wed, 15 Mar 2023 06:25:45 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 50F98406BB55;
        Wed, 15 Mar 2023 13:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 50F98406BB55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678886741;
        bh=w+l8fFrVX6FIKmLxm+gV3mOZF4Hp0Xy8bNIfb/p6EvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qPcpvH+rSI0ai+7mPZ+q9uCx+qPKCLA7wwPtGLQzE/eGxT1db9tITwwEPXoHP4mJ5
         eOOV3v8UJ+qo7yrs4MBvNHmVUl0pUF84G3pymE0rYU5U397RaPVJxTGQ9tx/3lF37m
         qzkbKbna2QFOzQk1ICxurTAGwN03I3klV9UGpHgI=
MIME-Version: 1.0
Date:   Wed, 15 Mar 2023 16:25:41 +0300
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
Subject: Re: [PATCH v5 00/27] x86_64: Improvements at compressed kernel stage
In-Reply-To: <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
References: <cover.1678785672.git.baskov@ispras.ru>
 <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c44d6b6b6f5d3c7f6262581bf7a3920b@ispras.ru>
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

On 2023-03-15 00:23, Andy Lutomirski wrote:
> On Tue, Mar 14, 2023, at 3:13 AM, Evgeniy Baskov wrote:
>> This patchset is aimed
>> * to improve UEFI compatibility of compressed kernel code for x86_64
>> * to setup proper memory access attributes for code and rodata 
>> sections
>> * to implement W^X protection policy throughout the whole execution
>>   of compressed kernel for EFISTUB code path.
> 
> The overall code quality seems okay, but I have some questions as to
> what this is for.  The early boot environment is not exposed to most
> sorts of attacks -- there's no userspace, there's no network, and
> there is not a whole lot of input that isn't implicitly completely
> trusted.
> 
> What parts of this series are actually needed to get these fancy new
> bootloaders to boot Linux?  And why?

Well, most of the series is needed, except for may be adding W^X
for the non-UEFI boot path (patches 3-9), but those add changes,
required for booting via UEFI, like memory protection call-backs.
And since the important callbacks are already in-place W^X for
non-UEFI won't be too undesired property.

The most part of this series (3-16,26,27) implements W^X, and
the remaining patches improves the compatibility of PE, which
includes:

* Removing W+X sections (which is now required as Gerd have already
   mentioned or at least very desired)
* Aligning sections to the page size in memory and to minimal
   file alignment in file.
* Aligning data structures on their natural alignment
   (e.g. [2] requires it)
* Filling more PE header fields to their actual values.
* Removing alignment flags on sections, which according to
   the spec, is only for object files.
* Filling in relocation data directory and its rounding the size
   to 4 bytes.

Most of this work is done in the patch 24 "x86/build: Make generated
PE more spec compliant", but it also requires working W^X due to
the removal of W+X sections and some clean-up work from patches
17-23.

> 
>> 
>> Kernel is made to be more compatible with PE image specification [3],
>> allowing it to be successfully loaded by stricter PE loader
>> implementations like the one from [2]. There is at least one
>> known implementation that uses that loader in production [4].
>> There are also ongoing efforts to upstream these changes.
> 
> Can you clarify
> 
>> 
>> Also the patchset adds EFI_MEMORY_ATTTRIBUTE_PROTOCOL, included into
>> EFI specification since version 2.10, as a better alternative to
>> using DXE services for memory protection attributes manipulation,
>> since it is defined by the UEFI specification itself and not UEFI PI
>> specification. This protocol is not widely available so the code
>> using DXE services is kept in place as a fallback in case specific
>> implementation does not support the new protocol.
>> One of EFI implementations that already support
>> EFI_MEMORY_ATTTRIBUTE_PROTOCOL is Microsoft Project Mu [5].
> 
> Maybe make this a separate series?

This now is just one fairly straight forward patch, since the protocol
definitions are already got accepted and the protocol is used elsewhere
in the EFISTUB. This patch would also have to be replaced, rather than
removed if it's made a separate series, since it adds a warning about
W+X mappings.

> 
>> 
>> Kernel image generation tool (tools/build.c) is refactored as a part
>> of changes that makes PE image more compatible.
>> 
>> The patchset implements memory protection for compressed kernel
>> code while executing both inside EFI boot services and outside of
>> them. For EFISTUB code path W^X protection policy is maintained
>> throughout the whole execution of compressed kernel. The latter
>> is achieved by extracting the kernel directly from EFI environment
>> and jumping to it's head immediately after exiting EFI boot services.
>> As a side effect of this change one page table rebuild and a copy of
>> the kernel image is removed.
> 
> I have no problem with this, but what's it needed for?

The one hard  part that made the series more complicated is that
non-UEFI (or rather the only) boot path relocates the kernel, which
messes up the memory protection for sections set by the UEFI. I did not
want to remove the support of in-place extraction and relocation, when
loaded in inappropriate place, for the non-UEFI boot path, which is why
extraction from boot services was implemented. A proper W^X in EFISTUB
is a side effect, but the desired one.

The alternative would be to make the whole image RWX after the EFISTUB
execution. But the current approach is a lot nicer solution.

> 
>> 
>> Memory protection inside EFI environment is controlled by the
>> CONFIG_DXE_MEM_ATTRIBUTES option, although with these patches this
>> option also control the use EFI_MEMORY_ATTTRIBUTE_PROTOCOL and memory
>> protection attributes of PE sections and not only DXE services as the
>> name might suggest.
>> 
> 
>> [1]
>> https://lore.kernel.org/lkml/893da11995f93a7ea8f7485d17bf356a@ispras.ru/
>> [2] https://github.com/acidanthera/audk/tree/secure_pe
> 
> Link is broken

Ah, sorry, the branch was merged into master since I've first posted
the series, so the working link is:

https://github.com/acidanthera/audk

The loader itself is here:

https://github.com/acidanthera/audk/tree/master/MdePkg/Library/BasePeCoffLib2

> 
>> [3]
>> https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
> 
> I skimmed this very briefly, and I have no idea what I'm supposed to
> look at.  This is the entire PE spec!

I gave some explanations above, which are mostly the duplicates of
the patch 24 "x86/build: Make generated PE more spec compliant"
commit message.

Thanks,
Evgeniy Baskov
