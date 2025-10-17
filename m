Return-Path: <linux-efi+bounces-5068-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1207BEAF27
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 19:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D3D965E34
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBEF2857C6;
	Fri, 17 Oct 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7u7yxDR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD882283FC5;
	Fri, 17 Oct 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718132; cv=none; b=m+5G5SJ9ZoBosMhI6PxeywSEwuLYkAswEvG8nYhtDj9N0bVZ5DOapsMfYuChsZzDhdPkH3eypjXzQb7NE/uUWqs1jwYXSWgIVSaELJHhhHUUeIbmHkoK8ntjI7M192Iydzt1donfflyvMH0mOw7JhOsMGQP+eZ1a1Awz+Z2tYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718132; c=relaxed/simple;
	bh=dUE+qwx9KS/o4m0cuTqkDviPcdL6D1GZOXcU+S70UqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf61pidt5Qe4h06ARak/CtQYFfdIEXQ5bLQs9eKb40I1v36Vgg7QAsyxnVA1/kmv5h2DxAvNd8xznOvtDNHvGqJkG1vrS2DFAMBo7g/1q6B+Q36kqa/52ap0gk6JMn9DqJcL8rML3g9qwbg4bZ+eEXAtUZu5NLdSuNSzGpglNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7u7yxDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9A4C4CEFE;
	Fri, 17 Oct 2025 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718132;
	bh=dUE+qwx9KS/o4m0cuTqkDviPcdL6D1GZOXcU+S70UqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7u7yxDR47N75dqaU5iqxA/ViwyQdnTpY061XQ8ZPA+Kql9Xyytv4wzviuzMQKLNC
	 rV4ae4KDL+38dhq7eqT8oW+VJraLT6MVgmMFwZwRO6GRUtEcec17Fi2/gAj3NDvmKn
	 sa73LQEyyShEA4XVO2RXcvNyD6qvjxoh5a1kTmkAI5yFr8/MgX6jCdOdGqMsv4At6p
	 P98yRGESydIR1yXiedNtvD8UzMfAXy1WsGNlPVVEy36iHqm0paFr5MlNP950ETL1X6
	 iYWaY2352KQeyrhpYmbDi6eL6GWNWWY9COkL+SpfdmvW5ErgQ9yMDb5sXvq6U6QvDK
	 kZ2+7aPxWZ69Q==
Date: Fri, 17 Oct 2025 09:22:09 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Message-ID: <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
References: <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>

On Fri, Oct 17, 2025 at 01:00:17PM +0200, Ard Biesheuvel wrote:
> On Thu, 16 Oct 2025 at 17:49, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Thu, Oct 16, 2025 at 04:52:20PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 14 Oct 2025 at 18:47, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > > The idea is that libstub code doesn't belong in vmlinux.o because it's
> > > > not a part of the kernel proper, and doesn't need to be validated or
> > > > modified by objtool for any reason.
> > > >
> > >
> > > I don't see a reason to change this on architectures that a) do not
> > > use objtool and b) link the EFI stub into vmlinux. If LoongArch wants
> > > to change this, that is fine, but that still does not mean it needs to
> > > change on other architectures too.
> > >
> > > EFI related boot errors are a nightmare to debug, and I will be the
> > > one getting the reports when this regresses arm64 on hardware that 2
> > > people on the planet have access to.
> >
> > The idea was to have more consistency, so vmlinux.o never has libstub,
> > regardless of arch, but that's your call.
> >
> 
> The code in libstub ends up in .init.text, which will be mapped
> executable during boot on architectures that incorporate it into
> vmlinux.
> 
> If objtool validation is never needed for such code, on the basis that
> it is not actually called even though it is present, then I think that
> is fine.
> 
> For the other architectures, I don't have any objections in principle,
> I'm just being cautious due to the regression risk.
> 
> > I'd still propose we keep the KBUILD_VMLINUX_LIBS_PRELINK mechanism to
> > allow other arches to opt in as needed.
> >
> 
> Again, no objection in principle. To me, it just seems a lot of churn
> just to avoid having to teach objtool about indirect calls to noreturn
> functions.

Well, one of these days we will need to do that with some kind of
compiler -fannotate-noreturn feature or plugin or whatever, but this was
more about "why are we validating libstub code anyway, it doesn't seem
necessary and x86 doesn't do it, so lets make them consistent".

> > And that variable might even be useful for other cases (x86 startup
> > code?)
> >
> 
> Not all x86 startup code is in .init.text; some of it sticks around
> and is still used at runtime. I reckon that implies that objtool
> validation will remain needed for that, no?

I wasn't aware of that, in that case I guess the x86 startup code
belongs in vmlinux.o, or at least the runtime portions of it.

-- 
Josh

