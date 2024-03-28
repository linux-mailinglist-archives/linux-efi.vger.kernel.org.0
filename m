Return-Path: <linux-efi+bounces-890-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F398A8900BF
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917031F216ED
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB656B77;
	Thu, 28 Mar 2024 13:47:10 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D87E77B
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633630; cv=none; b=WgShQntsVEDLpl1K2raER9A6az0O9K2OHz70neAeGiYTEC2iGakdWwVWUyhb3iymD/e06sy0uNdjhggWqPSVTmCc5/0H5z7a7ZMVisfhrkaQV8IXTWjSF/F7K7WiMHhJL3SxSBqeWAn/YMJdb0HRMeg+7WI3y3u/eoMEYb4GMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633630; c=relaxed/simple;
	bh=+yIofdhgCqrgjkqxvRHQcjIVZRzo9K5tHymVvW3EjaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmnKkB/Sch7t8etC+Vn2Qg+DlZ9k77LN5hS35+tGhhzMdJS8nAKAWz06hO34fG6h9QwIs32RX/yO144Hst1bSVZhSOrIfpv7vh1aXmOlB5TphVMjOqtcyDZvf1isnZ6jJuZxnmRSwL4wmDel8/h0JTzBXylJcHSqA5t3BI3B+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9198C100DA1C9;
	Thu, 28 Mar 2024 14:38:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 382D754B1D; Thu, 28 Mar 2024 14:38:40 +0100 (CET)
Date: Thu, 28 Mar 2024 14:38:40 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	kazuma-kondo@nec.com
Subject: Re: [PATCH] efi/libstub: Cast away type warning in use of max()
Message-ID: <ZgVy4BP1dpho5PZ8@wunner.de>
References: <20240326101850.914032-2-ardb+git@google.com>
 <ZgUollgbjAkTR0CD@wunner.de>
 <CAMj1kXE8pFxr3Ym5K7pHEJEti=+BahyaZKuACiEz57wyQ4C0Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE8pFxr3Ym5K7pHEJEti=+BahyaZKuACiEz57wyQ4C0Sg@mail.gmail.com>

On Thu, Mar 28, 2024 at 11:13:07AM +0200, Ard Biesheuvel wrote:
> On Thu, 28 Mar 2024 at 10:21, Lukas Wunner <lukas@wunner.de> wrote:
> > On Tue, Mar 26, 2024 at 11:18:51AM +0100, Ard Biesheuvel wrote:
> > > Add a missing (u64) cast to alloc_min, which is passed into
> > > efi_random_alloc() as unsigned long, while efi_physical_addr_t is u64.
> > [...]
> > > --- a/drivers/firmware/efi/libstub/randomalloc.c
> > > +++ b/drivers/firmware/efi/libstub/randomalloc.c
> > > @@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
> > >                       continue;
> > >               }
> > >
> > > -             target = round_up(max(md->phys_addr, alloc_min), align) + target_slot * align;
> > > +             target = round_up(max(md->phys_addr, (u64)alloc_min), align) + target_slot * align;
> >
> > Why not
> >
> >     max_t(u64, md->phys_addr, alloc_min)
> 
> Why is that better?

It just seems to be the idiomatic way to handle these casts in the kernel.

It's also what checkpatch suggests, so by not using it you risk getting
"helpful" fixup patches from the usual suspects.

It's your call buddy. :)

