Return-Path: <linux-efi+bounces-5070-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70669BEAF94
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136971AE37FB
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303262FC02A;
	Fri, 17 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyMB2QFh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BE2FB974;
	Fri, 17 Oct 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720717; cv=none; b=G8h/xr5I3QVBq2ubegOiOHUV0qj/jQZ2jSJsvze8o0DIOvd6CumUWX9+tuQDwXR1kaSiOZsjSiwUrIVWYydloYcVQjCXi3UDNLC5UXG2Usthg8fQLYshaapynfqy2np1I8jWd69CisHOBJUPK2rbnl0dTIeOa+tWxVO1UXURPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720717; c=relaxed/simple;
	bh=QB0Gc9ncYgSpVBw7Sv+xdUvjxJSRAnUxhhUy/5mCqRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeDIs4wU6JUSpUab6FFUistCBTN+FmPIPftNy6a1qZAPb8SzbtlABlzFtvDMJY2nG7mSKOvShwuwV0KgdTHo1m9rpy61zKGNIPrcofuEz/+LpODh33TwBXg7XGA1Oon/7sDh/UR4qF01YkMxUV+/ZVaVU91IOC1Xhk/O/N16hPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyMB2QFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73862C4CEE7;
	Fri, 17 Oct 2025 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760720716;
	bh=QB0Gc9ncYgSpVBw7Sv+xdUvjxJSRAnUxhhUy/5mCqRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyMB2QFhdPvWwqmedF1cUtHx/GMJGwYeTjLQ9zGpgPpBZYqkdHWu3wPNj8c1hBdHB
	 WQ48f/D5edLCK38H4+LbFg4btdTgcmUIm4/yYIKsOx8X1V0/ks5mfKfqXLc6DYntOp
	 fi03qQ2pfmq3kW6OEWDnRsypKH6R/KCaVg4vjO71XVJtMNFstSQ7cOfj3om9m2DnUk
	 cz+nM0NDNlTZNl5gyuCgzvLXNsB8pGZ30qhYeVWGm9EF3yUF9FMeGOQcp5ZdmLADAY
	 E5u2UaJwn6iktWGlFMLvRxa4kF+rXf9pu7Uo6m4fI6bC/vubJuHCmUHspN+KvMcjwR
	 llQ+KB3I7rfkw==
Date: Fri, 17 Oct 2025 10:05:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Message-ID: <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
References: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>
 <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
 <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>

On Fri, Oct 17, 2025 at 06:26:47PM +0200, Ard Biesheuvel wrote:
> On Fri, 17 Oct 2025 at 18:22, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Fri, Oct 17, 2025 at 01:00:17PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 16 Oct 2025 at 17:49, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 04:52:20PM +0200, Ard Biesheuvel wrote:
> > > > > On Tue, 14 Oct 2025 at 18:47, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > > > > The idea is that libstub code doesn't belong in vmlinux.o because it's
> > > > > > not a part of the kernel proper, and doesn't need to be validated or
> > > > > > modified by objtool for any reason.
> > > > > >
> > > > >
> > > > > I don't see a reason to change this on architectures that a) do not
> > > > > use objtool and b) link the EFI stub into vmlinux. If LoongArch wants
> > > > > to change this, that is fine, but that still does not mean it needs to
> > > > > change on other architectures too.
> > > > >
> > > > > EFI related boot errors are a nightmare to debug, and I will be the
> > > > > one getting the reports when this regresses arm64 on hardware that 2
> > > > > people on the planet have access to.
> > > >
> > > > The idea was to have more consistency, so vmlinux.o never has libstub,
> > > > regardless of arch, but that's your call.
> > > >
> > >
> > > The code in libstub ends up in .init.text, which will be mapped
> > > executable during boot on architectures that incorporate it into
> > > vmlinux.
> > >
> > > If objtool validation is never needed for such code, on the basis that
> > > it is not actually called even though it is present, then I think that
> > > is fine.
> > >
> > > For the other architectures, I don't have any objections in principle,
> > > I'm just being cautious due to the regression risk.
> > >
> > > > I'd still propose we keep the KBUILD_VMLINUX_LIBS_PRELINK mechanism to
> > > > allow other arches to opt in as needed.
> > > >
> > >
> > > Again, no objection in principle. To me, it just seems a lot of churn
> > > just to avoid having to teach objtool about indirect calls to noreturn
> > > functions.
> >
> > Well, one of these days we will need to do that with some kind of
> > compiler -fannotate-noreturn feature or plugin or whatever, but this was
> > more about "why are we validating libstub code anyway, it doesn't seem
> > necessary and x86 doesn't do it, so lets make them consistent".
> >
> 
> Sure. So objtool validation is not needed even if the code is
> incorporated into vmlinux, and therefore mapped executable at boot?
> I.e., objtool does not check for gadgets or other things that may be
> problematic even if they are never called directly from reachable
> code?

Well, boot-time gadgets aren't really a thing.  And, as you said,
libstub is in .init.text, so it gets freed (and presumably mapped
non-executable) during boot, so we don't have to worry about any gadgets
hanging around in memory after the fact.

That said, objtool also generates ORC metadata, so in addition to
security-type things, it also cares about any code that might show up on
a stack trace during a boot-time warning/oops.  So it *does* care about
.init.text code in that sense.

But IIUC, the libstub code runs *very* early, and wouldn't show up in a
stack trace anyway, because there are no traces of it on the stack once
it branches to head.S code (which doesn't save the link register).

-- 
Josh

