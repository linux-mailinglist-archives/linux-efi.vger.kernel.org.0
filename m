Return-Path: <linux-efi+bounces-5385-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A4DC3F581
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 11:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 446634ED56D
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC12302153;
	Fri,  7 Nov 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IBrvoXGc"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE882DC33D;
	Fri,  7 Nov 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510226; cv=none; b=POVjR/+y3zhY6KBo3mSgcR3CKmG112wUzLnGKv6hujORQkKiIdHz7AJaJfm88qL50NMGEw5g1WDrDRrpITeIf2vajsKavqKLunohiWftDS3/NNU43cHzuUg5maV/FucOVOKdLxh7KNgtsiDOwCyB8qK1mwHDgbi1W8HJ1bucsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510226; c=relaxed/simple;
	bh=fOgQDtqlVQWIBqxX53OOUmVK1mIb6jmBaOa0euHWYBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8U+TBR5mu1PeT252+/iT9v3jxijF5ITK1tr1izOTU+7Zn4gWj1BKu1eU7zJorGn5LYqK4Oz8NgK0Eu6ah9eF3ONdOBbPRC1q8aTCxiERAm8yOQAHO3pVXxf/yKltiDuVrqtXF2kcOkuNha8wXqeJznlZa1sH1+CzOADEuPnhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IBrvoXGc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PqT8GpjqV7V4Ir3awIVbzA8+VPhRFtrr00TKXqiZ7lA=; b=IBrvoXGcOJHDdCOMIpE8Xp0W6y
	ob3QvgnIrMYOanEwNsFEryZLmJUJCnJaQCT0zV+awTzc/g1ZpVSaAlWcxrrVRwjJjeUQZBfajSO9e
	z+CZlzahTnLXT0gSDFJ1HvRnxneBRvnadqMnXFSnXwVIvkyMahHu3Br5+Me4O5gCT1IAYoa/hOrvU
	P/2VT13RpIMprSKtXQCdToYXGzjpkRphQORm2RQ3k1kJJq7R8p/QS5oTkrVWQcYMW6oiZajktCJjk
	hqBuJX14y91pI2wcl/EdPQUN12fxh8ueOTlF7kam+mi9zkkS9XYWRj5CfSAvmv/0fgW7GlKA8rEX3
	ZYh3kSgA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHJPv-00000006Ygd-3M4o;
	Fri, 07 Nov 2025 10:10:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B737B300325; Fri, 07 Nov 2025 11:10:03 +0100 (CET)
Date: Fri, 7 Nov 2025 11:10:03 +0100
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
Message-ID: <20251107101003.GB1618871@noisy.programming.kicks-ass.net>
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

'https://uefi.org/sites/default/files/resources/Platform Runtime Mechanism - with legal notice.pdf'

Has on page 16, section 3.1:

  8. PRM handlers must not contain any privileged instructions.

So we should be able to actually run this crap in ring3, right?

