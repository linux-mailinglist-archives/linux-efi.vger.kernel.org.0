Return-Path: <linux-efi+bounces-3549-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950B4AA848D
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E56E1899560
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1D633E4;
	Sun,  4 May 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqvLml9G"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B501382;
	Sun,  4 May 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746344320; cv=none; b=fuWE9z73g7gKwZCUOynP/1vEMsIuoA8sx5VAgD/P0C5tcvHbaUn1ZK/bLDvcZGPqivwzu3CDrlv24szFFWmaHepekfyv+0mJ6YrXaETdolderj40ABJM2F+2EzdURkVoOqqnKxtggZ2nCABlQ6IgtO723tSSwnF0TuNxV6bkzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746344320; c=relaxed/simple;
	bh=Pb8UY72ziA2OKScLOhdBxtD6WvfLEX6DP0wbLPqS/pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A26ftPVTOfHAkM2nfMUVEEahdOdi8OYycW2eKDho1/FV+J2VChPVsWxb5aJEHTkYwu5V/TmQ9vUOdP5dn9OZKF90ER381HrIkwioYDhFmrGePHo38RfLwvtxvCEcX80FSRs7dmMZrsZVL44CoQoQHPXpOQp+n40OLt4pQahEqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqvLml9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D9C4CEE7;
	Sun,  4 May 2025 07:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746344319;
	bh=Pb8UY72ziA2OKScLOhdBxtD6WvfLEX6DP0wbLPqS/pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqvLml9GZAj0iEOLlt961lk9APUHXNa03H9+TGTzWjLN42h7Q+9iNKYsEROup85t1
	 3kdP2ylTbFC8F5vtdNeDvidBtCejuD8DXiayRhlHck3Yi+4+K/DLhCgeZ5KzIG6YS/
	 oPjUHUYVyDWtTIUqmQg5Auc2i0UINMyOHpxgZxk08wIoRLLz8ULXHp7pq+RhEm0fw/
	 MAPejGKxabfq/aThqlikiGRLB31PDdKyRDoghzTGi/gt+n+8lE1GH0E1cWVLFpTaZP
	 9GVftFULCE+3Hx4p0crq118a5JZfCihYJFMRys8jIcu3Il0pSwtsNBQVhY8fwwtFnF
	 K9o2gntXQsVQQ==
Date: Sun, 4 May 2025 09:38:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/sev: Support memory acceptance in the EFI stub
 under SVSM
Message-ID: <aBcZe1amYvqslhvA@gmail.com>
References: <20250428174322.2780170-2-ardb+git@google.com>
 <0ad5e887-e0f3-6c75-4049-fd728267d9c0@amd.com>
 <CAMj1kXE7=u9xNcUHiyFVPbOpwPvntFjdLfTzD0LeD_7it2MEQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE7=u9xNcUHiyFVPbOpwPvntFjdLfTzD0LeD_7it2MEQg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Thu, 1 May 2025 at 20:05, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 4/28/25 12:43, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Commit
> > >
> > >   d54d610243a4 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")
> > >
> > > provided a fix for SEV-SNP memory acceptance from the EFI stub when
> > > running at VMPL #0. However, that fix was insufficient for SVSM SEV-SNP
> > > guests running at VMPL >0, as those rely on a SVSM calling area, which
> > > is a shared buffer whose address is programmed into a SEV-SNP MSR, and
> > > the SEV init code that sets up this calling area executes much later
> > > during the boot.
> > >
> > > Given that booting via the EFI stub at VMPL >0 implies that the firmware
> > > has configured this calling area already, reuse it for performing memory
> > > acceptance in the EFI stub.
> >
> > This looks to be working for SNP guest boot and kexec. SNP guest boot with
> > an SVSM is also working, but kexec isn't. But the kexec failure of an SVSM
> > SNP guest is unrelated to this patch, I'll send a fix for that separately.
> >
> 
> Thanks for confirming.
> 
> Ingo, Boris, can we get this queued as a fix, please, and merge it
> back into x86/boot as was done before?

Just to clarify, memory acceptance trough the EFI stub from VMPL >0 
SEV-SNP guests was broken last summer via fcd042e86422, and it hasn't 
worked since then?

Thanks,

	Ingo

