Return-Path: <linux-efi+bounces-3336-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C19A89570
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 09:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8164189904A
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF227A135;
	Tue, 15 Apr 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="al98KKN1"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58EA48;
	Tue, 15 Apr 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703079; cv=none; b=be2JvUN1eRO/CApE4cfQa6o1yajLlZouLNA380uYQNh+CELiSwBWUPLat9sCG711I1szPq5n9ZpccXQWGHV/z956o8glzpOQg2Qj/Yz15nih6RoITtwrOE6SRFdXTEod00XPCSpGM+CY9VsrJD+KtRHlwuhYYJV5id+3+SZJjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703079; c=relaxed/simple;
	bh=XQ+wSzbBzV1R2+z1+etTemlYiACEzkYHtN75V2w3GOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtsid/h02mXdNK5+eYgNyS0Q/evO90URM2SiG1lnZ2PxFLx7e/LDQl8gpBaradcv5ffGCAZgXhyjQ+bPb+G0Bqb7G+swniQqK95UX2ILtoGq+whw//m4PpwFbZwPzr+HIb++eQNauFo/k6KPTvsWg4oXiyeA+UpNb/C62AeATnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=al98KKN1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LG6Ch7+K8r0h5qLUo1lCgwElhe9Hhjrd5BJuDVcLf8Y=; b=al98KKN1dlJhUN70DpyIOuHAA9
	NU8CqWAuT/kR4j/1JMvvQmNbpLcKBUSzti6lJZhm+pKMQ9mxf95rP5Q7wcXgkJNvaszQ0s4sa0l+O
	bUOovl77RQBp2cNaN7e/TU4Rc1e90zxuEneGW5Sk0i3NjbjPahtvWSzFVl4A6n48cIe5B62XMURiX
	HNPyHmuIHlEDYsv/VARRwRFCXGlRgqpO8tRpuc5tUD68y7gKIrnp5AoT62Tvv12uUV0xid7DcWAaN
	zADqhZTgF+OnxBKndnpeSfIN7nkrEykEPAKSKcN6lf0jKJcsKf4h22JtY0g6539jQyV2YoCoVklyn
	0SwhlfoA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4axy-00000009pdl-2Gjx;
	Tue, 15 Apr 2025 07:44:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9F4F0300619; Tue, 15 Apr 2025 09:44:21 +0200 (CEST)
Date: Tue, 15 Apr 2025 09:44:21 +0200
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
Message-ID: <20250415074421.GI5600@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>

On Mon, Apr 14, 2025 at 03:36:50PM -0700, Josh Poimboeuf wrote:
> On Mon, Apr 14, 2025 at 01:11:43PM +0200, Peter Zijlstra wrote:
> > Since there is only a single fastop() function, convert the FASTOP
> > stuff from CALL_NOSPEC+RET to JMP_NOSPEC+JMP, avoiding the return
> > thunks and all that jazz.
> > 
> > Specifically FASTOPs rely on the return thunk to preserve EFLAGS,
> > which not all of them can trivially do (call depth tracing suffers
> > here).
> > 
> > Objtool strenuously complains about things, therefore fix up the
> > various problems:
> > 
> >  - indirect call without a .rodata, fails to determine JUMP_TABLE,
> >    add an annotation for this.
> >  - fastop functions fall through, create an exception for this case
> >  - unreachable instruction after fastop_return, save/restore
> 
> I think this breaks unwinding.  Each of the individual fastops inherits
> fastop()'s stack but the ORC doesn't reflect that.

I'm not sure I understand. There is only the one location, and we
simply save/restore the state around the one 'call'.

