Return-Path: <linux-efi+bounces-1613-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F8C96289F
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 15:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBC3B22485
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B90181328;
	Wed, 28 Aug 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuDgMfT0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E416BE1B;
	Wed, 28 Aug 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851694; cv=none; b=aW/qhcMwlWi59MvzZzyg7B7Yc43zGJGqj1EVNibUPOEr6OAnjqhvg54tXaj13LCQt+MlTD0SYi2sDp1mdBAoiokOAOUbm8sPUU3TWIEI+4sI/RGltmW015F5nwWHDHHgezDEht3RBDTtSKh0WxhT34WzpEnqTNUUXC1krrJHAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851694; c=relaxed/simple;
	bh=KW5R7PwTkwJ7eH25MlLERl4o7RhFtKAZw+Vph435i7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNS2yThr75gblHTYNFEhSuaNSAlZTUGUCp3Z3oQghF9WJT7kemM6HJDCenTh6jtIDkDBJAdRyr0X0pIhsw7Pjbppb3Pxehv5hmA1PL4jVCRNm2zMhJOBu+IMgUbqO/9RUVt9wP38uW9+kRoqlUNyyUOQj0uAuC1CsvEfiUurpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuDgMfT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8CEC4FEA9;
	Wed, 28 Aug 2024 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851694;
	bh=KW5R7PwTkwJ7eH25MlLERl4o7RhFtKAZw+Vph435i7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DuDgMfT0kvoDLyx95ArYFHwsNqDzm6c4x7/q1V3hvhbqF/TzT9iKEZmBTYQmJP3RM
	 HPuxl935jLmeaVpD3uiIJOk/F8xg+tsHUClxjXJXn5DHGKz6essCDjGPBHQZc+GpUY
	 mIkNt3AKSXkJhltbBvo1fMG67b2lHr/w2H2n3iRLLH6IW1TzWvm9nEEisO6wXskNAn
	 R7RxpO1/C9HmRd4/LRTUovmmqAyWIj3sh78gT+FLw0n9vTAHvN14l5Ks1oPvNu77QS
	 Y/0HqKcmC+hf0rpS7iU+3oEH98sl5rVrjvSRivMAOw/ROX+P2B3CM7b1BHV6kNI1lL
	 uHbuvLz2oDC4w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f50966c448so43596911fa.2;
        Wed, 28 Aug 2024 06:28:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtQJehQr30aKfiZoUCO6Arvt9YJdUyMtKVXtVzPLb6gz4Id9CL93SlI/NMkFg5PdqPBZx27StHl/VQC4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkD0qwtRBlvphPZebR2aOSUTfHLdZXQjvHWPw6UoBfZgN0sDZ
	jKNLy88yl+1+gLBqXFGDT3FJKXsUGUhrMPFXBcmDaGSq/X5MgTNib7qiwsRwR2C6NRLgx87ZpM3
	sL19F27g6IsU8dSqvfny6pg301BU=
X-Google-Smtp-Source: AGHT+IFPpXqgB2ZHxGcUOd4HwSoKV4p7KRCTOVZffH5Q1PrkpitY1msj3d+3/H33hv0TesEGqrq38ufbKq5w17FoLjM=
X-Received: by 2002:a2e:a54e:0:b0:2f3:e2f0:af15 with SMTP id
 38308e7fff4ca-2f5617dca81mr13124511fa.30.1724851692671; Wed, 28 Aug 2024
 06:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <20240819145417.23367-2-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-2-piliu@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 15:28:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG_TynaQni6mzXYg6sCybSMba7cuwnyb4qi5LNZ=53pKQ@mail.gmail.com>
Message-ID: <CAMj1kXG_TynaQni6mzXYg6sCybSMba7cuwnyb4qi5LNZ=53pKQ@mail.gmail.com>
Subject: Re: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip unusable memory
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-efi@vger.kernel.org, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 16:55, Pingfan Liu <piliu@redhat.com> wrote:
>
> efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> but the current implement can not ensure the selected target locates
> inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> EFI_RUNTIME_SERVICES_* etc.
>
> Fix the issue by checking md->type.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> To: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> index c41e7b2091cdd..7304e767688f2 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
>                 efi_memory_desc_t *md = (void *)map->map + map_offset;
>                 unsigned long slots;
>
> +               if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +                       continue;

This is wrong in 3 different ways:
- md->type is not a bitmask
- || is not bitwise but boolean
- get_entry_num_slots() ignores all memory types except
EFI_CONVENTIONAL_MEMORY anyway.

So what exactly are you trying to fix here?


>                 slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
>                                             alloc_max);
>                 MD_NUM_SLOTS(md) = slots;
> @@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
>                 efi_physical_addr_t target;
>                 unsigned long pages;
>
> +               if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
> +                       continue;
> +
>                 if (total_mirrored_slots > 0 &&
>                     !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>                         continue;
> --
> 2.41.0
>

