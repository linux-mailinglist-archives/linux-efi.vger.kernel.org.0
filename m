Return-Path: <linux-efi+bounces-3212-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FFA7E899
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 19:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23F61899D6C
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE921C18E;
	Mon,  7 Apr 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fVJdzCDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MjrhbkZi"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB121B9F7;
	Mon,  7 Apr 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047229; cv=none; b=PRY/7ESxl2UsfJhB6e5t5MOU7HENkJTumHqoDUiA4h5yS4i10jgu3i131kIFhhteaYi5vAPMcA61qG0wTafDcgzOQgAFY0/8C+IEKtYvgZS77kideH0W5l5WLVNwFdDXTMUqd4OzlWY8eKFzNwsR4304xxdsw6HryWBzuP00YlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047229; c=relaxed/simple;
	bh=43EUjzsJrbIj5lwOeksbNo3oJD//CY9Yr3R4TUrVDs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih+hMArIRrnfYA2ZtHqoTV/monNrgbGIx8p9Ydj8eEGIymSv0IGugLW0HOS+Ty/wzSvoVH0U4UhB6lDGUNwvakq/wdAZTGzzHPcHuLGDySbAnpjMwrWsWY0OMTKzY7C3/tdxTOPQkoPfIJuh+ZERgnIsKv42oZ7/EkA3/DjDIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fVJdzCDe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MjrhbkZi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 73609114017C;
	Mon,  7 Apr 2025 13:33:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Apr 2025 13:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744047225; x=
	1744133625; bh=rOJzUg2Z5K8abGAZ6cTAjToJiu9EAfJ9aa8qOahrQmQ=; b=f
	VJdzCDeLdqn3xJxSLqXhQOmDzk8oDAEY0guunfyBSbz0cG0/NpjJ/i/fh+QP0evn
	UlB8x0SZk6/42mbV8Ru3ino0HSFVohqFxkZPqRZkEUJnuPtv5VjGjCVoOqnPoPuL
	GLVxVnAXVyFwnW8q1bg9WK1+fzWzciuUXLVOP3Lw+6HV5DJgo6zPNwlLVz3qtwp9
	QdMuaCZva5+ZF2FEbBblhNa4zwNKu48DNtY0dOsDAuEvL3BXVDVc1KEUNuRarapb
	ak+ft+4W3NsNPEY7KIOxFJ5UGR842XtHTDUi94HpQe1dOrI4BAMdW4XiNooEkavM
	L8HV7VnD2blR1TUbvUWnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744047225; x=1744133625; bh=rOJzUg2Z5K8abGAZ6cTAjToJiu9EAfJ9aa8
	qOahrQmQ=; b=MjrhbkZiFT0ljg5hOuwZCPpBavvRiXba4TXQEIXWIbjp2Emgh7M
	GSwj6fREyoSLeLH11GxCTAcKF58NHA5dZAtDDv753eHKQGkmgnM4nCFOz0oNYQe3
	pQiUUetIvCWhH7JKi4y2Kw++Un5rLvK0tafsWAU/ijQqjXaZ3Y6Nf2bkUhGgWaHK
	6IMrtWHYAcj6kUXg/eeMCc00hqEVnvtsfNSIzCrKxu25BSd/q3HUr0xgfJ8t53Uj
	3acRl9hvwX5ulvpWZvRdLpTKjHsKEbQVA5CSWc7PQ3SEcdztcWMWvOob1xN/R/x9
	sDLnFosfgpNie1eTDqUzCRygDRlqqoGjiYw==
X-ME-Sender: <xms:eAz0ZwjHnpJgtanECsN6naUH00uYVcMFlVM-58W-MFlU2HCkbkJR6g>
    <xme:eAz0Z5AKwsfhy-kbm5Jk_1dEd1xvfZsv83AWMU78Wn4X6EzroSN6dFEuuHpy9GyBB
    5ctmSw1e_16RCTev9k>
X-ME-Received: <xmr:eAz0Z4E3PPdC0YIyeso4hI7M-GZ1ywdocoVTn9M59q8sG2Vu90EizoneXfklDrc__jC1Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:eAz0ZxT0UKzcOcivwsNglq4oowhd-Mr8Htp5NBrJLCxyD8Rw-cD1Rw>
    <xmx:eAz0Z9yodbCpMEKGy0PpSI-r1fDEcIkTRkFENQT9pKzB_iM9oBGhWA>
    <xmx:eAz0Z_4phctABvZGCT7dDRLY-rit4buJB5Or7mGrZiIfulo9IS6Csw>
    <xmx:eAz0Z6ymMrhDNFI15-U80FCa0nL8ICFGhwIfK-wfEmZu89YAwppVWA>
    <xmx:eQz0Z9k3U8O9p9okIOZjokXBTkB6Ecg9S_R_i4gkUITs-vjb25b77pG5>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 13:33:40 -0400 (EDT)
Date: Mon, 7 Apr 2025 20:33:37 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for
 SEV-SNP
Message-ID: <grmalijxenphqg664brbqbreitq3qkancb7qv32yjdwzfoqowy@6tavdslt75i7>
References: <20250404082921.2767593-5-ardb+git@google.com>
 <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
 <Z_QA6GwqoxdW6D0e@gmail.com>
 <CAMj1kXGWPopQupteK0=mqd5z29Oj4Ye6KyPfgup-nHQO863Qow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGWPopQupteK0=mqd5z29Oj4Ye6KyPfgup-nHQO863Qow@mail.gmail.com>

On Mon, Apr 07, 2025 at 07:21:17PM +0200, Ard Biesheuvel wrote:
> On Mon, 7 Apr 2025 at 18:44, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> >
> > > On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> > > > If the GHCB is available, we should always prefer it.
> > >
> > > I believe we should consider the cost of code duplication in this
> > > situation.
> > >
> > > If the non-early version is only used in the kexec path, it will not be
> > > tested as frequently and could be more easily broken. I think it would be
> > > acceptable for kexec to be slightly slower if it results in more
> > > maintainable code.
> >
> > Absolutely so.
> >
> 
> It would be nice if someone could quantify 'slightly slower' - I am
> leaning to the same conclusion but I have no clue what the actual
> performance impact is.

If we can survive the performance of the initial boot, we can live with it
for kexec.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

