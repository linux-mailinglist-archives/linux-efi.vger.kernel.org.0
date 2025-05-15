Return-Path: <linux-efi+bounces-3710-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F00AB7EBB
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 09:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88A686261F
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670AB1C1F21;
	Thu, 15 May 2025 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbwUTmev"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6554B1E44;
	Thu, 15 May 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293764; cv=none; b=sjDDDZrU2hP0CasHN5aA+xZfrWsq42lCVgum8JxOQRyQzrYRGC1cWlj6722FLkWVZ7Vn6oOUSs2tm2TjKLQe9GxnndOIujMzTlKGWwe6WOfK5TN6TcD7lykIZrUrY6f3Gsf4odwowc2MyNSjC0M1dJoyOqvXO3Am2S/K0GrGfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293764; c=relaxed/simple;
	bh=YHJT4wm+T2A49IT7RSsIJGqVIPpC3aXG4z2X+sFYsUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2S/x+riSTuO0WlCI3N/4oebwfTYyT1Nj9izyrCABFBBow0nucP8JQ+/G+TfNjBx/mLtg1fWLo0j+eAQcb8/AeS2oSrzypx0FHGVqGEn3Y5zzMEemwuITyw9yfKKIORNrpf4IBmNt0ZtZU21n6XB3DEX0NL1k1raAT2F8yo15X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbwUTmev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD63C4CEE7;
	Thu, 15 May 2025 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747293763;
	bh=YHJT4wm+T2A49IT7RSsIJGqVIPpC3aXG4z2X+sFYsUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbwUTmevQ8BmLai2PWIHrlt6AXd779vz3b4vVk/itFR6ZImShZfpNL02IJtoP6YOj
	 ZUA57Tbh+BOwGXsKMx0EJo0ySV+CqMLEkH7I7e7LPM4f5a78IWIL8m1l5jCX+S+zH0
	 8SSd0CdM6qbJI2NeqDIfLSB6lXFTV4k/nQmYZMNUl8v4NvfJYXb5LpeqSK72hlsYFN
	 Ud8S913d9C0BCy06hix8z0NXnUCwKzcEoHQdYz4BSImokQ5uzpmPCjxB++DeXBNk2x
	 0L6avX8w2A01XG1BsQXOzv6WzuktGXX8/iQyOffg0LxOsIdeziAKn3hcK8HBZ4wNo5
	 r/X7UDgsygs3g==
Date: Thu, 15 May 2025 09:22:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 01/21] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
Message-ID: <aCWWPmVloPP0_St0@gmail.com>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-24-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> +	if (cr4 & X86_CR4_OSXSAVE)
> +		/* Safe to read xcr0 */
> +		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> +	else
> +		/* xgetbv will cause #UD - use reset value for xcr0 */
> +		ghcb_set_xcr0(ghcb, 1);

Just a couple of style nits here - this new __sev_cpuid_hv_ghcb() 
function should follow the existing SEV* (and general x86) style:

 - When mentioning instruction mnemonics, please capitalize them, such 
   as XGETBV here.

 - Same goes for registers, such as XCR0.

 - Finally, if a comment line turns a branch into a multi-line 
   statement, curly braces are needed, even if it's technically still a 
   single statement per the C syntax which eliminates comments at the 
   preprocessor level.

Thanks,

	Ingo

