Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2791B76B335
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 13:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjHAL2p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjHAL2m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 07:28:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6AFD3;
        Tue,  1 Aug 2023 04:28:41 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C27881EC00D9;
        Tue,  1 Aug 2023 13:28:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690889319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UfO22w9Tp3Hz/y6a+rRbpNT/F/PtTNxoeq6RVJqn6G8=;
        b=gssKNn1FIm2koELniHRrV5ebSV6dNjy9keNMamAIop20LnG/16Qw1/YRDduf6LeWcI7doW
        0/Uknya/6mbMo+LE24UN4s7ImYucAWD6z06mtSPe8R52ECYPO18wb++6Www57wXfp7ILgj
        1bA/PjlCbIju5exyFirK7OY46LcXmyg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ihEbStS98RaJ; Tue,  1 Aug 2023 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690889317; bh=UfO22w9Tp3Hz/y6a+rRbpNT/F/PtTNxoeq6RVJqn6G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btat0hcqqe//HvCm7fj9l6cY8RqJbwoVUh+i3GuOpfMX6bY+qCV/xL95xKgV3WOA1
         wedjhJ+9oTUOQljQNOLrBfxDJ/7U4Nv2JQZnIBV80xxv0WLDZj45nFLvwj4hXbYWAA
         WLi9sjwrytBkDJU1Kjybp6p4z7i/ZgedUZAGDYKt/wpCL2+Uw+cMjNvBSkpn+BX/61
         8Kb7cXpXipsTuuBUvA9+qdgnlM63Pp+0giBdIp0WPKl494Xp1lh94S6NOJFCiC/H39
         JhT077+99PsomQ6ImUwtTDC/AQg8WGGtCKVLEFEjRAvoMeVrCJURGDZiaDgHigPqy/
         kXWcESzQ4oYRNOm27gkq2wYEgKbQ86xVtuFemquG/L86lXxWH0oF4ZCcFLmks87mmO
         zAWSKPfWrEbhMMK8qiO7NjRTB5s27yuw9A75PEpLcJFI9GltjpS6EKR3wVXsdEEOYo
         I3Djl2p/HXtDZklurmKK2invJcLIa5hz3Q6CUaHGVPFg+tfx5Gw8C4N0sd+MNjq0ML
         CpcMK2QdO+mB/vyYYUKYk1Z60ZzlhxYtUv5a/FlglVkGUEwkJb4pm2khzCJDN0rldc
         BOOtCaI4vZyoXEzpa6adkjCsJx+T/j08BVBk+21e25VX8kNlq0F+W3pMZJPTFaTejd
         ntPBmtix2hIubeBIh4Ap3s1s=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D236140E019D;
        Tue,  1 Aug 2023 11:28:17 +0000 (UTC)
Date:   Tue, 1 Aug 2023 13:28:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v7 02/22] x86/head_64: Store boot_params pointer in
 callee save register
Message-ID: <20230801112812.GDZMjsTG4sXJNzqbVG@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728090916.1538550-3-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 28, 2023 at 11:08:56AM +0200, Ard Biesheuvel wrote:
> Instead of pushing/popping %RSI to/from the stack every time a function
> is called from startup_64(), store it in a callee preserved register
> and grab it from there when its value is actually needed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head_64.S | 23 +++++---------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index c5b9289837dcbad2..dbc80fe098f86860 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -62,6 +62,7 @@ SYM_CODE_START_NOALIGN(startup_64)
>  	 * compiled to run at we first fixup the physical addresses in our page
>  	 * tables and then reload them.
>  	 */
> +	mov	%rsi, %r15		/* Preserve boot_params pointer */

Please move those side comments over the insn.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
