Return-Path: <linux-efi+bounces-5659-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9859C7E79B
	for <lists+linux-efi@lfdr.de>; Sun, 23 Nov 2025 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689573A375B
	for <lists+linux-efi@lfdr.de>; Sun, 23 Nov 2025 21:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0B24A05D;
	Sun, 23 Nov 2025 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5OfKYtv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAC1FF1C7;
	Sun, 23 Nov 2025 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763932534; cv=none; b=U67h3MSPBdiD4rjXge4RNuy8lOUCGVo1PFb6lnOzfO0wN1W00H97IpKWolGShruCqQFhchQu0x0sY/4GGoXi1ywB3ptk28CvSLQS++sbh7rCI3gm7qhWquzJYrA2iD6maq4vVdiHOFBnAjP25w+NDa9SAu26GduNGLuEXvqY+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763932534; c=relaxed/simple;
	bh=D+OCR0hsIV5XBu9XitqcJnVl2OG0xT1N8cd+2rxAbx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGV5w/bBz9AjostvrcGpvOvL20/IWiIKvL75eofUlL6XZzf9PRi68EfnQ/pY5rjnwspRHsJYfHo6Ll/4BSnzVLSTrgQqkank/wyfI1WN0ZFz+6pcdS0vmWX6F5+oyYHFAdyAMRMNCXHaY8Bvyyth/i03CP+f6m5mTIfL39DTTWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5OfKYtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD64C113D0;
	Sun, 23 Nov 2025 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763932532;
	bh=D+OCR0hsIV5XBu9XitqcJnVl2OG0xT1N8cd+2rxAbx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5OfKYtv/ujJ053wsKTh+hcRA+Ivna+Bt62V0TjLzF2yiIHx7BpzLiRUDINbCJ8Yx
	 WzFACAdHIyvvVpE5gvPtCls6LtSWJSY3vyCek4t3xSyLUfxr2z+32kGj+aUrQZuKne
	 NCJXnlSqTi6KFqidDad5ynXBMp9rn/lXF36IxnSPfTMveQMFvo6d1hiwyjxBQfrDZQ
	 SDf95KbWuILgD2SkzBxC7jvITxbJlbmH95RuJrQgA1zp+xn0SvcBYl+YDIkR2FI2C1
	 6zJYFk7EwaHnDkKKcFGvTiDSgVq1zLvAw5Glu2MTwTYBANcdaZUvkXc+U8NI35BSy9
	 T6oq6SOQ3K1gQ==
Date: Sun, 23 Nov 2025 14:15:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kbuild: Add KBUILD_VMLINUX_LIBS_PRELINK
Message-ID: <20251123211527.GB3667167@ax162>
References: <20251119042708.27658-1-yangtiezhu@loongson.cn>
 <20251122013551.GA3928114@ax162>
 <7f179e5f-610c-6468-cb3f-17d25d096a8f@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f179e5f-610c-6468-cb3f-17d25d096a8f@loongson.cn>

On Sat, Nov 22, 2025 at 07:26:52PM +0800, Tiezhu Yang wrote:
> On 11/22/25 09:35, Nathan Chancellor wrote:
> > On Wed, Nov 19, 2025 at 12:27:08PM +0800, Tiezhu Yang wrote:
> > ...
> > > index 433849ff7529..e72d3254b93f 100755
> > > --- a/scripts/link-vmlinux.sh
> > > +++ b/scripts/link-vmlinux.sh
> > > @@ -61,12 +61,11 @@ vmlinux_link()
> > >   	shift
> > >   	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
> > > -		# Use vmlinux.o instead of performing the slow LTO link again.
> > 
> > Why is this comment getting removed?
> 
> When using KBUILD_VMLINUX_LIBS_PRELINK or KBUILD_VMLINUX_LIBS_FINAL,
> drivers/firmware/efi/libstub/lib.a needs to be linked to the final
> vmlinux with vmlinux.o, so I thought the above comment is not proper,
> it I misunderstood it, I will keep the comment as is.

I think this comment is referring to the use of vmlinux.o instead of
vmlinux.a, nothing to do with libs=, so I think the comment should
remain.

> > >   		objs=vmlinux.o
> > > -		libs=
> > > +		libs="${KBUILD_VMLINUX_LIBS_PRELINK}"
> > >   	else
> > >   		objs=vmlinux.a
> > > -		libs="${KBUILD_VMLINUX_LIBS}"
> > > +		libs="${KBUILD_VMLINUX_LIBS} ${KBUILD_VMLINUX_LIBS_PRELINK}"
> > >   	fi
> > >   	if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
> 
> FYI, the previous patch is still under discussion yesterday [1],
> I do not know whether this patch is necessary and what is the next
> step [2].
> 
> [1] https://lore.kernel.org/loongarch/CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com/
> [2] https://lore.kernel.org/loongarch/39617a3e-c476-abac-8425-bbcece769cdb@loongson.cn/

Thanks, we will wait to see the conclusion of those threads before
applying this.

Cheers,
Nathan

