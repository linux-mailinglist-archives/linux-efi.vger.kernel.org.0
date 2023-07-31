Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784737692B8
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 12:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjGaKHu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 06:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGaKHq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 06:07:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA47E5;
        Mon, 31 Jul 2023 03:07:44 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF88C1EC0178;
        Mon, 31 Jul 2023 12:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690798063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ysQo98yDKlCml0DCGm6IRpUMs4ajRymXoiFBPaEeyg=;
        b=F7aJcARBfktAxqBhuO9X+wSkLb6L4Fd4Wrd286KLygT/UFX8DeUYMolakHJlWXklSrTgye
        FRPH4z9EsTvjUyMymlA4vG4LtroADeD0VR01818HEciZLFStKLEoNo1cwahH8jB2yMC6hR
        Gzu1DApEqUEVG/XznoSdy32mjhFp56M=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fTEdBS7V9Xij; Mon, 31 Jul 2023 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690798060; bh=9m7pk2RstT9dO+BGQTp4CY67Ko5cWyd/HYkKQ0C+tDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EChL3FXikekTZYCV1sbCsBvF3qIM7wNqmtFtSKu/Slvg/RHSh8+Ll8S1LhTTUaTWN
         G8HONpzMscAzwsjG/CWhpXbY0h1tH5AXs/xnOu4R5yuNYp6m5xxnr8hTNkoB/a7+6m
         EdyLc84M4W4K65Kd5UymTkhSHzJa3u/D8gaaS1Zsvn0p2U8zo4IiYaD0vg5msTfj5r
         PPCFfbYxYtwLKYbElDSlD1wO7Pup8D26TUsEU6i/QUuZ9NKOPSazHBGzJPphzgmh7P
         YNZpL0wJ8/eoh0ZxkazZL4UCXyzNql1CwyIh9dPnFpzPjdsbLcqWGHPhEHOl1TNG/X
         LU1Geelk0BOGd7pssFqhDdMSnixxAGd1zH2PG7KkiE7GTWX8uxOobLBC5SjslrGN4l
         DAME5XozWYc+kcmIBaA8W9uS+mhXmOMArKd+8RyV0CMNS3wl9JMGq4lyyiYESfoQ6+
         GmFxhBX+gM/wZouVURlNSL6uNz4RSDz8EBmPgHJR9Lk4xm5ur3h0xHP7pwrInh3nd+
         hu7A94FnwxhLR0afUDcsTkeDuV7w5UVQp1cIxtKxuU1VZdcnI1kl1WgkyWnMPjRW4U
         cXxezd3sHVS88iTJ5KaO22Fr3bHvHn1Z69ZeMnOH7gUL5082TbX1eZyHOxRm+GgQCH
         bjYKkl2gJLwrLXbBruhOQA34=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DECC40E0033;
        Mon, 31 Jul 2023 10:07:20 +0000 (UTC)
Date:   Mon, 31 Jul 2023 12:07:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Subject: Re: [PATCH v7 01/22] x86/decompressor: Don't rely on upper 32 bits
 of GPRs being preserved
Message-ID: <20230731100713.GAZMeH0RvXfNclFqMO@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728090916.1538550-2-ardb@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 28, 2023 at 11:08:55AM +0200, Ard Biesheuvel wrote:
> The 4-to-5 level mode switch trampoline disables long mode and paging i=
n
> order to be able to flick the LA57 bit. According to section 3.4.1.1 of
> the x86 architecture manual [0], we should not rely on 64-bit GPRs

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

> retaining the upper 32 bits of their contents across such a mode switch=
.
>=20
> Given that RBP, RBX and RSI are live at this point, let's preserve them
> on the stack, along with the return address that might be above 4G as
> well.
>=20
> [0] Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=80=99s=
 Manual, Volume 1: Basic Architecture
>=20
>   "Because the upper 32 bits of 64-bit general-purpose registers are
>    undefined in 32-bit modes, the upper 32 bits of any general-purpose
>    register are not preserved when switching from 64-bit mode to a 32-b=
it
>    mode (to protected mode or compatibility mode). Software must not
>    depend on these bits to maintain a value after a 64-bit to 32-bit
>    mode switch."
>=20
> Fixes: 194a9749c73d650c ("x86/boot/compressed/64: Handle 5-level paging=
 boot if kernel is above 4G")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S | 23 +++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compres=
sed/head_64.S
> index 03c4328a88cbd5d0..f7c11a0018477de8 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -459,11 +459,22 @@ SYM_CODE_START(startup_64)
>  	/* Save the trampoline address in RCX */
>  	movq	%rax, %rcx
> =20
> +	/* Set up 32-bit addressable stack */
> +	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
> +
>  	/*
> -	 * Load the address of trampoline_return() into RDI.
> -	 * It will be used by the trampoline to return to the main code.
> +	 * Load the address of trampoline_return() into RDI and push it onto
> +	 * the stack so it will survive 32-bit truncation due to the 32-bit

I think you should explain here what that SDM excerpt above says so that
it is clear what "32-bit truncation" is meant.

> +	 * protected mode switch. It will be used by the trampoline to return
> +	 * to the main code.
>  	 */
>  	leaq	trampoline_return(%rip), %rdi
> +	pushq	%rdi
> +
> +	/* Preserve other live 64-bit registers */
> +	pushq	%rbp
> +	pushq	%rbx
> +	pushq	%rsi
> =20
>  	/* Switch to compatibility mode (CS.L =3D 0 CS.D =3D 1) via far retur=
n */
>  	pushq	$__KERNEL32_CS

What is more interesting is why is this trampoline crap unconditional?

/me goes and does git archeology...

194a9749c73d ("x86/boot/compressed/64: Handle 5-level paging boot if kern=
el is above 4G")

    We go through the trampoline even if we don't have to: if we're alrea=
dy
    in 5-level paging mode or if we don't need to switch to it. This way =
the
    trampoline gets tested on every boot.

Well, f*ck no.

All my machines don't have 5level pages. And I bet 5level pages is still
not in the majority of the machines out there.

This all needs to be abstracted away into a separate function which
exits early if no 5 level support.

Kirill, please fix this.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
