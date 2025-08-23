Return-Path: <linux-efi+bounces-4596-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F8B32C19
	for <lists+linux-efi@lfdr.de>; Sat, 23 Aug 2025 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5532F1B65E0B
	for <lists+linux-efi@lfdr.de>; Sat, 23 Aug 2025 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958A419309C;
	Sat, 23 Aug 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okdJjChS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCBAD4B;
	Sat, 23 Aug 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755985683; cv=none; b=NemPwrIIJfvgHo6X+abIOU+R/cdtSkartJI2zcSxcV3xihs7T0NLTVwkzBiqkfA7+lkVgTXdxwf0nKjFpg5jzuj00tIymsZAkdW1kWig3qlwBFXdYM51QSbiYecIdtil/9BF9Eo92e4cRToX2mOqtJuWcGNd04YyT59l0FqG3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755985683; c=relaxed/simple;
	bh=f+2e1mjfdrM4u6c20rSZEJrXZ7DiDa0vXieudZxMy4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ya5bxJBTEZZB0Re3d0XC2pGEnZYkdvdfyrAcKB6so2EVY3hPJ1eYCSBqKwwPlABL41+LphgyKKepQAx8tUflhke/65chH4b5TtnC+CdgLNWztTeDh3VgpPtQc7uLs2Llx4IR6ncLc8r6E4ulNdLIQXFE0HSwy2qL4swRYaAJ4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okdJjChS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD629C116D0;
	Sat, 23 Aug 2025 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755985682;
	bh=f+2e1mjfdrM4u6c20rSZEJrXZ7DiDa0vXieudZxMy4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=okdJjChS8xDJKozutDClByY1QI8HxqsxfRLN6XIOhW4F/CD2Vmv8revUE77i4D9b7
	 YLiPtKcKWgfl455V3ZjOLSEw02BJCLdhrnl5bIKjFB+nyPwFDemhrqxOFfdFBFy6r1
	 SW0aUch9FILfVp+0p24u5UAwhERO/pGUQViOJlqLu58EG72cNvs5Aiz1ifThpzFCQC
	 0wYPPkHothpsuuu0sPoBd/RDnfS1segsfiwrGEw7i9TeP1bnsvJp433DhH5bAz5axK
	 /xzW7BQTM6AA+njIvacRoJWNR4OQkq8PK/u3O877KELm4+FphSMcl9XeXSf4fgF95d
	 1IJ+hgeBIqE8A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55ce5097638so3416770e87.0;
        Sat, 23 Aug 2025 14:48:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK8sirszlngt/VpuH6XHJkAECZXksO9I1K5k2+GT9nGsxUaCn1LKxP9arMwm8mlpqcX9GEYfd0LnC+BcvJ@vger.kernel.org, AJvYcCWd7mYb0+oCwzEen/3j8hQ2NcX9Rmf9pX+6e/ixq61Lhgm6MvrAaKPg43i7oGBGPM+9TqAWs4pAkOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZ3mseVIKBDylgxhLUDuc3spm7KbZWs1HhvirenG8F3T+clje
	7dG9eDVilyeCfHUHEpVInsugUN2kTXHGHYSBRVHoPn8ptitEE7mjtxuVdFwcyG4Va2KiqY/YxEE
	086IP2bwFkCNbJDIQCP3c2x7bH4zpMds=
X-Google-Smtp-Source: AGHT+IHpU7xCroubPXDWGgYJBrip4rxJYyc1NgWuY2GTM1r2YZ/KwreaPY1ko02JrW08q1BaBbIhh9myTEwFob0bbAM=
X-Received: by 2002:a05:6512:61d0:20b0:55f:34e8:b1b0 with SMTP id
 2adb3069b0e04-55f34e8ca18mr774083e87.15.1755985681198; Sat, 23 Aug 2025
 14:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
In-Reply-To: <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 24 Aug 2025 07:47:49 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
X-Gm-Features: Ac12FXzn0qCCniv9JuLvANrQaphyB7rl0h7KLf3cn0PE7oJ7DT-dRyUUwZAdnF8
Message-ID: <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
To: Evangelos Petrongonas <epetron@amazon.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

(cc Ilias)

Note to akpm: please drop this series for now.

On Fri, 22 Aug 2025 at 04:00, Evangelos Petrongonas <epetron@amazon.de> wrote:
>
> When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> early during device tree scanning. After kexec, the new kernel
> exclusively uses this region for memory allocations during boot up to
> the initialization of the page allocator
>
> However, when booting with EFI, EFI's reserve_regions() uses
> memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> rebuilding them from EFI data. This destroys KHO scratch regions and
> their flags, thus causing a kernel panic, as there are no scratch
> memory regions.
>
> Instead of wholesale removal, iterate through memory regions and only
> remove non-KHO ones. This preserves KHO scratch regions, which are
> good known memory, while still allowing EFI to rebuild its memory map.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> Changes in v3:
>         - Improve the code comments, by stating that the scratch regions are
>         good known memory
>
> Changes in v2:
>         - Replace the for loop with for_each_mem_region
>         - Fix comment indentation
>         - Amend commit message to specify that scratch regions
>         are known good regions
>
>  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>

I'd rather drop the memblock_remove() entirely if possible. Could we
get some insight into whether memblocks are generally already
populated at this point during the boot?


> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f2..a65c2d5b9e7b 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -12,6 +12,7 @@
>  #include <linux/efi.h>
>  #include <linux/fwnode.h>
>  #include <linux/init.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/memblock.h>
>  #include <linux/mm_types.h>
>  #include <linux/of.h>
> @@ -164,12 +165,32 @@ static __init void reserve_regions(void)
>                 pr_info("Processing EFI memory map:\n");
>
>         /*
> -        * Discard memblocks discovered so far: if there are any at this
> -        * point, they originate from memory nodes in the DT, and UEFI
> -        * uses its own memory map instead.
> +        * Discard memblocks discovered so far except for KHO scratch
> +        * regions. Most memblocks at this point originate from memory nodes
> +        * in the DT and UEFI uses its own memory map instead. However, if
> +        * KHO is enabled, scratch regions, which are good known memory
> +        * must be preserved.
>          */
>         memblock_dump_all();
> -       memblock_remove(0, PHYS_ADDR_MAX);
> +
> +       if (is_kho_boot()) {
> +               struct memblock_region *r;
> +
> +               /* Remove all non-KHO regions */
> +               for_each_mem_region(r) {
> +                       if (!memblock_is_kho_scratch(r)) {
> +                               memblock_remove(r->base, r->size);
> +                               r--;
> +                       }
> +               }
> +       } else {
> +               /*
> +                * KHO is disabled. Discard memblocks discovered so far:
> +                * if there are any at this point, they originate from memory
> +                * nodes in the DT, and UEFI uses its own memory map instead.
> +                */
> +               memblock_remove(0, PHYS_ADDR_MAX);
> +       }
>
>         for_each_efi_memory_desc(md) {
>                 paddr = md->phys_addr;
> --
> 2.47.3
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>

