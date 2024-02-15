Return-Path: <linux-efi+bounces-574-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8D85717B
	for <lists+linux-efi@lfdr.de>; Fri, 16 Feb 2024 00:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61501C20ED6
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320413DBB3;
	Thu, 15 Feb 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKZRg9Yl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D4213AA4F;
	Thu, 15 Feb 2024 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039288; cv=none; b=HgKmw8Lj82Tgxmc2bV6Am28DPOn6ySe1GnLHIpdXWOiU/e6YOk476POgaffkq6AGOuyrxVyj3u4ASewPgdCA+3Y/Tz1PK9gmlKHI0vi24TlQTRWnSFyPP9IaKZf9VK7tsikClIwR4B2GFYGqqa0D44Kgrgue28XmRJUxAI8CtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039288; c=relaxed/simple;
	bh=7iJLw/6LPcevINvsicUat4ZsHVJ3XTY7Nx+EesDtbdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0xzXXiqH8eCFnGn3zmxWBUVuB2oVr8BreMCGeKpAYHbrFIuWXkvhuiQ/3gu1e0NbwPYq5NhMaR3fnUTfgFDHlLss6OoeNb58a5rT3/0Vj0cTCaxE+iBOdJ3GH4YxbrwwKwjCh8uDtOlJvGMnrHpLHzzwk4J9l4YMk33e1gHMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKZRg9Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAE5C433F1;
	Thu, 15 Feb 2024 23:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708039287;
	bh=7iJLw/6LPcevINvsicUat4ZsHVJ3XTY7Nx+EesDtbdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PKZRg9YlGF5yDV0vr9GDUjfS5j8SkYJfRBBInWE4tDM1CTtSYl1gFXShydBbVI7bY
	 7YmtI/Il56ECCrfR7yarirDv3ZEMhRdUQRaYwX7QSPNA9zaB9B+KMzSadLFA/TRpNG
	 9E6vT79qBLhN8LzeNvObmjPlopfyLooqyax6qz1GVP3QsBiDh+SxH/F9SH2elcjQ9k
	 sTRnHQrMDIqAioVM1eVcWZcppzlbVdzFaVflE+xyl8q8L9xIeYt8EgsR+OoOmWOEXW
	 ylHXGshIVK5PpmCY9Ow2Dr6/X6M8j2UWaNf8AaO38NwazJftHCKaSD9tv7DAG6ieZj
	 uZsNhe3jUkZHg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51182f8590bso1854648e87.0;
        Thu, 15 Feb 2024 15:21:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQ4zEsi7Qjo0XoJ/glC+mD+set9Drx8SIVlo3/rwkiWvUmou9bAOQ6wNEmLJSVXDOxuLGT85pJ+F3wYXdVpWHrE73a8RmN9zTbICf3a2a3Dlq5sIB2syFG5O8g02aLDsQJzwnVC2TrkKN5rcroYYwhSYOAUlCHus6g6Snx7+L/
X-Gm-Message-State: AOJu0YwHq+s3BexQBSPR1Phzq5LnRp6ZeeIfKpjGEvSuOTtI8JJiAphN
	MqB0Z9OQlkLxlnVGv4Ok+yQDJSzfrssu7A/IF290ILa4IoQxsfWMbER44aDeJPZH8PETUOG3Nzs
	TKWjJfG/8pwywrnqSHHYgIjH5FLA=
X-Google-Smtp-Source: AGHT+IGy+ro0gLdOQgR6w/ffrsZf/Qm7wt3zjX123wUPreRbqJOD3J6hNqRBaxU2o1QoV3B2+471el4akJoaXzGnsso=
X-Received: by 2002:a19:e04c:0:b0:511:8691:62d4 with SMTP id
 g12-20020a19e04c000000b00511869162d4mr2289262lfj.41.1708039285682; Thu, 15
 Feb 2024 15:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215225116.3435953-1-boqun.feng@gmail.com>
