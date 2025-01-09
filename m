Return-Path: <linux-efi+bounces-2547-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99CA07C38
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03589167993
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC821E091;
	Thu,  9 Jan 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmRkMjY8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150821E08A;
	Thu,  9 Jan 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437532; cv=none; b=cdaAUy7dba/v08yHyMnwvEpGHB7vHE3AA8S7zyMJW77TGqHfWxK6wblic9xSAOpUZoBsfGwyPMfypsojQX+OmkROYSDCaW2NuHtUbG3GUqzSL89+29FezmpdxpJfuucZcD+j7haSWw6OjriNBioDfney5jgrco8cJb1f2k2TTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437532; c=relaxed/simple;
	bh=B5qGzh3F3kerw7P377R3DsRB1w+E7Ta1ahc6bkUY/1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxUVgxI4f64eViXi9I8q9I15ot3e4j7+eAyL2mmXLm+BEHS7qrDsgG152awoKUui7RdLZSbPs3SKw6CJaohC3QZf/G2rHjlWTnI47X3+EM36qVFE3VHP6f+KNVY1DWvpV2vO/UmY5K/lwkWOtNMRFZbsVWHKsHbHF9wH0tGHUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmRkMjY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F0CC4CEE5;
	Thu,  9 Jan 2025 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437531;
	bh=B5qGzh3F3kerw7P377R3DsRB1w+E7Ta1ahc6bkUY/1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cmRkMjY8OsIYYJDWKSpjhw+g+1zB4rBWS7SE3iX5pPFtvLujNylb8kt2Fqr54vP+q
	 KUra8lVVKeiRM3F4onBR98Rv59+Nkv/C4T8tzq3ZNjJC5PUpPQLC7EnnketY4MN7WP
	 5laxah/hDyJw1lb6Pn+padKhPWYms3hI3auLtTSmpeXvlXlm5PZ2BOzP2RAW/zBPBL
	 X35uZMXUS0ZWzlrkIyaO7BoOVGP0+M1UlyNNalPNAoKE3zEg81soUYNbTw2JZ9jMV8
	 mA+/O8ObKIEh4ksS647Y287P4Jok/a82Zrt5pN7c/XGRZUGIVfJ8RJyYv0gQf9iJe6
	 Yaj9Jgygdp5kg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so9183191fa.3;
        Thu, 09 Jan 2025 07:45:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRIQ8dwBBXzpzs7zoMeOhEX3hXcUHThAaUOEFvbIsHaOvQ2YqPcl8hRgi81In3S76e9tBbm4JmC5oBSPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6nnA8qwxVpVqCgRNvGKzb3EtRrxJMFM9d1aVDDLyLP4QeaP4
	HmyRNG6ykRbCu2EQJCKNBQxkxJxFNJcZi6c7gubjbEbQeyahQmX5IouroDNysC1dZHK5VbTaGPm
	0Q1Wu1Lp42yG8XQ3VdsKhCxwrZM4=
X-Google-Smtp-Source: AGHT+IFGG2VZLnb6Rf9cPbXGfRKdHD2AX/axHtZpfvjPsUUlrem6ul0qd2lRvBmBrREq0G7sO/Ktr8Z6TbVGz2UNujk=
X-Received: by 2002:a05:6512:b8b:b0:542:249c:2156 with SMTP id
 2adb3069b0e04-5428452b8bcmr2118447e87.15.1736437530239; Thu, 09 Jan 2025
 07:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com> <20250108215957.3437660-2-usamaarif642@gmail.com>
In-Reply-To: <20250108215957.3437660-2-usamaarif642@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 16:45:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
X-Gm-Features: AbW1kvY3sSuQK6Y-79x26wc0_PSSMv_8bcWle1lLxS4GweITKQnpqDTYjg3HPTc
Message-ID: <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>
> The commit in [1] introduced a check to see if EFI memory attributes
> table was corrupted. It assumed that efi.memmap.nr_map remains
> constant, but it changes during late boot.
> Hence, the check is valid during cold boot, but not in the subsequent
> kexec boot.
>
> This is best explained with an exampled. At cold boot, for a test
> machine:
> efi.memmap.nr_map=91,
> memory_attributes_table->num_entries=48,
> desc_size = 48
> Hence, the check introduced in [1] where 3x the size of the
> entire EFI memory map is a reasonable upper bound for the size of this
> table is valid.
>
> In late boot __efi_enter_virtual_mode calls 2 functions that updates
> efi.memmap.nr_map:
> - efi_map_regions which reduces the `count` of map entries
>   (for e.g. if should_map_region returns false) and which is reflected
>   in efi.memmap by __efi_memmap_init.
>   At this point efi.memmap.nr_map becomes 46 in the test machine.
> - efi_free_boot_services which also reduces the number of memory regions
>   available (for e.g. if md->type or md->attribute is not the right value).
>   At this point efi.memmap.nr_map becomes 9 in the test machine.
> Hence when you kexec into a new kernel and pass efi.memmap, the
> paramaters that are compared are:
> efi.memmap.nr_map=9,
> memory_attributes_table->num_entries=48,
> desc_size = 48
> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
> as it was reduced due to efi_map_regions and efi_free_boot_services.
>
> A more appropriate check is to see if the description size reported by
> efi and memory attributes table is the same.
>
> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>
> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>

The more I think about this, the more I feel that kexec on x86 should
simply discard this table, and run with the firmware code RWX (which
is not the end of the world).

The main reason is that the EFI memory map and the EFI memory
attributes table are supposed to be a matched pair, where each RTcode
entry in the former is broken down into multiple code and data
segments in the latter. The amount of mangling that the x86 arch code
does of the EFI memory map makes it intractable to ensure that they
remain in sync, and so it is better not to bother.


> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index c38b1a335590..d3bc161361fb 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -40,21 +40,17 @@ int __init efi_memattr_init(void)
>                 goto unmap;
>         }
>
> -
>         /*
> -        * Sanity check: the Memory Attributes Table contains up to 3 entries
> -        * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
> -        * So if the size of the table exceeds 3x the size of the entire EFI
> -        * memory map, there is clearly something wrong, and the table should
> -        * just be ignored altogether.
> +        * Sanity check: the Memory Attributes Table desc_size and
> +        * efi.memmap.desc_size should match.
>          */
> -       size = tbl->num_entries * tbl->desc_size;
> -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
> -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
> -                       tbl->version, tbl->desc_size, tbl->num_entries);
> +       if (efi.memmap.desc_size != tbl->desc_size) {
> +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, table desc_size == %u, efi.memmap.desc_size == %lu, table num_entries == %u)\n",
> +                       tbl->version, tbl->desc_size, efi.memmap.desc_size, tbl->num_entries);
>                 goto unmap;
>         }
>
> +       size = tbl->num_entries * tbl->desc_size;
>         tbl_size = sizeof(*tbl) + size;
>         memblock_reserve(efi_mem_attr_table, tbl_size);
>         set_bit(EFI_MEM_ATTR, &efi.flags);
> --
> 2.43.5
>

