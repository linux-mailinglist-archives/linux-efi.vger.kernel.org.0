Return-Path: <linux-efi+bounces-1563-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BEB95A011
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2024 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF031F216F5
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F871B2504;
	Wed, 21 Aug 2024 14:37:32 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D491B250C;
	Wed, 21 Aug 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251052; cv=none; b=elPhtbll+90MUQioxckemg6JoY4jgEqiVs9ZN0FhSdpA0aPHoL94JDNoEsd89J72OqC05DbjyG/konqoQyrHNf2mkuTxAifumHPDTNCfTQjrzAu3afkQYXnCNNZlfynx2UGQn+c4ey6yI6M+fRdpDL92oAGRl4qps1fwwT9Ke8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251052; c=relaxed/simple;
	bh=Q9BEJeSBoIEjJQNbYz7heGvctum7v0MDA7rn4un73sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqicAXhztcxrcrCNVBkpm7+xso+XA1RUYYt+18H7g29utWikJNF+Jg2p3iQHpMOEscwshdja7ZWJV78jbOLhQxCEzDDAzlLDRNMxwrZKB6GKXJ4E+vq1JRW3Z1WG2ZkJCauY9KvNaXLu5BbEWPLa2Dx8Cqw7zyqnZKxscWiobRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 953C4E80807;
	Wed, 21 Aug 2024 16:27:13 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id CE5BD16008A; Wed, 21 Aug 2024 16:27:12 +0200 (CEST)
Date: Wed, 21 Aug 2024 16:27:12 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <ZsX5QNie3pzocSfT@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>

On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:

> *** Background ***
>
> As more PE format kernel images are introduced, it post challenge to kexec to
> cope with the new format.
>
> In my attempt to add support for arm64 zboot image in the kernel [1],
> Ard suggested using an emulator to tackle this issue.  Last year, when
> Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> emulator approach again [3]

Hmm, systemd's systemd-stub code tries to load certain "side-car"
files placed next to the UKI, via the UEFI file system APIs. What's
your intention with the UEFI emulator regarding that? The sidecars are
somewhat important, because that's how we parameterize otherwise
strictly sealed, immutable UKIs.

Hence, what's the story there? implement some form of fs driver (for
what fs precisely?) in the emulator too?

And regarding tpm? tpms require drivers and i guess at the moment uefi
emulator would run those aren't available anymore? but we really
should do a separator measurement then. (also there needs to be some
way to pass over measurement log of that measurement?)

Lennart

--
Lennart Poettering, Berlin

