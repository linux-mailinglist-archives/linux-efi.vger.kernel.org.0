Return-Path: <linux-efi+bounces-3695-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F399AB65A2
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABB54602B3
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07321C197;
	Wed, 14 May 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TXlMDxp0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D654C6C;
	Wed, 14 May 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210645; cv=none; b=WTWUAmfELpGstRkAAJbC3wY+2w64enm6Ho7iqwMiO3RuHfaM+AZLWwA/1aZpN6nsjM10boDs03tTl8Sfl0OcYlOA9kZhDyXdD4nW8V1XQEPp3FEDv22+9Nao70u1Ky2PEQl6xT0QsbyQExqTV9VQ/ixZNQIDmAPXlAcX5IHqZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210645; c=relaxed/simple;
	bh=5AoP0C45Rujt2/qmyP1ByxUZYaf/jnuzWCg4Vm2Q7qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFBvxoKudLHzhUqqCPJVhB/4cysjdW1FNMmeEQC2yMKZdjSJWuwEuJPQ5tuYtBL5aFvWL5MT5AVYrI+tRT8kidp2kJZSZKpY24wvlPR2IJxUVcGE92qqjhevPyHQQ66yIuVxzldzLBkmeFQjduaAzR1D2sWnj6Ov83WsoxT55PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TXlMDxp0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1577E40E0266;
	Wed, 14 May 2025 08:17:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WoSoz4lF6Fqx; Wed, 14 May 2025 08:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747210637; bh=zt66luONkXkTmFTbUwrKTLRryiIVYQEFM3dwgSKR15Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXlMDxp0xyXwRgGDj1jUhLnT/x4p/H8WCQotvm5GSyaLEZ8divHZuVZNNi109MX9s
	 ExFsQM5OeN9nIZsVavPma4HO3WZVeHbMuvhayRFygXTfBQu0KddoZD49X2AdKiI8Tn
	 tZTNm8FHJFwB8odaCxHb6S+/D6PXwA5dHIY36++OIj24ko8GUX0BV+B9don/4HVctD
	 FvfNF5C73EoX/nYqu/f7YSKFUF+LbK5tcojVB6PGkuYIIZmT+P7PIdkKZL8VD1/qqt
	 y2x+/VvdD0Zaq+UkW4qgdsRq4RGDBEw7CoOFaOzhxAAPPyBvaUNYuYSJoynEZwsoSF
	 1NmVgZFgTc+AGx9/+Quv/LS8bxJ4LCbVq45AkM/ZdZjg5STUMaGo1IO/h+cd2ZHEhW
	 Piu7pFvpQ0/nWc66o/SL2glISqq3Is6t6CRiZBGvcXieMWKeGET5IMRp/Jho5oNAkq
	 jJj50qE2GnAetdQBjkYalnsaSjAvfcgJCm3Dt2x2cxHFTHj/SD4mZtIABkAQqYF+WQ
	 ysg2LeTIbC0O82IBaORSOhc+mNwNAUOWt1U6EoKe6Cg5ARGsooRkRH1WWFB/aZWeXF
	 yubYpSrFAC7/Xdos1HaqalbikqZHKDOh2wW/ir2vOu6+Ts0fusQBxsmu/UYKtEiCUK
	 pGuy2aeaeRTxKNtboRYefJYk=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA0EB40E0239;
	Wed, 14 May 2025 08:17:06 +0000 (UTC)
Date: Wed, 14 May 2025 10:17:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250514081706.GBaCRRguKiuyx3gcd4@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com>
 <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
 <aCQ2L3L2DQX80blY@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCQ2L3L2DQX80blY@gmail.com>

On Wed, May 14, 2025 at 08:20:31AM +0200, Ingo Molnar wrote:
> I've highlighted all the robustness problems and design flaws of the 
> existing SEV* startup code...

You can highlight all you want - nothing warrants rushing those in without
testing. Period. No matter how much you try to spin it and flip it.

> Your failure to follow and understand this series is not an excuse for 
> the flippant and condescending tone you are using in your replies ...

You must be confusing me with someone else to constantly give me that
condescending schoolteacher tone.

If you do shit like you do, you will get called on it until you behave
according to the rules we all have agreed upon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

