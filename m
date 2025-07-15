Return-Path: <linux-efi+bounces-4346-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F39B0551C
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 10:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE25D7AD926
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757C2749C3;
	Tue, 15 Jul 2025 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYm/zufu"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6A25D55D;
	Tue, 15 Jul 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568712; cv=none; b=Fl0IOH9FTrmmXCE2iEXbrqDpmyiAT9bxAs8xsf51T8hsDF/R5EfrNA7Gh26DIRttf0qGpLRHGNFfiwFsqApAL17xktPS0Qzrb2UXcRgM/hDxxVbsH7eJFCE+8g0aZFBKM0lQcoekrN00yj56gmmBQXkt0QVrSDp6hB8L7tb3Y08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568712; c=relaxed/simple;
	bh=+vwArnrY1WUKpHwVAhWW4AdnqAXxb7+tLN01yLid6D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slkfyg+ej85HvkNiD9XRqgOlMG9Xj8Y6f8JtSmsRy6YT7oGS5Dv1+ezdrTH0A7hfh+dZBl1dzLDfz28nDTGHtXrqee1LthMHsTfkuNkTCH/ZtzhmJMYhLcVBCN3UIY395/hyFHSa3yjSWjYYoG7zAlu/n5pnr05KnNjPll7lkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kYm/zufu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0T1MAaef5TRDgYb2ggWbaAQ7P+Pjl4UPCbAZTCdx3jU=; b=kYm/zuful5YpIcQKeAogobkh5w
	gtQgGyCJvrx88F9aqMMCBThiUhl8tokdLvPaee1EvNBGSJAYFMMp8yBW3mg4Q4+/sSRLHUuLbSs60
	edg3jsXa+qD1hGBCyJlwoyzaPK4/QjexBONi1etGhmU1pUcG6P6pCna+AR5KtJZ9cw127OtcBF36s
	3UQ/FxrqQ/wnDTcsiJXPhbrO8CP/w+DY3zMWaKbZ6DzPXgzTF5UVEZTxb+osOwHsOtKJ7xlfgjTyv
	uBqEZKmTGLj5GFwPkC8Dzl4ZRzMDdJ0eMf6+3a1/p2Wl98qKQIYzhVpMwirc/DPG8dMQM/Inwf90o
	CwVwtdzg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubbAx-00000009rLY-34gi;
	Tue, 15 Jul 2025 08:38:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68E1E3001AA; Tue, 15 Jul 2025 10:38:10 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:38:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
Message-ID: <20250715083810.GN1613200@noisy.programming.kicks-ass.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.496787279@infradead.org>
 <CANiq72kP7_24ChdQ+vDg+HWJB-4mKWvB9P33C9O=0W_kLt0+eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kP7_24ChdQ+vDg+HWJB-4mKWvB9P33C9O=0W_kLt0+eA@mail.gmail.com>

On Mon, Jul 14, 2025 at 06:30:09PM +0200, Miguel Ojeda wrote:
> On Mon, Jul 14, 2025 at 12:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Apparently some Rust 'core' code violates this and explodes when ran
> > with FineIBT.
> 
> I think this was fixed in Rust 1.88 (latest version), right? Or is
> there an issue still?
> 
>     5595c31c3709 ("x86/Kconfig: make CFI_AUTO_DEFAULT depend on !RUST
> or Rust >= 1.88")

Oh yeah, it got fixed. Clearly I failed to update the Changelog.

> >  - runtime EFI is especially henous because it also needs to disable
> >    IBT. Basically calling unknown code without CFI protection at
> >    runtime is a massice security issue.
> 
> heinous
> massive

Typing hard; Thanks!

