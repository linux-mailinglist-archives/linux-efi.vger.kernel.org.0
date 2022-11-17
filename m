Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6387562E07D
	for <lists+linux-efi@lfdr.de>; Thu, 17 Nov 2022 16:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiKQP5e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Nov 2022 10:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbiKQP51 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Nov 2022 10:57:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807B78184;
        Thu, 17 Nov 2022 07:57:26 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7de329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7de:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83A811EC064F;
        Thu, 17 Nov 2022 16:57:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668700644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W8YkQu/vfSvn/2nEVdS0A+vwsC5ZEvAvbum5zYFdJ0M=;
        b=V5J5OEdDOpyQDj9L23GOOsLZA8aSfWHudAhiJTIqvqw0Drkvf3vXLjiBGV2bKayvUv4t3s
        BBtatasCd2WC2Y2nO2a1LQUAL5Jd6nnKwQN/9bibbh0s13UjCqDrwlP/22oShJQdFi8QQ4
        dytc3fckxihGTvXThjCu2ZopI3vghgs=
Date:   Thu, 17 Nov 2022 16:57:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 04/16] x86/compressed: efi-mixed: move efi32_pe_entry
 into .text section
Message-ID: <Y3ZZ35vJBh4fQu9M@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
 <20220921145422.437618-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921145422.437618-5-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 21, 2022 at 04:54:10PM +0200, Ard Biesheuvel wrote:
>  	/*
>  	 * We need to set the image_offset variable here since startup_32() will
>  	 * use it before we get to the 64-bit efi_pe_entry() in C code.
>  	 */
> -	subl	%esi, %ebx
> -	movl	%ebx, rva(image_offset)(%ebp)	// save image_offset
> +	subl	%esi, %ebp			// calculate image_offset
> +	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset

All looks ok, just one question: what was the reason for that
image_offset thing?

I see:

1887c9b653f9 ("efi/x86: Decompress at start of PE image load address")

It says that if the kernel is loaded as a PE executable using
LoadImage() we don't know where that image will be loaded each time so
we're saving that offset for later when relocating (or not) the kernel?

All part of those improvements:

https://lore.kernel.org/all/20200301230537.2247550-1-nivedita@alum.mit.edu/

Am I close?

I.e., that image_offset is purely a kernel thing and not something EFI
LoadImage's inner workings mandate...? It doesn't seem so from where I'm
standing but lemme doublecheck still.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
