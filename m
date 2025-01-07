Return-Path: <linux-efi+bounces-2523-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35815A03D9C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 12:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAA516588C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B861E1322;
	Tue,  7 Jan 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldes8mxw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818E1E0DB3;
	Tue,  7 Jan 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249058; cv=none; b=LuYlKCv8vwmiTxRNB5+/Io7V2QwIUZBR6rXD8mop0e1ZKnUS9DhJ2EDhkKdnh0OmnTAoVlJtKqlygtei94BWwkE9OmHQjurZwlT/7y+KrIyEnUotsTIbA/vPmnXBWpiOt1QJsv/JDtsjOD8U8hTKdjhkPSA0I+mLFo/4eeTE6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249058; c=relaxed/simple;
	bh=dt2X7/PCxcdjMgA20b9Usa+3WoU2yvBBl6+5rt7S5Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t07JRO2BU4QWU341nZbkXjB7cTK/1zoAv04scUMAjM4YYwoQnP2ll56+iBR1RyQ+m906oY7kVWVaAPm1pLZlF/bBe36M6JlALviaE427hJ2GY+MxC97A29JTGbC4C03xv6Z48VZayqvQE+Z/XhlXYBoS/TzygC8pO08qsSUWJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldes8mxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF5BC4CED6;
	Tue,  7 Jan 2025 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736249056;
	bh=dt2X7/PCxcdjMgA20b9Usa+3WoU2yvBBl6+5rt7S5Vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ldes8mxwG4HDlFj+tk4mTgqhRKvJd1Ox4k5nYetXOoyj+4j2+Zgh7/0Go8iT3g/co
	 kW+T8tbqWO+EOgAaJe0ysbIGQ8MKx+JvptMgxUe5eDRepZ69J07d5VyxKQ0y15HdCW
	 0ydc2Pza/eYxyUTutXwu+tAabKYn1h9Eqhj48Bsl6Xfb0kM67Ild7ac9wrOVPNH9op
	 6rioE/xaM+xv0SQ/z+xaVnpeSkOHagDxx4991+UFlKDbIWr0wBaaNu25xmwejSedH+
	 F2nSEvIKJArbrjU3r0ZP0o5kKLpXtOHX0qfMaUOcD57d8uE4kVZ2otkzUBWEKTuTAC
	 epBErD1th59XQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e3778bffdso17021237e87.0;
        Tue, 07 Jan 2025 03:24:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMHcUGcIgTSo+6WHg28N7G8hLvG6+PoaAWBe4abCk5BffDvLp7l6LyvBZ9JL2UpNbKnlV2mxVv30DbOrLP@vger.kernel.org, AJvYcCWviz2t9npeUAgHtlr03Lx1oyoE4lAMpBd52Nd1gVZLFdZMwCofT2kXlu9t7Lp9U+MiShKu4BqIuyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9pp09C34vg21llYzZl8Gg0m1UK0GPqjOpAXG0yrWZ+gi7PL/
	11xm9JoK8hDHLlrUFpehjpjhCFhID7F7NwoNcUQR6UuTtFbkOYNNUO4i3WHVdoRr4M7ERcPOysi
	9XoKj0fTM1RGUigOA9QTfzMIpA3s=
X-Google-Smtp-Source: AGHT+IGAOcAFwK8GBPrxeeNWlh1XI2i4kKeMGKAGvBgXrGITxts5+I1PjRMxW13me8QtRk3RpSOAMH1XydpYC0hkrEU=
X-Received: by 2002:a05:6512:3b1e:b0:542:2a20:e695 with SMTP id
 2adb3069b0e04-5422a20e76emr14148344e87.9.1736249055255; Tue, 07 Jan 2025
 03:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org> <20250106-efi_fw_bug-v1-3-01a8eb40bfeb@debian.org>
In-Reply-To: <20250106-efi_fw_bug-v1-3-01a8eb40bfeb@debian.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 7 Jan 2025 12:24:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFn7CeT6R2w_XKAJoj5WUYObOWKeUO2istY8sULQTwomQ@mail.gmail.com>
X-Gm-Features: AbW1kvaCKoi9P0uI7pcQB2zWKLzs0pLgDPKKtQOrBb6EPE5AurwzIJVVRbTIhvk
Message-ID: <CAMj1kXFn7CeT6R2w_XKAJoj5WUYObOWKeUO2istY8sULQTwomQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/memattr: Include EFI memmap size in corruption warnings
To: Breno Leitao <leitao@debian.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 20:03, Breno Leitao <leitao@debian.org> wrote:
>
> Add EFI memory map size to warning messages when a corrupted Memory
> Attributes Table is detected, making it easier to diagnose firmware issues.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/firmware/efi/memattr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index 5f83cdea88b05cb325e9f90c14a0048131e53cfa..2c276bcc0df48352bec6cd96b69edf67a16f6069 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -22,7 +22,7 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
>  void __init efi_memattr_init(void)
>  {
>         efi_memory_attributes_table_t *tbl;
> -       unsigned long size;
> +       unsigned long size, efi_map_size;
>
>         if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
>                 return;
> @@ -49,9 +49,10 @@ void __init efi_memattr_init(void)
>          * just be ignored altogether.
>          */
>         size = tbl->num_entries * tbl->desc_size;
> -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
> -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
> -                       tbl->version, tbl->desc_size, tbl->num_entries);
> +       efi_map_size = efi.memmap.nr_map * efi.memmap.desc_size;
> +       if (size > 3 * efi_map_size) {
> +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u, efi_map_size == %lu)\n",
> +                       tbl->version, tbl->desc_size, tbl->num_entries, efi_map_size);
>                 goto unmap;
>         }
>
>

Hello Breno,

I don't mind the patch per se, but I don't think it is terribly useful either.

Could you explain how this helps?

