Return-Path: <linux-efi+bounces-6139-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGrXBxtsj2mCQwEAu9opvQ
	(envelope-from <linux-efi+bounces-6139-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 19:23:23 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF9138E72
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192ED3013A41
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E726D4C3;
	Fri, 13 Feb 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFgneBJp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62F23EAAD;
	Fri, 13 Feb 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006999; cv=none; b=KZv7EHAMY/C9ZV4+2aESu1nn2CpjxFX2+Wv7/cLS3/c3Oq3PW4qKGwJAbqa5FUuNuKd0G8t3X9iB5dComv1YypvaCzvB0HVuhLFdkjYA4jguemDAoRh4vWvdyPS1C07YuT8w6N2an25Fkusm1lutpJFGcF+q/iqDnhJIVfmKwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006999; c=relaxed/simple;
	bh=NEH1QZTmQ/KouLPeuu7dpIgwEBk3WYs4TyDCd9OsMns=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mJ13M3tj8OJat6svpztjOjHYI2e4Yg8ucebNOVCnEXc39TisqFpThU8gdxongk9jP06CJNha9ynj732T1NAqpxBibxqpfyKpl314xHcMCChNXPpG9ABrJtlbJ5Onp6Mwp9CCtXrOYIjliP58i5ViR87DKKE4fatdN1Y2jTA1hhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFgneBJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3614C116C6;
	Fri, 13 Feb 2026 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771006999;
	bh=NEH1QZTmQ/KouLPeuu7dpIgwEBk3WYs4TyDCd9OsMns=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bFgneBJpRPCXT5CZFCagVq/UbRkU/9EIwz8teSdB6ax6CbqLgGQCE2Hdr47sRxni0
	 7ZkJ1hjBk17re+KW0H1kgyI7E2s29Hk73Av3CxCuLg8Lp70MS6R5a23/XssHKpmWc6
	 9z3yM3syID5V2RgntlO2/BerQxO5EKaFdaCRd+BT2GR5OxbZfok7nriy9EJpADUqKm
	 pmwGZxLiXbMvUbXu/uww5W6MU4jfpFFclHA9NQ8HYVnC/lIIvUWjtf01Xiw8DdMF32
	 Y+uOEpx1W5NiG3VY1wuTwN2B2JexrnMOiKGuNH2BjG/4Z+yunF7qIQBqnb7v6wkbHr
	 vRoxWxONC6jqA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB78EF4006A;
	Fri, 13 Feb 2026 13:23:17 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 13 Feb 2026 13:23:17 -0500
X-ME-Sender: <xms:FWyPaUt4SejTetociJuLAZSXK5GhGsOrMyZ0oardfBlboSyXzWENpg>
    <xme:FWyPacRtDrQW0kbw_QJHqHNuHb8lXyUodUH1yOM_qjlaNR9ewX_lEBDMill5smX9s
    bDtto_HBy-cB5C1sdisI4MspQKnUY22GluylXQQyvo2mFV7cIDkyW3d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekvdffkefhgfegveekfedtieffhfelgeetiedvieffhfekfeeikeetueeg
    teetteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppe
    hkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghpvghtrhhonhesrghmrgiioh
    hnrdguvgdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheplhhk
    phesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhm
    vghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FWyPaQNWCGXp1wFSQrxCfx50suiOQzBOvDVlr5lqKoytaOBo058sog>
    <xmx:FWyPaS9PT0cvFfD3yBgturSV-tVeyM_PqXe1vhfVC8igBdAAbwn4iw>
    <xmx:FWyPaZdBAOJy0nUhm7E7Vr2kZhYLw7EbRIQXlszDf599upTbJu9hng>
    <xmx:FWyPaZx38RDRB958wpAlEx6ZpgfdqBCyw0T_u9hd3Ph2dLyFvxa0fA>
    <xmx:FWyPaWLqMzsV7qCuEirqs_tOh09gy-XlNiPeMgbzDd3Krj3IiJA3ht8Z>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B79CC700065; Fri, 13 Feb 2026 13:23:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO2I2uItOS1k
Date: Fri, 13 Feb 2026 19:22:57 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Arnd Bergmann" <arnd@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>
Cc: "kernel test robot" <lkp@intel.com>,
 "Evangelos Petrongonas" <epetron@amazon.de>,
 "Mike Rapoport" <rppt@kernel.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <2ee747d7-e000-439f-bda2-0b2ad050ed61@app.fastmail.com>
In-Reply-To: <80fd8ea2-bca0-4a8c-a442-77beefc06105@suse.de>
References: <20260213165158.1327846-1-arnd@kernel.org>
 <80fd8ea2-bca0-4a8c-a442-77beefc06105@suse.de>
Subject: Re: [PATCH] efi: export sysfb_primary_display for EDID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6139-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email,arndb.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8ECF9138E72
X-Rspamd-Action: no action



On Fri, 13 Feb 2026, at 19:17, Thomas Zimmermann wrote:
> Am 13.02.26 um 17:51 schrieb Arnd Bergmann:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The sysfb_primary_display structure is now part of efi-init.c but
>> conditionally defined. One of the users is missing in the condition:
>>
>> aarch64-linux-ld: drivers/video/fbdev/core/fbmon.o: in function `fb_firmware_edid':
>> fbmon.c:(.text.fb_firmware_edid+0x3c): undefined reference to `sysfb_primary_display'
>>
>> Export it whenever CONFIG_FIRMWARE_EDID is set, so the fbdev core
>> code can use it.
>>
>> Fixes: 4fcae6358871 ("sysfb: Move edid_info into sysfb_primary_display")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202602111543.Do4nkY5l-lkp@intel.com/
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Thanks for the fix.
>

Indeed, thanks for the fix. I'll queue this up and get it out soon.






