Return-Path: <linux-efi+bounces-1194-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3136902ABC
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 23:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E248F1C20DD9
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF99474060;
	Mon, 10 Jun 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY+GZju3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84A5588B
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055787; cv=none; b=S4HN7qAJ3fIBT7RkW2QU05t6FH/P8xboHuSEeIOHyJOzYK6A3cdj/iRoC59Zk6kN+FGnvR6HOw/GVyHENtfhdU5D+PfREFvjjDooKNjHTsbMmE1FSKDNJOBPxanC2JBwnLDvsxwjIZWhDbUPFheI+wYinGikIA/aUY2OLPeqDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055787; c=relaxed/simple;
	bh=J7hm3nD1fFmvW2pTglc/i1qnC+jOdynzO8FCw/Gb6Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5q9GXeb1RFvqc8uXmv3ooU/abMvDAEdBHjMkuVCrtrPDWivsqbjecOZ60QSFUXbg78way/wpa2ktCOy/SbSqiy6x8+vuFuwohUkCYAZOQ5/WkMw5F5sH6Z751y9Ujgnvt1C8UB/pRdqx5IY1P8jxbNLiNJ6nTvJGH22MC8lAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY+GZju3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5D9C2BBFC
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055787;
	bh=J7hm3nD1fFmvW2pTglc/i1qnC+jOdynzO8FCw/Gb6Qc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fY+GZju3FuPcBhR5k4Ig9DD1qT/BoKwWyce+cvqJ7OE4jSqeeiTqrhV4iirP0dSni
	 QmYU8BG1RmBpUj+qjPr/bdF46v32IfUIPCqKCGceGYHlWcMaphd7O2hH/8Sq2qHvPJ
	 Kgpjh7/zg9HP8lZ20LwsHEtQ3jqu+r5LNv0/858rdWMerO76eeMFyyGVuR2XeZ3IRT
	 rQiyJ021S5bLeUMEjDUd8KQmP55uO0ZG4LIM/f2VUG8uwTPYi1vh6TV648gwxyrI8p
	 m3/vWDdhAtrPu2RM6GNzPnNKsEewYe0hCT1gx7BHwBfm5XcKUzpjSraA1ncnUbGYGc
	 Mr3Xkt20APk0A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so4133961e87.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 14:43:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YxeeKpz0dqZeVVd7vuza012R8+/Tv1SoWWlsuQEp+hO675gJkGT
	6McL1cFVNgmUhRw/GZ0AqASJuajCV5UpyRwjBo5I7fZXprWY53XzbWjx0hZyGTwlFEChom02xan
	gncR6peupcou1s9ZwQsK6I26uf94=
X-Google-Smtp-Source: AGHT+IE15OJdrPQobPWZovo/GLpUikqnoqSdLlZwE3swwrlDCj1HnTN4HsOUoSCKdEU9v/2q2xCsDPMCPBiPpynY8Zg=
X-Received: by 2002:a05:6512:238a:b0:52b:c2e8:6aa1 with SMTP id
 2adb3069b0e04-52bc2e86edbmr9446290e87.29.1718055785438; Mon, 10 Jun 2024
 14:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
 <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com> <CAAzv752N7mZ58uzMkaxAFDbefCLSqtLkZBVXXuY00RA+UQ6ppw@mail.gmail.com>
In-Reply-To: <CAAzv752N7mZ58uzMkaxAFDbefCLSqtLkZBVXXuY00RA+UQ6ppw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Jun 2024 23:42:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHuNCexwOZNoqncLdY2NQk8LTZvXztSYmv_kTr1jr2E7g@mail.gmail.com>
Message-ID: <CAMj1kXHuNCexwOZNoqncLdY2NQk8LTZvXztSYmv_kTr1jr2E7g@mail.gmail.com>
Subject: Re: EFI mixed mode boot failure
To: Nicholas Bishop <nicholasbishop@google.com>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 20:04, Nicholas Bishop <nicholasbishop@google.com> wrote:
>
> > Which platform/EFI implementation are you using?
>
> Testing on an Intel Compute Stick (Cherry Trail) and QEMU+OVMF. (I'm
> using an older build of OVMF because recent releases fail on ia32 with
> an exception early in boot for me.) I'm using a custom bootloader that
> invokes the compat entry point.
>

Interesting. Does your custom bootloader implement its own PE loader,
and if so, does it correctly clear those parts of the PE/COFF sections
that are not covered by data in the file?

> > In any case, it seems your analysis is correct, and no BSS clearing is
> > performed on the compat entry point boot path. So please check whether
> > something like the below fixes your issue as well.
>
> Confirmed that this boots successfully on both the test device and VM.

Thanks. I'll have a patch out right away.

