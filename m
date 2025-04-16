Return-Path: <linux-efi+bounces-3345-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02631A8B40C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 10:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F4D189ED41
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC05230985;
	Wed, 16 Apr 2025 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IJrOEVPN"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2C21D3F4;
	Wed, 16 Apr 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792755; cv=none; b=lX0akOkX0LuuStL9RGtiY5ySkCN1e7QqB1wlkhIm6fWqRhUNIWtko7rKWxOWbJ+1oM441vmvI7XRZGTBxpmJtrs0fGZ2c6HJjOKnTa+hOr0uruvXcm0wtJp5nOTLG0spY43NLLaj3m3u1lCcU/0cr/94GUzwp6TKNt7O7Cc3cbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792755; c=relaxed/simple;
	bh=Jo7IRF/Ea1yo6H+X+UMDZdtb+HL4j7gjXTkaOwkldUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkjMX/9q8/r2A348+0Fzmawhc6SR+7KQdvNxfKk9sFQHvQWv5IqtDKKJjPWVXTj0IaX1cPn5+4adD4ZE6Rk40Adb5vo5LfSmrRP+e1Kgs69bEW8MP7biZZaPwBDuBi9VvVCbKxFxzJSciwV0kJ3yUhyANAB5RTEMsNHaq8mc3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IJrOEVPN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YETO2W6ulsRrHM98mq1KvuhMY9RNq8oCyk4fATPKFl8=; b=IJrOEVPNua8vzJb+7uWns05tw4
	sztwBjFwY5OyOa7zNXoI1H+oDYIB9a9f5JCHXULahiGfAnaoKB54gZy/9zzs0PSYluelynI1ZvKS8
	bB0gEnYxdxvf9kwn0QPpjDNQFHhMYWw/pmoS45nMVGLsL492nAFFN/stSfevMwhY1RRy/PEQkBJHB
	CoueN4gxQoNr1f1WuOpJToedrovo/lpjq81gP/expg90GCmgl3WB4l8oXHbzJQCMkKIfdJZcDunoo
	jnUQg9SzgNOGwsOrCQUthZINNaAO15BjlO6D6v0yTkqCBeB1ulvI7R8dkkmFLCR59qZ7U4dTBc5DY
	C/qUPgxw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4yIN-00000009vep-1fDc;
	Wed, 16 Apr 2025 08:39:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 89D633003C4; Wed, 16 Apr 2025 10:38:59 +0200 (CEST)
Date: Wed, 16 Apr 2025 10:38:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, pawan.kumar.gupta@linux.intel.com, seanjc@google.com,
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <20250416083859.GH4031@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net>
 <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>

On Tue, Apr 15, 2025 at 07:39:41AM -0700, Josh Poimboeuf wrote:
> On Tue, Apr 15, 2025 at 09:44:21AM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 14, 2025 at 03:36:50PM -0700, Josh Poimboeuf wrote:
> > > On Mon, Apr 14, 2025 at 01:11:43PM +0200, Peter Zijlstra wrote:
> > > > Since there is only a single fastop() function, convert the FASTOP
> > > > stuff from CALL_NOSPEC+RET to JMP_NOSPEC+JMP, avoiding the return
> > > > thunks and all that jazz.
> > > > 
> > > > Specifically FASTOPs rely on the return thunk to preserve EFLAGS,
> > > > which not all of them can trivially do (call depth tracing suffers
> > > > here).
> > > > 
> > > > Objtool strenuously complains about things, therefore fix up the
> > > > various problems:
> > > > 
> > > >  - indirect call without a .rodata, fails to determine JUMP_TABLE,
> > > >    add an annotation for this.
> > > >  - fastop functions fall through, create an exception for this case
> > > >  - unreachable instruction after fastop_return, save/restore
> > > 
> > > I think this breaks unwinding.  Each of the individual fastops inherits
> > > fastop()'s stack but the ORC doesn't reflect that.
> > 
> > I'm not sure I understand. There is only the one location, and we
> > simply save/restore the state around the one 'call'.
> 
> The problem isn't fastop() but rather the tiny functions it "calls".
> Each of those is marked STT_FUNC so it gets its own ORC data saying the
> return address is at RSP+8.
> 
> Changing from CALL_NOSPEC+RET to JMP_NOSPEC+JMP means the return address
> isn't pushed before the branch.  Thus they become part of fastop()
> rather than separate functions.  RSP+8 is only correct if it happens to
> have not pushed anything to the stack before the indirect JMP.

Yeah, I finally got there. I'll go cook up something else.

