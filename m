Return-Path: <linux-efi+bounces-5649-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68178C7BF92
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 01:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06C284E1A52
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 00:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65C1DDDD;
	Sat, 22 Nov 2025 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBy+Q6F/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA94400;
	Sat, 22 Nov 2025 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769668; cv=none; b=bLqEjsjbFNRjKKcoHt7ZOkLHA15HqFinv96jtItshvrNZ5G5sh2DVkRDO/0OZ50w0S1c3zXnLi+voKyEGs1BMdW6afiXK/U6ECyoFd+I5bzxtH0NasJgWuzbPR86KRs1dDZD/HDCaXMT8uqxGnw+AMT0bHbVaKQ+5/KZ1+Y74Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769668; c=relaxed/simple;
	bh=7VO8MtWqKmaIpeDWygtuR4K+s9loO2/N5EOqF8TuZKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifnegzt8EsBhZ8gKRBmtTX/QWiqa2hbHJ91m+SzynG9mI8vR6zcmcdDVNCy8WduhLP2JBA+bAQYeuRqIDDK9Z0p1kT/OuYASuSxyW/RWMn4UP/RB50iThUlaVWHoMJGPNm6kAfHPrsPF86ASDYJGh/pQYiOAMMYOpzjFSc+sUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBy+Q6F/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1879EC4CEF1;
	Sat, 22 Nov 2025 00:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763769666;
	bh=7VO8MtWqKmaIpeDWygtuR4K+s9loO2/N5EOqF8TuZKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBy+Q6F/kNGlBfq4O+WSanA5e8J+IBriuKtAEnRPMqD8xgh+9NUcsdRQKdyB7kJ9z
	 oc/4ZVK2Q2Ki4BcZbLFLzmdTRk2VYtJhqNOI05v1dZpkM9t4T14HL5Pym1d78q5FQQ
	 cInnVW6id1gGtRmHOwsYWfOtAXo1xxT3jGW6ZDSggl94vFoUfG3egL1eAof2Lxq0/B
	 TXKNPMzJl54V/HTfLlu/AZuCtFLCJjQj52CdS2/3r+w+wPrF0o/dFWwuuYpYGpiUUx
	 angpT+Z/hP0QEoNEgtR78CMDnpVWsZCrf9hFflWC+bFF1P4JheC+kJvpNojrSh5K6C
	 /krEyXvOprQhw==
Date: Fri, 21 Nov 2025 17:01:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kbuild: Add KBUILD_VMLINUX_LIBS_PRELINK
Message-ID: <20251122000101.GA1996391@ax162>
References: <20251119042708.27658-1-yangtiezhu@loongson.cn>
 <20251121070140.GA780042@ax162>
 <hka6ukulmkmxp7mrcmxmllco2sqof2elextc7ggcikazfzmwni@a4pnogedcr7r>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hka6ukulmkmxp7mrcmxmllco2sqof2elextc7ggcikazfzmwni@a4pnogedcr7r>

On Fri, Nov 21, 2025 at 10:42:47AM -0800, Josh Poimboeuf wrote:
> On Fri, Nov 21, 2025 at 12:01:40AM -0700, Nathan Chancellor wrote:
> > > @@ -1199,6 +1199,7 @@ KBUILD_VMLINUX_OBJS := built-in.a $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)
> > >  KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
> > >  
> > >  export KBUILD_VMLINUX_LIBS
> > > +export KBUILD_VMLINUX_LIBS_PRELINK
> > 
> > This variable name is a little confusing to me since they do get added
> > to vmlinux during linking, not before. I am not sure of a better one
> > though, maybe KBUILD_VMLINUX_LIBS_FINAL?
> 
> I think that name was my idea.  Not sure what I was thinking, I guess
> "prelink" was somehow meant to imply after the vmlinux.o whole-archive
> link but before the "final" link.

Yeah I could see where you were going with that but glad we agree final
is better heh.

> "final" is indeed better.
> 
> > It may also make sense to
> > introduce similar syntax to the existing libs-y syntax, maybe
> > 
> >   final-libs-y
> > 
> > or something like that?
> 
> Yeah, I suppose that would mirror how KBUILD_VMLINUX_LIBS is wired up.

On second thought, it might be less complicated to keep it this way...

> > Also, since these objects are no longer in KBUILD_VMLINUX_LIBS, does
> > this new variable need to be added to any of the other places in the
> > build system that use KBUILD_VMLINUX_LIBS for things such as build
> > dependencies?
> 
> Not sure about that one.  drivers/firmware/efi/libstub/lib.a is getting
> built regardless so there must already be an implicit dependency?

I think the explicit dependency currently comes from

  vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)

in Makefile. I think something like

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index cd788cac9d91..38b5f0ba9a4b 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -68,7 +68,7 @@ cmd_link_vmlinux =							\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 targets += vmlinux.unstripped .vmlinux.export.o
-vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o $(KBUILD_LDS) FORCE
+vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o $(KBUILD_LDS) $(KBUILD_VMLINUX_LIBS_FINAL) FORCE
 	+$(call if_changed_dep,link_vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF
 vmlinux.unstripped: $(RESOLVE_BTFIDS)

is needed to ensure that an updated drivers/firmware/efi/libstub/lib.a
results in vmlinux getting regenerated (at least according to my
testing).

Cheers,
Nathan

