Return-Path: <linux-efi+bounces-5065-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBCABE459A
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 17:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCFA486514
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18634F496;
	Thu, 16 Oct 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYon15nT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92634F478;
	Thu, 16 Oct 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629763; cv=none; b=aixM50ZuDZ/9OGp8V4VohXY40suvrhT7VQCWhM50CoxJyUNg2yQTUCP/Xu3tM2HvDIxqdWqX9JJTbA4Q0NlMFgLaUHdDGWdoJpQFTFOFAeu/QuylGZXRw5wfEm7WhcPBmzKwc97fGjmrhEgAq494E+m2knkyyj1wuxa+ig10JAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629763; c=relaxed/simple;
	bh=SA4GVw/nGNJf/qOm9uwEhfvgtPwILVcT7iMh4Nomboc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgWxe+ziWqNYRcJV5i/G3zb4ydNYA5V2v/yt/8htRRK7svNlWH9dYKapHGk322y0mD0YOKsV6y3I5R0RCtvv9i35sRUh5s+C0RwWQAc2h00PCGIZoKY7GjcWApMxpNUcxzA2GxxWmMg4frzhxpZ7r6kEqr0WflPqkUw1/fiYxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYon15nT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5BDC4CEF1;
	Thu, 16 Oct 2025 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629763;
	bh=SA4GVw/nGNJf/qOm9uwEhfvgtPwILVcT7iMh4Nomboc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYon15nTC1mf/Qvey0ODWWWDCuKPTr+/B27xSXjLWRwifGlrhDcQOgJhEMNqsjziR
	 eDOiocYrPuTcMiBDfhqjwhqH9hA4sSLXWykN43T5M+Ix8ShIiM79qj+AJGvyo089PX
	 stOi4BAdKthV2JSsl7fMI1yYGo8J8o5uuKi2kihDTXySBmt0eIJajJLrWVbK7+0jGA
	 qzWWj00vhlfquMHu8Cdg4TiwBuaginpMBQHcctPHlbwBi42bVHU/M//wtdNHb3AEXf
	 ReNHOGVbu4I8xxDFWQXcYZtcer8mhUYow8CFKTXY+Y181eNS51IOOuYu5LidalJ0HF
	 AIpnRMtBHrx4w==
Date: Thu, 16 Oct 2025 08:49:20 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Message-ID: <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
References: <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
 <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn>
 <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>

On Thu, Oct 16, 2025 at 04:52:20PM +0200, Ard Biesheuvel wrote:
> On Tue, 14 Oct 2025 at 18:47, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > The idea is that libstub code doesn't belong in vmlinux.o because it's
> > not a part of the kernel proper, and doesn't need to be validated or
> > modified by objtool for any reason.
> >
> 
> I don't see a reason to change this on architectures that a) do not
> use objtool and b) link the EFI stub into vmlinux. If LoongArch wants
> to change this, that is fine, but that still does not mean it needs to
> change on other architectures too.
> 
> EFI related boot errors are a nightmare to debug, and I will be the
> one getting the reports when this regresses arm64 on hardware that 2
> people on the planet have access to.

The idea was to have more consistency, so vmlinux.o never has libstub,
regardless of arch, but that's your call.

I'd still propose we keep the KBUILD_VMLINUX_LIBS_PRELINK mechanism to
allow other arches to opt in as needed.

And that variable might even be useful for other cases (x86 startup
code?)

-- 
Josh

