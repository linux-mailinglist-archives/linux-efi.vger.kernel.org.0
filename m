Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045206B2C79
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 18:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCIR7R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 12:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCIR7O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 12:59:14 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247BE20C4
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 09:59:09 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 852D74077AEC;
        Thu,  9 Mar 2023 17:59:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 852D74077AEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678384747;
        bh=EnLRkd8goNbY7ucAVPqHL+QWlJ1+ZlWnVanpAglRp10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dbo9deGpCrrFRpSZ6mocT8QAbBUKzjSCfM1W+z4MmbzztVldzI6gKAjEciN5+7j+Q
         Z9Ov4NPzeqqsUeCSFcjnedASDjRbUUcmLK8GhzyIJp8yF8gcj0HzZndMkwdyVr587g
         iHG/pQSNG3/zoLdzrmWc9AMPW6fmgyz9p2ec0k/0=
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 20:59:07 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Re: [RFC PATCH 0/4] efi: x86: Use strict W^X mappings in PE/COFF
 header
In-Reply-To: <20230308202209.2980947-1-ardb@kernel.org>
References: <20230308202209.2980947-1-ardb@kernel.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <29877cfc0be87c081e175608003b709a@ispras.ru>
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

On 2023-03-08 23:22, Ard Biesheuvel wrote:
> This is a follow-up to work proposed by Evgeny to tighten memory
> permissions used by the EFI stub and subsequently by the decompressor 
> on
> x86.
> 
> Instead of going out of our way to make more space in the first 500
> bytes of the image, and relying on non-1:1 mapped sections (which is
> risky in the context of bespoke PE loaders), these patches reorganize
> the header so the PE header comes after the x86 setup header, and can 
> be
> extended at will.
> 
> I pushed a branch at [1] that combines this with v4 of Evgeny's series
> (after some minor surgery, e.g., to reorder the text and rodata 
> sections
> so they are contiguous)
> 
> We might split off the rodata section as well, and give it 
> read/non-exec
> permissions, but I'd like to discuss the approach first, and perhaps 
> get
> some testing data points.
> 
> Cc: Evgeniy Baskov <baskov@ispras.ru>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: "Limonciello, Mario" <mario.limonciello@amd.com>
> 
> [0] 
> https://lore.kernel.org/linux-efi/cover.1671098103.git.baskov@ispras.ru/
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-x86-nx-v4
> 
> Ard Biesheuvel (4):
>   efi: x86: Use private copy of struct setup_header
>   efi: x86: Move PE header after setup header
>   efi: x86: Drop alignment section header flags
>   efi: x86: Split PE/COFF .text section into .text and .data
> 
>  arch/x86/boot/Makefile                  |  2 +-
>  arch/x86/boot/header.S                  | 52 +++++++++-----------
>  arch/x86/boot/setup.ld                  |  1 +
>  arch/x86/boot/tools/build.c             | 38 +++++++++-----
>  drivers/firmware/efi/libstub/x86-stub.c | 43 +++-------------
>  5 files changed, 59 insertions(+), 77 deletions(-)

I've quickly looked through these patches but I'll do more testing 
tomorrow.

This approach seems to be better than mine if it will work. I've tried
the similar thing but I did not think of creating the local copy of the
bootparams and the attempt to map them did not work since the PE loader
I am trying to get kernel booting with does not accept sections before
the PE header. But since the bootparams is inside the padding and is
not used, it should be fine.

But this will still need more changes to work properly with stricter PE
loaders like the one that I've mentioned in my patch series [1].

The image should also have 4K aligned section virtual addresses and 
sizes
(even on .reloc and .compat AFAIK), otherwise UEFI will ignore memory
attributes (or refuse to load the kernel). Another desired thing is 
having
adjacent section with no padding in between them, since [1] does have a
mode that requires sections them to be adjacent. 
(SizeOfHeaders/header_size
should also be set to the size of setup since it is also checked to be
adjacent to the first section.)

I did not do the one-to-one mapping of file and virtual addresses since 
it
would require almost 4K paddings for the auxiliary sections.

[1] https://github.com/acidanthera/audk/tree/secure_pe

Thanks,
Evgeniy Baskov
