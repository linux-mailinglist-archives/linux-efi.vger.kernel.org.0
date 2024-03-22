Return-Path: <linux-efi+bounces-849-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC6886CA9
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D042284719
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2EF4595B;
	Fri, 22 Mar 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg5Mqxje"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AA4501C;
	Fri, 22 Mar 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113488; cv=none; b=cGe0bo3KcYxBHfqkeHjvus13amhf6DeQriD8GuHVyW9ntJJAZ4Q51SXd/FW6gGT3usr/rmaYNv4qfQU4G0+NJarYzLye1G5V9nun/5cISI1YTs3MjFITHSW2chrm9CMGWPdyBM1JAJr4xAvkwSgB1RpONe1IX8KU7cbDQ5PT4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113488; c=relaxed/simple;
	bh=HAKZ7cmBvqd6aSZFndMvBQg8DCq/3g1+oo1NIjMagHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATZDyjSCuxve+3SJtxx/Rm+zxmUBQmHyj4pRo2uqBcuo0vaqHZxbXBTQWrHFdXXuq8KOHuDHdH7T2Q8dljWu2eMVGrePLYeqdNjnDEsN6/QbIOpjw1U/SeR66tracT2k50lUNgTn9Hkvo648uz7+VIPd8qtxeknIE1ss0UdCKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg5Mqxje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B8C433C7;
	Fri, 22 Mar 2024 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113488;
	bh=HAKZ7cmBvqd6aSZFndMvBQg8DCq/3g1+oo1NIjMagHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tg5MqxjepdspHRR5uIeSUEeWCfndJZIpSgKe5FNHJJqmLE8TtJoPdgXPSaF1/BAnt
	 3b8xJx44vgVFDcWSHIiV4GNpwiA2jzR24jTfpzlP4KT/7RTVmhADBjAR5CXhEhylSZ
	 vVuJ6xWDmq5X7aGKKemy+oRbwO1su6TyVwZwbE3kF1vD82zXUKLpXl9xRINP8wzIFJ
	 ADmPiYCWiFmKbasxDDegdvYYnZV2VWsHjNW1Jntt6EjCuOl5TPdsqy5UFvNgfFXZmn
	 7otGsrHTDEi+gzhJR7EzrjSc7VCVMFcnyXi5oVipuDUyXyE4RmpzKepF5rcmUxro7F
	 BpIEI9IYsunmA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513e25afabaso2437770e87.2;
        Fri, 22 Mar 2024 06:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvjStzuX6anZY0Z9hec8pUrd9eNOKcbo4SFpMfhb7dVhICz/uPXlHAHJzguHRaxyNWd7u0F82P0rtFczHTE2bFHRtSfkxhfk6YnHKK
X-Gm-Message-State: AOJu0YwM4Famppuy8l1XnonvhQcLvteK0BpiZxPltfVBXEHGnFmZyf+N
	U5ESU0NStKAJsVrApeW1eIfxxeCVUNzZKOccYgyaWTEZLGiIv1EVP9ppVBxJip23jHX+8J5eID6
	yFjDkguiGbQe5t+1g7g7bhOpwB0U=
X-Google-Smtp-Source: AGHT+IEIA+evTHJpyKg98JNtKwr5btrYIbch9rK1MshAfP0vLICEz71naB+QTV7q817ECTKKOei8/+8e3+92R6/E2oY=
X-Received: by 2002:a19:3813:0:b0:515:92a8:25c1 with SMTP id
 f19-20020a193813000000b0051592a825c1mr1495201lfa.56.1711113486649; Fri, 22
 Mar 2024 06:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322110058.557329-1-kazuma-kondo@nec.com>
In-Reply-To: <20240322110058.557329-1-kazuma-kondo@nec.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Mar 2024 14:17:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFSpF0YzwtgER11ocBrhjyG0Us7=kp7a92tDm3aZy=WrA@mail.gmail.com>
Message-ID: <CAMj1kXFSpF0YzwtgER11ocBrhjyG0Us7=kp7a92tDm3aZy=WrA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: fix efi_random_alloc() to allocate memory at
 alloc_min or higher address
To: =?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"tomenglund26@gmail.com" <tomenglund26@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Mar 2024 at 12:01, KONDO KAZUMA(=E8=BF=91=E8=97=A4=E3=80=80=E5=
=92=8C=E7=9C=9F) <kazuma-kondo@nec.com> wrote:
>
> Following warning is sometimes observed while booting my servers:
>   [    3.594838] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic al=
locations
>   [    3.602918] swapper/0: page allocation failure: order:10, mode:0xcc1=
(GFP_KERNEL|GFP_DMA), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0-1
>   ...
>   [    3.851862] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for a=
tomic allocation
>
> If 'nokaslr' boot option is set, the warning always happens.
>
> On x86, ZONE_DMA is small zone at the first 16MB of physical address
> space. When this problem happens, most of that space seems to be used
> by decompressed kernel. Thereby, there is not enough space at DMA_ZONE
> to meet the request of DMA pool allocation.
>
> The commit 2f77465b05b1 ("x86/efistub: Avoid placing the kernel below LOA=
D_PHYSICAL_ADDR")
> tried to fix this problem by introducing lower bound of allocation.
>
> But the fix is not complete.
>
> efi_random_alloc() allocates pages by following steps.
> 1. Count total available slots ('total_slots')
> 2. Select a slot ('target_slot') to allocate randomly
> 3. Calculate a starting address ('target') to be included target_slot
> 4. Allocate pages, which starting address is 'target'
>
> In step 1, 'alloc_min' is used to offset the starting address of
> memory chunk. But in step 3 'alloc_min' is not considered at all.
> As the result, 'target' can be miscalculated and become lower
> than 'alloc_min'.
>
> When KASLR is disabled, 'target_slot' is always 0 and
> the problem happens everytime if the EFI memory map of the system
> meets the condition.
>
> Fix this problem by calculating 'target' considering 'alloc_min'.
>
> Cc: linux-efi@vger.kernel.org
> Cc: Tom Englund <tomenglund26@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Fixes: 2f77465b05b1 ("x86/efistub: Avoid placing the kernel below LOAD_PH=
YSICAL_ADDR")
> Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>

Hello Kazuma Kondo,

Thanks for your patch. I will take it as a fix.

You sent the same patch twice, right? Is there any difference between the t=
wo?


> ---
>  drivers/firmware/efi/libstub/randomalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmwar=
e/efi/libstub/randomalloc.c
> index 4e96a855fdf4..7e1852859550 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>                         continue;
>                 }
>
> -               target =3D round_up(md->phys_addr, align) + target_slot *=
 align;
> +               target =3D round_up(max(md->phys_addr, alloc_min), align)=
 + target_slot * align;
>                 pages =3D size / EFI_PAGE_SIZE;
>
>                 status =3D efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRE=
SS,
> --
> 2.39.3

