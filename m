Return-Path: <linux-efi+bounces-6137-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLnuElpdj2mZQgEAu9opvQ
	(envelope-from <linux-efi+bounces-6137-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 18:20:26 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9937138943
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCF73036D6F
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987ED2DB79C;
	Fri, 13 Feb 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ1me+Rn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73236CA6B;
	Fri, 13 Feb 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003223; cv=none; b=UOCPfbDpxtiN11us45dBkFzp4vNpXSOWC3cZOD/+jc4W0/7Exku5d6usmQyaAJng7HtnuO7qlVPabMHbXZgKQQDyCzCUe459PKQwTChSVd5PtEjTzdYeIg+mb4g3M0g+yXc1XltpXc4489/+Zndl/2gZFEP0lbDcktruxQhFo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003223; c=relaxed/simple;
	bh=+LclX38OrI0KgaAdB7NwBZq/cU/VxYfgDrGVgHh3Das=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he0MmiaC//sQbpC6d0Za1W8rTjMaDRgt5EJm89kG2Z3IZaLr+9BpLzwyt6eQxrPmi8OE0qo/S8zLJfbXh51oDe0ErX54lH3qrFzhbfDiJyk7aQ9bc2+QFrxIhE6xrzDEOqeGTZtvfEEADmpsc6ymzJdkGQs+rmmi/KwI2mvvXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ1me+Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD9C19421;
	Fri, 13 Feb 2026 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771003223;
	bh=+LclX38OrI0KgaAdB7NwBZq/cU/VxYfgDrGVgHh3Das=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJ1me+RnKRGLhGoHAPL4YNLROdA/vGro/41iyTWVy2Gdt0KEOho9/SjGiqsbSefqf
	 1xzDKDFPT5Szk6Fv+ZI9XQD/8usUWYcksgPbPB2OvRPKWvPcma06V4D2aiXS8aNyo3
	 ZQYxqO/jyZFdFB9Qm/B6+pvxtb9fqWDSP7IHEkGLEM9+EbgmvHhrI1RUWyDbW3uYUX
	 ZZ3FPkrz/y2ZzfNKqHPbnVfcOKuR47daLLJk063OmuAEYpPz2ng8Yi4iYlElrOBkaD
	 YIHiDpB+adsNNxxEn+fEISFIwJalS78sZRd/4cfAQBW8afO+qI8hCnQIXs9G5mVech
	 dp0LmRZQCJfjw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9E448F4006E;
	Fri, 13 Feb 2026 12:20:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 13 Feb 2026 12:20:21 -0500
X-ME-Sender: <xms:VV2PacGI0vlgbrJvA39gHOcuxE4YgPqhU7MefajaiyfRWlNX0UQjTw>
    <xme:VV2PadJbvhOg4g68wcGnSTfGTNvbpGZl6J8emGXTDlQrW3up2p1XkFMOxRpRB2PkE
    t7ZSysWrAYhX_QBM10D1Cb3IpXTjDxQUkPf4zWbHViEh-e2X1qd9S4>
X-ME-Received: <xmr:VV2PaRhdaJoBiwPaXM_lA57mR1QnuxltEpKLkKA6Q0mqUr-kS7-C58uJRaxoQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhpph
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhngh
    hosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgt
    phhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtg
    hpthhtohepthhhohhmrghsrdhlvghnuggrtghkhiesrghmugdrtghomhdprhgtphhtthho
    peigkeeisehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VV2PaX6L905tO5Mr7KmKd4hhofDyIrFl7INMJxQickKUh4SrdC6wCw>
    <xmx:VV2PaWPKP9SD_bbiw0eouQFDQdKtnIhtgHG60lAHhwJ-BU2wDFFu-g>
    <xmx:VV2PaWeHE2ZiaWd_w1MfW8B6fFyVeYiizWfo1zylnOftPfEo1pWP5g>
    <xmx:VV2PaR2Q-mq8Ph_gQcFui3wOA7fhDsgAcP2gmv9PLuu_0WVkS-vNxg>
    <xmx:VV2PaWMU1062Uene-WEpehlqjuxyfhf7P_zeDK_37MW4CAq2MjdB97XV>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:20:19 -0500 (EST)
Date: Fri, 13 Feb 2026 17:20:14 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Mike Rapoport <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Moritz Sanft <ms@edgeless.systems>
Subject: Re: [PATCH 1/2] efi: Fix reservation of unaccepted memory table
Message-ID: <aY9c80nXefdXjGXh@thinkstation>
References: <20260213154838.46567-1-kas@kernel.org>
 <20260213154838.46567-2-kas@kernel.org>
 <b3b073e4-d51e-4fd7-ad7c-7465dab412b6@intel.com>
 <aY9Mf8oZODGiDoXp@thinkstation>
 <6d6dd421-774c-4f29-84d5-3e449240eb93@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6dd421-774c-4f29-84d5-3e449240eb93@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6137-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A9937138943
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 08:46:55AM -0800, Dave Hansen wrote:
> On 2/13/26 08:14, Kiryl Shutsemau wrote:
> >> The memblock code seems to be able to handle arbitrary alignment just fine.
> > Memblock will track it, but, as the comment says, anything smaller than
> > page size will not be mapped, but we need the table to be accessible by
> > kernel.
> 
> That seems really, really fragile.
> 
> We should first make sure this is intentional memblock behavior and not
> a bug before we go add more hacks on top of it.
> 
> Why would you even present a byte-level reservation interface if it is
> free to just silently ignore some of the ranges by rounding them off later?

+Mike.

My guess that multiple memblock_add() calls might add up to the full
page size.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

