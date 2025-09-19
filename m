Return-Path: <linux-efi+bounces-4877-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7306B89B9C
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B767BA379
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7DB2C028E;
	Fri, 19 Sep 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbW7a68a"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0222248A0
	for <linux-efi@vger.kernel.org>; Fri, 19 Sep 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289348; cv=none; b=jBGoEsyjlEpfoqGmjAJ3KiZ2b+lUCECQFRiiPPwYdhAKafDx2l8onFGYy7lsqeejzbfXvlii2LvoMnqWH2rq2yvc4A8EDKg1KltgDjrL8zTMja60T6BXh431JDr+ReV2MyLLmXoMQz+NA7D9i1EK+tMmudDy/OVvR/ZhhuHfHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289348; c=relaxed/simple;
	bh=VD9twcb7S80CWtXroi12j7zJyLQewjL/Uh8dbBcqjKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNN6kelnLeQhfo78XlrVNgTXZoBX96NqQDgW8iVbViwOGgaJizwIGnKucMuIpJBE4ngWgU85bGebp1+Q6eycDMYbOkR2l+n9jSAIsROWQc5xBjnUEEAIVMcNZByFX+ZfPN8JD+a1vBK1UHE7GTXh+UNi/VMJDCfuSswHuahDMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbW7a68a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874F8C4CEF9
	for <linux-efi@vger.kernel.org>; Fri, 19 Sep 2025 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758289347;
	bh=VD9twcb7S80CWtXroi12j7zJyLQewjL/Uh8dbBcqjKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YbW7a68aWSJxQEfmTEPnCmr11Z2hvNwSBS/1T508pGv4HRlYeL+Y+U5Sf8u2O0BtO
	 kWFuvqOA59UsVdf9bwfNLIl70YHRbaNNLV8KQGDoZwY+Z+DVrGlGttxJKCgvuN8P0T
	 17NpHMU9XFYMkAVJQzrKsif4n/e5004EriNYjkF+6qv6yLCJojhNCt9JovMI42Se9X
	 GWUOmwScY43XVBStyjc/QlurNEI+ii+hQpykMoVxihY+LObjXy9e9BVlyWVDrIwmfY
	 WZ0Su7L0QT0mff4d8Qp8jerN/mNPxZfchVsYdnaiMMqEEIvTyvFUO+pMomfBh9Yleq
	 8cTevw6nkr85g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-577232b26a6so2108599e87.2
        for <linux-efi@vger.kernel.org>; Fri, 19 Sep 2025 06:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFcKELWMzn5fgTMjT8sfZK+z0SSTcCz+nufG7L74/hI7Nnmu3x5zbiSKrIlzPb+a3KxdiNALiBn5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPWNZNAPyJ8PsjgAxYwKyAC1KtioGiO9CnJWk6+OHEc8dzdFB
	8k67ROdbA1xCN7a8Hn2GV95p2tfD8DqDFlDiIJ+/v4xxUwQ5jfG33XHtxTRGBOhj8DDKNXhzuWi
	qvLPJhS+ZNMG9lceoKEPBMGLQ+HPvLlU=
X-Google-Smtp-Source: AGHT+IEVHQt1+umL/shZjWxswdEHXPWfiF7ZzA5sdLmn3VX8+SoqCosMzyNK1tpKJwOoXR+4DBwNsPqC86+/RqtDsIE=
X-Received: by 2002:a05:6512:20da:b0:55f:6c08:a15a with SMTP id
 2adb3069b0e04-579e213146cmr1070509e87.32.1758289345910; Fri, 19 Sep 2025
 06:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-16-ardb+git@google.com> <aM0_96QvR-hlYMJJ@willie-the-truck>
In-Reply-To: <aM0_96QvR-hlYMJJ@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Sep 2025 15:42:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHDtTNMzih7OoTYU0vN4M3mOmFL3YOfaPUKReyJQA6uAQ@mail.gmail.com>
X-Gm-Features: AS18NWAfcXjUAqbspxju1lDMLZ8UsXKdDJ3RZBNTTMabN4mFPEeu8uYKA9lxEsc
Message-ID: <CAMj1kXHDtTNMzih7OoTYU0vN4M3mOmFL3YOfaPUKReyJQA6uAQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] arm64/efi: Use a mutex to protect the EFI stack
 and FP/SIMD state
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 13:35, Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 18, 2025 at 12:30:17PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Replace the spinlock in the arm64 glue code with a mutex, so that
> > the CPU can preempted while running the EFI runtime service.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/efi.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index 0d52414415f3..4372fafde8e9 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -166,15 +166,22 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
> >       return s;
> >  }
> >
> > -static DEFINE_RAW_SPINLOCK(efi_rt_lock);
> > +static DEFINE_MUTEX(efi_rt_lock);
> >
> >  bool arch_efi_call_virt_setup(void)
> >  {
> >       if (!may_use_simd())
> >               return false;
> >
> > +     /*
> > +      * This might be called from a non-sleepable context so try to take the
> > +      * lock but don't block on it. This should never fail in practice, as
> > +      * all EFI runtime calls are serialized under the efi_runtime_lock.
> > +      */
> > +     if (WARN_ON(!mutex_trylock(&efi_rt_lock)))
> > +             return false;
>
> If it will never fail in practice, why do we need the lock at all? Can we
> just assert that the efi_runtime_lock is held instead and rely on that?
>

Excellent point.

Do you mean a lockdep assert? efi_runtime_lock is a semaphore, so
there is no is_locked() API that we can BUG() on here.

