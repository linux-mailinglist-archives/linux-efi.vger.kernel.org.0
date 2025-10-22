Return-Path: <linux-efi+bounces-5084-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A4BFB646
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 12:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3444F507D75
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6B28C840;
	Wed, 22 Oct 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Epi7j6zd"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E326CE2D;
	Wed, 22 Oct 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128605; cv=none; b=LvGRTbyVamuADMuzD/645HsPmZGKn6A7QkB1DSk5p2F+zOFHo9PIzOvMbLrEoifwLSseXqCNBxVAndm3ljuHnZaKGlyF6Oo2Dgtv701uOFBrhg2DkVdOPeql5mVtNidPZT3obr5hydfC7EypMPKQbtlH+uMqlkb9DqaipHtWphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128605; c=relaxed/simple;
	bh=AfH0HOp6dIRA6LJbVwBgTMvik8DPOlQ3HjTpgrwJ9/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0FEsnHMAhjxRWlQfQ3vd59rgPcHjI8Ygs5e0WxglSA4EZCVKheOw1V6ugPE17aKvSDujLEtceXYohHOg3B9tLGUOtxiTkV0CLj9bEUAog4JBVaoEIYJe9lnpnUh2pFS6YYh9ExIYPoH48jKW9HtOSBXUG7kzsVOOkekNJS65mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Epi7j6zd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=etZw5gn8CVF/PJZZ4oulMIW858XJRdicPsa/oqCkWQI=; b=Epi7j6zdJk8KGMZHyT9bkaxOI4
	EOkbySSC9iaf4a4NyCEn3I2+GiQAwbaNQPUj32RdKYHw1dPZEKj8iaPw544CNzldd6qlDiQ1Fj9kq
	rpBvw2c9yfg6xRTu3uLbHDvrV7Xcf609lMo9OgErB+auUwZBMEG/uen9uPYWhSmZfq+22G4aekcC3
	zOjF49qN1B8bOHOnHweXNeTGkQmu3Bm0HplSSYuEjVhDC0tZXSfxniUhT9aZvldEJIds3NlQQf/W+
	ox9GBg5Tia4hnroj28WsMObDGTzUIo08IoV300jL/A+ijZocARd77OaHPCOwfzRbKrOHDiiW5I5Ed
	vvYm0haA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBV7u-00000000SY9-3I9H;
	Wed, 22 Oct 2025 09:27:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4AF730039F; Wed, 22 Oct 2025 12:22:53 +0200 (CEST)
Date: Wed, 22 Oct 2025 12:22:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20251022102253.GW3419281@noisy.programming.kicks-ass.net>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
 <20251022082541.GL4067720@noisy.programming.kicks-ass.net>
 <20251022094019.GAaPimg3VCgRu6eELd@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022094019.GAaPimg3VCgRu6eELd@fat_crate.local>

On Wed, Oct 22, 2025 at 11:40:19AM +0200, Borislav Petkov wrote:

> > But that's not the same, stac() and clac() are FEATURE_SMAP, these are
> > FEATURE_LASS.
> 
> So?

That's confusing. Just keep them separate alternatives.

> Are you thinking of toggling features and then something else getting disabled
> in the process?

I'm thinking that machines without LASS don't need the clac/stac in
these places. And when reading the asm, the FEATURE_LASS is a clue.


