Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB56D8556
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjDERz3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjDERz1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 13:55:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19576B8;
        Wed,  5 Apr 2023 10:55:08 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 691C11EC0104;
        Wed,  5 Apr 2023 19:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680717286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=33UG1WS3gw1CuOwXuYioeLNLGEVKHwH+Ir//ss8v/CY=;
        b=kypMIPHYDCdQPSLxPrRaxaco3D2GpUwVKRif07IXGNx/UR8guiLAXIk006ChkN1t91Ksz3
        6kwgvVhIuKPvVY8bMXe6awdZ06Z/0LZuFbgK1dHjW+GaPbAypxnHB4u1ZfwglmodbV3WVh
        H0BlnRsRWe7UtmPI0Fxs+zAeL9/coAk=
Date:   Wed, 5 Apr 2023 19:54:41 +0200
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
Subject: Re: [PATCH v5 03/27] x86/boot: Set cr0 to known state in trampoline
Message-ID: <20230405175441.GFZC214WxyhULbtl3P@fat_crate.local>
References: <cover.1678785672.git.baskov@ispras.ru>
 <63368ff665956a64f07aee9bc863b70c86b8b0c8.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63368ff665956a64f07aee9bc863b70c86b8b0c8.1678785672.git.baskov@ispras.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 14, 2023 at 01:13:30PM +0300, Evgeniy Baskov wrote:
> Ensure WP bit to be set to prevent boot code from writing to
> non-writable memory pages.
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/head_64.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 03c4328a88cb..01fa42d31648 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -660,9 +660,8 @@ SYM_CODE_START(trampoline_32bit_src)
>  	pushl	$__KERNEL_CS
>  	pushl	%eax
>  
> -	/* Enable paging again. */
> -	movl	%cr0, %eax
> -	btsl	$X86_CR0_PG_BIT, %eax
> +	/* Enable paging and set CR0 to known state (this also sets WP flag) */
> +	movl	$CR0_STATE, %eax

This sets a lot more than WP. Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
