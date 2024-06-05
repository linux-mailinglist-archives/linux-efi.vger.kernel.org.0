Return-Path: <linux-efi+bounces-1171-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35DD8FC349
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABAC2826D7
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 06:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAB13A407;
	Wed,  5 Jun 2024 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3OT5zo/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE430225D9
	for <linux-efi@vger.kernel.org>; Wed,  5 Jun 2024 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717567581; cv=none; b=Jq2FbzWXGTpSY3s6m1Gv7xs/TslaEMdczez8xKoyTY9dk8ucVe+XHi9FKHUNzCCSJGUNCcuN31V2xWStKGO6XeOX7m3KJIObHX5fRpNxYcpo5GptK9mtCKIzCcPCds8/dD7jsRNAb1DllDnHrv/lQErnSq+lX+VlfwP1q/Giz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717567581; c=relaxed/simple;
	bh=BiSmwTrxWLxh5h085WZkpSdwLH7oF+jc68zVLnIv38k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxn786UOAbjrmybW0cXQVwGfQuoA0ooMeSizDYeelAh694DAJ7k1yDyxyPhZls4YITHdQ7/5dObVlbxqR5fmR+MWMuA6ZuM8hJqHpq8JYl8xMtsK1XQVwYjcJhm5w0zfjfinPzmKu22w3lgBV5QftXuoKGDxlrRSJw7Wz9rWSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3OT5zo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD84FC32781;
	Wed,  5 Jun 2024 06:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717567580;
	bh=BiSmwTrxWLxh5h085WZkpSdwLH7oF+jc68zVLnIv38k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3OT5zo/1ffkaHL9+lrDiZqKmTd6L5CuG1M8+/lXQKBpZeN8hZrmiOnk4Breo3bHY
	 ye4LJIqAXkR1YMHEZAT+y5Bo5KI1SHhSvWjWdxRGiwOFtxgZN+Q2mQHvrpnh7z5aZy
	 IadnUFaE4rSsZNG6Cr1s3NCtWKHqRFBsqnCAL6m0g1LJtTfuHGBcb+wpyijQiR3NwU
	 psu4P1RMkshzOU/lBmhY71p2st8tvjVHzHnIl2YqLn1nqtwaOyM36K6xUfOZ9vpGcE
	 7ig02PraomFtOiC8fbBXMRXfgI2qIGG1E4OJ5GQq/nwdcrZ6BJPUwoVP+RWFGARjDK
	 qiwdVPURFQAdg==
Date: Tue, 4 Jun 2024 23:06:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] efi: Add missing __nocfi annotations to runtime wrappers
Message-ID: <20240605060618.GB279426@thelio-3990X>
References: <20240604155625.2197275-2-ardb+git@google.com>
 <CACRpkdZ=-OMFD0d25m_YBjo+Wt-Ca7mjSNphgSA+2avxkcDYBA@mail.gmail.com>
 <CAMj1kXHZ=tchvZ7qmJiE2ajU2nbzkcMnbviyhZeug58wMWzNUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHZ=tchvZ7qmJiE2ajU2nbzkcMnbviyhZeug58wMWzNUw@mail.gmail.com>

On Tue, Jun 04, 2024 at 11:26:51PM +0200, Ard Biesheuvel wrote:
> On Tue, 4 Jun 2024 at 23:05, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Tue, Jun 4, 2024 at 5:56 PM Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The EFI runtime wrappers are a sandbox for calling into EFI runtime
> > > services, which are invoked using indirect calls. When running with kCFI
> > > enabled, the compiler will require the target of any indirect call to be
> > > type annotated.
> > >
> > > Given that the EFI runtime services prototypes and calling convention
> > > are governed by the EFI spec, not the Linux kernel, adding such type
> > > annotations for firmware routines is infeasible, and so the compiler
> > > must be informed that prototype validation should be omitted.
> > >
> > > Add the __nocfi annotation at the appropriate places in the EFI runtime
> > > wrapper code to achieve this.
> > >
> > > Note that this currently only affects 32-bit ARM, given that other
> > > architectures that support both kCFI and EFI use an asm wrapper to call
> > > EFI runtime services, and this hides the indirect call from the
> > > compiler.
> > >
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Thanks for looking into this Ard!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Maybe tag on:
> > Fixes: 1a4fec49efe5 ("ARM: 9392/2: Support CLANG CFI")
> >
> > So it goes into the v6.10-rc:s.
> >
> 
> Thanks, I've added these and pushed the result to efi/urgent.

You don't need to rebase to include it but just for the record, I tested
it as well and it resolves the crash I saw when booting under EFI in
QEMU with CONFIG_CFI_CLANG=y.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan

