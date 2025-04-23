Return-Path: <linux-efi+bounces-3429-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DEEA98EAA
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4171B8029C
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB44280A5F;
	Wed, 23 Apr 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYMljrPl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB3280A5B;
	Wed, 23 Apr 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420099; cv=none; b=mzpYeZ6oXocZPtWAbCp0mmcxWkxzIXCSw1pN64zViTrXWOS3SO72rt3+4QRbdkYTaCWM7MglYXZWc77Sp/TVgWK9PpVAtnEmqPMJM3mwvsgi6tik2xwH2fK+Gjfzig/TcsPBnaEB9TkCgR2bs91blbBAWc1z1F93gJKN0l4aUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420099; c=relaxed/simple;
	bh=BZUQRAYUddc34QXc/MDpz5LiGoKEZUtXDQhactkv3dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6sFp/3WJmKl/4hd+GQR783g19mtjuAdj+jSxOxHKINN/fnArhV6dDYcn9Irwz08ScL8bz5zD1tXpuigIoorn5tbfSe3vHxLoxsPeibSCRd18Rp3DzBuSpYiTlMojxqhWJRUYjcXoGuyWV7J6/4xiT3S+RuP2DkpoqCa20psvO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYMljrPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F68C4CEE2;
	Wed, 23 Apr 2025 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420099;
	bh=BZUQRAYUddc34QXc/MDpz5LiGoKEZUtXDQhactkv3dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYMljrPlU/jGgjyvMxkoCSABMerrM9A9mKSPQwUI56SrEOCKBaXzrP48oOBgymYam
	 uzhNIkN8WcGz63+vkBu5DYUa0jLXZvGReHqb0NaE2nr6ualwZeeLgEeiAKYsxCR+Tk
	 m5evl+ZXsEQm4XhFR91Uuu/kgFlvF4ltvuOztOYiWmTuT+QLB5BKYKleueSA5bOOZF
	 OKVna9LiFwW8HXm5dInmNHi45icOQuiz38YMuqowQ4x6+Do4baKM4IsM7g2rc8THby
	 tUMy9JQegLMFSP4ixCN65NjKK6Mqf7+LgeYR6xhgqRjuHnWTfOORPGKJ78jGjph3M+
	 Z9fiErcmjTJGw==
Date: Wed, 23 Apr 2025 07:54:56 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: tip-bot2 for Ard Biesheuvel <tip-bot2@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-efi@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Disable jump tables in PIC code
Message-ID: <odoambb32hnupncbqfisrlqih2b2ggthhebcrg42e5fg25uxol@xe5veqq52xif>
References: <20250422210510.600354-2-ardb+git@google.com>
 <174539448176.31282.2929835259793717594.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174539448176.31282.2929835259793717594.tip-bot2@tip-bot2>

On Wed, Apr 23, 2025 at 07:48:01AM +0000, tip-bot2 for Ard Biesheuvel wrote:
> The following commit has been merged into the x86/boot branch of tip:
> 
> Commit-ID:     121c335b36e02d6aefb72501186e060474fdf33c
> Gitweb:        https://git.kernel.org/tip/121c335b36e02d6aefb72501186e060474fdf33c
> Author:        Ard Biesheuvel <ardb@kernel.org>
> AuthorDate:    Tue, 22 Apr 2025 23:05:11 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 23 Apr 2025 09:30:57 +02:00
> 
> x86/boot: Disable jump tables in PIC code
> 
> objtool already struggles to identify jump tables correctly in non-PIC
> code, where the idiom is something like
> 
>   jmpq  *table(,%idx,8)
> 
> and the table is a list of absolute addresses of jump targets.
> 
> When using -fPIC, both the table reference as well as the jump targets
> are emitted in a RIP-relative manner, resulting in something like
> 
>   leaq    table(%rip), %tbl
>   movslq  (%tbl,%idx,4), %offset
>   addq    %offset, %tbl
>   jmpq    *%tbl
> 
> and the table is a list of offsets of the jump targets relative to the
> start of the entire table.
> 
> Considering that this sequence of instructions can be interleaved with
> other instructions that have nothing to do with the jump table in
> question, it is extremely difficult to infer the control flow by
> deriving the jump targets from the indirect jump, the location of the
> table and the relative offsets it contains.
> 
> So let's not bother and disable jump tables for code built with -fPIC
> under arch/x86/boot/startup.

Hm, does objtool even run on boot code?

-- 
Josh

