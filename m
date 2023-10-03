Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34E7B5EE6
	for <lists+linux-efi@lfdr.de>; Tue,  3 Oct 2023 04:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjJCCDJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Oct 2023 22:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbjJCCDJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Oct 2023 22:03:09 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488FDC;
        Mon,  2 Oct 2023 19:03:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id CE95C32009BD;
        Mon,  2 Oct 2023 22:03:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 02 Oct 2023 22:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696298580; x=1696384980; bh=/r
        hTflYoPwnnmnQhWCyTwhi8FB2reVSWDhY2bHzcxhs=; b=SFTMUiALgcbhCjiXxi
        FM3zEpPlAMpB3OcfaDVfRKiXoAm0jS1j3eqmpE1aDJxWgtwIsVtIvy62M/md1+Cp
        XnnAe72GPO/SX+2YHZ3hBeeVuQZeCgtWaJLUHajyf+YB37lyem3czNbw8lau9j5Z
        wRRI28WZLw8hRtEYhjyQwHCbkS2KiqcrwXd1KlswpUWdQorq5binvBGumnkBLtHc
        gZrjHgeEWevnONhZIVNWgOQSBfeQvxOh9JHaYczapwIx2mWy6Pf7wvllhKOH/mL9
        joJN3oVg3FtU/B3aMrtoQBaL0SlVB7l8nx5/tAUZKcdEASz7NSy637elT6+0sAHI
        l64A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696298580; x=1696384980; bh=/rhTflYoPwnnm
        nQhWCyTwhi8FB2reVSWDhY2bHzcxhs=; b=d+APmJxtvAAm0wTWWJMUS0n7GXC4U
        CL+Azk+cJqRrJreG131PjZoECN2JDPKdgzoG8hIh7o7lmRukCJFiwCy2VUufQBjj
        qiCLS/n7iV4sHWuiMWrm2P25K5xj2rmCGcNPqZY6IhBghipaBaWSu3k5DSnAtOjO
        gUiPYs47vs91LFmf7xVMyUw1SuKz0tlHoKsN45KedCh/SxAcQiU3+3ZGwFqEGBJ0
        wI9ayQa+7OVluMQ+v5kwaTJJGQd2SWNEMpZWPwW4C9Dz2wsw66AyO9+PoLulkT/j
        JQQ89VgKSdJUySX9FaZJoM8178f2TyeBgkN+T+5c7MZ2hmOr6jWljnvLw==
X-ME-Sender: <xms:U3YbZSj1m82saTiMtgQZFJwwCt732BNDyxJr10-sd3faHThNByWkHg>
    <xme:U3YbZTBuf6JUqwWljfu_7fRyr3p0MO8EjWxQn32i-QVEotsvtibg2R7kBcqodvY5Z
    o-9F0pa7JOIbqVZPKM>
X-ME-Received: <xmr:U3YbZaFi4dhGLFNlidCHNE_5EQeJP_c6nvIPgA6529q8CnpXBPgd5ktg7kmJkA3Kfo0KBSfSxD2esk227abqeoLyfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeimdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrhcuoehkvghrnhgvlhesjhhfrg
    hrrhdrtggtqeenucggtffrrghtthgvrhhnpedukeegffdtfeeihfehteevvdeiueetteel
    gfefvdfhleeufeegieduieduhfekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:U3YbZbQQ46XiWmR0LV9mP1rbb0Xrp_U7toyQpqwiPqv4xKfFUpKW3g>
    <xmx:U3YbZfyY41xOIz04Ua5Qv4_SKCvM5v0y1pnvEheHtLzSviFzeXc1Vg>
    <xmx:U3YbZZ4nkRnTEpt10v_Ex6o9-L0WUowm4uVxFkc9qkBMD80fZ-kjIg>
    <xmx:VHYbZSrvZyl1x9TQaHgoQn2ZOjsuEmhzK_gsf5KNrC_guCwI-4DncQ>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Oct 2023 22:02:57 -0400 (EDT)
