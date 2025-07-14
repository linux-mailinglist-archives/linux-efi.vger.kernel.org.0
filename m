Return-Path: <linux-efi+bounces-4313-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB0B03745
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D610B1892512
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4222253A9;
	Mon, 14 Jul 2025 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0BzFd2t"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282A1F4E34;
	Mon, 14 Jul 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475152; cv=none; b=P1hHzQon4eqWPKPY9Bc+yw90rRs3kT1EKj1rS8NVqVpKdE0Jy7frvzbBSqgiXJ+vRDOGAuu8dputFnCrUppyO+zSBV62cYa/2wIMihHD0KaaoAgusWRlUTSoD/kun+o6kkKsWn8jFnSs4i8smSI0e9n0uTMzRXFJ9rZkQUFUSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475152; c=relaxed/simple;
	bh=FoVaztxrgRjP723XEHoNpTeXrGoae6UBLEUANs0Qpaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKeUVcGICzRma1u71Nq02e0CsO+/6qWZLrC3CxVpL1Io0aUr9viwPiBp0vYFq+I1yL+rEK8uIaQXT1nZlu6oR05n6BPQcndbY5Ow8VQE4ZN4k8r2HrhhtPIDodnJldLvOY3WI9SliHmUhPzl8dGCSqquSsp/5i5FhSvG44lwwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0BzFd2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81383C4CEF7;
	Mon, 14 Jul 2025 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752475151;
	bh=FoVaztxrgRjP723XEHoNpTeXrGoae6UBLEUANs0Qpaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E0BzFd2tMpHuzCAGj0Ha0CVohGxMveMx8per5k7RAhR7NUoko0ZizjF4aMru7nVx+
	 f6DO/K6pD5VjJXRceEphe82jro7Utmnm0HWgud6W2bQfDWJEB/hzU9evMVlCu6LbBk
	 mxkRJe0YzBHASOoAsnfuoyRjYAV/uc1qwbynoV9IIyEhIeSvKS1WZrCspje8ajHZKQ
	 8aCQzFkaP01xv9sFO1evfdyraLMjqgEeh1qCX6moUT5F7RHLN88XbjHpoDDG1eyxdt
	 KSVirQoQ+SBohXHHQHsKQ/1kKzFgE6mRmw4CZTRewqndUcmr3KYh+6S7nmFwo1ToU5
	 azFAeYfAEIU3g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso3977163e87.1;
        Sun, 13 Jul 2025 23:39:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWn040dsPeSnnSq0JwY4UInDltRbbANLHP4goDQIIpTKDSrbDuVRPSd0d/o333ER9z08hgLo7jzXw0=@vger.kernel.org, AJvYcCXVFf96qkbg/OKHvB5+kSj88fQQ4kSuAAwbVND07YljZrwfRdkr22kNCFH+rScjbJb1/SJyuVQa5+hDbZxS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EcxLcX9rl/QGlWkQgKwb5AlPkhGnLpcioRh2odkZH5nmbRsT
	CeRvyH/R/1w3/1Z1ejBigvQKPsFKCnM7CzjepaIFXVt3tEr7BswdZwSUtjxSM9DQLfrs/h9EpxV
	cZ48tmBD2T17RC0+KNyMMqttZ0VcOH2E=
X-Google-Smtp-Source: AGHT+IFxzHHsHKYeCt0f+cMy1PRcE2Hm8loCADPyjxk8BTSemM4PgfyJ8BFt5KB/oTN+yNGLKV77gfsAksW2t1ap+Ik=
X-Received: by 2002:a05:6512:398c:b0:553:2bb2:7890 with SMTP id
 2adb3069b0e04-55a044ee7c4mr2693238e87.25.1752475149885; Sun, 13 Jul 2025
 23:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com> <20250514174339.1834871-15-ardb+git@google.com>
 <aHEUpiXt-pW7DBAN@willie-the-truck>
In-Reply-To: <aHEUpiXt-pW7DBAN@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Jul 2025 16:38:57 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFLZWvEBTX__P6B+3nMn-HZpKaVRkiUmfj35xiG8LH0bQ@mail.gmail.com>
X-Gm-Features: Ac12FXyjnBSSZ8dr1S-plRyUJrxrxaJsBWEcfmexP3uC92-azvZJoR8dJ8zqYvk
Message-ID: <CAMj1kXFLZWvEBTX__P6B+3nMn-HZpKaVRkiUmfj35xiG8LH0bQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 23:42, Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 14, 2025 at 07:43:46PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > efi_set_pgd() will no longer be called when invoking EFI runtime
> > services via the efi_rts_wq work queue, but the uaccess en/disable are
> > still needed when using PAN emulation using TTBR0 switching. So move
> > these into the callers.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/efi.h | 3 ---
> >  arch/arm64/kernel/efi.c      | 3 +++
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> > index decf87777f57..abe9176a3a23 100644
> > --- a/arch/arm64/include/asm/efi.h
> > +++ b/arch/arm64/include/asm/efi.h
> > @@ -132,15 +132,12 @@ static inline void efi_set_pgd(struct mm_struct *mm)
> >                        * exception when invoking the EFI run-time services.
> >                        */
> >                       update_saved_ttbr0(current, mm);
> > -                     uaccess_ttbr0_enable();
> > -                     post_ttbr_update_workaround();
> >               } else {
> >                       /*
> >                        * Defer the switch to the current thread's TTBR0_EL1
> >                        * until uaccess_enable(). Restore the current
> >                        * thread's saved ttbr0 corresponding to its active_mm
> >                        */
> > -                     uaccess_ttbr0_disable();
> >                       update_saved_ttbr0(current, current->active_mm);
> >               }
> >       }
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index d01ae156bb63..5d188c6c44d7 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -177,6 +177,8 @@ bool arch_efi_call_virt_setup(void)
> >               return false;
> >
> >       efi_virtmap_load();
> > +     uaccess_ttbr0_enable();
> > +     post_ttbr_update_workaround();
> >       __efi_fpsimd_begin();
> >       return true;
> >  }
> > @@ -185,6 +187,7 @@ void arch_efi_call_virt_teardown(void)
> >  {
> >       __efi_fpsimd_end();
> >       efi_virtmap_unload();
> > +     uaccess_ttbr0_disable();
>
> Moving this after updating the saved TTBR0 isn't great for SWPAN, as it
> means that if we take an exception (e.g. an IRQ) before calling
> uaccess_ttbr0_disable() then I think we'll end up running with the user
> page-table installed briefly in TTBR0 which SWPAN is supposed to prevent
> outside of genuine uaccess sections.
>

OK, I'll respin this to take that into account.

