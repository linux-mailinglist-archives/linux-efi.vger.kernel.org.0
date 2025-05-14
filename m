Return-Path: <linux-efi+bounces-3692-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F61AB62DC
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68B91890CC1
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C41E5B68;
	Wed, 14 May 2025 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smzt+dvt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D8101DE;
	Wed, 14 May 2025 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747203637; cv=none; b=Y8/0PD86k2kv0TtDEH+0aX0QVxgiD+yjVmcD2RXZYFs672m21t9CvLHS6El3dSQPEbvU6rYVIQlr3ghzc/6TTI88n9Pb+msFj3NnHXZ0uyfIOQbI0pb3gIC5yy+oeP4PYVSe4L1V9ri5jeQ4ZUJ5VuWJUrA2weuns/CLN7KxTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747203637; c=relaxed/simple;
	bh=PLDqcmSDaOp+qb5YFcXzw305AJnn0Y7PQrpTkMISjZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irk0Lwy1sP0EAQjuqpO1CETT3nooo94+6ff0faX7zKGEbs5I2qhLI0XlsFnRhnBIiwQJcEKz0s8GZ13B0i5pcFsBlGzC8p465gLMCNkt5lYVOCVAoeJBu94S4QxXVTbzp4DaSis3zq7Eg0ur2gxsj7MNTBcvBc6e2+qxrYrkjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smzt+dvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824D1C4CEE9;
	Wed, 14 May 2025 06:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747203636;
	bh=PLDqcmSDaOp+qb5YFcXzw305AJnn0Y7PQrpTkMISjZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Smzt+dvt5tfSuQZPeyZimmhJnl4kz8wzMCP/VrcM8yV1kOtpICNv+vSGHrCiP0N/7
	 Rtg5zRKRVkmTA0/S6ehoAHyOnLbhckgKC1RyRi640gI6epgtHhPlYJFUIasxv5wKTm
	 nV/ZIe/6Rz1AhlXwjihHNnhAnLHjB10+a5urgMK7mxSKqZqWMbbp6FoJzVuIwuL6+l
	 /OexObRYOtaxXSJ0vwIG93MaeuS7XZNiMLRghjBw4GZO3Z3QBHs3lBEOvuJeVKqerQ
	 Lay4nBP4l+9RpqwxSL/SakcroDGwLHtBJWQXkZzOaXHLBU0U5wQl6VDxw4eqjMdpW7
	 zCZX3aQ/nuM0w==
Date: Wed, 14 May 2025 08:20:31 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <aCQ2L3L2DQX80blY@gmail.com>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com>
 <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> > Note that two of those fixes were from Ard who is working on 
> > further robustifying the startup code - a much needed change.
> 
> Please do explain why is it much needed?

See Ard's excellent description:

    https://lore.kernel.org/r/CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com

    This C startup code has been expanding, and in particular, the SEV-SNP
    startup code has been expanding over the past couple of years, and
    grown many of these warts, where the C code needs to use special
    ^^^^^^^^^^^^^^^^^^^^^^^^^^
    annotations or helpers to access global objects.

    Google uses Clang internally, and as expected, it does not behave
    quite like GCC in this regard either. The result is that the SEV-SNP
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    boot tended to break in cryptic ways with Clang built kernels, due to
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    absolute references in the startup code that runs before those
    absolute references are mapped.

    I've done a preliminary pass upstream with RIP_REL_REF() and
    rip_rel_ptr() and the use of the .head.text section for startup code
    to ensure that we detect such issues at build time, and it has already
    resulted in a number of true positives where the code in question
    would have failed at boot time. At this point, I'm not aware of any
    issues caused by absolute references going undetected.

    However, Linus kindly indicated that the resulting diagnostics
    produced by the relocs tool do not meet his high standards, and so I
    proposed another approach, which I am implementing now (see cover
    letter for details). Note that this approach is also much more robust,
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    as annotating things as __head by hand to get it emitted into the
    section to which the diagnostics are applied is obviously not
    foolproof.

    Fixing the existing 5-level paging and kernel mapping code was rather
    straight-forward. However, splitting up the SEV-SNP code has been
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    rather challenging due to the way it was put together, i.e., as a
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    single source file used everywhere, and to which additional
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    functionality has been added piecemeal (i.e., the SVSM support).
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I've highlighted all the robustness problems and design flaws of the 
existing SEV* startup code...

> Really? Much needed huh?

Your failure to follow and understand this series is not an excuse for 
the flippant and condescending tone you are using in your replies ...

Ard is being very generous in his responses, and I'll defer to him as 
to the timing of this series: v6.17 is perfectly fine too.

Thanks,

	Ingo

