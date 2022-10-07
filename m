Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479B05F7646
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJGJaz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJGJay (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 05:30:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C81162DD;
        Fri,  7 Oct 2022 02:30:51 -0700 (PDT)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C8C61EC04E2;
        Fri,  7 Oct 2022 11:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665135046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n1vckELSkNGpxcbqedOWvmC3fl/6VqPt9RpfZgtr0hs=;
        b=odvX9K4hZp1/3aU7XFcXApnWbXdvroDWLdZSr1Ghpwk8s8M31s3Ud2oQSPUa5PF8OXVHYZ
        ABSfcRM3a+2AAfLgCmzlMB8dIs/bNrmzNlpQ7h1Dn6h9SekXYvfhr/pH1br3evNGZctTHj
        ltP25cdvwrZXjFn8allLHaylcTl5qVo=
Date:   Fri, 7 Oct 2022 11:30:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 03/16] x86/compressed: efi-mixed: move bootargs
 parsing out of 32-bit startup code
Message-ID: <Yz/xwv1HVRV6Ff43@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
 <20220921145422.437618-4-ardb@kernel.org>
 <Yz615Qc1K284jlH9@zn.tnic>
 <CAMj1kXGfMp_nquvL2ECchof_BMZ54tZK5JwrXno4VO6nGCJVAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGfMp_nquvL2ECchof_BMZ54tZK5JwrXno4VO6nGCJVAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 06, 2022 at 01:29:55PM +0200, Ard Biesheuvel wrote:
> Documentation/x86/boot.rst has a section on this (at the end),

Ah, and I really like that NOTE at the end.

> but we should really stop using it. It is only implemented by
> out-of-tree GRUB at the moment (last time I checked) and leaking all
> those struct bootparams specific details into every bootloader is not
> great, especially the ones that intend to be generic and boot any EFI
> OS on any EFI arch.

I'm all for making early asm code simpler so yes, can we start removing
it?

Dunno, maybe ifdef around it with a Kconfig option which is default off
and see who complains...

> That is the same thing. The EFI stub is what enables the kernel (or
> decompressor) to masquerade as a PE/COFF executable.
> 
> In short, every EFI stub kernel on every architecture has a native
> PE/COFF entry point that calls the EFI stub, and the EFi stub does the
> arch-specific bootloader work and boots it.

Right.

> In addition, the x86_64 EFI stub kernel has an extra, non-native
> PE/COFF entry point, which is exposed in a way that is not covered by
> the EFI spec, but which allows Linux specific loaders such as
> systemd-boot to boot such kernels on 32-bit firmware without having to
> do the whole struct bootparams dance in the bootloader.

Ok, thanks for explaining.

I like the simplification and obviating the need for the bootloader to
do any dancing before loading the kernel.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
