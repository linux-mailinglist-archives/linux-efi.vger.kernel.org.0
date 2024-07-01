Return-Path: <linux-efi+bounces-1363-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4E91EACE
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jul 2024 00:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9421C21341
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 22:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D115133987;
	Mon,  1 Jul 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ1bl+hn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7F38394;
	Mon,  1 Jul 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872743; cv=none; b=nAUwkIAacSZMnGf3JGxOpwOyoDSnP4LfK5ferP577RbqJggi9atpAVTSXVZ8QI9O4bWisliPfeFLStEgroJ1BqyjQrAFGoYgWCfOVikLTFaEwhCerRaNGXMbB1P/oz8eIhTNMTaMAk3LnIUVnIUynq8gSjCTOQQ0sQ4ZO4k0p64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872743; c=relaxed/simple;
	bh=Vl99IWyfrchtGKp/1JALMN1waMUzpYBfr0eOfPm/CNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jcpx5gv3i5hG3+I0KR1xZW6hgr3hyoz9+UQFe7qtmthPiOUYi0x7PCRl+ZjRd+RruULHhivQjK+74YaKmQChkVgQ4jSC386u6BlHhs0vfJBEmh4qKBCroV9eGuvL+BRCBskq5lMaDXEiCgKt6FFJgt2WY7K6wAP/4Y6FGg0TtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ1bl+hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2DEC4AF0C;
	Mon,  1 Jul 2024 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719872742;
	bh=Vl99IWyfrchtGKp/1JALMN1waMUzpYBfr0eOfPm/CNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oJ1bl+hn7HE2B0DV0aV15+UOZ0UX+jE0Gc7k2TZrKPDDv+SigOJvr29TS9+BDw4CD
	 jhVI73cfP32bSBzSJPln1VIrsN0b3f5ZeAflDVuJ0gFWpVHG39IIGvaZZv81/UKU6Q
	 7EYwhaDrrVZM6oUZxykxpuYr0HEPph390tY21tyT9cPQ4HOefjppt4iQUNbdAmb1ZU
	 2cYO/0pn1+6yVUCKvss4mM7kXbxrBQv2sA0hA9q4pWQVF5uKsCz5Tp/PYKeBMY0jWZ
	 TRMCvBhSBGAoUCjSATrc5KSzpn0okx0Bw6C3wy/B9Odj5kzvLgYsKn8pK4aSaoo7GU
	 eU5cbYfiKU1Qw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso5239948e87.1;
        Mon, 01 Jul 2024 15:25:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqXcPSPBqq7XID7lbW6adOFjfd4ZCbZAuEx0ply1vwmxng9OlYuyAU9DqovIpFstUenn8qfVE3HCxS6KqPZx2klMfviKGhsAxzIGgwmhLD21p5jPj2t5w5/u7ieg5Tze5V2gtTtxRp
X-Gm-Message-State: AOJu0YzZ8zLvvkPTHa2UlIe7b2eeqkSyS8ldB5z97+QbYoLFqR4pxmCj
	uzcGrpHqn6ykNYub5c5glMC6CSJmjZzgCOtO3aIkaJv3iUOnKaGx18aNF0UGEh2/ldoy2H+8ILV
	gie/5AMJPytVEDMP0GZSxgRhAsOk=
X-Google-Smtp-Source: AGHT+IE+dlYVgKNjElhlLc2gxznzb3V4NMtzyoQNHPLrJ9s/f01RZksEPKw+zn5DJGJNGUZtAAn6XxOJItaNJcwJ1Zc=
X-Received: by 2002:ac2:4c41:0:b0:52c:d645:eda7 with SMTP id
 2adb3069b0e04-52e8267a440mr5453680e87.18.1719872741182; Mon, 01 Jul 2024
 15:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620073205.1543145-1-ardb+git@google.com> <66830ebdb7f0e_5639294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <ZoMUnSaqORagM_Y2@agluck-desk3.sc.intel.com> <6683178094c32_5639294c7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6683178094c32_5639294c7@dwillia2-xfh.jf.intel.com.notmuch>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Jul 2024 00:25:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGvVwx9JdeDSYT0TwJmVnTz4qWyfah082pD2b_F85351g@mail.gmail.com>
Message-ID: <CAMj1kXGvVwx9JdeDSYT0TwJmVnTz4qWyfah082pD2b_F85351g@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/efi: Drop support for fake EFI memory maps
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, dyoung@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 22:54, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Tony Luck wrote:
> > On Mon, Jul 01, 2024 at 01:17:01PM -0700, Dan Williams wrote:
> > > [ add Tony who may care about the more-reliable removal ]
> >
> > I don't think I care about removal the fake options. I have had
> > systems that support real "more-reliable" memory for many years.
>
> Ok, lets remove it and see what happens. I recall now that the major
> policy knob that users may care about is efi=nosoftreserve, and the
> ability to specify efi_fake_mem for testing purposes can move to memmap=
> on the assumption that kernel-devs are much less likely to specify
> broken settings, or at least can pick up the pieces.
>
> Ard, you can add:
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>

Thanks all.