In-Reply-To: <20240215225116.3435953-1-boqun.feng@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Feb 2024 00:21:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3L5SdeXDfd3uYSOz-oG7+J31pd3WtZJ+g9eGDHDdOxg@mail.gmail.com>
Message-ID: <CAMj1kXF3L5SdeXDfd3uYSOz-oG7+J31pd3WtZJ+g9eGDHDdOxg@mail.gmail.com>
Subject: Re: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
To: Boqun Feng <boqun.feng@gmail.com>, Oliver Smith-Denny <osde@linux.microsoft.com>
Cc: linux-arm-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc Oliver)

On Thu, 15 Feb 2024 at 23:51, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
> a trouble with the following firmware memory region setup:
>
>         [..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
>         [..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]
>

Which memory types were listed here?

> , on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
> range will be omitted from the the linear map due to 64k round-up. And
> a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:
>
>         [...] Unable to handle kernel paging request at virtual address f=
fff0000dfd80000
>

You trimmed all the useful information here. ACPI reclaim memory is
reclaimable, but we don't actually do so in Linux. So this is not
general purpose memory, it is used for a specific purpose, and the
code that accesses it is assuming that it is accessible via the linear
map. There are reason why this may not be the case, so the fix might
be to use memremap() in the access instead.

> To fix this, add ACPI_MEMORY_NVS into the linear map.
>

There is a requirement in the arm64 bindings in the UEFI spec that
says that mixed attribute mappings within a 64k page are not allowed.

This is not a very clear description of the requirement or the issue
it is intended to work around. In short, the following memory types
are special

=E2=80=93 EfiRuntimeServicesCode =E2=80=93 EfiRuntimeServicesData =E2=80=93=
 EfiReserved =E2=80=93
EfiACPIMemoryNVS

and care must be taken to ensure that allocations of these types are
never mapped with mismatched attributes, which might happen on a 64k
page size OS if a mapping is rounded outwards and ends up covering the
adjacent region.

The Tianocore reference implementation of UEFI achieves this by simply
aligning all allocations of these types to 64k, so that the OS never
has to reason about whether or not region A and region B sharing a 64k
page frame could have mappings or aliases that are incompatible.
(I.e., all mappings of A are compatible with all mappings of B)

ACPI reclaim is just memory, EfiACPIMemoryNVS could have special
semantics that the OS knows nothing about. That makes it unsafe to
assume that we can simply create a cacheable and writable mapping for
this memory.

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # 5.15+
> ---
> We hit this in an ARM64 Hyper-V VM when using 64k page size, although
> this issue may also be fixed if the efi memory regions are all 64k
> aligned, but I don't find this memory region setup is invalid per UEFI
> spec, also I don't find that spec disallows ACPI_MEMORY_NVS to be mapped
> in the OS linear map, but if there is any better way or I'm reading the
> spec incorrectly, please let me know.
>

I'd prefer fixing this in the firmware.

> It's Cced stable since 5.15 because that's when Hyper-V ARM64 support is
> added, and Hyper-V is the only one that hits the problem so far.
>
>  drivers/firmware/efi/efi-init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-i=
nit.c
> index a00e07b853f2..9a1b9bc66d50 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -139,6 +139,7 @@ static __init int is_usable_memory(efi_memory_desc_t =
*md)
>         case EFI_LOADER_CODE:
>         case EFI_LOADER_DATA:
>         case EFI_ACPI_RECLAIM_MEMORY:
> +       case EFI_ACPI_MEMORY_NVS:
>         case EFI_BOOT_SERVICES_CODE:
>         case EFI_BOOT_SERVICES_DATA:
>         case EFI_CONVENTIONAL_MEMORY:
> @@ -202,8 +203,12 @@ static __init void reserve_regions(void)
>                         if (!is_usable_memory(md))
>                                 memblock_mark_nomap(paddr, size);
>
> -                       /* keep ACPI reclaim memory intact for kexec etc.=
 */
> -                       if (md->type =3D=3D EFI_ACPI_RECLAIM_MEMORY)
> +                       /*
> +                        * keep ACPI reclaim and NVS memory and intact fo=
r kexec
> +                        * etc.
> +                        */
> +                       if (md->type =3D=3D EFI_ACPI_RECLAIM_MEMORY ||
> +                           md->type =3D=3D EFI_ACPI_MEMORY_NVS)
>                                 memblock_reserve(paddr, size);
>                 }
>         }
> --
> 2.43.0
>
>

