Return-Path: <linux-efi+bounces-5962-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC70D035AE
	for <lists+linux-efi@lfdr.de>; Thu, 08 Jan 2026 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E0FD3102C67
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jan 2026 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0852D3D7D63;
	Thu,  8 Jan 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTfeszvR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5347423C
	for <linux-efi@vger.kernel.org>; Thu,  8 Jan 2026 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872585; cv=none; b=lDARiGC4JwrJB8lkID26Z7+Hz3I8I3LsyBH4Cc1AjdB5E5p7J/eINpDX+xdssm8636X6RDUDn1bbyUMstNfNUauuW+hX5zmf/Qh+XNhW+dj1u7UP8xj1oJlZu/kZ+4HQjsBqc8fwLQ3uIUe37j+UmlnYuEvpgZcCp8wWWXUPQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872585; c=relaxed/simple;
	bh=C2VN2SxLsljkpC4BuEwbUefE/Qd2WOf58X30ce4IAyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ol5IrSHLqqyA2btsTsdpdpGHK3Y4jZKSUxs9jTnO9FaRPq2Zs7xw32D55C6YrKupO34OgaDcwrtnabszPhrYV5bjQ1rSeU7UKT9otydCWfCwGGj82UKkLVwXE5sV2R2gdYqlM9vX1pMG0HR8DmeMzXnxG0XbPHeWRo9Vk1lnImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTfeszvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0340C16AAE
	for <linux-efi@vger.kernel.org>; Thu,  8 Jan 2026 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767872584;
	bh=C2VN2SxLsljkpC4BuEwbUefE/Qd2WOf58X30ce4IAyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rTfeszvRQpkxGg0S04Shzi+xeSPR3ERg8gkAOkmTq6OGIKmdMEdo2iu1dCjP7jO6y
	 Fpu8/JLBbyPBxn15V2PAttF4fheb8kiPxGxXwxkEkq2G/p8aHeXdZ8L27NqbbKW/6Z
	 P12hs1rk0UK011136hSbBcl0XK2gm2bjzYcQQQ2zaoE9IKIqvCD1quRbd29k2vRJ89
	 Z+BffeI6pH7Dpc65vLC4peNz/07hkpYUKzIhslPi/Czmm9Zli6uolR6QZu0+ydWj+z
	 7gMrvgiBfJ8D7EkelWvaiTDpiDvI6S3vNJR9sJoYDXYRdnZsIJFXs+4jFNUQ6ifAjh
	 lEXIoBuA2RI5w==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso3190171a91.3
        for <linux-efi@vger.kernel.org>; Thu, 08 Jan 2026 03:43:04 -0800 (PST)
X-Gm-Message-State: AOJu0Yxq5BE75LS8YWHvd88EsxMCncAk0vRtcA1Q+0AnrXKdMvLI4zwW
	va6jVENBjL6X6iD736T6k4SFb21hW/xe5WHnWa2pNoNAasi/SQ8Sd25bE3P7OqwOr6V452wz2V4
	DltAKPTNhxa1xnptlEjHHAw8IAzDjq3k=
X-Google-Smtp-Source: AGHT+IEFT5YhXCulWBUu34jJZEJZdbPyv6DvUO5tqyOInODALGn4A//T7nD9CHLOtY1mtM8id0C/V6tceDaprBJN+F0=
X-Received: by 2002:a17:90b:4ece:b0:341:ae23:85fd with SMTP id
 98e67ed59e1d1-34f68c4cde9mr6207431a91.11.1767872584209; Thu, 08 Jan 2026
 03:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205093215.607858-2-ardb@kernel.org>
In-Reply-To: <20251205093215.607858-2-ardb@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 8 Jan 2026 12:42:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGingD=uuXW_u0n7J3pQ=DA3DQGL6_vPxwVd1u0kjzfoQ@mail.gmail.com>
X-Gm-Features: AQt7F2osxZTFj8EkIcwnoHF9aYiPTeb7_YnxqBCCBtm9KL8mYkpQDTMcLhWGgiM
Message-ID: <CAMj1kXGingD=uuXW_u0n7J3pQ=DA3DQGL6_vPxwVd1u0kjzfoQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Wipe INITRD config table from memory after consumption
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, James Le Cuirot <chewi@gentoo.org>, 
	"H. Peter Anvin (Intel)" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 10:32, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> When the EFI stub itself loads the initrd and puts it in memory (rather
> than simply passing on a struct boot_params or device tree that already
> carries initrd information), it exposes this information to the core
> kernel via a INITRD configuration table.
>
> Given that config tables are preserved across kexec, this means that
> subsequent kexec boots will observe the same information, even though it
> most likely has become stale by that point. On x86, this information is
> usually superseded by the initrd info passed via bootparams, in which
> case this stale information is simply ignored. However, when performing
> a kexec boot without passing an initrd, the loader falls back to this
> stale information and explodes.
>
> So wipe the base and size from the INITRD config table as soon as it has
> been consumed. This fixes the issue for kexec on all EFI architectures.
>
> Reported-by: James Le Cuirot <chewi@gentoo.org>
> Tested-by: James Le Cuirot <chewi@gentoo.org>
> Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Link: https://lore.kernel.org/all/20251126173209.374755-2-chewi@gentoo.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/efi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index a9070d00b833..988198c36a63 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -818,6 +818,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                 if (tbl) {
>                         phys_initrd_start = tbl->base;
>                         phys_initrd_size = tbl->size;
> +                       tbl->base = tbl->size = 0;
>                         early_memunmap(tbl, sizeof(*tbl));
>                 }
>         }

I had forgotten about this, I've queued it up now.

