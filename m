Return-Path: <linux-efi+bounces-575-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0048571B8
	for <lists+linux-efi@lfdr.de>; Fri, 16 Feb 2024 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A441F23766
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A81145347;
	Thu, 15 Feb 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZQnA+Vj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DB8833;
	Thu, 15 Feb 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040421; cv=none; b=Ztx8fyZK54CPBy6zCo2vnsjSyLqZ3ivEmAZaBxUceIReqZ58LtTn/6unRJbALmLhi0GQkOICnDSc8nkcaHPZeFUqvkvTiHv1VCGA3LkjQ9qUfi4uajYfL3/H3fUQQnpXeCQOPqhNZT3mmEJEhWpumlWaPfz9haVPTW6kVBMLrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040421; c=relaxed/simple;
	bh=MdGOLNF5O+3/k/MN90ft/gq4gaJkB7U3p52hntLN17I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXPfNeI+bHMIOVQ6X6rgC1TAFwlZMLhri3AnsYjBJsCdOVDDfbu5CprU0UlwOw1Usthw16D5c343oBhTv/2kK03dA/rReS3TKMQH6ZVxwmsa1Eeqx1rUiiN206U4/0lqbj2qvkUpZ2UuHeVcT70izc5QtnVmL8fd7ofkkuxZ7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZQnA+Vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D593C433C7;
	Thu, 15 Feb 2024 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040420;
	bh=MdGOLNF5O+3/k/MN90ft/gq4gaJkB7U3p52hntLN17I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gZQnA+VjpmOCIRf9BW8kNoSxWl0GNonzrGp8LNK/SUjyPZVrrJ/rJJ40MCuRsXI/v
	 ETfI2MnlVBYn/ByAwOfhMv+JCOydgbzT/QDKj8u8GV7iYeA0WN4s2w5wC+DlaG0mU2
	 dJPws4t1UCpi88hW8KXWrT1VJvjSEvMwah3AwwuPGhkCLhB4mNLhDI7GOleSNn6I+F
	 MtDvAuoLpvlM9vO1P3NU+W5PgYLTPQ8XjJbY3vbWi8koboKupO22okOpKJZanKx9eG
	 yPMl31hJ7LVqrlO6DYcqhHq7zvcgk+8cgAW9SOPVIokrpgPG/U9l3f0joYKyuE2evm
	 VxdrqDzROXsyA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso18587331fa.0;
        Thu, 15 Feb 2024 15:40:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWhRzD0P1zKDk9vdZ+E9F5V5VO9zXumfoZunB5H1a0zOgaTIDBsrmMPp4uypmAEgIA2zcITFf9V6K+2TZ1hehvcG81K9EJYFx+SAjgD9h7MOzmGoq5sxqq3m1Bx14pcTrvBReM1fk8
X-Gm-Message-State: AOJu0YyQ3mBHUB+ZAIAySBjH8IZ+LxjLPnn2iyiq9evBxP1TEIcxulY6
	RyiMQS6C/ggSiRpyixSAfqamSLCt0yIhP6z5FFVuL1UKrxRhbY+TZ+5+8UQna6cMBI8ZvHe587A
	kxWCjFGkLk8VK18Oyimdo2u51kjQ=
X-Google-Smtp-Source: AGHT+IEJnOuiKoXLEzOneSrmISAp+FvSiNtE8/3bi4MJIh9xlNEbfU2lfXGAfUxhS3wG7zMPFna3hgcfQe2KZIk6//Y=
X-Received: by 2002:a05:651c:1a29:b0:2d2:912:916b with SMTP id
 by41-20020a05651c1a2900b002d20912916bmr2609906ljb.24.1708040418698; Thu, 15
 Feb 2024 15:40:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215225116.3435953-1-boqun.feng@gmail.com> <CAMj1kXF3L5SdeXDfd3uYSOz-oG7+J31pd3WtZJ+g9eGDHDdOxg@mail.gmail.com>
In-Reply-To: <CAMj1kXF3L5SdeXDfd3uYSOz-oG7+J31pd3WtZJ+g9eGDHDdOxg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Feb 2024 00:40:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGd8a-ZrSj4N=F9NZgAXcvNNHvF86aEs9smSwu66D85+Q@mail.gmail.com>
Message-ID: <CAMj1kXGd8a-ZrSj4N=F9NZgAXcvNNHvF86aEs9smSwu66D85+Q@mail.gmail.com>
Subject: Re: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
To: Boqun Feng <boqun.feng@gmail.com>, Oliver Smith-Denny <osde@linux.microsoft.com>
Cc: stable@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 00:21, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Oliver)
>
> On Thu, 15 Feb 2024 at 23:51, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
> > a trouble with the following firmware memory region setup:
> >
> >         [..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
> >         [..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]
> >
>
> Which memory types were listed here?
>
> > , on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
> > range will be omitted from the the linear map due to 64k round-up. And
> > a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:
> >
> >         [...] Unable to handle kernel paging request at virtual address ffff0000dfd80000
> >
>
> You trimmed all the useful information here. ACPI reclaim memory is
> reclaimable, but we don't actually do so in Linux. So this is not
> general purpose memory, it is used for a specific purpose, and the
> code that accesses it is assuming that it is accessible via the linear
> map. There are reason why this may not be the case, so the fix might
> be to use memremap() in the access instead.
>

Please try the below if the caller is already using memremap(). It
might misidentify the region because the start is in the linear map
but the end is not.


diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 269f2f63ab7d..fef0281e223c 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -31,7 +31,6 @@ void __init early_ioremap_init(void)
 bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
                                 unsigned long flags)
 {
-       unsigned long pfn = PHYS_PFN(offset);
-
-       return pfn_is_map_memory(pfn);
+       return pfn_is_map_memory(PHYS_PFN(offset)) &&
+              pfn_is_map_memory(PHYS_PFN(offset + size - 1));
 }

