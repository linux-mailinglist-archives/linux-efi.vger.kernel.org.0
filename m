Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88C76B65DA
	for <lists+linux-efi@lfdr.de>; Sun, 12 Mar 2023 13:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCLMKI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Mar 2023 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCLMKI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Mar 2023 08:10:08 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DAE7DBA;
        Sun, 12 Mar 2023 05:10:06 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id ABC0E44C1011;
        Sun, 12 Mar 2023 12:10:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru ABC0E44C1011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678623004;
        bh=VChUI6KZnJGMnvBF3FzoVnKI9M+mUNERwVFRrmpoIZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yc8HbzFlfgFbI3nnOXrkNX6AtKvm8VrJzMXgm86+AjDAz9wadxLbDGsOX0WKqLI7m
         Pr+TSJhDBFlcQv++6bRZ8eo740yorThOsVxxdKHitN8pyZVyYP6rLCf8hxG8pTkz5f
         DBAld/E9WOO9Zz6VPc+q6tj5pxNXDqEdZsLbSIo0=
MIME-Version: 1.0
Date:   Sun, 12 Mar 2023 15:10:04 +0300
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
Subject: Re: [PATCH v4 21/26] efi/x86: Explicitly set sections memory
 attributes
In-Reply-To: <CAMj1kXHAeddy+6MjwgHLH7J=qAO0SaecB7ZGuHNT+13-r1VcQw@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <c38ad7a1b89aff743d4a29882a7022d97d4fea58.1671098103.git.baskov@ispras.ru>
 <CAMj1kXGzXLp20nbg-NoToENbDQhn1b0Gpi2s8f9DgSSM28BbeQ@mail.gmail.com>
 <f29b8efc018819cbb8202d13795ba89e@ispras.ru>
 <CAMj1kXHAeddy+6MjwgHLH7J=qAO0SaecB7ZGuHNT+13-r1VcQw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <414e462cf01e4809ba5b4713327803f9@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-11 20:39, Ard Biesheuvel wrote:
> On Sat, 11 Mar 2023 at 16:09, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> On 2023-03-10 18:20, Ard Biesheuvel wrote:
>> > On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> >>
>> >> Explicitly change sections memory attributes in efi_pe_entry in case
>> >> of incorrect EFI implementations and to reduce access rights to
>> >> compressed kernel blob. By default it is set executable due to
>> >> restriction in maximum number of sections that can fit before zero
>> >> page.
>> >>
>> >> Tested-by: Peter Jones <pjones@redhat.com>
>> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> >
>> > I don't think we need this patch. Firmware that cares about W^X will
>> > map the PE image with R-X for text/rodata and RW- for data/bss, which
>> > is sufficient, and firmware that doesn't is a lost cause anyway.
>> 
>> This patch were here mainly here to make .rodata non-executable and 
>> for
>> the UEFI handover protocol, for which attributes are usually not 
>> getting
>> applied.
>> 
>> Since the UEFI handover protocol is deprecated, I'll exclude patches
>> from
>> v5 and maybe submit it separately modified to apply attributes only 
>> when
>> booting via this protocol.
>> 
> 
> I think the issue here is that loaders that use the UEFI handover
> protocol use their own implementations of LoadImage/StartImage as
> well, and some of those tend to do little more than copy the image
> into memory and jump to the EFI handover protocol entry point, without
> even accounting for the image size in memory or clearing the bss.
> 

AFAIK this patch does not break loaders that load PE image as a flat
binary, since it only operates on ELF sections that are mapped 1-to-1.
But that's just the note for a future.

> To be honest, even though I understand the reason these had to be
> implemented, I'm a bit reluctant to cater for the needs of such
> loaders, given that these are all downstream distro forks of GRUB
> (with shim) with varying levels of adherence to the PE/COFF spec.
> 
> I'm happy to revisit this later if others feel this is important, but
> for the moment, I'd prefer it if we could focus on making the x86
> image work better with compliant loaders, which is what this series is
> primarily about.

That's very reasonable. I'll put this patch aside for now then.
