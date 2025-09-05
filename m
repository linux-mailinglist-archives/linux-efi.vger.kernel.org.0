Return-Path: <linux-efi+bounces-4703-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B3CB459B8
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B221C21791
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0B35E4CA;
	Fri,  5 Sep 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFOlwufC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355930CD93;
	Fri,  5 Sep 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080512; cv=none; b=gbLbIzeKinhboZbMFLpRaUKer7Ub4LIBHf+1KCqmaoyubOd2NwCMVIsU7aLvGuROeGNzcGhIc9KxNG3oAC5SFgkkG7BhCdRLbrsi7QjxoIPmR2KalQRFA+IJ3DdEtxTwi/gqrVBVVCxQyJpulr4B9HgCHWarcv+nZp3peU1jBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080512; c=relaxed/simple;
	bh=tbO9ihI8N/tHJd5rn+q0yf0ZhhuPpFDOP1LlEgGefh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKvT7bp5GyLr140L+YNZyIKzNhQckrkov8obTNzCHUyzcYbIf3Z9qYWseDCKK00e4TlPEf7gbN+WOFhrMllzeVSK8UxwrPTo4Gj6ohUdRRa39VC9FCM8bBd5l7v+RciSY94jvq9dDZ7krSBST4Ut+jTiVQqCyBlQcyBtFJZR9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFOlwufC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6391C4AF09;
	Fri,  5 Sep 2025 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080511;
	bh=tbO9ihI8N/tHJd5rn+q0yf0ZhhuPpFDOP1LlEgGefh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jFOlwufCougt/KWndQp5f92rVECAChAIQNoFor7KFc8x6Bw4tYTJiozWza/6NluUi
	 BFGShRkwWQS5I1wJbbiNtJTjhlF9caNARCOumM3OysnR4XBzsB+Jf4omq7HmdmQX6V
	 UUBzBYUPt2avxON+tAe7WSfKR/gg309FIq+MYz0W8iOV+nXBJreXko73B1oMGpF3yP
	 YD3vdpH2LsDjmu6Akw8XUpHjAFdwE1edMWl8h8FEinH6Lw+lF10guZv3QhL7htyMnL
	 dBSqjhwLkDEesMEYwQ2Ht8UKXdwEJlVcYcx/2lzh9oo3HbbyzED/9QoSyglPPgQFf3
	 tBC30iVlTA/zg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-337e1ce5dd1so16880781fa.3;
        Fri, 05 Sep 2025 06:55:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu9n2dnbJ9TtovrQqBGYcb5E90lfSQrtfWpsOGgv4BS1EOWJY4SpXsj8AY7kKnqTAGAQzLjgfS3OU=@vger.kernel.org, AJvYcCWYILl4RgZSKj3BvnlP4lJAihEkz18dkYmTHcWd1C8lDMMQuyM6eVka2jd2UXMqdMX011eAkCzoj2GAF5Ik@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGeHMZUHrWzgJ2dbjDach10P27iEaByQEFJeEHjXZAb5B4TXd
	mcFsi3O4jXz/rXrFYmUR52kLIrQPV5qfA7EMDygyUdzTmJtzJa7y0a9uq16dbrn0HOsk2Qd9txv
	HUCpVHJ7pcPewfQbRCeTQJ2bgiEuu598=
X-Google-Smtp-Source: AGHT+IGnR2SsMTiyOAAhvwYnOIXA5lhedj7YSR5pCY82ACY1he4UyteJ+PqMEQ2mdIywc/cZuplmILslAXt6ruyb2Ww=
X-Received: by 2002:a05:651c:20da:20b0:338:1c5b:37f0 with SMTP id
 38308e7fff4ca-3381c5b4ba4mr9724091fa.32.1757080510151; Fri, 05 Sep 2025
 06:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com> <20250905133035.275517-14-ardb+git@google.com>
 <20250905134409.GD4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250905134409.GD4067720@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 5 Sep 2025 15:54:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE49HFQHYJ=bgz2hPoa7ZocqbeL+pWGtpxxBU2g6_7+SA@mail.gmail.com>
X-Gm-Features: Ac12FXwgTpHgZE1QucUvVXDJ06PpzmoBlm_o2ucaJEAd7ZBRUBINwU5z8wjYoHg
Message-ID: <CAMj1kXE49HFQHYJ=bgz2hPoa7ZocqbeL+pWGtpxxBU2g6_7+SA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64/efi: Use a semaphore to protect the EFI
 stack and FP/SIMD state
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Sept 2025 at 15:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 05, 2025 at 03:30:41PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Replace the spinlock in the arm64 glue code with a semaphore, so that
> > the CPU can preempted while running the EFI runtime service.
>
> Gotta ask, why a semaphore and not a mutex?

Because mutex_trylock() is not permitted in interrupt context.

