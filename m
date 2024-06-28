Return-Path: <linux-efi+bounces-1314-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD8D91C547
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 19:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42BA1F24FC4
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DDB4CB37;
	Fri, 28 Jun 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GQWmfHJf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8BEB645
	for <linux-efi@vger.kernel.org>; Fri, 28 Jun 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597575; cv=none; b=D8aXHpSYBujwC7pBDmnnSSnnXJ+hKaeUYUJtFrZQQlnoGbH/P9V6aBVh0X8XwB2zHr9Cp9tBsOMxnz92cR+NI9ll0CgdKN8N3oEs+2/HoyZZ2rm9ASg7BIo35J3LJh7eNieY+I4EvSgKWAuugzD8ReEe8fgGiUfolycCd9fFr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597575; c=relaxed/simple;
	bh=tTLRieckeyxYVGOVh/03e914DI5l/pZBDdVDGkM/k/4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz2xy1O6qdXv7t8JzN4EHkngIymgPlMwHarjO9V2KcPew8PBy74Tba/ro1fmujZT5I10v7LjYaQthr5OvA78XgZTGsJQ7RpokfGJpLT5G2DyIOTK/QCTctm9gVu5zTUH6GI5a3+X6jxrqgplRv7U7r4Z6TinL5NSXWfHHmDjYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GQWmfHJf; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1719597565; x=1719856765;
	bh=tTLRieckeyxYVGOVh/03e914DI5l/pZBDdVDGkM/k/4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GQWmfHJfuLULricDPOre1cZwT8woMO0Uz7XYgQKk7Fjco4AHm5t7Gy+0NL1uOoAcK
	 JTFHiRAYDYO8lUU2+T8xEpbck82Ud/QnYK6pYGzX8yWWTQkHnqYyDoTPQvTLEmc2qg
	 Vu600R5u2bU6e4LEZgOt5cDXlkGaJpmnyySM5m+YN1uXoVE/pwnj2r+6rCuGTDpCR3
	 k1Vjkrt75c0tYY+WrpOHFFe+49bhkNCxQSDrLu7YKKQWIKF/aHMWHPEg74hiRDvYFb
	 2E00XMd8P4VIg7YfBLVn0MHCYHNduiP3g9PIwWxnjgNAYESzNerDfsIqhThLqkassX
	 tIBoOTkj6twqQ==
Date: Fri, 28 Jun 2024 17:59:22 +0000
To: Ard Biesheuvel <ardb@kernel.org>
From: Tj <tj.iam.tj@proton.me>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: Regression: drivers/firmware/efi/libstub/zboot.lds DISCARD
Message-ID: <8VJ2jEkhpuJK8NuCSjaEEF6UzSnKlMNJlaJRjAXsuNe58zjkjcfRd5LAA0siGO18Eg2ljPEBduEjgRNr1YF9mS9rY2Du_caKNaCFzQ9B7g8=@proton.me>
In-Reply-To: <CAMj1kXH_4U+jFVpXmoBXFOaV_YEgrZggTEF18s2zTrO=L8j+6w@mail.gmail.com>
References: <6_Pz5RcQjqur8JTEHcvFxmszE0W-Ptt80fUB5Fbt8oUFUQxkrYweR2p9n9thV9_VPchd0N-zqKlC9DKXf8mNmVtshUQs_VwrV0_UNn_4nSI=@proton.me> <CAMj1kXH_4U+jFVpXmoBXFOaV_YEgrZggTEF18s2zTrO=L8j+6w@mail.gmail.com>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 6c5bb5269222e5bd0e3c42681e460d64e29978b3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> That commit only affects zboot images, which Debian does not use afaik.
>=20
> Could you check the kernel .config for CONFIG_EFI_ZBOOT ?

Indeed, on checking the configs it isn't set so now I'm puzzled as to how t=
he build succeeded! I'll leave it for now since it looks like you're on thi=
s in the binutils bug with a proper fix.

