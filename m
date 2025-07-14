Return-Path: <linux-efi+bounces-4337-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177C0B0403D
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 15:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751003A2EE4
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEC524E4C6;
	Mon, 14 Jul 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Zs7/Urma"
X-Original-To: linux-efi@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46319AD48;
	Mon, 14 Jul 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500189; cv=none; b=pWVkWj3rh6eC7yhK12Jl12esVaB09vdieImj6XEOBjJRTk4sCRX0DLN13Q8nFerIHhXLRaTsjJdI1deGxb06yXDwubInUi10kOj+zIEYoKrC3OzSBDMqUdNBmWLesdyituBvardqkGX8pU61ib0i3NxTvEqbvpoAVZoSgL32eAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500189; c=relaxed/simple;
	bh=ybgRCZHZ0CuPfC6wWoHh7yHJQJ+KcmfY2gHP3n9Z9wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GyWpcgPPy596xc0C37b1RoobkG40c/HYx3rkaAmJdpepgZ2+ZKuEdyY7H8EtO88tmC8fmc9y85lCNPV7l0Qi2Oi6uNlC74eZzYIil6d3CCl/KTSAU7/to/N0QfSOiKvXnv7LxF/tPRRNoqfVWv389YHQzFp44PRFzww8Gzgf09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Zs7/Urma; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5E6C04040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752500181; bh=ybgRCZHZ0CuPfC6wWoHh7yHJQJ+KcmfY2gHP3n9Z9wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Zs7/UrmaekvQ8ORByhFhCX15B+mvD0Zkt/8yqcr5xm8GAsw7OPlqdSDgcode73TTI
	 dRuUBo129gg2JrgIIhdYQ+Y+ol0nDKh2/A+RqVdYlF6miKu9fX3HWgCMJEAR1PrlCO
	 rrj6xYCjRmHbuBSaKL7nssGG1f3X4y8oB6q3zvFsoXIro4/tlpuoDUCJ8iNEpTa2Bc
	 vqUuwTHVB+qxcrMu1zT8ZL5nfOK8NI69RDbxoWRSwbkS8nly1MgQ2leZlAZwatm5Pl
	 JJbzcphhvdPzlD6zsXL9PwgJrbhFWLU9iar8eoFEcSsvyGkEyNyr/1iX4P7Ijc+a8x
	 kuMrpJg+6DdXQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5E6C04040B;
	Mon, 14 Jul 2025 13:36:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ard Biesheuvel <ardb@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-efi@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: add API doc entry for ovmf_debug_log
In-Reply-To: <CAMj1kXEsERVQgm2PF4npmeKg_tM2-ivFXwFObQzddxMaU5HMyg@mail.gmail.com>
References: <20250711054446.1537700-1-kraxel@redhat.com>
 <CAMj1kXEsERVQgm2PF4npmeKg_tM2-ivFXwFObQzddxMaU5HMyg@mail.gmail.com>
Date: Mon, 14 Jul 2025 07:36:20 -0600
Message-ID: <87cya2j3mz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> (cc Jon and linux-doc)
>
> On Fri, 11 Jul 2025 at 17:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Thanks. I'll queue this up in the EFI tree unless Jon prefers to take it.

I've not seen it until now ... Fine with me if you just take it.

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon

