Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6036D850A
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 19:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDERlu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 13:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjDERlt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 13:41:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A46196;
        Wed,  5 Apr 2023 10:41:44 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 449BF1EC0104;
        Wed,  5 Apr 2023 19:41:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680716503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2ClY+CpEfSbmaZZUTYOHVmK59OI0ocsuZrgDQYcPMyk=;
        b=eQrA8gdYgozOQ7xmoRl/9DQnN+2OXqwpD1+iaVWCUi0p70HrIywCNqiVF8Aehnj0BZvNHP
        oUC4GAzDYIIWq3pJaoYkEYpeYAMgTClfaEXLMn6cU1Sc7cofSB8Lepe9w1Na8EUiEo+jKE
        J6FNoDZ4E3gTaiGBClnAcHrH5MZJEIc=
Date:   Wed, 5 Apr 2023 19:40:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 02/27] x86/build: Remove RWX sections and align on 4KB
Message-ID: <20230405174059.GEZC2yq9WiXFsICyEy@fat_crate.local>
References: <cover.1678785672.git.baskov@ispras.ru>
 <edf3afbdcd87cb6c61815068084ac6de35be15a2.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edf3afbdcd87cb6c61815068084ac6de35be15a2.1678785672.git.baskov@ispras.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 14, 2023 at 01:13:29PM +0300, Evgeniy Baskov wrote:
> Avoid creating sections simultaneously writable and readable to prepare
> for W^X implementation for the kernel itself (not the decompressor).
> Align kernel sections on page size (4KB) to allow protecting them in the
> page tables.
> 
> Split init code form ".init" segment into separate R_X ".inittext"

s/form/from/

> segment and make ".init" segment non-executable.

"... and make the .init segment RW_."

> Also add these segments to x86_32 architecture for consistency.

Same comment as before: please refrain from talking about the *what* in
a commit message but about the *why*.

And considering the matter, you have a *lot* of *why* to talk about. :-)

Pls check your whole set.

> Currently paging is disabled in x86_32 in compressed kernel, so
> protection is not applied anyways, but .init code was incorrectly
> placed in non-executable ".data" segment. This should not change
> anything meaningful in memory layout now, but might be required in case
> memory protection will also be implemented in compressed kernel for
> x86_32.

I highly doubt that - no one cares about 32-bit x86 anymore.

> @@ -226,9 +225,10 @@ SECTIONS
>  #endif
>  
>  	INIT_TEXT_SECTION(PAGE_SIZE)
> -#ifdef CONFIG_X86_64
> -	:init
> -#endif
> +	:inittext
> +
> +	. = ALIGN(PAGE_SIZE);
> +
>  
>  	/*
>  	 * Section for code used exclusively before alternatives are run. All
> @@ -240,6 +240,7 @@ SECTIONS
>  	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
>  		*(.altinstr_aux)
>  	}
> +	:init

Why isn't this placed after inittext but here?

I'm thinking you wanna have:

	:inittext
	. = ALIGN..
	:init
	<rest>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
