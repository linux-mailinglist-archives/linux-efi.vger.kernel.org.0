Return-Path: <linux-efi+bounces-5678-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A3C830AF
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 02:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA64E2AFE
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8172481B1;
	Tue, 25 Nov 2025 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+XiJM7V"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A40A95E;
	Tue, 25 Nov 2025 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035375; cv=none; b=p0HcxMh08lo8+AAD4VgnVtV8YfTKNgZoU9vTInq7JzAX2FC/+oW8L+EVp8ekB8DCw1o26xwYdzuSaJiY5V6KKGlejFX0m0vjnFKGlCm7Ux994rd/4szBW7aKllPIc00EO9BWfnc48aenRwql6PzncTCQ3rX6d9arWKiphbws39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035375; c=relaxed/simple;
	bh=UFH2/+azJV59ltuzGJVPHH4dKdyAhCIy5D5qLcxTlMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecZsWiTwwEOE0ppfoK0pYhWJRDvXYxai+1BmAmaqGp0ZslyjvjQJ2yb962l2+luzEoJu5qhvzvvLkxG1fynfoQEanxl6qsjhSTxQ6R5cAzHaqfz0jy5BrkNSZkPd2VKjClwDhz+2uT9TNFEo+vrxlWBSXpPDhOmVWWqwulFxwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+XiJM7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDEFC4CEF1;
	Tue, 25 Nov 2025 01:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764035375;
	bh=UFH2/+azJV59ltuzGJVPHH4dKdyAhCIy5D5qLcxTlMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+XiJM7VwSKsLWHvLu1Rdz9qkvR5i2wZV7QWqXHgrLB3V9jaVw5nh8EeLnLJFzz6s
	 t4W3teADt1DPjf21Vbjj690WoOEySUaVFI4eWSwcuJBIVmIk8Owtnwx5FOxJKvN9z0
	 IVuL1BdHhysWf/tUBDL3GaWYoNOF67/5AxrRFV8g0gdUhkP5db02pfTXCzhnSUbQnR
	 ATYlERHg6Bp3GHLTJeBGvL7NA90zQ/Mjw6UlkvFNvng9k3N0aYvEN8upkusc0o7UH9
	 ypMcKtE96mAPW+H7Pr9wxtnMjY1JqtNNqjWyrCIyoaFT/Nw5eRcLm9D2UJBfwdpDsu
	 EcxAsQdEzpP5g==
Date: Mon, 24 Nov 2025 17:49:30 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Message-ID: <pgzg3tdudow4ww3tnqdvmppufbpbf6ws5adjjcwc7g3ou7yoih@mzk7iwh7trbe>
References: <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
 <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn>
 <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
 <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii>
 <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com>
 <aRsH7RTpAah4g5Xr@willie-the-truck>
 <CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com>
 <39617a3e-c476-abac-8425-bbcece769cdb@loongson.cn>
 <CAAhV-H4fHBuRpDEDQrExApgnREJaT8JWUJ2700bEPFxDqToi2w@mail.gmail.com>
 <fc4fa66f-15a0-ebe3-0a27-f3f38b03bbdb@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc4fa66f-15a0-ebe3-0a27-f3f38b03bbdb@loongson.cn>

On Sun, Nov 23, 2025 at 11:37:14AM +0800, Tiezhu Yang wrote:
> On 11/23/25 10:29, Huacai Chen wrote:
> > Is it possible to improve objtool that can handle indirect __noreturn functions?

Someday that will be possible via a new compiler feature or plugin.  But
today it can't be done.

> > Is it possible to improve objtool that can handle
> > OBJECT_FILES_NON_STANDARD event LTO is enabled?

No, that is purely a makefile construct which should in general be
avoided anyway for a variety of reasons.

> > Is it possible to improve objtool that only ignore __efistub prefix
> > for LoongArch?
> [...]
> static int validate_branch()
> {
> ...
> 			if (arch_is_efistub(func))
> 				return 0;
> 
> 			if (file->ignore_unreachables)
> 				return 0;
> 
> 			WARN("%s() falls through to next function %s()",
> 			     func->name, insn_func(insn)->name);
> 			func->warned = 1;
> 
> 			return 1;
> ...
> }

That only silences the warning, it doesn't prevent objtool from doing
the actual stack validation or ORC generation.  Neither of which makes
sense for libstub.

And objtool has many other features beyond just stack validation and
ORC.  None of those make sense for libstub either.

To fully exclude all libstub code from objtool, these arch_is_efistub()
checks would need to be sprinkled all over the place.

That would be a lot more fragile than just excluding libstub from
vmlinux.o in the first place.

-- 
Josh