Date:   Tue, 3 Oct 2023 04:02:54 +0200
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
Message-ID: <ZRt2ToOHm2XT8MlU@desktop>
References: <20230912090051.4014114-17-ardb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12 09:00:51, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Now that the EFI stub boot flow no longer relies on memory that is
> executable and writable at the same time, we can reorganize the PE/COFF
> view of the kernel image and expose the decompressor binary's code and
> r/o data as a .text section and data/bss as a .data section, using 4k
> alignment and limited permissions.
> 
> Doing so is necessary for compatibility with hardening measures that are
> being rolled out on x86 PCs built to run Windows (i.e., the majority of
> them). The EFI boot environment that the Linux EFI stub executes in is
> especially sensitive to safety issues, given that a vulnerability in the
> loader of one OS can be abused to attack another.

This split is also useful for the work of kexecing the next kernel as an
EFI application. With the current EFI stub I have to set the memory both
writable and executable which results in W^X warnings with a default
config.

What made this more confusing was that the flags of the .text section in
current EFI stub bzImages are set to
IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_MEM_READ. So if you load that section
according to those flags the EFI stub will quickly run into issues.

I assume current firmware on x86 machines does not set any restricted
permissions on the memory. Can someone enlighten me on their behavior?


> In true x86 fashion, this is a lot more complicated than on other
> architectures, which have implemented this code/data split with 4k
> alignment from the beginning. The complicating factor here is that the
> boot image consists of two different parts, which are stitched together
> and fixed up using a special build tool.
> 
> After this series is applied, the only remaining task performed by the
> build tool is generating the CRC-32. Even though this checksum is
> usually wrong (given that distro kernels are signed for secure boot in a
> way that corrupts the CRC), this feature is retained as we cannot be
> sure that nobody is relying on this.
> 
> This supersedes the work proposed by Evgeniy last year, which did a
> major rewrite of the build tool in order to clean it up, before updating
> it to generate the new 4k aligned image layout. As this series proves,
> the build tool is mostly unnecessary, and we have too many of those
> already.
> 
> Changes since v1:
> - drop patch that removed the CRC and the build tool
> - do not use fixed setup_size but derive it in the setup.ld linker
>   script
> - reorganize the PE header so the .compat section only covers its
>   payload and the padding that follows it
> - add hpa's ack to patch #4
> 
> Cc: Evgeniy Baskov <baskov@ispras.ru>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> 
> Ard Biesheuvel (15):
>   x86/efi: Drop EFI stub .bss from .data section
>   x86/efi: Disregard setup header of loaded image
>   x86/efi: Drop alignment flags from PE section headers
>   x86/boot: Remove the 'bugger off' message
>   x86/boot: Omit compression buffer from PE/COFF image memory footprint
>   x86/boot: Drop redundant code setting the root device
>   x86/boot: Grab kernel_info offset from zoffset header directly
>   x86/boot: Drop references to startup_64
>   x86/boot: Set EFI handover offset directly in header asm
>   x86/boot: Define setup size in linker script
>   x86/boot: Derive file size from _edata symbol
>   x86/boot: Construct PE/COFF .text section from assembler
>   x86/boot: Drop PE/COFF .reloc section
>   x86/boot: Split off PE/COFF .data section
>   x86/boot: Increase section and file alignment to 4k/512
> 
>  arch/x86/boot/Makefile                  |   2 +-
>  arch/x86/boot/compressed/vmlinux.lds.S  |   6 +-
>  arch/x86/boot/header.S                  | 213 ++++++---------
>  arch/x86/boot/setup.ld                  |  14 +-
>  arch/x86/boot/tools/build.c             | 273 +-------------------
>  drivers/firmware/efi/libstub/Makefile   |   7 -
>  drivers/firmware/efi/libstub/x86-stub.c |  46 +---
>  7 files changed, 114 insertions(+), 447 deletions(-)
> 
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 
