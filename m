Return-Path: <linux-efi+bounces-1216-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C18907998
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC38C1C237D3
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501414A633;
	Thu, 13 Jun 2024 17:19:11 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAC14A62F;
	Thu, 13 Jun 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299151; cv=none; b=srYmRtpgyVmGmrUH3YV4pZw/D/JmsnEhKr6iS2QEMnA+/CH6PCh+sRBg7hMZfW6jl3UcmbgzOwhrciU1fi9SOs1hl1CDqNtOCXOKqqP2P8fakfE3UDuN5oPIF9A6VCoGofWVNEOhMpa/7maoXtxOBrsV6cU/plgnCUL9EfDK2iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299151; c=relaxed/simple;
	bh=y1kH8xzI8T8Uj60m75aLu0+Pa+JTu+23CAjyZUqTDEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBpWsctPkIYh6f7bzl29eSKta2IZ3gwGJ2hNTBFD5jMB5ipMaybvXedLGxg6AZXUMAUN6ukWnwt3mF7xyh+Cx8jKjzDDhwmVfIp57PKRrMF5/uxr2BNfLChKJSNWww40f+qcFVGu68fIA9JjXn5GAIsa8wcFUYM94JodyeV7Qlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4567C3277B;
	Thu, 13 Jun 2024 17:19:09 +0000 (UTC)
Date: Thu, 13 Jun 2024 18:19:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/efi: Fix kmemleak false positive in
 arm64_efi_rt_init()
Message-ID: <ZmsqC_q1jyMGzvUF@arm.com>
References: <20240613162031.142224-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613162031.142224-1-longman@redhat.com>

On Thu, Jun 13, 2024 at 12:20:31PM -0400, Waiman Long wrote:
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 4a92096db34e..712718aed5dd 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/efi.h>
>  #include <linux/init.h>
> +#include <linux/kmemleak.h>
>  #include <linux/screen_info.h>
>  #include <linux/vmalloc.h>
>  
> @@ -213,6 +214,7 @@ l:	if (!p) {
>  		return -ENOMEM;
>  	}
>  
> +	kmemleak_not_leak(p);
>  	efi_rt_stack_top = p + THREAD_SIZE;

It looks like a false positive and the reason is that we only store
p + THREAD_SIZE in efi_rt_stack_top, not the actual allocated pointer.

-- 
Catalin

