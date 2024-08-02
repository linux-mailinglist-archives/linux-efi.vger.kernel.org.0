Return-Path: <linux-efi+bounces-1528-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4046945D66
	for <lists+linux-efi@lfdr.de>; Fri,  2 Aug 2024 13:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676481F21FA2
	for <lists+linux-efi@lfdr.de>; Fri,  2 Aug 2024 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CF1E3CB1;
	Fri,  2 Aug 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mREUOL5U"
X-Original-To: linux-efi@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40951DF67E;
	Fri,  2 Aug 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599246; cv=none; b=L9HFLZFkcbQA15PkC+9jTCE2hghptO2vc3bU4agBWVXDvmjTcVhl8veISmfApbDgMvj7HL1JZpN74SUUHV91EW0lxI/H002GnkZa5IZKCT1KH9ZOATKNRHjCVllr0uDhwFegVZpoxBMPNaO+VRvQ2Lo5WzKPe3k1BVzFbbTnuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599246; c=relaxed/simple;
	bh=wUKkUSdw0p6i3Bs8P7gvRXVxcbGTf3ktetocNF5mH70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3OHItZiGZVDhvLrQzniw/LkOOIf2RRqCAOyuA55YP6YEytgg7mgMmO9le8IFQp6Y3OvHvjvI6RWvG7IMB6XDy3Vva/xbrtKPCwmwbEFc/pbn4nFXv9wmjC/EN7Y6vbGnXMmuYDmrd5i7/8nj3tsevOhQ26WR2n4k1VzKPxOaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mREUOL5U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BmhN0+wpI6L4vTvyz8ph0NLVfTqswy6p5ftY8fHzRww=; b=mREUOL5U5K9EpWl79M33tWiLwB
	y6fMilzj4UtNKSPbdPqOteOfejqkylm3Z8gqvkxbzYnzE/2BSqFt25qzcUUEshSiT6yK9zaE1tCn7
	3NHpz4lIIRtGf5CceloVEFg7EFAiRicOPx1SgesFO/ML7xQTxbT3Nxr8UhbQuLM4oG8XitFPAEcnJ
	zjIWP1hBswBr2eLTGIH5NTxBUFuY5t15tuCelJVkhbwVZ2pnSaL2eChhAm44rnnjrqJOClXb3ZOXn
	Q256mNVW4dRpB6fZH+XIDioNSfAY+K6dBLR3OuWiVUfkUy03LCv33+p+OH5webHCY+wrMLg/ysjpM
	gGujWshA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48660)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZqkM-0006d3-21;
	Fri, 02 Aug 2024 12:46:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZqkO-00080n-GF; Fri, 02 Aug 2024 12:47:00 +0100
Date: Fri, 2 Aug 2024 12:47:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ardb@kernel.org, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	kees@kernel.org, masahiroy@kernel.org, palmer@rivosinc.com,
	samitolvanen@google.com, xiao.w.wang@intel.com,
	alexghiti@rivosinc.com, nathan@kernel.org, jan.kiszka@siemens.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
Message-ID: <ZqzHNN27hwms0CB/@shell.armlinux.org.uk>
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
 <b8792d9c-c2a2-6808-f94b-e3b826232f78@huawei.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8792d9c-c2a2-6808-f94b-e3b826232f78@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 22, 2024 at 10:53:10AM +0800, Jinjie Ruan wrote:
> Gentle ping.
> 
> On 2024/6/24 10:36, Jinjie Ruan wrote:
> > Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
> > stackleak common code: on_thread_stack(). It initialize the stack with the
> > poison value before returning from system calls which improves the kernel
> > security. Additionally, this disables the plugin in EFI stub code and
> > decompress code, which are out of scope for the protection.
> > 
> > Before the test on Qemu versatilepb board:
> > 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
> > 	lkdtm: Performing direct entry STACKLEAK_ERASING
> > 	lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)
> > 
> > After:
> > 	# echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
> > 	lkdtm: Performing direct entry STACKLEAK_ERASING
> > 	lkdtm: stackleak stack usage:
> > 	  high offset: 80 bytes
> > 	  current:     280 bytes
> > 	  lowest:      696 bytes
> > 	  tracked:     696 bytes
> > 	  untracked:   192 bytes
> > 	  poisoned:    7220 bytes
> > 	  low offset:  4 bytes
> > 	lkdtm: OK: the rest of the thread stack is properly erased
> > 
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>

Is this a feature that you have a use case for?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

