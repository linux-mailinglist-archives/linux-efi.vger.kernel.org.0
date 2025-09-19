Return-Path: <linux-efi+bounces-4874-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D798B8949D
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED46B1C8454C
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925E30C100;
	Fri, 19 Sep 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz4Ve53m"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10330BB92;
	Fri, 19 Sep 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281766; cv=none; b=iyIEhLiiCCHjr56PN428JZlwHmlCtInV6VkCl74qS0/M7Nncw9tKVeiYJbIorp7AEa1D8MJzxEIoTzAcJwm6gyvdsTek+Ps21gPj51cnX6vJDwMgJkZep7t6G10mdYZ2wS9ofMyHOzICEvObtXMe9gGb5XkklJlZTF7RayQRj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281766; c=relaxed/simple;
	bh=wnyDqESt/ipv898GHeveS4jM+lRj8y6Mhs5r+47EcR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1TwVbL/rRT8QTyBTnpNgHRky9F0RPH6zoGDjgPDWhG4z6hwHwfl+iVLpRX4BJdqg3QoPyJQDlkr65+Z9/S8BBVn3ytUklupq1m479Uk7e9EuxG0PunGJ3C1v9mu2+bT4u7ptuwq92dfC7L1pFD8NKWpItcIbKfEAZKRgH2d3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz4Ve53m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E915C4CEF0;
	Fri, 19 Sep 2025 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758281765;
	bh=wnyDqESt/ipv898GHeveS4jM+lRj8y6Mhs5r+47EcR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qz4Ve53mma2E/fOmseIz7hIcDw9Z7wZpbryG+ZEJV3QplSorgNXiOn4BTUSJVlp8Q
	 jCZe7yanDfhQEcEXb3Anl+JUkn29ahTyirG0dR03TeSb9+4Q9fE8TVyAlR+yeA1qaZ
	 MvTtpiejxzhHJDA40Bsmi5NDBl7I7LFF4t6vVLPM4QItqatPi7Z6alKn26MKLjfEFr
	 AnJLGAYJEV1HCIgk/DKz7UabhIcQOEp+bnw/RAqzIT9t6tMzLpYzeIvPJG9eGNWQc/
	 o6PtMDmBSsWkLHTxagF7PePCmtpVpoKTAt1QTlSGChnxzqq/wnLTuJKYLOCJgHG3Bp
	 tmFNl6HqA2X/A==
Date: Fri, 19 Sep 2025 12:36:00 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 7/8] arm64/efi: Move uaccess en/disable out of
 efi_set_pgd()
Message-ID: <aM1AIPmNGik2fqL3@willie-the-truck>
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918103010.2973462-17-ardb+git@google.com>

On Thu, Sep 18, 2025 at 12:30:18PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> efi_set_pgd() will no longer be called when invoking EFI runtime
> services via the efi_rts_wq work queue, but the uaccess en/disable are
> still needed when using PAN emulation using TTBR0 switching. So move
> these into the callers.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/efi.h | 13 +++----------
>  arch/arm64/kernel/efi.c      | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 10 deletions(-)

Thanks. This addresses the comment I made last time around:

Acked-by: Will Deacon <will@kernel.org>

Will

