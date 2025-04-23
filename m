Return-Path: <linux-efi+bounces-3437-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3EA995F8
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014355A8393
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E52820B4;
	Wed, 23 Apr 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9WGVSOL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC52798E3;
	Wed, 23 Apr 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427763; cv=none; b=VqJG4DNYjcUElHbt9J6QzaoxMv1Ub/tr2OEZdL/1QSJ4tMDtn1yfY5yrYoGmlGBrfnr4kDQifVDtilZ4cLKLZIVerHezgljOo4tkBlHpd8xdzAJxIEJxnl0Z7ECDLHVN2wFUzZhCrdBCoGK+fad8baTH6kKig0LTC3gUTZUPwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427763; c=relaxed/simple;
	bh=f+Y3X3YiUsLlyM25CR4YNDzXTSkXUg0kSn7T+IarnKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ed/QMuY2LCLcZzK2IHNFPlZtGmksCApSpchTxz9cKuYp3RT29xELDaWGZZQoNRTqHcdvBs3J3P+YJAR+7OUUMsuJPIgxnAG8rNdloJqnq1w/upapFg3k+98aZftznzouGe0oZdN5+wS1WHr3pMwmCaD6nYyPbQzZCeOb50LNqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9WGVSOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E73C4CEEC;
	Wed, 23 Apr 2025 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745427763;
	bh=f+Y3X3YiUsLlyM25CR4YNDzXTSkXUg0kSn7T+IarnKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9WGVSOLMK2IllaBXAwJz0xviUDru67xnRfAFN3NVrlYNOHhmJOguw0EhAM+yrkaM
	 L2yswzZRsPsf7PyeX0XYkveLk3Up8+3VIxMl3Beu9sU5BRfff99I5aDKfLDTxOtMYW
	 3G8XYMu5o/iazQUNQSx75copPBEloQIoB9B4MDmh7Kg2sXHaJGinEnpPt6Zzde1VQP
	 ebMSZnkvYkfnHh7nqG4AoncsSCp5po+bPqgAzuo1jQbq54AAf4H4CBin4GSd/Kqufm
	 gPTRhk7+qQ9KO1XDMita+8TYvKeW7gt6nFPaHS0qCVvrr8gnazJvCmViCq4fDsYqWz
	 3bzBnyaM8kyZA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549967c72bcso6492e87.3;
        Wed, 23 Apr 2025 10:02:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSjDZIWiSxe+T3le2RgKz6P7q44EbxoT28mGKqYL5ytAa+nBpH7HRf2svK2dkN0pMz9k4JFLQciX0uVGJ3JVWUvRI=@vger.kernel.org, AJvYcCW30C8fxugnnZN93o27yTbc/iSoIT2zw5v+Iof6ky5boFOmnP6Q1FE+2p5FogQI0t4HMsgH0xKJgS8oWsZf@vger.kernel.org, AJvYcCX7dz6NPrzhgl9jazcQiLt964il4JDqA9+N7wUhm3xXo9ez+p6F13QyMy8SaDW6HgoskEKeUt8NSoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvf6dnU2Pt15S9arqszWo7VDyW/01YztJ0zZCQZB8brEfx9gaG
	e/imkDXfQnrE4VSqES7PGw25T5w8L0+llT95JCpYOcJ3c3xPjp/g85o6FMoCa5yr1ONhhQp1lVv
	JCUixHzLLYE/UcE24tVHchLjnuLg=
X-Google-Smtp-Source: AGHT+IEq7CfO+E4wwVjeXjdovTnbd7lMFJ2vO364cYkkDGW0lhY//NHoPoHLFTLaawgvlDn/RwsjYOWKhta7ldtyrvA=
X-Received: by 2002:a05:651c:1556:b0:30b:a20d:1c06 with SMTP id
 38308e7fff4ca-310903c31b4mr66868041fa.0.1745427761263; Wed, 23 Apr 2025
 10:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422210510.600354-2-ardb+git@google.com> <174539448176.31282.2929835259793717594.tip-bot2@tip-bot2>
 <odoambb32hnupncbqfisrlqih2b2ggthhebcrg42e5fg25uxol@xe5veqq52xif>
 <CAMj1kXFpE=P0_a3fTAnb7qQmXLt19dCtuEcd5U8xwYzAcO=ufQ@mail.gmail.com> <4dxg5dunoft5r5hd5kddqzap2stn2ytiwvgik7vvktifbhiyv4@2dxkkjlygnia>
In-Reply-To: <4dxg5dunoft5r5hd5kddqzap2stn2ytiwvgik7vvktifbhiyv4@2dxkkjlygnia>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 23 Apr 2025 19:02:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERamRZW6rmqa8dqQdx81Sc5bSJKijoQpVp76ZyFns3PA@mail.gmail.com>
X-Gm-Features: ATxdqUE5Z9-T4w1qCH98mwuh4sMKz8HQW1HGvxwhBiUUro1F0vtBiYZJZ-iwEN0
Message-ID: <CAMj1kXERamRZW6rmqa8dqQdx81Sc5bSJKijoQpVp76ZyFns3PA@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot: Disable jump tables in PIC code
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: tip-bot2 for Ard Biesheuvel <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-efi@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 18:41, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Wed, Apr 23, 2025 at 05:01:42PM +0200, Ard Biesheuvel wrote:
> > > > So let's not bother and disable jump tables for code built with -fPIC
> > > > under arch/x86/boot/startup.
> > >
> > > Hm, does objtool even run on boot code?
> > >
> >
> > This is about startup code, not boot code. This is code that is part
> > of vmlinux, but runs from a different mapping of memory than the one
> > the linker assumes, and so it needs to be built with -fPIC to
> > discourage the compiler and linker from inserting symbol references
> > via the kernel virtual mapping, which may not be up yet when this code
> > runs.
>
> Maybe objtool should ignore .head.text.  It doesn't need ORC, static
> calls, uaccess validation, retpolines, etc.
>

I am trying to get rid of .head.text.

But some of the startup code may still be in use later, so I don't
think we should disable objtool validation entirely unless we really
have to.

