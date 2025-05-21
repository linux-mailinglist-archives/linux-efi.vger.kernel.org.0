Return-Path: <linux-efi+bounces-3762-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE689ABF78B
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 16:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109099E7BD4
	for <lists+linux-efi@lfdr.de>; Wed, 21 May 2025 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3942F18BC1D;
	Wed, 21 May 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX1GEa45"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3B192B66
	for <linux-efi@vger.kernel.org>; Wed, 21 May 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836694; cv=none; b=C/z61RvrnQ4iGkgQLaqpnFtNFi9bKd+/0dPZhJBVeT9bKzWuTYypCPCbg9vuHEdR5+lw7vdhkuNfhyDtWnnm3m2R+2UNbWw/eUB1f8SBm6dG41Ajobcbba3qwEJVGDvrmx8etn5Wy8fEVx6Rka6O8zQyFJ/ZD9jn7Ftobe3wG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836694; c=relaxed/simple;
	bh=nw2NRoUJDDAAldajyVllAgUstOzJboAyZ3klDqEyg5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6oPeYFnosphya+EzpruivL2vg6rQcfeSWrtP83SGWOjCHL3jIdLgs9KqdWQNJP9u09/3WY8i9fD/9hFyfbVdf0/YvPJAFuws3PohsHqjEgvne/zOfeKl6ypN21WsWsO7nj0cQhIBn8JeW2AoRhGfJxrxu2/4qbNqqaX3SYTwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YX1GEa45; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747836690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqC/At+Um4IKJ5Dheln0Cu/AgMJ1XH9fkqhVL9d6moY=;
	b=YX1GEa45eCgiG4xT2xH95M+vdf1hh6x+zLnRNOQHD/QK62fCU1CNHRm3nVAdDMP4lX51p+
	OhrXTk9wRNyLqDF/ayc252XzQ4KBknNHy7/xBQP7rIAnUHpeaI/d7JPlBSxyIRiiCRwKax
	GzGpxWTf/mRMd1/eBBpSYM8TlWMnkQw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-p5QLAFmLN9OiOJ_fxbwFlg-1; Wed,
 21 May 2025 10:11:28 -0400
X-MC-Unique: p5QLAFmLN9OiOJ_fxbwFlg-1
X-Mimecast-MFC-AGG-ID: p5QLAFmLN9OiOJ_fxbwFlg_1747836687
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30026180035C;
	Wed, 21 May 2025 14:11:27 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.52])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B2A1955E83;
	Wed, 21 May 2025 14:11:25 +0000 (UTC)
Date: Wed, 21 May 2025 10:11:23 -0400
From: Peter Jones <pjones@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: pe.h: Fix PE definitions
Message-ID: <bc8307c5-cf59-4a9a-95e1-c49ac19efb43@uncooperative.org>
References: <20250504182244.30446-1-pali@kernel.org>
 <CAMj1kXE5DQ-tBFa+xLR10+joGADRB6BJ70EvDfJzfWJr1o3Q2A@mail.gmail.com>
 <20250505173259.b34f6hvn6t73q3df@pali>
 <CAMj1kXGE0fSRvR4=+qAWu54ehzJfdC9GSzHODr4pMTEbBwOhuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGE0fSRvR4=+qAWu54ehzJfdC9GSzHODr4pMTEbBwOhuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, May 21, 2025 at 03:45:13PM +0200, Ard Biesheuvel wrote:
> (cc Peter)
> 
> On Mon, 5 May 2025 at 19:33, Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello Ard!
> >
> > On Monday 05 May 2025 13:25:45 Ard Biesheuvel wrote:
> > > Hello Pali,
> > >
> > > On Sun, 4 May 2025 at 20:23, Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > * Rename constants to their standard PE names:
> > > >   - MZ_MAGIC -> IMAGE_DOS_SIGNATURE
> > > >   - PE_MAGIC -> IMAGE_NT_SIGNATURE
> > > >   - PE_OPT_MAGIC_PE32_ROM -> IMAGE_ROM_OPTIONAL_HDR_MAGIC
> > > >   - PE_OPT_MAGIC_PE32 -> IMAGE_NT_OPTIONAL_HDR32_MAGIC
> > > >   - PE_OPT_MAGIC_PE32PLUS -> IMAGE_NT_OPTIONAL_HDR64_MAGIC
> > > >   - IMAGE_DLL_CHARACTERISTICS_NX_COMPAT -> IMAGE_DLLCHARACTERISTICS_NX_COMPAT
> > > >
> > >
> > > Where are these 'standard PE names' defined?
> >
> > Basically in any project which is doing something with PE, at least in
> > projects which I saw or used it. Those names are mostly coming from
> > Windows SDKs/WDKs as the Microsoft is inventor of them and are de-facto
> > standard names -- or at least people are following existing naming
> > convention for a good reasons. If you are are not familiar with
> > MS/Windows world, you can find them also in projects like binutils,
> > llvm/clang, wine or mingw-w64, which are hopefully well-known project
> > references.
> >
> > Some of IMAGE_DLLCHARACTERISTICS_* names (including the NX_COMPAT) are
> > defined also in the PE MS spec (win32/debug/pe-format). I hope that this
> > spec can be taken as a reference, even that it does not document
> > everything related to PE, and contains mistakes.
> 
> I don't feel strongly either way with any of this - I don't think
> there's anything to fix here, but I'm not attached to the names so I
> don't mind changing them either.
> 
> Peter: any thoughts?

I'm broadly for making the names look more like what the spec uses
whenever we can when it doesn't introduce naming collisions with other
stuff.  But like you, it makes very little difference to me.

-- 
        Peter


