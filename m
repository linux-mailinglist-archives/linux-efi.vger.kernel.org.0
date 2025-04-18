Return-Path: <linux-efi+bounces-3360-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC2A9339F
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 09:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E32E4666DD
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 07:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8D269CE4;
	Fri, 18 Apr 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwZiS97f"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821620FAB1;
	Fri, 18 Apr 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962122; cv=none; b=CCBTU5xWYQSAloxRP/xIFgaveks9PoQgs+x4FYIT8iV1K1sSe+1x2Hyv+cn7UGJgWZtMzJSMOs6do94OLlPeadegSftFfbd+xkyquuELZT10mXhD+FlWupv2DmRunrWR5TNaRZ6TNJnEBkp6WRmCYUHJVEDWWNwN3tFV6ezerIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962122; c=relaxed/simple;
	bh=oUqXKlSytv6v62jVSSHh1Ufa7g4F58Km2gOwS/yxsOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0oUAu0i5RwsyI9TdIgyPMHve+IreflpG2bFT8pF6mmWPWvR2tyWLGg1IINZGoc4buj54Kro0FT6l40dMaHeE/B0PRjp3ea4zttsVL3HRloC04Me1j4DFhr9E/icrScWlCdax9TuVPl3nc1fIlTn23IHKkL7221H7JR+Fz6D3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwZiS97f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4BFC4CEE2;
	Fri, 18 Apr 2025 07:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744962121;
	bh=oUqXKlSytv6v62jVSSHh1Ufa7g4F58Km2gOwS/yxsOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwZiS97fCQyL2Em6BDKP5hHBpuNlufQyA/G4Sl6ZZQlpoo9lLrDxdI8PdEIhfnDh3
	 mfTRJZzp8wVEGmXVdPNb2Nwhi0fabFFVk1NZyx+izZymjgKh/zs+6/J4oLg4bVNgNJ
	 ituCiz0tIcT+BzoW+TLQKPMlX/5Ablpb0De2ma8Yr+Yy2Reohg7DXK2GYGG48KBmnP
	 lZMl0zZvAjiJBp9BszuxwDw6BumnjCfRkgLq+ZM+o2ANacrXdcjgTAeuxJIUFHBszl
	 zfyiFBl5oILo2IdDXAgTYmUjRlr+AF2mTo9rLbF8hB5YBpS3LoH74nBr5ksCs7o9IV
	 mQeTI8lEAQ0Uw==
Date: Fri, 18 Apr 2025 09:41:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-efi@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
Message-ID: <aAICRcfkBV3tHP-G@gmail.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
 <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com>
 <Z_rQ4eu4LYh6jGzY@gmail.com>
 <CAMj1kXGTP31w7vM+jWqpbJPmoyPU9vqOrmvXsueoPnBin0y_hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGTP31w7vM+jWqpbJPmoyPU9vqOrmvXsueoPnBin0y_hQ@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Sat, 12 Apr 2025 at 22:45, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > On Sat, 12 Apr 2025 at 22:29, tip-bot2 for Ard Biesheuvel
> > > <tip-bot2@linutronix.de> wrote:
> > > >
> > > > The following commit has been merged into the x86/boot branch of tip:
> > > >
> > >
> > > This may be slightly premature. I took some of Tom's code, hence the
> > > co-developed-by, but the should really confirm that what I did is
> > > correct before we queue this up.
> >
> > OK, I've zapped it again, especially as the rest of the series wasn't
> > ready either, please include the latest version of this patch as part
> > of the boot/setup/ series, which hard-relies upon it.
> >
> 
> I have sent out a v4 here [0].
> 
> I am not including it in the next rev of the startup/ refactor series,
> given that this change is a fix that also needs to go to stable.
> Please apply it as a fix and merge back the branch into tip/x86/boot -
> I will rebase the startup/ refactor series on top of that.
> 
> Thanks,
> 
> [0] https://lore.kernel.org/linux-efi/20250417202120.1002102-2-ardb+git@google.com/T/#u

Noted, thanks for the heads up!

	Ingo

