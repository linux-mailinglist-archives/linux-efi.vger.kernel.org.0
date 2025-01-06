Return-Path: <linux-efi+bounces-2512-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C0A03080
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 20:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769DE3A1472
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A51CEAD3;
	Mon,  6 Jan 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuwxkiMR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768E15886C;
	Mon,  6 Jan 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191490; cv=none; b=MNJIe+RRrC8T3Bhj3FyhNStEwYZ7PhLBf4eP+BqcTRLqUWNojjUXueob2U3oph2Mtes521Y3UpAS/71RhokiGp34d90rAfin1sQYFANdlzShjYGPUSBlcLbTvGZqBZkKBYBTtRvVAs7cQWuNkMlXDD9An7SmvEfPNhiM69hDG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191490; c=relaxed/simple;
	bh=0hyMn0bPIEAfcK45khr4YkCuT0VHlXoasMWzrRFiF8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9GB0xbZmJF6rx7SnTamF879sNKf8Q6/4lEQTJoRbpQ5YRmu4TQNB8yLKTcDZl4m8ueXNhXPW+PyjJozXVDRlw0OOC/YPuy+tPEbcwtGMTwnuPpwz4kh4QjXD/zC3CUcbpIS5UzKz02/ZpVp1edfk5nsh7iD41BNXpgPJ/BTjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuwxkiMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11277C4CED6;
	Mon,  6 Jan 2025 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736191490;
	bh=0hyMn0bPIEAfcK45khr4YkCuT0VHlXoasMWzrRFiF8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JuwxkiMR/H+KV5zevhoDk5/hBtsQcFe97PFNRP2vTGtI/0S2dD1/ZJuflg5vUxiH/
	 ihXgAjGqQnqeKh/FlyIRWRISmX02iqhtGrEvh8pQy1oeFQgg1imSpvgtsV0nzr3eUH
	 NzRZL5/uHGb+rU9uoF0CaVeehFNMdRA/wwVJuheRZDz2mTHleYacYIB3DfnAn569/k
	 E1MulrD1PYJJElGRVV+2cyxUapVYSyGL/sk+reJ/1BsXPXAE7MBPqBXVYDb0h92hx2
	 oURGnX325UGMq+tIMMLhDEp41TXZA5eqVYA57sC1hGtfKjVfsTaH7TCzCO9w6nnqQp
	 VMHwNBC/K3Ikw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so15496661e87.0;
        Mon, 06 Jan 2025 11:24:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu+nx20R8BWz9xMPVhDIhzonpx/pwTJDqbicD+FpAMsSp9d99ZXTLZD+xXCgTVtwXQE4JuAW31sbCY5gjd@vger.kernel.org, AJvYcCX50B7ZoCMR3jHiQY2E5F1f3J11vENZkkXSZzf8eXhd9nerWjbB6F2AkRDAbP68QWa4s59NSvzo/6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPyNie1NrjqDg6RMldywCamEaJEq8igE5n5Q8sa+WKjsTPcVQK
	xZ6KQBDiA6vewysGyJWCoLEdGUN+tpSYzj67IMow6hT4NB7+gxsGMhj2vIztnZMMkT8KjIf+I+4
	/s07f/tRusoOCWpDvmGglBoj42h4=
X-Google-Smtp-Source: AGHT+IFKaam7f50fNkh4KOUcZhLlBpR+TZ9tQkMw9cD/JnesIJgWam+FpXifNp7v9nAMRe4pO/y42rmA+N+j1KQ+JyI=
X-Received: by 2002:a05:6512:b22:b0:53d:e3a6:ae8b with SMTP id
 2adb3069b0e04-5422953fdf0mr15793968e87.26.1736191488453; Mon, 06 Jan 2025
 11:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org> <20250106-efi_fw_bug-v1-1-01a8eb40bfeb@debian.org>
In-Reply-To: <20250106-efi_fw_bug-v1-1-01a8eb40bfeb@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 Jan 2025 20:24:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFV69QgspGy7XBQ4Vw5pKgxved_HNuvHDWObL8cxRpRcw@mail.gmail.com>
X-Gm-Features: AbW1kva6cuiLn1VK7XZIzcZ4KV1oiKBih2tcmPsWP5DGESLsUdT9nzp-bHl6FYI
Message-ID: <CAMj1kXFV69QgspGy7XBQ4Vw5pKgxved_HNuvHDWObL8cxRpRcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/memattr: Convert efi_memattr_init() return type
 to void
To: Breno Leitao <leitao@debian.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Hello Breno,

On Mon, 6 Jan 2025 at 20:03, Breno Leitao <leitao@debian.org> wrote:
>
> The efi_memattr_init() function's return values (0 and -ENOMEM) are never
> checked by callers. Convert the function to return void since the return
> status is unused.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/firmware/efi/memattr.c | 7 +++----
>  include/linux/efi.h            | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index c38b1a335590d4f6b75012414a936e66f22dcd9a..e727cc5909cb676c47d787ab0d7754b6fdcb493d 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -19,19 +19,19 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
>   * Reserve the memory associated with the Memory Attributes configuration
>   * table, if it exists.
>   */
> -int __init efi_memattr_init(void)
> +void __init efi_memattr_init(void)
>  {
>         efi_memory_attributes_table_t *tbl;
>         unsigned long size;
>
>         if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
> -               return 0;
> +               return;
>
>         tbl = early_memremap(efi_mem_attr_table, sizeof(*tbl));
>         if (!tbl) {
>                 pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
>                        efi_mem_attr_table);
> -               return -ENOMEM;
> +               return;
>         }
>
>         if (tbl->version > 2) {
> @@ -61,7 +61,6 @@ int __init efi_memattr_init(void)
>
>  unmap:
>         early_memunmap(tbl, sizeof(*tbl));
> -       return 0;
>  }
>
>  /*
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index e5815867aba971a64091bf0ea017d95f21115124..5404939df81bdc870f6ee5d0fb7cbb53394a2304 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -771,7 +771,7 @@ extern unsigned long efi_mem_attr_table;
>   */
>  typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
>
> -extern int efi_memattr_init(void);
> +extern void efi_memattr_init(void);
>  extern int efi_memattr_apply_permissions(struct mm_struct *mm,
>                                          efi_memattr_perm_setter fn);
>
>
> --
> 2.43.5
>
>

