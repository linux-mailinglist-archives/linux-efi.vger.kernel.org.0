Return-Path: <linux-efi+bounces-3531-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938FAA7063
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 13:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AD07A6766
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22973241697;
	Fri,  2 May 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kG8HmKNj"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1D23FC5A;
	Fri,  2 May 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746184112; cv=none; b=e84RDTQKtOF7twRaQ6EasoYS3KSNtPWz8stPNXGi+MSOgD4uWWFvWw470PY0x1BamqEOirquPm2lfzCnSjp6cdLQNyPQYBAaKv4woPYrsqcj3lEUC5l7vfJ+V1E7PoCz3r4sqnuo0hzLusOplScHCtuXIdBjSdt7Ne5sxZiTZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746184112; c=relaxed/simple;
	bh=MTlzj5d2urKFEAV7iZYPY4R3fhJhN8yR0DXLHI6gP50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKdlvMW2JoydPvzq6yQHnYydcCsNcX9L0KgFSV1/63uYbTxGpW3VuSrwdlXmvzzOfONnArV+qQ1/aJIK+SIzgRPQxfI+JeSXDeQ0E/s1Vf5rUIL+mQmYEs+YrFXiB9ceM/ZwBOp8o2BX3Ixu5A3NR9YI9pK38AXtDBBpnkIGpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kG8HmKNj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=82slXiOoQVQC9//as6jdxQ6yG/Hw27pBqImDHueRTQc=; b=kG8HmKNjrK+7DQFDdc/MrJOMH4
	Y0nlMW4CXIzpC7crHUmkOOlocJehtXtXKUzA4aVtzUGnerxozQrWEotMZUdXDJTuXRaX78tTyC70s
	2ryexNLCNcJnWPOj6ZP004b3M5oGAdO3IPu6JGvMdusFAl1ZBD0NcLEo2wWAVoqOeHEDcQjQ+yqsv
	y5sqM4TbomGC2kUX+czUqgE/Zpth7Ud2EzoOi7MpYgqCPKambMTKgDVCC0fVDs8yIwJyP5qsr4Rci
	daVXRfSTj2jZ6a2qFppqYinMcJBjk0gIkRio2Jo5V5Xh03CnWDozNID5TuMgd7f+sQ8In2Dbhcue2
	WSp0S2Dg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uAoFe-0000000Endv-1amq;
	Fri, 02 May 2025 11:08:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6F11730057C; Fri,  2 May 2025 13:08:17 +0200 (CEST)
Date: Fri, 2 May 2025 13:08:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, ardb@kernel.org, kees@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	jpoimboe@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250502110817.GX4198@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <CABgObfZQ2n6PB0i4Uc6k4Rm9bVESt0aafOcdLzW4hwX3sN-ExA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZQ2n6PB0i4Uc6k4Rm9bVESt0aafOcdLzW4hwX3sN-ExA@mail.gmail.com>

On Thu, May 01, 2025 at 08:33:57PM +0200, Paolo Bonzini wrote:
> On Wed, Apr 30, 2025 at 1:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Notably the KVM fastop emulation stuff -- which I've completely rewritten for
> > this version -- the generated code doesn't look horrific, but is slightly more
> > verbose. I'm running on the assumption that instruction emulation is not super
> > performance critical these days of zero VM-exit VMs etc.
> 
> It's definitely going to be slower, but I guess it's okay these days.

Yeah, it adds a bunch of branches at the very least. But that was indeed
the argument, we shouldn't care much these days.

> It's really only somewhat hot with really old processors
> (pre-Westmere) and only when running big real mode code.

Right, really old stuff :-)

