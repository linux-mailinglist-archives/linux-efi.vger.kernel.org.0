Return-Path: <linux-efi+bounces-3219-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E56EA7EF89
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100C118932F2
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FFE215F43;
	Mon,  7 Apr 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="dVgljzSM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZaHWAluz"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82041EF0A1;
	Mon,  7 Apr 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060118; cv=none; b=Ki3KsAWm0tzdIEpMgD3EnMsAXeURdWcMOniFJRbVtUf1a24XpuGyrUuj05ZSHkEncE22Upz3HXISNNMs00qUKTXzzk2vaNA0b0tWUX4OOd2gmquvRdp9OK4gO7/32Z2SK3PvmBTo2hn3eZf0jhWUl9GN4Dho4UaPsDtzpp3A+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060118; c=relaxed/simple;
	bh=WkcvTRYspnESz6gLqavJF30kPibHjQxjvDEtMkjjOPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUZxhC3SFOan3yUV6ZPGueWpNY2+0nNDQAjPRzomUQDd1Dft9sBybwwEpL4OgiMIN9dbg+OS+q6bZi4MTfCbcgs/31dkLAZsHhiAhKIIlpxhTyMo9mH4k0OhM+EuTbKzX3VXxysctpVQzeGVoD/el8ePAUYHttCE9IDt1GYpXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=dVgljzSM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZaHWAluz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id ED2A613811B0;
	Mon,  7 Apr 2025 17:08:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 07 Apr 2025 17:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744060113; x=
	1744146513; bh=h1peeUsk7FcP1jakLjVZgwWrgqF1Mde4rlg/PA+xMpQ=; b=d
	VgljzSMbZWrgPrS3o5cSEtrnxusAVgdDTirUvcEI6/A36Ks0NRYZyg441rwUGbQ/
	O0pKNxldMuedgBxH+F/p1qpReCAlqfCe0pvfErsKlckeZS6C+x4IuyfnaM0d/SCe
	R9L271tJonV9FsbFCD7ZfQzPyHM5OKsKSo7ity7npgML7appEnu8rY962R6Aa7W1
	M0Vhrr38FtWDyafOUaiEuVVgoa+n4LC/qvhSAd2ijdHSUI0nGrqcFAavb4JAL+a1
	zumLQUY8xkXYbHHKWIiVuh8XZ9cg4LZ62xi/ECumsbjdYf/TEEr7t67Z8FT0CPCD
	MuqPnIAqbbiS2NVX5MGxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744060113; x=1744146513; bh=h1peeUsk7FcP1jakLjVZgwWrgqF1Mde4rlg
	/PA+xMpQ=; b=ZaHWAluz1rXePNQnICfvFitFCXmQoI9a1xr5JUxF2C+qbCyT+Ph
	L+wCkqB7+xFZGly2Su505Y4Zd3hBUjDTsHP92/hNreMc2SE5HELdcn9o4pmlN/8C
	VRDW2Jpa/8swDqIm06W8RW3bYljR5JLOUDc6UthCMapHgkFAl6wQlAFJ5o0aTIFD
	18K4XeBvq/9HyVzsPmw3okLcQrQnkdgBcExGhnJUngJtVHNHaYuWdFoSrQnax/p0
	Qiu3bOsdsLP8GcOkX9hJud/uuUpkLvNutzbUNNJVvaBCgnDDa0cvb5F9Go9yFsAL
	KHvHsP1wdGQKYG1+8X+CcwC4ob2ikT72PEQ==
X-ME-Sender: <xms:0D70Z-5RJaTazvew3m-h0gp3_ILffdHENyp5EOAgrX36_aGbaquYpA>
    <xme:0D70Z37S3Z6qapQ_bCLQmduVM4vmDbSOiUqWCrGtVX9beJf6MyspfVKDZGKXLXE1d
    BkU3XBrsM4VUK7PSPY>
X-ME-Received: <xmr:0D70Z9crGDeezMSSXb8dE25VdJC7eMgBmd_ODAvoRvvCym95PX_ejW9pAz5ZO7A27vpAXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilh
    hlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfh
    hfffveelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghm
    ohhvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhirhhilhhlrdhshhhuthgvmhhovheslh
    hinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeguihhonhhnrghglhgriigvsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegrrhgusgdoghhithesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgr
    shdrlhgvnhgurggtkhihsegrmhgurdgtohhm
X-ME-Proxy: <xmx:0T70Z7JAxU1jzTWV-RNGCHhdsSqe7Mg_VaygbtkPiAOrfok80HM1eQ>
    <xmx:0T70ZyI8eJEzWYQxzR7leU6YesWMaeoJBc-dd707B00vL2igy1g24A>
    <xmx:0T70Z8zCdmLxsRrxHcsSD0Lz_EVm4XknA-WS6W6MnQV44GlYkZaoFA>
    <xmx:0T70Z2LKQY5664dZApn1cBh4ZEoTQ0nrNb_IIcfXLc0cbLnqmGq8MA>
    <xmx:0T70Z1a23ls62NLy-qXRZoDlT7cVb77pGEHLWM3KWNsLj7hgS2jDdWQ->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 17:08:29 -0400 (EDT)
Date: Tue, 8 Apr 2025 00:08:25 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for
 SEV-SNP
Message-ID: <7u74hxavnqqtcaciqco4ra37rep7k4f4cnv65mk5rmcu3fuo6n@kdhc2oceeu2p>
References: <20250404082921.2767593-5-ardb+git@google.com>
 <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
 <Z_QA6GwqoxdW6D0e@gmail.com>
 <CAMj1kXGWPopQupteK0=mqd5z29Oj4Ye6KyPfgup-nHQO863Qow@mail.gmail.com>
 <grmalijxenphqg664brbqbreitq3qkancb7qv32yjdwzfoqowy@6tavdslt75i7>
 <CAMj1kXHcdT8X8uUyd+9eEF1Nc=CBNj2M4z172DUU7g_pJ5BHuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHcdT8X8uUyd+9eEF1Nc=CBNj2M4z172DUU7g_pJ5BHuw@mail.gmail.com>

On Mon, Apr 07, 2025 at 07:45:59PM +0200, Ard Biesheuvel wrote:
> On Mon, 7 Apr 2025 at 19:33, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Mon, Apr 07, 2025 at 07:21:17PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 7 Apr 2025 at 18:44, Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > >
> > > > * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > > On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> > > > > > If the GHCB is available, we should always prefer it.
> > > > >
> > > > > I believe we should consider the cost of code duplication in this
> > > > > situation.
> > > > >
> > > > > If the non-early version is only used in the kexec path, it will not be
> > > > > tested as frequently and could be more easily broken. I think it would be
> > > > > acceptable for kexec to be slightly slower if it results in more
> > > > > maintainable code.
> > > >
> > > > Absolutely so.
> > > >
> > >
> > > It would be nice if someone could quantify 'slightly slower' - I am
> > > leaning to the same conclusion but I have no clue what the actual
> > > performance impact is.
> >
> > If we can survive the performance of the initial boot, we can live with it
> > for kexec.
> >
> 
> The initial boot does not occur via the decompressor, but via the EFI
> stub, where memory acceptance is handled by the firmware (as it
> should).

I wounder what protocol BIOS uses.

> Given that the traditional decompressor carves out an allocation from
> the raw E820 map without using any of the higher level APIs, it has to
> accept the memory itself if it is marked as unaccepted in the table.
> 
> Perhaps the decompressor should try to avoid unaccepted memory?

It limits KASLR. I would rather wait more on kexec.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

