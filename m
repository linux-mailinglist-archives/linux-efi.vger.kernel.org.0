Return-Path: <linux-efi+bounces-3697-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8DAB6819
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259928C0BB4
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9725DAF7;
	Wed, 14 May 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xbpj4WNr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALLJSQ8l"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA525F97E;
	Wed, 14 May 2025 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216449; cv=none; b=YsOz2f/+k+AgP7Uf85qKzYoWS51OMMpXUHuoBI4HERVRNO4tsv3+0Zq0To5HKxLISy6VjV9BSmNDMWCqeR22goU+z6l7EE6vC+4KDQMB0RYJIxie7n+0y4ROND03FOZe5kt7tqkuSB/uDWdL+wBcmMCTqdvAEdNk/nJ1faQdGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216449; c=relaxed/simple;
	bh=ni2ujCUUK50+l/mp77F0X4asQYcKuGwv6DTb3CRLaJY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=NuS8Dvh7rPrk/WEBDWkoSLn4SfXzdhFa8hKB0PIzgDVLacKf5vw97cMl6yGYWyud1CG18QNWVtIqdsArKy/ASTyRawViEVhQ7Xbs1Itga02EyFb1ikLbCELVAm2qDRZAk/6uKi1/BREyxnPYJq2C06ba1zD5mnt8Kc7xOeECsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xbpj4WNr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALLJSQ8l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747216446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=szSON8XluKV7feOkhHdeIpICpw90RUfpg2AC3qITLPc=;
	b=Xbpj4WNrmUUlf8f9j3pDZfl/IK7LUIcrS/+sQNbu4cNESLSXJWFzg4yMBsRkw/Lex8GFrF
	hBP96sr6dPKqCRszB5XGlYpCTPraTuR/d6jQDqxaHtzcBdnNiNSqe9u9gJe3LlsZlCKHBc
	4uqWqBSE4rO+JYAyr7eQGuAKzS3pccsZ8GftkCQI8tuBu+G9WagIPKvaKYrv7EoklgbzQ1
	rLJYtFQlJLOy0EQWoT7xMEArz9LoTRNGWKb9khUn9J2kNlxdHSdfWARaXGbWVHnNGM5aH2
	5lLOT/MnU8j4yiWoWjPO/DtyssNgKhwVxAmF9K1wVH67rIp51xqFGwhH6SxmxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747216446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=szSON8XluKV7feOkhHdeIpICpw90RUfpg2AC3qITLPc=;
	b=ALLJSQ8leMe1/tQ4Dd7Mn7t0DiheU/4uTATtLwTnl/YC49mX8a0rcry0Dw7K7p49Jod99a
	V2iKraO90UOE1sBw==
To: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, x86@kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin
 Loughlin <kevinloughlin@google.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
In-Reply-To: <aCQ2L3L2DQX80blY@gmail.com>
Date: Wed, 14 May 2025 11:54:06 +0200
Message-ID: <87wmajikld.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ingo!

On Wed, May 14 2025 at 08:20, Ingo Molnar wrote:
> * Borislav Petkov <bp@alien8.de> wrote:
> Your failure to follow and understand this series is not an excuse for 
> the flippant and condescending tone you are using in your replies ...

Can you please stop right there?

I've been observing this for a while now and to be blatantly honest,
_you_ are the one who is constantly failing to work in a team and _you_
are the one who acts like a 19'th century school master.

Your outbreaks of showing up and applying random patches fresh from the
press, your absolute refusal to slow down when asked for, is annoying as
hell to everyone working in and against the tip tree.

You can do whatever you want on your private mingo/*.git branches, but
this frenzy of shoving crap into tip has to stop once and forever.

Borislav, Dave and Peter are doing a great job in taming the influx and
reviewing the patch firehose, but there are limitations on bandwidth and
you cannot demand that everyone drops everything just because you
declare that a particular patch series is the most important thing since
the invention of sliced bread.

You are not the one setting the rules of how the tip team works together
and if you can't agree with the rest of the team, then either we all sit
together and hash it out or you step back.

Continuing this sh*tshow, which is going on for way too long now (hint:
years), is not an option at all.

Thanks,

        Thomas

