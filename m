Return-Path: <linux-efi+bounces-5237-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35568C1D489
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CF4E2A37
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F82EAB6E;
	Wed, 29 Oct 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="No6VOoQq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD923EAA3;
	Wed, 29 Oct 2025 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770928; cv=none; b=cWVuuioM1F1DAjP0NTjNFhwU5Ro1liO3R49g0cJdztG8JmZ7L8yBBnFL9NmUS+G9hEQqCgC2HECGvQ7Ouz1gQ27BJyLL0wBuPv+6YAwiGUDrvBQ734XjUiDHiXewcRzp+6OY+3uZv+q54CBZRN8V00REp4hKxOt56lbN8VKuYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770928; c=relaxed/simple;
	bh=9P+WoI6Mmq2BTFYoAogR3ZGKsNtVyY/N/G04rod5W5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjtZJHpeTO/C6usmzSdiUAmNsnvA8rPJdwmrmSx8VlxGZc6KVTzXa7fJKB2rre2w55Gk1A8WKm4BOrYSDYqOPIzNGi105zATRDfCKlE3eJ7hznyKFa4tfOT6RFGqMz0IaQHptZL5Kv5XeYnOomHKw2z9PRgyJkYKuj9NN6zgYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=No6VOoQq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F3D540E021A;
	Wed, 29 Oct 2025 20:48:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UKakze3Rz98h; Wed, 29 Oct 2025 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761770918; bh=ipq+EFcb+YziU9vD4EE7woJ8Nn+bMhjNmyVrxE6eF7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=No6VOoQq6FYuBQVfO29Nkyh+oZoDxdg27MNyDDvGUTkaA8D7Q2HqpzGSHcufGiuWY
	 rh5lUW1bY3v2ONlZ5cs5ma72fwKfSqY83T101dcuu+xw2JmHfjXAD1zqfpQmqEXdyq
	 eo/gke4F98WDfPZElyakD0CrpPEijs6zXqLnj6NQ3E52j5JyN6R1as3jgT3crA78H8
	 jJvlQefDdmLkucSTj/oF0oU6flpn7UZm29ioybLOUG58+8MZ0GKr6himmex1TlU/NB
	 OUpkSS/EBBmFWzwvclixhQmUnp+ZSPLhmLQzjyI1Vbwz8H0beFOS8xd+/6m1MAyhsb
	 EWc873fH3e27daHAu56Jbkiw1VtCD/GbUcJc5FepEqjYXiKP+4q2vv0poS/3WE8JOS
	 AxDCetKdUmoCTDZvLrFUfroJ6Xr7NoeE5e6CVsO5Izpm+eqIURXHbR03ap8vOxi0lA
	 n3FfWG6Z+vzUg+Npe9S6JzYBP9JkkbnpBTxc85YCHQPDmYx4gcPhs3oUk7VpahNVDa
	 vMmcIF6X9Hf8bzKJoTA8bFmzyYlNZd4f7Pd8Q1pee6ubodxoiFapdSeqh9X3OMKj4e
	 lhsqT1KUVVjfLxANRHoopnZi8Pb5z3SDkLtPVyodC8GxYmFHZrbkx6mCdq2TROjO2D
	 a+MaDex6SZpGbz86CkEa6lS4=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AA6F740E021B;
	Wed, 29 Oct 2025 20:48:20 +0000 (UTC)
Date: Wed, 29 Oct 2025 21:48:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Usama Arif <usamaarif642@gmail.com>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com,
	x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
	nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, kernel-team@meta.com,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH v2 0/2] x86: Fix kexec 5-level to 4-level paging
 transition
Message-ID: <20251029204814.GHaQJ9jhw4u5SU1rNJ@fat_crate.local>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028105637.769470-1-usamaarif642@gmail.com>

On Tue, Oct 28, 2025 at 10:55:55AM +0000, Usama Arif wrote:
> This series addresses critical bugs in the kexec path when transitioning
> from a kernel using 5-level page tables to one using 4-level page tables.

Out of curiosity: what is the real-life use case for this?

Judging by the Reported-by's I guess Meta is doing some kexec-ing into default
kernels which are 4-level so that they can work on any machine ...

Close?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

