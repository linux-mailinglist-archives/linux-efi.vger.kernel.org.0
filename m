Return-Path: <linux-efi+bounces-5626-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E3C77A29
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 08:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC74E80D8
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7CF2D77EA;
	Fri, 21 Nov 2025 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsIlKV+a"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759036D515;
	Fri, 21 Nov 2025 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708506; cv=none; b=pd3jhjW1knqixcLEtuvMmie+I9dhZxaF5TvfIm6VspMByRYXrR4JXe7s6L3sMD8osIb0QYoJ2p10EhBmFG0FfWB+rgriMuyYNhBDfiyfuqsvv0r/WuV/V/K2dQSVSTMuleCmtKNNozzIQPg+KzVKg+zBOwX8cV6IAqSbv6/Td/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708506; c=relaxed/simple;
	bh=1YnEm2rwYro5kibPE7TCBvONQ7gMituY5BQOTzSye/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqwrGH+Ftl0ICU3QntMm5DI+W+sQHbUXWac0a4KsRINsYs9Bx5zP2H0tlM0W88Fxa1kY2TpcyP0r9lK6kTtJaA4ulQ1vxt90yraOgFEJv02yMcFw6HtPcJvoXe0MMM1VHW9AjCuTgSWAt+kdanwzN7sf6B05o7MWhL6bZANlpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsIlKV+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DE4C4CEF1;
	Fri, 21 Nov 2025 07:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763708505;
	bh=1YnEm2rwYro5kibPE7TCBvONQ7gMituY5BQOTzSye/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsIlKV+azWDhpO+J32G4unagDrWFST2VumSfhKWuVYUEAwoDv+aVp22lROqHAwE6m
	 eZT/MSEkH8tWj56AeDZ6Nb2SoQQdCXvXvlJmz/0OvXlf1PkkaLAOLBidSpbxs5LqyQ
	 wx8oNhKq1nfYTl4yoPqn/cfgW0aE14ipP/6SQ4nOVl4FtWsvpeFZcgkKeAsCJTUkcM
	 dIddexyQrvr70uypC0ogeCOFlyHyBVBZQ4ThAj2Q1asa7ikRlgWO/H4gyc9sXOx6VR
	 R4L+zkr8xX0yj+c0NAeWAsINUCBl4OxhjHw76dwQChivSgX7SEjQ7YDQbZ/LVt9gwY
	 1zdrWruK71EFw==
Date: Fri, 21 Nov 2025 00:01:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kbuild: Add KBUILD_VMLINUX_LIBS_PRELINK
Message-ID: <20251121070140.GA780042@ax162>
References: <20251119042708.27658-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119042708.27658-1-yangtiezhu@loongson.cn>

On Wed, Nov 19, 2025 at 12:27:08PM +0800, Tiezhu Yang wrote:
> In order to only link libstub to the final vmlinux, it can not use the
> current KBUILD_VMLINUX_LIBS, just add KBUILD_VMLINUX_LIBS_PRELINK. This
> is preparation for later patch, no functionality change.
> 
> Link: https://lore.kernel.org/lkml/pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy/
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> There is a long discussion in the previous patch:
> https://lore.kernel.org/lkml/20250928085506.4471-1-yangtiezhu@loongson.cn/
> 
> This version is based on 6.18-rc6, split the generic parts out
> into a separate patch to avoid merge conflicts, the other parts
> will send out after the merge window.
> 
>  Makefile                | 1 +
>  scripts/link-vmlinux.sh | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d763c2c75cdb..69485f47b794 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1199,6 +1199,7 @@ KBUILD_VMLINUX_OBJS := built-in.a $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)
>  KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
>  
>  export KBUILD_VMLINUX_LIBS
> +export KBUILD_VMLINUX_LIBS_PRELINK

This variable name is a little confusing to me since they do get added
to vmlinux during linking, not before. I am not sure of a better one
though, maybe KBUILD_VMLINUX_LIBS_FINAL? It may also make sense to
introduce similar syntax to the existing libs-y syntax, maybe

  final-libs-y

or something like that?

Also, since these objects are no longer in KBUILD_VMLINUX_LIBS, does
this new variable need to be added to any of the other places in the
build system that use KBUILD_VMLINUX_LIBS for things such as build
dependencies?

>  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
>  
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 433849ff7529..e72d3254b93f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -61,12 +61,11 @@ vmlinux_link()
>  	shift
>  
>  	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
> -		# Use vmlinux.o instead of performing the slow LTO link again.
>  		objs=vmlinux.o
> -		libs=
> +		libs="${KBUILD_VMLINUX_LIBS_PRELINK}"
>  	else
>  		objs=vmlinux.a
> -		libs="${KBUILD_VMLINUX_LIBS}"
> +		libs="${KBUILD_VMLINUX_LIBS} ${KBUILD_VMLINUX_LIBS_PRELINK}"
>  	fi
>  
>  	if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
> -- 
> 2.42.0
> 

