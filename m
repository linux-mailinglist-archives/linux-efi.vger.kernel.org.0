Return-Path: <linux-efi+bounces-5387-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B07CAC3F6D7
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 11:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85E4A4EDAB4
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03594305960;
	Fri,  7 Nov 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QSVC1dyB"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4E305940;
	Fri,  7 Nov 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511283; cv=none; b=LWXYqd3pZNb6209vYwwi5V8f/Q0uoy6a7ZTzS5ozP2KplHjIQ0w84J0fpVL8WsgPTIQbmtzQcHrBA5iDBGrpEJQC42yDoCYJGr5qhBk7Z/rEJ1S/6Y3n6xKIVTMoBS6H1hGARZJFWvushtJkZoY4Shuy9Fv+XSBUPytsNmrQ8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511283; c=relaxed/simple;
	bh=ao1huc81LhbI7M7V+Lmw7sAVNImuD4foYke1+Hng3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awgVKZCC0GrCeHtPgqFdHPmSP//up9FGX//4cq8VqnJnE3yVHf/Z0P/R9Fnu1w6nTenY7teiUssvPTSnF3asWLC2JbUKRIxbjEqPl6wTUcLcWfFhr8F4tlDr1cm38vl+3SxLT7luKys5VL9Zel6JSg2jKeb4+nUuidD8d8JcwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QSVC1dyB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rUEiTpU7HDDR8xMFqOe2EDvAunYxBiPHehj76UNcJvY=; b=QSVC1dyBVq9iOjDUlh61G8KGft
	apfvjGnw3TRhtW3UGKL1sovVkDGWzQpQIn/liVJrV82JFl9AwrM673VsvTrWDEpeOXvMdulJsnaOZ
	zABWuolDlh+YxMKGXuOeXPM4UnjK2Ie2JLs902MAPKOVY15MCYjgM54HecdEinsD8R7UMM4CiPUSh
	AHGQHmBsP2ItnH8zopdbipVsoI0sHOyBWXTAaiiQVzEkU2aOS+YLXtd8lOG0y/SWpShji3riP9Z8M
	NNAaIZ2nfbc/O2OFGIT3QtTEpe+FrxsN98ckdXs0Lyr8OqOS0fiLQ4LsF/G1BZf9c99u34MYBuakw
	w3jhpeTA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHIpN-00000006AtS-2BCf;
	Fri, 07 Nov 2025 09:32:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3E2993001D4; Fri, 07 Nov 2025 11:27:45 +0100 (CET)
Date: Fri, 7 Nov 2025 11:27:45 +0100
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
Message-ID: <20251107102745.GC1618871@noisy.programming.kicks-ass.net>
References: <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
 <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
 <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com>
 <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>
 <20251107090406.GU3245006@noisy.programming.kicks-ass.net>
 <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>
 <20251107094008.GA1618871@noisy.programming.kicks-ass.net>
 <CAMj1kXFWCwEENyS=JM5mAON6ebfTwwJh-mRDYCY5NA+5UGzZJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFWCwEENyS=JM5mAON6ebfTwwJh-mRDYCY5NA+5UGzZJg@mail.gmail.com>

On Fri, Nov 07, 2025 at 11:09:44AM +0100, Ard Biesheuvel wrote:

> As long as you install with EFI enabled, the impact of efi=noruntime
> should be limited, given that x86 does not rely on EFI runtime
> services for the RTC or for reboot/poweroff. But you will lose access
> to the EFI variable store. (Not sure what 'noefi' does in comparison,
> but keeping EFI enabled at boot time for things like secure/measured
> boot and storage encryption will probably result in a net positive
> impact on security/hardening as long as you avoid calling into the
> firmware after boot)

I would say it should all stay before we start userspace, because that's
where our trust boundary is. We definitely do not trust userspace.

Also, if they all think this is 'important' why not provide native
drivers for this service?

> > At the very least I think we should start printing scary messages about
> > disabling security to run untrusted code. This is all quite insane :/
> 
> I agree in principle. However, calling it 'untrusted' is a bit
> misleading here, given that you already rely on the same body of code
> to boot your computer to begin with. 

That PRM stuff really doesn't sound like its needed to boot. And it
sounds like it really should be part of the normal Linux driver, but
isn't for $corp reasons or something.

> I.e., if you suspect that the
> code in question is conspiring against you, not calling it at runtime
> to manipulate EFI variables is not going to help with that.

Well, the problem is the disabling of all the hardware and software
security measures to run this crap. This makes it a prime target to take
over stuff. Also, while EFI code might be good enough to boot the
machine, using it at runtime is a whole different league of security.

What if they have a 'bug' in the variable name parser and a variable
named "NSAWantsAccess" gets you a buffer overflow and random code
execution.

Trusting it to boot the machine and trusting it to be safe for general
runtime are two very different things.

> Question is though whether on x86, sandboxing is feasible: can VMs
> call into SMM? Because that is where 95% of the EFI variable services
> logic resides - the code running directly under the OS does very
> little other than marshalling the arguments and passing them on.

I just read in that PRM document that they *REALLY* want to get away
from SMM because it freezes all CPUs in the system for the duration of
the SMI. So this variable crud being in SMM would be inconsistent.

Anyway, I'm all for very aggressive runtime warnings and pushing vendors
that object to provide native drivers. I don't believe there is any real
technical reason for any of this.

