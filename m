Return-Path: <linux-efi+bounces-5383-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15875C3F3A1
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 10:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B903B28FE
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AC302168;
	Fri,  7 Nov 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kDSvD9yt"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6B302141;
	Fri,  7 Nov 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508435; cv=none; b=pmOZhluTJ1/QeMqfhb75gJk6MW/begGvOvAUQQemQnbxpMtlYB+pBXxxIC22BlCNCelVbk5Nso54dXF9t30WG3hcIds92kP4XWXrbQo9ufbDHxM0gmQDt+uSRTH8QQSKZwfU8Vfo8aJIQjqTvVrTfnQxZCdNMswqMTgM4OrhRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508435; c=relaxed/simple;
	bh=rkNsN1a15cMQntK6NCx8UySyfutqiHHs4xarBW6fZWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXntYgsiSNf1eAGQnZf434j1sLBILJVQJVTeYZscnxN+b1++lD9kB0eFUncKkDfdDHUOqJnYpyDRMpzx1ehswnaBptj+ehbxJOfxeOnw9rjZN4VN2ZnTJTj3tX4PA/WO5t/cbF3dztkCmu+n8ibs+sFRCcLVRek8b696kbSFjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kDSvD9yt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V8d+yn4AO1UFFoQVocsh7D1YuIdpfDSz/w0xD9bCqtQ=; b=kDSvD9ytkKqFCjZo/bcZqXBqtR
	Foq7ldUIJJ5anVlRyrA3/aAAiDZoUbtdNkT5blORuzXkRy+tdqiSI0Y1IwbRkeiTnKUby7DYME6lx
	F9eEOLBkb/fPkef7D5+dRlrn4pVp3BleZ6vxMvnX1pS8vIWdckwjp/BVIugyQvv55MUIxlz/Nw16V
	8LJU1yOwJV3Mx4EkiggrWvDj+1iECu1DKqL8Gjqm+rBgJjAg6DqYnzIvz5PFzcxRgXymdGR2uXmOy
	1AeGeuzCJHHzLKVEcq3hgAMtxHGqc4FCQZ26fnczzKsOackua1Jb8TtwLY0evDVZMYrNxLaIpnR5g
	dQUE2LEg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHI5K-000000064zc-1P3A;
	Fri, 07 Nov 2025 08:44:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C04773001D4; Fri, 07 Nov 2025 10:40:08 +0100 (CET)
Date: Fri, 7 Nov 2025 10:40:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
Message-ID: <20251107094008.GA1618871@noisy.programming.kicks-ass.net>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
 <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
 <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com>
 <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>
 <20251107090406.GU3245006@noisy.programming.kicks-ass.net>
 <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>

On Fri, Nov 07, 2025 at 10:22:30AM +0100, Ard Biesheuvel wrote:

> > But that's just the thing EFI is *NOT* trusted! We're basically
> > disabling all security features (not listed above are CET and CFI) to
> > run this random garbage we have no control over.
> >
> > How about we just flat out refuse EFI runtime services? What are they
> > actually needed for? Why are we bending over backwards and subverting
> > our security for this stuff?
> 
> On x86, it is mostly the EFI variable services that user space has
> come to rely on, not only for setting the boot path (which typically
> happens only once at installation time, when the path to GRUB is set
> as the first boot option). Unfortunately, the systemd folks have taken
> a liking to this feature too, and have started storing things in
> there.

*groan*, so booting with noefi (I just went and found that option) will
cause a modern Linux system to fail booting?

> There is also PRM, which is much worse, as it permits devices in the
> ACPI namespace to call firmware routines that are mapped privileged in
> the OS address space in the same way. I objected to this at the time,
> and asked for a facility where we could at least mark such code as
> unprivileged (and run it as such) but this was ignored, as Intel and
> MS had already sealed the deal and put this into production. This is
> much worse than typical EFI routines, as the PRM code is ODM/OEM code
> rather than something that comes from the upstream EFI implementation.
> It is basically a dumping ground for code that used to run in SMM
> because it was too ugly to run anywhere else. </rant>

What the actual fuck!! And we support this garbage? Without
pr_err(FW_BUG ) notification?

How can one find such devices? I need to check my machine.

> It would be nice if we could
> 
> a) Get rid of SetVirtualAddressMap(), which is another insane hack
> that should never have been supported on 64-bit systems. On arm64, we
> no longer call it unless there is a specific need for it (some Ampere
> Altra systems with buggy firmware will crash otherwise). On x86,
> though, it might be tricky because there so much buggy firmware.
> Perhaps we should phase it out by checking for the UEFI version, so
> that future systems will avoid it. This would mean, however, that EFI
> code remains in the low user address space, which may not be what you
> want (unless we do c) perhaps?)
> 
> b) Run EFI runtime calls in a sandbox VM - there was a PoC implemented
> for arm64 a couple of years ago, but it was very intrusive and the ARM
> intern in question went on to do more satisyfing work.
> 
> c) Unmap the kernel KPTI style while the runtime calls are in
> progress? This should be rather straight-forward, although it might
> not help a lot as the code in question still runs privileged.

At the very least I think we should start printing scary messages about
disabling security to run untrusted code. This is all quite insane :/

