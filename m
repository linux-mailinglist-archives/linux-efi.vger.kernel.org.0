Return-Path: <linux-efi+bounces-5530-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6873C64B65
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 15:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D19F4E2C94
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418F23321CF;
	Mon, 17 Nov 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gCKmkY57"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD627C842;
	Mon, 17 Nov 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390964; cv=none; b=R37c0pRPJY/SrwJxVm/pziFijeObSn4+V5M7ezwWpEOL5e5sJ5k1b4Shz2gVijWMXIzH3EcbmApUgUaxLM56RP+FZRUM4KXr1uXzK5gIDDEtgqqkeISkwio7dm4oM2E8UNvMrjP5x1RnKlETyibWDkQFGgERcLGgDWu+MQFzeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390964; c=relaxed/simple;
	bh=S8BvsHeD0AeLcWf06BgwMrTgm+zr8WJUMblfMGsjpto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA0kDgaRptWHU95w+G+iWqZl3OHbAJ/lXRTgrGsxDfT4Tl1LWhCh0MKj5MPDWEw+yZD5d/aiIBgNYMOmBxX7n3EN+C+/b6rfwzjp0M7und1CLBAvOz3ymeS52To4yWtFjtJtY8N5Jc0vNY7JkdaoFVyd4PdvsEnLUHjd1IUlYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gCKmkY57; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3D5740E022E;
	Mon, 17 Nov 2025 14:49:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id knQjdnLUgBcQ; Mon, 17 Nov 2025 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763390953; bh=A21fKw8PZFQqm3LnxJKKQT5CGTMxtIA9C3gw213t52I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCKmkY57w0VpneojWpcBzvl0JPJC+qHcNCG+Gm+vDGV0adIlodnJqA1GR0VDYMMYX
	 hjnENLTrJVPo4RkV12oERD8zRkFXhz47m8bE7lSzlhxVfCCuW5vBhtF1M9teMYuyep
	 SX46pgXugc0ar5hOvZVY3lfY2vEiniNzPZjIqSXsSYJ7eGgVCJTcb/tXh2y7cgIdQy
	 VYtVA7/plGcE3szkH9VJ2T6g6d7cpd+3FyMSvNxbALvLGnLKvum4hTcXSK05rB/D7L
	 d+XYHyhY1L4OmPOmO/IYzTDgSlqelx2fbRx9PYpP8i8VkoBclm7wgqD1qoUdHNsBb0
	 rVYaXana5AwWFvPctjgeuDMqaZJYzBlorZfp3BzHWaXVDBNbLxDrzEBENuYPORM2Qu
	 6ReE613WGhBe7sADiAD2QINoEDlw8TKClQX9KyXb/X3dYPBs3R9v2H0p9nHLREJkhc
	 OGJu/vrTNxiZ5PeXfAikl19YJnuTdXBtoAZtAz7wvDvnmnJgiJYjJ+tt0sN35fdYZl
	 eWLqPVVbBVPishz8jUcxGs6J4JMWBdxKr9SgxAlV6ZNxjpy2SphJkqrKT7Vp1cpcCS
	 hmJ2baEyGYHoLMplBNBgl2jJ1T07qz1HQdAuA1gp5LXpqTSpz1MydRFaYtKdqtiZ5Z
	 cAnx5Agi6zzKRVxt8sXDh0rk=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EB0C740E01CD;
	Mon, 17 Nov 2025 14:48:46 +0000 (UTC)
Date: Mon, 17 Nov 2025 15:48:40 +0100
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
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v12 6/8] x86/traps: Communicate a LASS violation in #GP
 message
Message-ID: <20251117144840.GIaRs1yNEYjdNF0SHu@fat_crate.local>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
 <20251113224204.50391-7-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113224204.50391-7-sohil.mehta@intel.com>

On Thu, Nov 13, 2025 at 02:42:02PM -0800, Sohil Mehta wrote:
> +	/*
> +	 * If LASS is active, a NULL pointer dereference generates a #GP
> +	 * instead of a #PF.
> +	 */

I'm having trouble matching the comment...

> +	if (*addr < PAGE_SIZE)

... to the conditional.

Aaaha:

"With LASS active, any invalid access to user memory (including the first page
frame) would be..."

Why is the first page frame special to justify a special check?

I must be missing something obvious here...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

