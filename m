Return-Path: <linux-efi+bounces-2812-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE0A3F94D
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33BF19E1507
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2025 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8F1D7E37;
	Fri, 21 Feb 2025 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn/Dd6oF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077241D6DB9;
	Fri, 21 Feb 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152584; cv=none; b=c92k8a6UTdF5THsB2O1ynIu2rnl9bg6/t09tV4WJdKHrb3Afk6F/QFOzfmLLPdUAE401gt6ccFKJkldmQ1l+MnQlx+qYBZKN1u/9Qdsrv1CCA0Gkqc3XhyXBYFLdXJEdPqAFL5nqAOgfunFMfXVPJdpjP777R94o5UbobptZ8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152584; c=relaxed/simple;
	bh=7xi8uvF/5YUSk7sp6b7nIulrDXB9vRthhzIK/7gO8FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlWBBXTCz4iE5tBD0Bcy9kU6jwUq1QFTo4kM7XmdoTPmfksB2Ug+4aIeqSQ29pLtRS3msU5Aip1+AkimOEW+MGWHDn2w4k8aC5VO0ObGLYu2jHTWAU7HO14YFchaB0erA/h5Jhxoe5RaHTRuyChhTZdDh6Jr6Aij/+sCOBlhRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn/Dd6oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E479AC4CED6;
	Fri, 21 Feb 2025 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152583;
	bh=7xi8uvF/5YUSk7sp6b7nIulrDXB9vRthhzIK/7gO8FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jn/Dd6oFEOaOJ5aGccbZTMfv5ZJZogO59bArTHkcRRKFIu2guukvJpxvYGlhtziVm
	 PFVg4P+o9giv/21a9OFpoyYLmpyu2ku8NXIO1ZpVNSJcvPkGLLjwmT2dkSG2wjkufM
	 8KXa7QpqTKEZXAh+OBXi3F6IaSqPnzQF77oh4ygWQvSd8KvAabEUt3L/7k/W/VTzs4
	 HFfdZSSfadFpgpsag8Cww6I8n44QvzgTeM69E/aBU1ENhnyAwB+c32TFyEy4h5ueHl
	 Nrk/fkFfsesf24LQ6KQx3Nla7zQL69wtbZYeHv2FJWSuc1mXm5T0YsLjXnxvSBXBqj
	 0j/ADcH8JUm1Q==
Date: Fri, 21 Feb 2025 16:42:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
Message-ID: <Z7ie-zG0cJFX0MOz@gmail.com>
References: <20250210174941.3251435-9-ardb+git@google.com>
 <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Mon, 10 Feb 2025 at 18:50, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Since commit
> >
> >   a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> >
> > booting via the EFI stub no longer relies on the legacy decompressor,
> > and instead, the kernel proper is decompressed by code executing in the
> > context of the EFI boot services, and subsequently invoked directly.
> >
> > The only remaining dependency is the EFI mixed mode startup code, which
> > makes a detour via the legacy decompressor's 32-bit entrypoint, in order
> > to obtain a 1:1 mapping of memory, which is a prerequisite for 64-bit
> > execution on x86.
> >
> > This detour requires some fiddly setup on the part of the mixed mode
> > startup code, which has to stash the firmware stack pointer and boot
> > arguments in memory, and create a fake struct boot_params to trick the
> > code in startup_32 to behave as intended.
> >
> > This dependency also impedes reuse of the EFI stub code in other
> > contexts, such as generic EFI zboot, which will reuse the EFI stub but
> > not the legacy decompressor.
> >
> > So remove this dependency, by replacing this detour with a minimal
> > reimplementation of the 1:1 mapping code. With some further cleanup
> > applied on top, the line count drops substantially, but without loss of
> > functionality. The resulting code can operate independently from the
> > legacy decompressor, and is therefore moved out of arch/x86/boot/ and
> > into the EFI libstub/ directory.
> >
> > Changes since v1 [0]:
> > - Create new long mode GDT that extends the firmware's 32-bit only GDT
> >   so that preserving/restoring data segment selectors or swapping out
> >   GDTs and IDTs is no longer needed at all.
> > - Rebase onto v6.14-rc1
> >
> > [0] https://lore.kernel.org/all/20250108182218.1453754-8-ardb+git@google.com/
> >
> > Ard Biesheuvel (7):
> >   x86/efistub: Merge PE and handover entrypoints
> >   x86/efi/mixed: Check CPU compatibility without relying on verify_cpu()
> >   x86/efi/mixed: Factor out and clean up long mode entry
> >   x86/efi/mixed: Set up 1:1 mapping of lower 4GiB in the stub
> >   x86/efi/mixed: Remove dependency on legacy startup_32 code
> >   x86/efi/mixed: Simplify and document thunking logic
> >   x86/efi/mixed: Move mixed mode startup code into libstub
> >
> 
> Unless anyone minds, I'd like to queue this up in the EFI tree.
> 
> Boris, Ingo?

Sure!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

