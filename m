Return-Path: <linux-efi+bounces-5648-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DAC7B5C6
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B23A3612
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF62F12A2;
	Fri, 21 Nov 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwfS76Px"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7CD2727ED;
	Fri, 21 Nov 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750570; cv=none; b=mSg3G3cSmjdhj4xZA3SKHQPEMsx7+AMfgT3UkvyD+vlms0MA/x/Bi1BO3n7O/atkUCW2NnIYRwEXwe6FR8BKFA4Y8nAHj44992wuYhI8xaPVQJEW9mvpkqef2qGEDFxxOwUW1+iOLJR2iXVV8IiC1HO8yAPecEk/NHbMUNNILhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750570; c=relaxed/simple;
	bh=0bMZ4NLDj8CskLCEMHyms2+DxxfLSA3gVajQFVYgIow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W23tKa89PE4h78hWIUxHE5T1fJEF5crJzfK43pF/I3E40hbOMexNeYu9dJv29L+Q7RMnxUnen9CLFO+cHTx4NNYrtr2huGK++p4c6FXpIFlxYwB6py+MlkfFpZRxIXHWcgKIMOSTLY/I4rZZ1i4TDBGSgP1ijZfMVZxCX7EjwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwfS76Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB4EC4CEF1;
	Fri, 21 Nov 2025 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763750570;
	bh=0bMZ4NLDj8CskLCEMHyms2+DxxfLSA3gVajQFVYgIow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwfS76PxWsTyb+evI0DjzSdw52gt48ZkvUBIvhqu2K2chtrb1J5goM2bIhcK6YF17
	 2E6jYyd9wEhXy8Ly+42iLaN2hn4Sfkv75r5BoMILmn6GdQqeojmMsN3yRq8/2KhEKD
	 poytx9cTo5q78MOQMGe0mtWoxln3wO+iG3ZqK82cPdN/vF2jpmKIooXZgNdygXvriL
	 CZjHlg7Jgm/kqJ8rHoRWCuVdjqJ2FXMtlRGsf1q9D0jHzbEs60T40Q3Npktkah8zdY
	 XIrSPHV/iIQj+YOeBEK8Imx4rz3lGbXX+xbuA+l08mP4vyDtnJzOObgUwo1rVcRbGJ
	 4I43q2OgU7yGA==
Date: Fri, 21 Nov 2025 10:42:47 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Ard Biesheuvel <ardb@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kbuild: Add KBUILD_VMLINUX_LIBS_PRELINK
Message-ID: <hka6ukulmkmxp7mrcmxmllco2sqof2elextc7ggcikazfzmwni@a4pnogedcr7r>
References: <20251119042708.27658-1-yangtiezhu@loongson.cn>
 <20251121070140.GA780042@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121070140.GA780042@ax162>

On Fri, Nov 21, 2025 at 12:01:40AM -0700, Nathan Chancellor wrote:
> > @@ -1199,6 +1199,7 @@ KBUILD_VMLINUX_OBJS := built-in.a $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)
> >  KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
> >  
> >  export KBUILD_VMLINUX_LIBS
> > +export KBUILD_VMLINUX_LIBS_PRELINK
> 
> This variable name is a little confusing to me since they do get added
> to vmlinux during linking, not before. I am not sure of a better one
> though, maybe KBUILD_VMLINUX_LIBS_FINAL?

I think that name was my idea.  Not sure what I was thinking, I guess
"prelink" was somehow meant to imply after the vmlinux.o whole-archive
link but before the "final" link.

"final" is indeed better.

> It may also make sense to
> introduce similar syntax to the existing libs-y syntax, maybe
> 
>   final-libs-y
> 
> or something like that?

Yeah, I suppose that would mirror how KBUILD_VMLINUX_LIBS is wired up.

> Also, since these objects are no longer in KBUILD_VMLINUX_LIBS, does
> this new variable need to be added to any of the other places in the
> build system that use KBUILD_VMLINUX_LIBS for things such as build
> dependencies?

Not sure about that one.  drivers/firmware/efi/libstub/lib.a is getting
built regardless so there must already be an implicit dependency?

-- 
Josh

