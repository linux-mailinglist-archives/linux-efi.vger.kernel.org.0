Return-Path: <linux-efi+bounces-5650-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB1C7C189
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 02:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC26635EAE3
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 01:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED929D28A;
	Sat, 22 Nov 2025 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l36EEGOj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F71287269;
	Sat, 22 Nov 2025 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775356; cv=none; b=Q6rnr4gDSTyiPNc5Jgu2FklX/pQJ5xYQopnVdczrnwM4og13cRSE9pc00ZGRmOv9Lr7/GWvnz65WdGt/s43WfnLKGXOnYxoSyfQizPWP4Nwk+uQYmpaUGODzDTdKXWDe9w/vqS6+stTWVNtLiPV82X+LG7L/n4MXyBhbzdwKKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775356; c=relaxed/simple;
	bh=nQkWOwaTw36gMDiYgxDhMlzpOTjcrAM2DF2QmNc8EMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeAxfEqixSOIZK8Kqf+CMGwjf2o+wSOnMfmebzv87eG8oBvqts4A/GVdW9wTdbEQ5Kc53mZGidrF1K9rNSX2MhEOaJ5tAAoqzgmf1lxvj4lrCrX78ALB9o8//Zm2ujByomA/3w6D7afpMw84HZ9NrFPyIZc5yNqkTbY+87qAy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l36EEGOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C965EC4CEF1;
	Sat, 22 Nov 2025 01:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775355;
	bh=nQkWOwaTw36gMDiYgxDhMlzpOTjcrAM2DF2QmNc8EMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l36EEGOjwua6msm41YR6/XW0HneEoFKcD817r2luDLPv4cwsDLsxpy/R7NtNuKVeV
	 YbZdTcJUSt0oqJPoFWsDo3DXphieyd3wKCultEzKQNX/aaS54ux2b7HFkcEkQ91GTt
	 Z4TxYiyuAIttgeCCHNCnFjL+M3UugXlvVaUdVcDZVg9AP0m56CqPdQkM1Qo4vDHzOp
	 vgXgzwEcZwEKliLOK2EMNNqlU9QRnRZafcBLqAuQDi9Ag3SRkBzgWNIuE8geiNWfCa
	 BH4qnKX2BA8ARE0zRYGiF/cKiU5r33tKYS5IV8B8+0iXr9pekgZ67+vWAvNGJ1b9Gk
	 m6p1Ii0z+3Euw==
Date: Fri, 21 Nov 2025 18:35:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kbuild: Add KBUILD_VMLINUX_LIBS_PRELINK
Message-ID: <20251122013551.GA3928114@ax162>
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
...
> index 433849ff7529..e72d3254b93f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -61,12 +61,11 @@ vmlinux_link()
>  	shift
>  
>  	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
> -		# Use vmlinux.o instead of performing the slow LTO link again.

Why is this comment getting removed?

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

