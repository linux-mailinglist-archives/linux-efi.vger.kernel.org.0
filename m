Return-Path: <linux-efi+bounces-3748-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DEDABA03B
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875363B57B4
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096C1A256B;
	Fri, 16 May 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li3qHaSS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047065661;
	Fri, 16 May 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410419; cv=none; b=oOYcvl/2LmJ3cedk/JDJYIK0ZaVMDOJVlje652ZDU34pmDbJ3od+kh+Yg87YIGlNBS7/weh2Wt6z3X3bOUsHY3A6T8ROx6VsaIsjMhTzDUdvsfq50ILoL8Jv9YyiXgF7msKFu2iv8Xk0wldyoVXbgUylkyA10k5WQ7pvhK7reqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410419; c=relaxed/simple;
	bh=mUg2KCJM3nZNLfgyNFElxT8URgyqRgXL21LFChPENMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSNlI3cX8SaU5IIJebR3Ly2TjJR1bpZEjUX9yBGb/soN4pWQ5hD2niox46Qg8HXIGiSzTDlxlYrqD4BV2S1kGnT+L99Q3Tdnvd+8i0Hm9dR6b4Lr1v6dmd8/akc2K2fyoUp0+AezWXVjsVWjAt6VZv6zy05EdKNA7J838QUKZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li3qHaSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0B6C4CEE4;
	Fri, 16 May 2025 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747410418;
	bh=mUg2KCJM3nZNLfgyNFElxT8URgyqRgXL21LFChPENMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Li3qHaSS9TkT6mLcLhYB4VIBNnt5ObMy+G1liN+Z4gP4Um6ezhoLyAkbM7NmhXDuE
	 9sg+oqlMSzZsRHs55D8CJy/r4o7z6OIaBvbdCcqUJ8qQ34ywTMJZiFD6+MftlFCl6E
	 y/vfvpe+iJshxbogh5k5OOyss2nRXIBmZxwy/QbnFaJyMe13nvmGWoa8NKwKJs4rxs
	 I0MdFbc3/aYparPnNkgh7VN+MENRkCV46inZ9awjeaSCR6Xn8BI2fea7uhusvq/fIa
	 nvO9+zMlKfPg5feoQCTowKyz72zrTfGTaQvRO8LfVG6sYROEeGE+Q16uKGOKC29CxE
	 3yUjgXprxS7rw==
Date: Fri, 16 May 2025 17:46:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
Message-ID: <aCdd60hwRbx207bU@gmail.com>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <20250516153009.GEaCdaAdhCVpjaViSx@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516153009.GEaCdaAdhCVpjaViSx@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, May 16, 2025 at 12:15:33PM +0300, Kirill A. Shutemov wrote:
> > @@ -173,10 +173,10 @@ For example, when an old kernel is running on new hardware.
> >  The kernel disabled support for it at compile-time
> >  --------------------------------------------------
> >  
> > -For example, if 5-level-paging is not enabled when building (i.e.,
> > -CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
> > +For example, if Linear Address Masking (LAM) is not enabled when building (i.e.,
> > +CONFIG_ADDRESS_MASKING is not selected) the flag "lam" will not show up.
> >  Even though the feature will still be detected via CPUID, the kernel disables
> > -it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
> > +it by clearing via setup_clear_cpu_cap(X86_FEATURE_LAM).
> 
> LOL, good one.
> 
> The rest looks nice and good to me. And FWIW, it boots fine on my Zen5 with
> 5lvl enabled.
> 
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

What's your preference on timing? v6.17 or v6.16?

Thanks,

	Ingo

