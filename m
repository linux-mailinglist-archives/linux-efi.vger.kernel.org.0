Return-Path: <linux-efi+bounces-4115-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA5AF8C08
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954B03B5FF1
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D02BCF47;
	Fri,  4 Jul 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OURYlIL9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F82BCF5C;
	Fri,  4 Jul 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617611; cv=none; b=SmLePWH0pemUktAF12h3ym6HiuqfO73fiYMo1y9RvmGwHquUz8Wg2Afs1kMbS6a8EHqKK/buKo/Wj2kPr6qpcoWFW9xZT1ipIUETslAMn9MNONMYD8S2Wg9Uzr/4Lj06CUUWyfIqaRfcem3+8yl5GHcCfKJk+hY3EKpsyEB/FzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617611; c=relaxed/simple;
	bh=9aUMtw1stPGYE0BaxMp9AP1glAqCxc7OYI5tFwmPTWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku+4vQeg5YzV3LsyDdIJW8fm2Nflkwnu6SxZMvrB2tzsbwktJvXgFi3Lez/E/4eRVs8oCFEdM8qCYt7kKfBrDNBYYtyXfto8ufgzUiJOUUOPt67OppzPUA3QL+2kFCGBLp2F7DpEHYwYDGZPnubvotD/WInafByDULU6Y9ai7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OURYlIL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10040C4CEE3;
	Fri,  4 Jul 2025 08:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751617611;
	bh=9aUMtw1stPGYE0BaxMp9AP1glAqCxc7OYI5tFwmPTWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OURYlIL9GNPi9qFVjsgDHlwjFmr6LHHVsCiKuy5ZYDQsFJPg2dMynssNMz83nBETj
	 Tose/50ZAVPROjr1NTxsdJSWzaSQEYtGu8IFIkhYcX+CeuuL2QuDq5G/yiFL6NvBFS
	 CX14xZ4sUIR6HkxC/faKmbiY66EgtBHBEq+NOkMpNXzhELY5v+qPGlmXGX38zwhy8w
	 OBDzRuelFrzpou8NOB4K+GNxkJEF2ZWGcc5cHo3ee05mLTTuql6bD7QvOVSUa8+avG
	 PjsjoeLI3yuN+Pg1Dl224l+8Y43O8JH3gG3sH967QRpEFBr8U0sGIVMZeqEJsvKfs3
	 EgXa19qTjoNzQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso806833e87.2;
        Fri, 04 Jul 2025 01:26:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8Cu/Q6ms/I1ZfKyJ8OqC2EBh8boVluminm9LH5hX0UhAiTWbeh2xEVTJfk9Z+HBuxWGiyF3P8YXe7FShE@vger.kernel.org, AJvYcCXVZeLrXOquzfhm7Bh0U4J1hA2Hx2nQAAtGAXa0tjKJ6nX4qx0DNjmHqWgtxzal0FjA2SOw2h9ylaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTxowI84HYmWnpPCboSbHJ3mCOwrLbRrskCJdFZ1Rfhud8ncV
	/1nESQH3qwmmpUfWfQwiKIce5asnruQ72ySFfrZpTFFqWk+2FpmcKLLkt/rAh4NLVDi5P6txaeR
	TeLbsJzcAPzl0PqqlEg2WkPuSsztKy7o=
X-Google-Smtp-Source: AGHT+IGpFw16pMJCMz67SWNFA6IMUVC0qphVdY6vm9ia3sgNYWHEFtvFRfb+0rVLwo2jlzGrmYMI9I0Ytmf3CMf87z8=
X-Received: by 2002:a05:6512:3690:b0:553:3770:c91d with SMTP id
 2adb3069b0e04-556d160f06bmr486751e87.4.1751617609446; Fri, 04 Jul 2025
 01:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org> <aGaxZHLnDQc_kSur@arm.com>
In-Reply-To: <aGaxZHLnDQc_kSur@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 4 Jul 2025 10:26:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>
X-Gm-Features: Ac12FXxELlmJOgclmPetSiXcBqm7bPSktVfuSqSd0ARv_5mIl32jvgAoBlJoUvA
Message-ID: <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime stack
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, usamaarif642@gmail.com, 
	rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 18:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jun 24, 2025 at 05:55:53AM -0700, Breno Leitao wrote:
> > KASAN reports invalid accesses during arch_stack_walk() for EFI runtime
> > services due to vmalloc tagging[1]. The EFI runtime stack must be allocated
> > with KASAN tags reset to avoid false positives.
> >
> > This patch uses arch_alloc_vmap_stack() instead of __vmalloc_node() for
> > EFI stack allocation, which internally calls kasan_reset_tag()
> >
> > The changes ensure EFI runtime stacks are properly sanitized for KASAN
> > while maintaining functional consistency.
> >
> > Link: https://lore.kernel.org/all/aFVVEgD0236LdrL6@gmail.com/ [1]
> > Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  arch/arm64/kernel/efi.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index 3857fd7ee8d46..d2af881a48290 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -15,6 +15,7 @@
> >
> >  #include <asm/efi.h>
> >  #include <asm/stacktrace.h>
> > +#include <asm/vmap_stack.h>
> >
> >  static bool region_is_misaligned(const efi_memory_desc_t *md)
> >  {
> > @@ -214,9 +215,11 @@ static int __init arm64_efi_rt_init(void)
> >       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> >               return 0;
> >
> > -     p = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_KERNEL,
> > -                        NUMA_NO_NODE, &&l);
> > -l:   if (!p) {
> > +     if (!IS_ENABLED(CONFIG_VMAP_STACK))
> > +             return -ENOMEM;
>
> Mark Rutland pointed out in a private chat that this should probably
> clear the EFI_RUNTIME_SERVICES flag as well.
>

If VMAP_STACK is a hard requirement, should we make CONFIG_EFI depend
on it for arm64?

> > +
> > +     p = arch_alloc_vmap_stack(THREAD_SIZE, NUMA_NO_NODE);
> > +     if (!p) {
> >               pr_warn("Failed to allocate EFI runtime stack\n");
> >               clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> >               return -ENOMEM;
> >
>
> With that:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> (but let's see if Ard has a different opinion on the approach)
>

I think this is fine - the stack just needs to be disjoint from the
ordinary kernel mode task stack so that buggy firmware is less likely
to corrupt it, and so that we can recover from an unexpected
synchronous exception more reliably.

In that sense, the old and the new code are equivalent, so no
objections from me.

