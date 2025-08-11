Return-Path: <linux-efi+bounces-4533-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C2B20031
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 09:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37371896A29
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD61EDA0B;
	Mon, 11 Aug 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NFxPYGqX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27E2D9797;
	Mon, 11 Aug 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896839; cv=none; b=PLJNCmKdBb36w1KAkivSqnydOZZSWTjtYy07vIpaV/2rx9bmYnrI1fV54j5hjtgEDdj2wI2Ey09kkI7S4PamYnWa1nDne/jFnlMNXLwfqw8ZPmscKJgeAz537Xf19EyTxZRytc+oyus1YEevfpvxScCNlZJg41X8OQ2ogaxfu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896839; c=relaxed/simple;
	bh=blfiziKo1X0XrXzbQBFXLIUg7D1um0kcJZQUsZm+gA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5t7Gcdi/2ZTO4fte4851wIVqwYVSpVDkAg0jsAuhaaqF22769RQVlRNePiupD8LM3K3czfxs1ANRRIMXwWzuz1fFTd3PJcIK7zXO/Dr+vh4Spf6Pmn7adYO69vGtMZD4IuH4/WHoDcgfuEJKzMN8xAsLTK6Mv+yGihkC84SHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NFxPYGqX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C1D7C40E0265;
	Mon, 11 Aug 2025 07:20:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SCieU36BNNGn; Mon, 11 Aug 2025 07:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754896831; bh=S+/fgZGLgbYCYioXxF+vG/zPq2/3vsDDa+3gaqsIl9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFxPYGqXn5phiwrwnAoHv5/jX8lRmMES/vire6JbR3+w9ES/lZJjYf0js/Jt3pkzn
	 l1NLPp7dsB8MreTIA+5+pZFlIMkpozYd7MorxIafpAi517vl9UzMjk9q5O7UbTEDf/
	 0u44tp+XrsrANe3SMLPxBE75dNIuDpZukPj0ypjljr0tfeiNCNM9+DpQblcMnt59hM
	 MkP795mUx+4QXZZNLnEnIsFmY8BldBdV/T51uSDyvOQBm9rEEX1OM5+za9598bMRic
	 pIVwt8/ThqeB6zLK6mf3y0vJZGZP0J0l9ySOc4pDEpRsiFtk6AhiZ86S3ZlzoJhyLt
	 hqHGUKmJsBLjZZiwRMG9bbcWu3d8RmzlNkSqf8tXUnY43yvUAotn7mNEDTYbaGQnJY
	 dTaOqefeG5ShmhPw5g9zhMaXdAJIwdrig8aOOPLPMZ4J9ch+8QaBu8fa6Ky71TDFAT
	 rWkN43THwuTBo0eEPkbOLzwXtOd3kfhZxYgOgR18dz1C8RzZukO2gLdoW0A2hiexFE
	 KEagHgEgvYVn4R/+9N5E66tGj/+7F9IgfTBAwOoIFxX5RDMAOO5j6w0tExGujkvLQN
	 sitTZpuPLqd4iZusXesKrouNzvBxz1Zty9KKxIsorD59eCH9w3Pt173+Y8hPxfAUsr
	 eEe7nSdzuJ765WMjEsyTOD7Q=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5039C40E01FD;
	Mon, 11 Aug 2025 07:20:20 +0000 (UTC)
Date: Mon, 11 Aug 2025 09:20:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v6 15/22] objtool: Add action to check for absence of
 absolute relocations
Message-ID: <20250811072013.GNaJmZrWDWsZQY_Eig@fat_crate.local>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-39-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722072708.2079165-39-ardb+git@google.com>

On Tue, Jul 22, 2025 at 09:27:24AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The x86 startup code must not use absolute references to code or data,
> as it executes before the kernel virtual mapping is up.
> 
> Add an action to objtool to check all allocatable sections (with the
> exception of __patchable_function_entries, which uses absolute
> references for nebulous reasons) and raise an error if any absolute
> references are found.
> 
> Note that debug sections typically contain lots of absolute references
> too, but those are not allocatable so they will be ignored.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  tools/objtool/arch/x86/decode.c         | 12 ++++++
>  tools/objtool/builtin-check.c           |  2 +
>  tools/objtool/check.c                   | 44 ++++++++++++++++++++
>  tools/objtool/include/objtool/arch.h    |  1 +
>  tools/objtool/include/objtool/builtin.h |  1 +
>  5 files changed, 60 insertions(+)

Looks ok to me.

Peter, Josh?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

