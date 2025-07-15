Return-Path: <linux-efi+bounces-4339-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD7B04D1C
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 02:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2174A2BD0
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 00:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25D155CBD;
	Tue, 15 Jul 2025 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nobd/7Rv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48542E401;
	Tue, 15 Jul 2025 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540417; cv=none; b=DPehmbhjd0+FoLNT+Cb0awPzdkD/bAmBWEb3e1z1ffvNUX3w+lC04s3ioHyVsdaAxk0D/jG+MQTuqoCmKP9/70ecIdws18ej1+imMV9iypTkpKlVcdRb3xkqF9bTzy/MC9b+ySDNyt2c+gBZvnt3nCfvecqwTO+S75u7TtSEhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540417; c=relaxed/simple;
	bh=QUWyRua1PVsgjZHyzHVszCN6h+pSG9rSXu9z+2oNTDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWajyGiHAwBNJXLspckB0XzOOZ/xeAQkl4MeK0sLXDhkFJJeIbg7PhJSDS5Cb9vida3IPvFRD5KdvNJmtm2vdLVxytNlmuvyrdnQTPXolhSL46e6VWiZJ2DXsx+NnG5mtwQDHEufJZ6zt9ukrxWvOwjODHnL1MKewl/iLPx10y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nobd/7Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E467C4AF09;
	Tue, 15 Jul 2025 00:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752540417;
	bh=QUWyRua1PVsgjZHyzHVszCN6h+pSG9rSXu9z+2oNTDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nobd/7RvPlaubgwTLjxG9HViOA5c65b3VYG8GgvTKY6MZkg4VsOJea+uJZ/f6tkkb
	 up6mTZXz/04SZpsFzSwhAg+L4QW0OzQfMcX5GJIPJS8LGC83ECscqfSgofd1OZ9REL
	 Mg6cz6xXHzBAl//zfVD8dEteRG9YdtWMCX4nuVeOBKhrVhOqg+J2qoB7rsK6NAv0/7
	 +NS6nW+8d4I55lyh4yFgDpCPxbdichtqkKk+MpaqT22N0FETlH6jC8391DnSoabRGT
	 16NTp05ayoCqz9epx/zfmyNhrGg436yCwdp/VPpskT6ClhfEdyuewZmwFMO0+COsX7
	 /9VIsgYVU/JoA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so60381971fa.1;
        Mon, 14 Jul 2025 17:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIy/+Q6HvvXMIx9NWuQrMQ1iJFHiTXp6i8fpu8Pfsmp8uLguK2m7in5kJzir/TWVmPnf54NLNfmNc+gddb@vger.kernel.org, AJvYcCWPUL8ca8i6c1ueIM3NUJGezjXQ6fJq0hO13YCZYS6HjdHZ3Hf8Dh4P6wbeiieaMTere9I8r4N5zek=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBzHRfAJWAiInyxtZtU+B4eptj8xGAIO3A6abgVnEYVspWZme
	HDOnS4XvBek1+txAxy9Ii0RGUPzLP+HNX6TTN4Qw5B7iFr5uRfi9lWGs3RB34TojuEPEUIEkk2X
	166S4d1E1k5oKmrFYdrjrkDZNVULFXlo=
X-Google-Smtp-Source: AGHT+IEK8xvGJsiLgjph1djYADb6nimHmTBNnLJKglHEK/iwDCjgQNndxfE14N2T8V7Sllti6VjlMLrU2PBcyU3/K50=
X-Received: by 2002:a05:651c:4002:b0:32b:3c11:518b with SMTP id
 38308e7fff4ca-330811a2361mr2611401fa.9.1752540415579; Mon, 14 Jul 2025
 17:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com> <20250514174339.1834871-16-ardb+git@google.com>
 <20250711134833.GI905792@noisy.programming.kicks-ass.net> <CAMj1kXGEHWMhMgY8ZMiRxKPTeD+oZBReozKwA4udJsrp-j_P_A@mail.gmail.com>
 <20250714105520.GS905792@noisy.programming.kicks-ass.net>
In-Reply-To: <20250714105520.GS905792@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Jul 2025 10:46:43 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEw=RSnf_Af=+AKWmuxJ+0dL_4CFSX7TyKo+SSKpxc6Bw@mail.gmail.com>
X-Gm-Features: Ac12FXwhxWd487QWnvJuNFtNxvH8YdIgyz_tVB6S9DDi7Xvs3l2_QCE4SmvUJoY
Message-ID: <CAMj1kXEw=RSnf_Af=+AKWmuxJ+0dL_4CFSX7TyKo+SSKpxc6Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] arm64/efi: Call EFI runtime services without
 disabling preemption
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 20:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 14, 2025 at 12:20:30PM +1000, Ard Biesheuvel wrote:
> > On Fri, 11 Jul 2025 at 23:48, Peter Zijlstra <peterz@infradead.org> wrote:
...
> > > Is the migrate_disable() strictly required, or just paranoia?
> > >
> >
> > Runtime services might be polling the secure firmware for an async
> > completion when they are interrupted, and so I don't think it is
> > generally safe to assume that an interrupted EFI runtime service can
> > be resumed on another CPU.
>
> Can we please get a comment with that migrate_disable() explaining this?
>

Sure

