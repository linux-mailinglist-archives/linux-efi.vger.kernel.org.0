Return-Path: <linux-efi+bounces-5037-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D0BD9D37
	for <lists+linux-efi@lfdr.de>; Tue, 14 Oct 2025 15:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF0F18A4385
	for <lists+linux-efi@lfdr.de>; Tue, 14 Oct 2025 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A614830F94E;
	Tue, 14 Oct 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RvJH0BSw"
X-Original-To: linux-efi@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960D30C36C;
	Tue, 14 Oct 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450216; cv=none; b=Dbrn781Ya/FmanHT7JbuRpcqQDE46AH1EuPj3IJz8bdxOv9xeBgzmjL3nblab1xRI6YX++GuHndJrcvQvgD7eyu6RTUE+0yCi2yZYHN+jQattLMVcNqJGMUmyiJ+1wFQNLcNoIEz4CyjdM1soTsYcGb1AmWP9NXu+NnhRiIUKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450216; c=relaxed/simple;
	bh=PRqYDMj3V0mpjuoGt3aazHK0eVFqNNCONPDyZsC7524=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EFE4HwSFeS9jENkdI68KoAKsb9kfLyVuaa6hmQSxPSoG/DRS8OUDh03Eg+uqxEntdDy5ovP1s2+zMYyTNUhtAt05juFd4rx5QkILrHZSZs4pa+4Mymt1UWSbYPjy+7dpD23bX195v07Zl45LU4D5scpp+vjqVPztOrUV9FGZGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RvJH0BSw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF8A540B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760450214; bh=PRqYDMj3V0mpjuoGt3aazHK0eVFqNNCONPDyZsC7524=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RvJH0BSwjh/wtqfhQDf0P8XDljS+zuNCsbBIC5CyawwUqzRAbAGVOd7QUlaLqPvDt
	 Oq1Z4K276ZiVoMIbhMHvNt9SXjPQm9X+tS3Q0SsmxDowuoDiRUbqt5+ui8a6wtsaZk
	 KrnFjtyGAe9gtG55X8EeGkUAJc6wwT6iTFPF3OpWP0XpCuzawcJAbGM7qSR/7tcOER
	 YR6PviAGMl9tYt6OthIITDZnIoSxEK3kcy8Fy7LFhrg/QNxAEqnaNb8ozO2HjeXWaD
	 9jT3T5rLrZtaJ1ctR+4HRBqZtisbD/YvGpn0prCNWsEeVrgmLRNEKjjGbtpDvnXTf1
	 0MN8S3y4G4Arw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DF8A540B21;
	Tue, 14 Oct 2025 13:56:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Hugo Osvaldo
 Barrera <hugo@whynothugo.nl>
Subject: Re: [PATCH v3] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
In-Reply-To: <20251013085718.27085-1-bagasdotme@gmail.com>
References: <20251013085718.27085-1-bagasdotme@gmail.com>
Date: Tue, 14 Oct 2025 07:56:53 -0600
Message-ID: <87jz0xd1sq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>
> Since the Handover Protocol was deprecated, the recommended approach is
> to provide an initrd using a UEFI boot service with the
> LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
> approach has been no more than an admonition with a link to an existing
> implementation.
>
> Provide a short explanation of this functionality, to ease future
> implementations without having to reverse engineer existing ones.
>
> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
> [Bagas: Don't use :ref: link to EFI stub documentation and refer to
> OVMF/edk2 implementation]
> Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> No changes since v2 [1].

Applied, thanks.

jon

