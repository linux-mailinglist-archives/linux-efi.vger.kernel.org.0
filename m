Return-Path: <linux-efi+bounces-4301-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060C7B0346B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E16D3B9849
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2234161302;
	Mon, 14 Jul 2025 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoUoENTA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884CBA4A;
	Mon, 14 Jul 2025 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752459645; cv=none; b=K6JaMNe4w8bHm2cfuNEAYH/HpvN4/0sgcPiIQHBfTwctiXjTSqHTHhAHe8/Dgyl2BEOV9iPHCWCzu4ppNy70rCi5Nc4Bv/hgwqwrlamfuQWeoq6InqMst9AvusNZ23wixho5D+Qn5wvcIk42oEJT2dFqX+TY/DCOrAr0CMcRKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752459645; c=relaxed/simple;
	bh=i6JzBgQljb1p+1NlyyYibH1USStHrkmH4JsqwLuSza8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9QtL9UvwLxq9facGsEXSagmqAUDqAJ6/EPXiVwdAYiYLki6rHBl2bqLFeyUFL7MtM3um1IlAxRFsDCePPjFugmTSuTyMXvwC2NMHTQgv9JyijUDNH+am1CQZeEdptNUBgJUjvnr4JpUolTMA7mqDuAkPEr91Uzaw2itKNZygQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoUoENTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D8C4CEE3;
	Mon, 14 Jul 2025 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752459645;
	bh=i6JzBgQljb1p+1NlyyYibH1USStHrkmH4JsqwLuSza8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AoUoENTAeXxa8t8weBai9VLbYTNcWO23BxK3RiXf6kviLHFD+Ov7eRk8a5VxfwxDO
	 boukk1akLGf+PCdwWHhOOdINWnKYsRpqF5DwyL3W5Ak8aacLB8o3ai8aAZIlrf63kF
	 9Q8wA1ZHBPetVd4WABO+sCo91hm5VYVvFZgNmr1H+LdJSEhv+2mclsSzh+UpyrNweL
	 DCB+vCA2W2e7meth2SdiOkRQVlZfO2ZBfwLkqLWqXFHtDpF92BUQ7ky7pNo+Q90BkQ
	 DkypO3gMUoqKmnEZkMos3WApzEx2+qu3tnelKrnZ/t73e5GZZHYhQ1bwjfn4rfqiBJ
	 BiEbmVn12cMIw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so31655981fa.0;
        Sun, 13 Jul 2025 19:20:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb94Y0q4Uu70EGrFFg+W3qic9yRdsVG0AsjNPWVC3FGauoKWtzdoJgVYWGD/gT9qx+4wHs9ZS4ukmMlnBZ@vger.kernel.org, AJvYcCXyUvjDdoPJtI2IWFYifmIlUldiX2TFu8a78i98347YG7bkuF8nqlbS0RxuPSZZokGdTa3CTsSfFBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgeGdn6wOEIkHmm2Avpew2ahQHq8Wm7EKiOkzmEXM2fVKHEZYA
	YtO4ebKTDiP20slDqw8NtVV5k0EA1g6eK+qRQ1+bU6hcVF+tEFSM3UhmrHVTBpLfHIsS1Esho71
	oBg8V4bAH+amhfGDhI5luNc8B6BMoOrc=
X-Google-Smtp-Source: AGHT+IFPUFMYWwjnzBcXwC0d6fwvdcN+mKrXo3pSpk73ThHe79z/VmIJ2Q3NAcpEs+1oONoYKC6JrFPxuK85+vm9p14=
X-Received: by 2002:a05:651c:221d:b0:32b:488a:f519 with SMTP id
 38308e7fff4ca-33053292135mr39355511fa.6.1752459643430; Sun, 13 Jul 2025
 19:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com> <20250514174339.1834871-16-ardb+git@google.com>
 <20250711134833.GI905792@noisy.programming.kicks-ass.net>
In-Reply-To: <20250711134833.GI905792@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Jul 2025 12:20:30 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGEHWMhMgY8ZMiRxKPTeD+oZBReozKwA4udJsrp-j_P_A@mail.gmail.com>
X-Gm-Features: Ac12FXwLcQxZDL-vTtg_BIL4PN-M5Xpb-28I605kB-Ll_-F_i8KKCCRihwo90qw
Message-ID: <CAMj1kXGEHWMhMgY8ZMiRxKPTeD+oZBReozKwA4udJsrp-j_P_A@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] arm64/efi: Call EFI runtime services without
 disabling preemption
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 23:48, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 14, 2025 at 07:43:47PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The only remaining reason why EFI runtime services are invoked with
> > preemption disabled is the fact that the mm is swapped out behind the
> > back of the context switching code.
> >
> > The kernel no longer disables preemption in kernel_neon_begin().
> > Furthermore, the EFI spec is being clarified to explicitly state that
> > only baseline FP/SIMD is permitted in EFI runtime service
> > implementations, and so the existing kernel mode NEON context switching
> > code is sufficient to preserve and restore the execution context of an
> > in-progress EFI runtime service call.
> >
> > Most EFI calls are made from the efi_rts_wq, which is serviced by a
> > kthread. As kthreads never return to user space, they usually don't have
> > an mm, and so we can use the existing infrastructure to swap in the
> > efi_mm while the EFI call is in progress. This is visible to the
> > scheduler, which will therefore reactivate the selected mm when
> > switching out the kthread and back in again.
> >
> > Given that the EFI spec explicitly permits runtime services to be called
> > with interrupts enabled, firmware code is already required to tolerate
> > interruptions. So rather than disable preemption, disable only migration
> > so that EFI runtime services are less likely to cause scheduling delays.
> >
> > Note, though, that the firmware executes at the same privilege level as
> > the kernel, and is therefore able to disable interrupts altogether.
>
> Is the migrate_disable() strictly required, or just paranoia?
>

Runtime services might be polling the secure firmware for an async
completion when they are interrupted, and so I don't think it is
generally safe to assume that an interrupted EFI runtime service can
be resumed on another CPU.

