Return-Path: <linux-efi+bounces-5638-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C2C7A79B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 833764E9D88
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0692D97BB;
	Fri, 21 Nov 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dtY7eTXm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUA0Fo5S"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759522D77E9;
	Fri, 21 Nov 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737824; cv=none; b=PFklOdWZVzqx7XvBGMAU1FTXxR+0r0OXfIcPA20Ctej2DJNtRskxNfx8udE1nCiGdd6orF2Hqz9KmyVwpUiBdiW0xz0+GJG9aL7QOJ7K8cmAcMp/AEWSbfzGNYZEbyTkvFo61v5o+gioIKHqquZMQwpvAHt+wzVKSYrorUpjkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737824; c=relaxed/simple;
	bh=zQmc1H8b7sb7g3t2YwDV+3J+D8KFWJ3TDpJc14/2hHc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S5nmmdnZYhYEFPZe6nJD5lHJUITuZWjgPdX8GtfzKshQRNwQ3iTMV6FDHVHTqEjl1ntcsXVBa2OzZpyHFB0xXlR8e8vZpH1P3gNlP4Z/1gTnnST7fyX/kHIx3H1dyAPxhVpCrqzPYbZcrZ5pUYBkrGniM30H6v0HxNisY2I9EbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dtY7eTXm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUA0Fo5S; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B06C7A013B;
	Fri, 21 Nov 2025 10:10:21 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 21 Nov 2025 10:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763737821;
	 x=1763824221; bh=DzcM0SEDw1Im8fyyYBvoRQL2qFmDyiUwqhJDAcQietI=; b=
	dtY7eTXm6z72fUOOO/qOQRCZCE7nLB5/COnsayJ2X3an2s6zR/DpxY7eInL21wlQ
	WIQopkjoX7PAbVqd3MT9lU3RtJ600pmCc5N1Dm1coHHww/H0laqmBQBlTVnZ3QXQ
	L4ESBSaG+iCHeJKZfvIhFj+AXJtwP2SYhBOaIuKJTzcFC5TOw4wWh15FKL7gocyJ
	Y6WH3Sv43ZoCTATa+bMHhkWHLvJxIeNA+QgEyv9Ruf/+sPqGJGs+I3Q/RZL/8UF7
	Zrx6C3Erl9ZKl95quATmJELhFxjo/nlckGUtbyfQHbF9awIjOxMxyt4qMVSp+9yt
	uFeKQR1s4lhzCtMxwTGR0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763737821; x=
	1763824221; bh=DzcM0SEDw1Im8fyyYBvoRQL2qFmDyiUwqhJDAcQietI=; b=Q
	UA0Fo5SvUkmXgGqQuJvjUSByoK42NUh42UjDqOaKiWgbS6MinxkT0sd272hB7W+D
	HvctXy7+yEhgAJ51/xXbP/xAE6qW5YvtfY59YHMu/ol287owpGlf3fMiYgOTAhyW
	jfgr7VTJf4K/GEf0acuiLyf/OCJS7wf69DtpG7zhHxO5/FuFETNEinUa3dQODHdL
	bhI7i0QGvSML5IlRuw+oEHe20JqklyfVVF67csPpgl27AxWTgmo4Ei9BmwmnVtpu
	oEZY1uUd1HRUEudf1xgj4V8nhLJkhDjDENxNkQ9AYvBlnY7msfO2AieYL6fNn/h1
	xvgSLLmJJxqt/eOuC19Gg==
X-ME-Sender: <xms:3IAgaYHUEGvo-ne5gkZhxxQ-MevE0ITlKZfF8bv2TXLk6DXyvgcZMg>
    <xme:3IAgacI0kVVgEWlixUuWUfiT6FuFhLx9CpWjrWM5eHx1ERCwPpjdKNtgYZhIja-5v
    kroOAJ2zKrzVh1F6q6_qLLg_H8k2HpnqsZ9Jsn5kdkdpsxS6h0dFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekie
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdr
    fhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvg
    hrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehj
    rghvihgvrhhmsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnh
    hnsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:3IAgaQobINDk36AsLM6qAi37y35WNG8fcy-IPYwT81UtDOP69W5h3Q>
    <xmx:3IAgaXHy2EKi4JZDENLJjNgh2jqPvL0iGJdWo6ROzCZAfVBSSOEUpg>
    <xmx:3IAgaU8wQD8W2AA4zezbIVBARPkZc-2doMkJoyEm_GT9fAygZG2L4g>
    <xmx:3IAgaURbIfsqA_WQy6F7q2MeK8e-4Qti348yk5jtKvNDZdcs-FFwjw>
    <xmx:3YAgaeSI3c_MRk18gVsMtEXTcvu2Jwxiwr0-6n59AFRitQQGspBnOGUo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EB84700054; Fri, 21 Nov 2025 10:10:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5Y7Dcvi2yON
Date: Fri, 21 Nov 2025 16:09:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Javier Martinez Canillas" <javierm@redhat.com>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-Id: <96a8d591-29d5-4764-94f9-6042252e53ff@app.fastmail.com>
In-Reply-To: <20251121135624.494768-1-tzimmermann@suse.de>
References: <20251121135624.494768-1-tzimmermann@suse.de>
Subject: Re: [PATCH 0/6] arch,sysfb: Move screen and edid info into single place
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
> Replace screen_info and edid_info with sysfb_primary_device of type
> struct sysfb_display_info. Update all users.
>
> Sysfb DRM drivers currently fetch the global edid_info directly, when
> they should get that information together with the screen_info from their
> device. Wrapping screen_info and edid_info in sysfb_primary_display and
> passing this to drivers enables this.
>
> Replacing both with sysfb_primary_display has been motivate by the EFI
> stub. EFI wants to transfer EDID via config table in a single entry.
> Using struct sysfb_display_info this will become easily possible. Hence
> accept some churn in architecture code for the long-term improvements.

This all looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

It should also bring us one step closer to eventually
disconnecting the x86 boot ABI from the kernel-internal
sysfb_primary_display.

    Arnd

