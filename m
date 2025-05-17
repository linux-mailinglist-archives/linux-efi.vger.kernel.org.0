Return-Path: <linux-efi+bounces-3751-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C1ABA8F0
	for <lists+linux-efi@lfdr.de>; Sat, 17 May 2025 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44643A0067C
	for <lists+linux-efi@lfdr.de>; Sat, 17 May 2025 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C51DE2BF;
	Sat, 17 May 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCqIQM+a"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A885C5E;
	Sat, 17 May 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747471496; cv=none; b=Z6+2HfbjLpN6A6SabpYKmU089skYSw2p9cdoRqjXdpTO1j6Xsfc2MB9b8Ew8h1iVQsYhqjRB+Z2gjK1Gghq2jbpX9dOAJRq8W7zfcB/KctXeGF6P0Aox6niX5hjPpJkT3FMpyNp2xWKiQTp5TQvzRmtzwoE0LDjwg4fczsbQKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747471496; c=relaxed/simple;
	bh=j0LTn1lN+WcSRX3JpuiuLhB0VN18irvMtE1JbmGibaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxBdFeqfTzrKzmsEEI1I6MAbC+tCVERQtVUMWxJZs1mejuvgKpoAsYNl3RnPU5pSx3gXJF29DpwZVBBGxyKXLVFwzX6ZjoXJmihJANzmNlem0BlPRip8QOD74WylYQkp68N/22xwtEvAx9CBnn0gWWPfhE0vkD4HJqI3EnXs6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCqIQM+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFACC4CEE3;
	Sat, 17 May 2025 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747471495;
	bh=j0LTn1lN+WcSRX3JpuiuLhB0VN18irvMtE1JbmGibaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCqIQM+awYF3higFIfsJGgfizWdYEJdayAkA+d2TShUU0oMsxxZRgrHH0g1eDbHBQ
	 ERsS+e2UX6tqWy0p3lR6z23HSpgvepSSEKxs+BAyuSZ0AtHjIhwmh+YyKuMIjdvc/d
	 uX7+aXjk9b/uVYfMIAUZgZp1brr+mVwTZemVp7+1xt0kPHvSa6jyL0XAvdwaC16E7+
	 OM+LlO8k3cSSmJM9gytA2HC0+1/wxYMnpc60pVzN2h6HgEtqzHhXSyPvEJX1ivhkF9
	 N7MlamtfHWzPiuXGImzRIMv8pDm6eNmclio7fP+lf/FcV9oXm+N4dFv7lpGHSdDXnd
	 edUPPspMWxvPg==
Date: Sat, 17 May 2025 10:44:47 +0200
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
Message-ID: <aChMf-wxUeE0oI1Y@gmail.com>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <20250516153009.GEaCdaAdhCVpjaViSx@fat_crate.local>
 <aCdd60hwRbx207bU@gmail.com>
 <20250516155649.GFaCdgQa7sX75vOLSm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516155649.GFaCdgQa7sX75vOLSm@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, May 16, 2025 at 05:46:51PM +0200, Ingo Molnar wrote:
> > 
> > * Borislav Petkov <bp@alien8.de> wrote:
> > 
> > > On Fri, May 16, 2025 at 12:15:33PM +0300, Kirill A. Shutemov wrote:
> > > > @@ -173,10 +173,10 @@ For example, when an old kernel is running on new hardware.
> > > >  The kernel disabled support for it at compile-time
> > > >  --------------------------------------------------
> > > >  
> > > > -For example, if 5-level-paging is not enabled when building (i.e.,
> > > > -CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
> > > > +For example, if Linear Address Masking (LAM) is not enabled when building (i.e.,
> > > > +CONFIG_ADDRESS_MASKING is not selected) the flag "lam" will not show up.
> > > >  Even though the feature will still be detected via CPUID, the kernel disables
> > > > -it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
> > > > +it by clearing via setup_clear_cpu_cap(X86_FEATURE_LAM).
> > > 
> > > LOL, good one.
> > > 
> > > The rest looks nice and good to me. And FWIW, it boots fine on my Zen5 with
> > > 5lvl enabled.
> > > 
> > > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> Bah, and I thought I'm replying to v3. :-\
> 
> Anyway...
> 
> > What's your preference on timing? v6.17 or v6.16?
> 
> Right, here's what I'm thinking:
> 
> * Kirill's patches would simplify Ard's cleanup a bit

Yeah.

> * The 4th one: Kirill A. Shutemov ( :  85|) ├─>[PATCHv3 4/4] x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only
> 
> looks ok too.

Yeah, and now has an Ack from Jürgen too.

> So, I don't see anything speaking against queueing them *now* for the 
> upcoming merge window, I am testing the tip lineup on a daily basis 
> this and next week and if it all looks good, we could probably send 
> them.

Cool!

> If not, we delay.
> 
> And if there's other issues which get detected later, during the 
> 6.16-rc phase, we revert.
> 
> So we have an exit route from each scenario.
> 
> So I guess let's...
> 
> Unless I'm missing an aspect.

I think that's a good plan. I've queued up Kirill's latest in 
tip:x86/core, with tags updated, and it boots fine on my
testsystems as well. Knock on wood. :)

Thanks,

	Ingo

