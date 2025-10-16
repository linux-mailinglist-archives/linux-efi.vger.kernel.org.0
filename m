Return-Path: <linux-efi+bounces-5064-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA85BE446B
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FC874E8F68
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24290339B5C;
	Thu, 16 Oct 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PlQkXKBJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5927E066;
	Thu, 16 Oct 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628966; cv=none; b=PA/LFCJUuqlsg4PlRpGaZcF8VEep1bOCeBdpSYJrHW3ibmI83X2jEcHAoeCPsojdJ2JmcsNH+j3Dqad2Ta355hYeKNkIz6kW2whh6a5L/uTMbVDXFaC5YKRaoB7ktz/TBUN4rqyAldIVh59CyNWZUSvKeSqVPNhlZRB+T7cI2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628966; c=relaxed/simple;
	bh=XZxC3Z7Brl2vKlEpL+VR3iYPXHyRePQJxpgSpCsm/Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ7xMYIehSgQImc6lv8EcPl3akCibCj7A+jGmyj9BwxCqSgVng9cF4jcC6ZGRfoOgOuRaFg/ffy9wKDOIDVEXaGBhjMwKjCQK47ZhY3HsUK2sLV6huhP4MXTmwM/GfBMMRatJpvqIqyPSJm7I3Gr3AaT2TAIGpmFEsJ5yqUtbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PlQkXKBJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AAB2B40E015B;
	Thu, 16 Oct 2025 15:35:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 63E0fiiBV7Sf; Thu, 16 Oct 2025 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760628948; bh=zjmrhIJBJoSPs1NvxJc+Q+GQcsPJIJZQEyPo+J6+Xpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlQkXKBJj7ZLIERAyD1oEOZFHmn1CsVj6+nlGx48xCSVZvSbFGSTOgTth098UxoUe
	 LAYrg56uDuYZocKzECUOg+j/Cp17o6fFRPtqtHncsQOTONFRfs39blPuoCnFpkWJzs
	 fk7pivKHHbJQ/WHPUxSk1ByMJlwJ7Ez1nypGW66G0cO70UiasLKCaoy4tYURLu9r7h
	 iz+Ax3tq4ga0X5sVuvwFEioTaaWWYQHRl9zsddrtCQZ5FP3yToYr3sX4x1bigiLvrX
	 4CtdQdYMQmr5AOolLPn5inmGg14hvKHgwhj+l3tYXLyIE4Ml9lKMbWF8++1lhixgMc
	 9o/EVuT1wz/CzAx1XT4tNXvzfAPEZCmcut69dfc1KxBibTseCcxtiDelvmo80fmHvB
	 UgSQir/REVvsm4HGcOCCk0MJ4CDlrPk7/xJ2KHDTluekNBnFAN73qQ7vQD/7/kbqNN
	 RD/3tXqOHvmoTpruAOTwEWGDQGikA8CzBHinZohmpiMfNLpu8CHDfp8jYJA2j02WeU
	 lJap/ceYWtN/haPsGdCZ8wzF992Ma3KqQjmPbFBanfTeGYKtZGj1s82s9hjPXF7uzw
	 g/BtnQqL4XhEBnDotIBKlvaHsWXvP856zK36kVnY2sk9qnhMEZwgliyyyOvEv0vnaG
	 F1EqIqhfX6jhqIhhnkZq/+VE=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D86AB40E00DE;
	Thu, 16 Oct 2025 15:35:20 +0000 (UTC)
Date: Thu, 16 Oct 2025 17:35:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Message-ID: <20251016153514.GDaPEQsj9eNwWfmtLf@fat_crate.local>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007065119.148605-2-sohil.mehta@intel.com>

On Mon, Oct 06, 2025 at 11:51:05PM -0700, Sohil Mehta wrote:
> Link: https://download.vusec.net/papers/slam_sp24.pdf [1]

Just give the full paper name and people can search for it. Links tend to get
stale over time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

