Return-Path: <linux-efi+bounces-3820-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207DCAD063C
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 17:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA43B1A9C
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD617A317;
	Fri,  6 Jun 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTo/71Ty"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FF2A8D0;
	Fri,  6 Jun 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225213; cv=none; b=r9syyv3LI5NnDIV2EF/MdqsJWUB3zzcv8qEpGthW9kjD+YVCS10y2ayuOf8y3F8C2biYkjx1Q1yB7FYquNwICQIYg+pLSTY6nHQWR+8dDS9d+KLcNXT+D08xlJzUD9W1ooyCpsZLkewwGpfwC6C30sBfUzzDROOjJg2DFGvbGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225213; c=relaxed/simple;
	bh=u7+1jKk4U/xWJB4Zo5+Sz+607XUjRbfyHpGhkVYPutc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7No4IbKll43ZrKY7KXOl4wVxGEABpa7ZOfniq0o++b35MNKbTKXFXVlewlV0LOj4eXLjrF8lcjzKuOpqJ50sXB9cb9ywo1tV92HvRCK53IpcUchgHoa9ELxVd/aRJjMXg4B6QcIub4H+5+iKP8SVESN52b+0yew9SxfTSPHmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTo/71Ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9436C4AF09;
	Fri,  6 Jun 2025 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749225212;
	bh=u7+1jKk4U/xWJB4Zo5+Sz+607XUjRbfyHpGhkVYPutc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lTo/71Ty+kIgPWVH5Ky6R0qfVki+z+evRjbbeZyQTBOmilmbtjsR6MT0YktZZSSpx
	 6z2Ol/jnRNaNDKZm/4SdhjQNJY601IFbzbteSa3/1WCcDOa/qIyKUemNgQrPOKnpG6
	 oOCCTpSWuvLcAO5+EyL1EGlXHEfaisWBbJi/NN1kHuwUClE4WXtlwPDcyt1CviXoIv
	 +IxsM343ms5ROGIlD51/Rb9nWMg0VzFT3clVjwyHGnadgxPxI0/mmCBl9lktfXp0Hy
	 WyLkmONaRd9UTk+9aD1wqvT7bWsoNWt7b4OeDDL51bLxF1c3dUrbIf10hpMU8tcziu
	 7ms+FxylfQ3Pw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32a7256ba04so11786551fa.1;
        Fri, 06 Jun 2025 08:53:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWw4K3Ooti4pc5JH80b64AiqgTFBSMyQ04frO/FVIXhU7RY2jcBXfXXraf7olzRqvcIu+vuZaEjXfHa9aWO@vger.kernel.org, AJvYcCXu/5WL7XSqv03zCfEYVms7Mo8JNLkGuFzWkMaEytaB1bY6to2gxqQQvPBP4H/NAU0dhi1P61k2bPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGksVQb2JC2uSrX7dBPlSU7NTPXzoJbhvZY0MuN1cCtxJ+hMj
	CFK5osW0EsqtdZDQw93Qdt0Ewq7a/WruFwYQIFCuODm38WJ0Pi+bI7LGO6xz7k5KG0N37RtwqW2
	+lexmBeAt6Z23xZvlDBNBNPROTfAbWDM=
X-Google-Smtp-Source: AGHT+IGjf30pjqgeFcxZcc9nje3zz3QRM+dSgZnGbpycrmsPTO+F/5DIfFuml+ST3gPpgrAY+WLHfJipmFbHLyFlz1o=
X-Received: by 2002:a2e:be8d:0:b0:32a:7666:80e0 with SMTP id
 38308e7fff4ca-32adfc0d983mr11518971fa.10.1749225211108; Fri, 06 Jun 2025
 08:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606154112.311565-1-vkuznets@redhat.com>
In-Reply-To: <20250606154112.311565-1-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 6 Jun 2025 17:53:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGQP5w+st3ijsmPABih+ukA4p3KEwb-tMdMfY9-PuVgtQ@mail.gmail.com>
X-Gm-Features: AX0GCFsJfeXsrOvTxgMTy_bG62Q9j2hbWCjL8sp7IyzG0hpadb0axosWdl0M_9E
Message-ID: <CAMj1kXGQP5w+st3ijsmPABih+ukA4p3KEwb-tMdMfY9-PuVgtQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Drop preprocessor directives from zboot.lds
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 17:41, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Older versions of `ld` don't seem to support preprocessor directives in
> linker scripts, e.g. on RHEL9's ld-2.35.2-63.el9 the build fails with:
>
>  ld:./drivers/firmware/efi/libstub/zboot.lds:32: ignoring invalid character `#' in expression
>  ld:./drivers/firmware/efi/libstub/zboot.lds:33: syntax error
>
> We don't seem to need these '#ifdef', no empty .sbat section is created
> when CONFIG_EFI_SBAT_FILE="":
>
>  # objdump -h arch/arm64/boot/vmlinuz.efi
>
>  arch/arm64/boot/vmlinuz.efi:     file format pei-aarch64-little
>
>  Sections:
>  Idx Name          Size      VMA               LMA               File off  Algn
>    0 .text         00b94000  0000000000001000  0000000000001000  00001000  2**2
>                    CONTENTS, ALLOC, LOAD, READONLY, CODE
>    1 .data         00000200  0000000000b95000  0000000000b95000  00b95000  2**2
>                    CONTENTS, ALLOC, LOAD, DATA
>
> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Ah yes, I failed to realize that zboot.lds is never preprocessed - I
did notice that the #ifdef is unnecessary here as LD ignores empty
sections.

So the fix is

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

I'll queue this as a fix.

> ---
> Note: not-yet-merged x86 version of 0f9a1739dd0e does not seem to be affected
> as vmlinux.lds script is a pre-processed version of vmlinux.lds.S.
> ---
>  drivers/firmware/efi/libstub/zboot.lds | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index c3a166675450..4b8d5cd3dfa2 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -29,14 +29,12 @@ SECTIONS
>                 . = _etext;
>         }
>
> -#ifdef CONFIG_EFI_SBAT
>          .sbat : ALIGN(4096) {
>                 _sbat = .;
>                 *(.sbat)
>                 _esbat = ALIGN(4096);
>                 . = _esbat;
>         }
> -#endif
>
>         .data : ALIGN(4096) {
>                 _data = .;
> --
> 2.49.0
>
>

