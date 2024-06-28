Return-Path: <linux-efi+bounces-1313-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B1B91C4B3
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16321F23CF3
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0811C6893;
	Fri, 28 Jun 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWsc7sOA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6B157A67
	for <linux-efi@vger.kernel.org>; Fri, 28 Jun 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595172; cv=none; b=cn931SuevIZWwCK6Y4oGQhWDB/TL533SWU93p1dDGesTxipWbM0/Ml7tUvfLe4qQqO+hS8LGNpZ92bNlWDJfWX16NMNqm5bE+na5AzDzuoat6AmOB9SuGX0k39hD4vTzZn854S4fLjqBm+y1w2WHqp61DQ2KYbU01azaNGWr0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595172; c=relaxed/simple;
	bh=BG+1LPgmYdmKGrxt67BBHfB1XlDpPggRfQnlBxc4a1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4z+hDjTWm+kJFarcmgP78iyZDjbCbTyPe4iQxpWGaqiyEjWPV1F9fa9/U8VsieUyo0O3Sjwwqk/BICOUSkvQG1/X1/m3NGI1gGQhmm0J+h4lebIdwaWyHz09Kbc4tDveoHKzn9VOQWJtm3Fyul3OgzVnfp8bAJtQGzX+Phn4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWsc7sOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DE5C116B1
	for <linux-efi@vger.kernel.org>; Fri, 28 Jun 2024 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719595172;
	bh=BG+1LPgmYdmKGrxt67BBHfB1XlDpPggRfQnlBxc4a1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PWsc7sOAJA0YKk6ov7s//Dk98bDoE73z3DTzjlJ2GrUiqCwTJQm1XsTcdlKDkDLm+
	 p3DN4bWIXzKwCT9/vDNhrZ2/CBcNRUTYPtdjlwJNkPP7DHgnyGZsdaZUfAkPnZQQlB
	 cS8w5+FPi3RSx9WJBz0cpiNiunW49snmAnIA0FGshxQGOiEcIuNxhrRRYGuTCH7cXo
	 E7/ZlrHTywT+H481/JdvgX9IMZ6Fx754RQNxn9J6eBEjZB6tJOSd2e9DFDF9pOfawT
	 JNpTcPaa7NPag45hDbM77afETSi2mzJhrmZtuG5pQWi4gec95PW2RXUNk3TCbVcMMJ
	 9hwm+B/cN+7vw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so11724371fa.2
        for <linux-efi@vger.kernel.org>; Fri, 28 Jun 2024 10:19:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz0amQZT7C7xDUFcamAClnSQ8IsT1A7sin4G3qOABm1Oe35OZAs
	XwI525iPmjB5vzWuk/Qqe0NVfuyQGi0fTR1m+TDtb5yr/a/7SZKyQP56xeCqXgkzyDhlNslVgrJ
	LVoVscUjP4nObrNIBJySXMhdF3cA=
X-Google-Smtp-Source: AGHT+IGqZkBvsG7tcX/bb/kur6muozJY/1cunx/2h9i7WNjCOHvaVYbJzBzb/c9mq2B82PsOP5W7g5YOlkhTSqc2vG4=
X-Received: by 2002:a2e:9dc6:0:b0:2ec:52da:6070 with SMTP id
 38308e7fff4ca-2ec5b357a22mr127579921fa.42.1719595170626; Fri, 28 Jun 2024
 10:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6_Pz5RcQjqur8JTEHcvFxmszE0W-Ptt80fUB5Fbt8oUFUQxkrYweR2p9n9thV9_VPchd0N-zqKlC9DKXf8mNmVtshUQs_VwrV0_UNn_4nSI=@proton.me>
In-Reply-To: <6_Pz5RcQjqur8JTEHcvFxmszE0W-Ptt80fUB5Fbt8oUFUQxkrYweR2p9n9thV9_VPchd0N-zqKlC9DKXf8mNmVtshUQs_VwrV0_UNn_4nSI=@proton.me>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Jun 2024 19:19:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH_4U+jFVpXmoBXFOaV_YEgrZggTEF18s2zTrO=L8j+6w@mail.gmail.com>
Message-ID: <CAMj1kXH_4U+jFVpXmoBXFOaV_YEgrZggTEF18s2zTrO=L8j+6w@mail.gmail.com>
Subject: Re: Regression: drivers/firmware/efi/libstub/zboot.lds DISCARD
To: Tj <tj.iam.tj@proton.me>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jun 2024 at 17:21, Tj <tj.iam.tj@proton.me> wrote:
>
> Commit 5134acb15d9ef27aa2b90aad46d4e89fcef79fdc may be the source of a regression that means aarch64 builds are unbootable when using recent binutils and GNU toolchain.
>
> Originally found in Debian [0] and reported upstream to binutils [1] it isn't entirely clear where the fix should be. The binutils bug report is the current focus on attention.
>
> I found that reverting this DISCARD allows aarch64 kernel to start.
>
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074111
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=31924
>

That commit only affects zboot images, which Debian does not use afaik.

Could you check the kernel .config for CONFIG_EFI_ZBOOT ?

