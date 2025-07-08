Return-Path: <linux-efi+bounces-4190-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C488AFCA23
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78F7560B66
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3E2DAFC8;
	Tue,  8 Jul 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9gs4jnv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C42DAFC3;
	Tue,  8 Jul 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976876; cv=none; b=gMafN4yBEeL3srVg/3401uvcmo1yV8nfY5V2MrNp1nYxpjnyct8gED+tIyVON+mt0r9+SNQ7uVTt95uVEXd1kA1mOB8JqytWiJgqqfEtJqbPUPKslN0Bor8ZSrilO/7JLvAx96YAZeMBoC2hQJvHdqAWgPpT/JcyXoCio1IeWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976876; c=relaxed/simple;
	bh=kEi/z0SApD4McCBJYfg8E/oqKRETuGz5mVH55FI4E9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIU3HdAEBhRp1mTS1sNOgRO93sfQj+4Yx8oJeIU82/Jwa7AZ8OqhMkgyxv6TsyAEw9ykSu/Cev+fogGl8SksONet2mla+s4cOh9xXbxjtbOEXZMQRfp/i4n8dwTYrBMrnAAdvuW6V4T3rjQhTUz2eIfIMtxO1lbzT0UjbcZh+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9gs4jnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F884C4CEED;
	Tue,  8 Jul 2025 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751976876;
	bh=kEi/z0SApD4McCBJYfg8E/oqKRETuGz5mVH55FI4E9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9gs4jnvcQMxjniKthzF3T8B3QVKkcsrdRfyYJF4BGni/JN22pFgMB8IbtBOz6n3K
	 xNGQHd1htHQ+dG2IRx+Qie9IBQgtvcUNUOgOz/P+oXe6IpiWHMPBitQlBvTJQJIM/h
	 JOOkfwv3qAunprvbL5qDiP4Ij81eqOPJcAVq6V1CcSjfyLPj68UCmGZ2JQBKAkk8jJ
	 knu0fVXaBTkCOGuitbI3jvSyqG4SSSg+sScLbJFsGNatOxuu53pznGGyIGmPq40Pr3
	 LI0zOG87BaGPM58U4xCr/YjhUwcwwYbac3MsVj9s19Gb98s8WqnypFJ6+ICYkPcCaT
	 yDUMJPB0CU+uQ==
Date: Tue, 8 Jul 2025 13:14:31 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, leo.yan@arm.com, kernel-team@meta.com
Subject: Re: [PATCH 1/8] arm64: Enable VMAP_STACK support
Message-ID: <aG0Lpy1c2LuSPdj2@willie-the-truck>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
 <20250707-arm64_vmap-v1-1-8de98ca0f91c@debian.org>
 <aGwCfRkYqcYBvxZK@J2N7QTR9R3>
 <aGznbObwbaZlnD17@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGznbObwbaZlnD17@gmail.com>

Hey Breno,

Thanks for doing this.

On Tue, Jul 08, 2025 at 02:39:56AM -0700, Breno Leitao wrote:
> On Mon, Jul 07, 2025 at 06:23:09PM +0100, Mark Rutland wrote:
> > On Mon, Jul 07, 2025 at 09:01:01AM -0700, Breno Leitao wrote:
> > > Enable virtually mapped kernel stacks for ARM64. This provides better
> > > stack overflow detection and improved security by mapping kernel stacks
> > > in vmalloc space rather than using direct mapping.
> > > 
> > > VMAP_STACK helps catch stack overflows early by placing guard pages
> > > around kernel stacks, and also provides better isolation between
> > > kernel stacks and other kernel data structures.
> > > 
> > > All dependencies are satisfied for arm64: HAVE_ARCH_VMAP_STACK is
> > > already selected above, and KASAN_VMALLOC is selected when KASAN is
> > > enabled, meeting the KASAN dependency requirements.
> > 
> > I reckon it might be better to say something like:
> > 
> > | arm64: Mandate VMAP_STACK
> > |
> > | On arm64, VMAP_STACK has been enabled by default for a while now, and
> > | the only reason to disable it was a historical lack of support for
> > | KASAN_VMALLOC. Today there's no good reason to disable VMAP_STACK.
> > |
> > | Mandate VMAP_STACK, which will allow code to be simplified in
> > | subsequent patches.
> > 
> > ... to make it clear that we're not changing the default, and we are
> > removing the ability to deselect VMAP_STACK.
> > 
> > Either way, the patch itself looks good to me.
> 
> Thanks for the suggestion. I will update and respin.

No need to respin just for that; I can fold the above when I apply.

Cheers,

Will

