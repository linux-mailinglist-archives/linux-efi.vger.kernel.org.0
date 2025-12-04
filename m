Return-Path: <linux-efi+bounces-5799-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E631CA50E9
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 20:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2159C3024866
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 19:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320B2F5492;
	Thu,  4 Dec 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwrriLnL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530772D8796
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875049; cv=none; b=kBGias+V1azVOx7kwdYrIHe9wBSGr6WDdlWSbnvbFlagk39z3osWjAdRGHWjwPTzcAACz1THZU7Lwbp8l1/IBi8MsQGb3L6njBxqzIfI4IW/CCvG5tJcCwk/TNEMYfKXpv36Zd/D3J8JD6/G3Q57uL1eW+Su2FqVgpwnagFK0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875049; c=relaxed/simple;
	bh=f5uHtGLwMguFLVGoXkjP5AUbZYSbqcYQFAFX3CvXVZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6lArkw8W2dFqwm9wW5DIrWLjRbrD1MmiuliK2v06huBtp/2IeSo9TLVJqCtgl0DUkwj0RtB/gczcjYVdI04qeQ5F9v/WiPNjXvukLqZKYw41AjMf9kGIjJf4u/slkYxF7WAt21qGDEBq+bziXgHDR5DOf/SFFfoalHcPmVek+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwrriLnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5E0C116D0
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875046;
	bh=f5uHtGLwMguFLVGoXkjP5AUbZYSbqcYQFAFX3CvXVZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MwrriLnLS/PMd5cj5PNQc6bNv6zdURu0ud8W6zH2riHearH3X405giZUG4D19Fm0K
	 u4ENWe1GMcb4gBaqd8vZFMzNuY3NQ6jjg8VhcD8et3h3F6kqv6uBX2K5Eycr6b3QYK
	 Nd/a7tAmBo5kxtmRgVy6nfu1eY5KJFkpn+ddefhdLEVE7CJRaZD13Bz18qU3iUb7kY
	 DPQ6wq1aw0B+2h9qMkCfv3JqZTum2kAeiCdV5P5Ezjkqc+V5ctxAaGlg8khO6J95sZ
	 qeqVUeZB8lcmhUX810nTdrz5Eygl54ClfXeGzU+NiXJAEt8WTHYqxKzxObEUWF/olA
	 fEdeas0ePhzUA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5959105629bso1322237e87.2
        for <linux-efi@vger.kernel.org>; Thu, 04 Dec 2025 11:04:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZRhhO3E3vnAy9H5OCJceo86XEWRtfCu039nsmvZuz0QZMKW7uaqJik5Ab465eJ6qckQ40hvh5TQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vdH3sjWUBGZcXPM6DKWDGHd0F79LNnuCejntAx9dP33kwz1U
	wHZP3Pua5At7i3i4LSYVnASt8KwUvkDVooipM7l+KHS4bttM/tleavWP/hWpwOR6v+wSRYPlXlj
	JBzLGpHCJIDZmeFoO0D0NPovxF2h3Nco=
X-Google-Smtp-Source: AGHT+IFEYD1bqJMFdg7oj7MR7E+gbB4Dbf/aEg8W8M4rh/jTprgRFfT6rPpglZwbJmD6Zmj1eFhpE1XWgDAa7O+cHXw=
X-Received: by 2002:a05:6512:b2a:b0:595:8062:138 with SMTP id
 2adb3069b0e04-597d66bcae1mr1442384e87.25.1764875044606; Thu, 04 Dec 2025
 11:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
 <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com> <5fb937b4-5459-4894-a107-945bfb50a701@intel.com>
In-Reply-To: <5fb937b4-5459-4894-a107-945bfb50a701@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Dec 2025 20:03:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
X-Gm-Features: AWmQ_bkc6G_eQpzXHDq9bevdJNU8kfDKPTGWNIj9U_97gYLqo7lW7A8NLEDHKtU
Message-ID: <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86: Extend LASS support to EFI configurations
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Dec 2025 at 18:34, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> On 12/4/2025 4:47 AM, Ard Biesheuvel wrote:
> > Hello Sohil,
> >
>
> Hello Ard - Thank you for looking at the patches.
>
>
> >>
> >>   2) Boot services code and data are referenced long after
> >>   ExitBootServices(). For example, efi_check_for_embedded_firmwares()
> >>   accesses boot services memory even after SetVirtualAddressMap().
> >>
> >
> > These accesses use the kernel direct map, so I don't think they come
> > into play here.
> >
>
> I don't mean SVAM should have switched these addresses to virtual ones
> but doesn't all of EFI_BOOT_SERVICES_{CODE|DATA} have address[63] = 0?
>

Whether a mapping has bit 63 set or cleared depends on the location of
the mapping in the virtual address space, not on the location of the
physical backing of that mapping.

efi_check_for_embedded_firmwares() maps EFI_BOOT_SERVICES_DATA regions
in the kernel region, so bit 63 will be set.

> LASS wouldn't care whether there is an actual mapping behind the
> address. It only relies on the MSB for enforcement. So, any code that
> relied on accessing boot services memory before efi_free_boot_services()
> could get affected by LASS.
>

This only applies to code that accesses boot services memory via a
mapping in the lower range.

> >>   3) Some runtime services fail to switch to virtual mode properly and
> >>   continue referencing physical addresses [3]. The kernel maintains a
> >>   1:1 mapping of all runtime services code and data regions to avoid
> >>   breaking such firmware.
> >>
> >
> > In [3], I mainly elaborated on why it is still necessary to call
> > SetVirtualAddressMap(), and why it needs to be called with a mapping
> > in the upper address range.
> >
> > For this particular call, there is no choice but to disarm LASS, given
> > that the lower mapping is still active at this point.
> >
> > However, that does not imply that we have to assume that systems that
> > support LASS (which are fairly recent AIUI) are buggy in the same way,
> > i.e., that they access addresses in the 1:1 region after
> > SetVirtualAddressMap() completes.
>
> I assumed that it must be widespread because the kernel maintains the
> 1:1 mapping unconditionally without any Family-model checks. The code
> isn't explicitly warning about such implementations, either.
>

Exactly, and this is an oversight that occured 10+ years ago. No
reason to keep carrying that forward forever.

> >
> > In fact, we might attempt to use the availability of LASS as a
> > preliminary cutoff point for disabling this hack entirely, and only
> > backpedal if we get actual reports where this is still a problem.
>
> Sure, I am onboard with this approach, but some folks seemed skeptical
> about it during the base LASS series review. My only concern is breaking
> user systems when they update to a LASS-enabled kernel.
>
> x86 maintainers, any preference?
>
> Would it be useful to put this (patch 2) behind an "efi=disable_lass"
> command line option? That way, if someone runs into it, there is at
> least a fallback option they can rely on. By default, we would still
> expect newer firmware to not need this hack.
>

efi=noruntime is already available, which may be sufficient to work
around this in individual cases, to regain access to a non-booting
system.

