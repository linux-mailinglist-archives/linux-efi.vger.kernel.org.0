Return-Path: <linux-efi+bounces-6275-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKdWHHrCrmmRIgIAu9opvQ
	(envelope-from <linux-efi+bounces-6275-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:52:10 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC76239302
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16ACD300DCE7
	for <lists+linux-efi@lfdr.de>; Mon,  9 Mar 2026 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199363BFE24;
	Mon,  9 Mar 2026 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSHrbFKP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F43BED7D
	for <linux-efi@vger.kernel.org>; Mon,  9 Mar 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060725; cv=none; b=Q7GzrOOd6CYthTmiuEP4SaDWox8htR0zlnsD/UgN2OZo6+tOWz5vafPuKEMlLjPBqmOExk9SCxkXqKpZ7eP0QknOA4MVuGBEqc77T2xi4dYHVblVCfTQDSy8zypHgleE/1TWGGOcRZaphGK1TG7sQxZjtRuHarkiMy1IOw5XTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060725; c=relaxed/simple;
	bh=+l3GAe2jq8eBBZZbhrY4uib7DNJV8apVKmihOAiT6Gw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mOJG/SD6F3OmO7Yq/v5kM/BYk6JxzkCRtktCe7lp+L4q+SeOCzjbf31RnkMjf5DA5kKyj4b++hY/3NAdAsqr0lxiCOmNIAZXb0k/KYbAB7ruHpJz74SV/bOLeTGo5UKpUqfTpSDJrzl3eh2+wOf8RnkmOyP1wPR0lR/t1qRxH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSHrbFKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC24C4AF09;
	Mon,  9 Mar 2026 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773060725;
	bh=+l3GAe2jq8eBBZZbhrY4uib7DNJV8apVKmihOAiT6Gw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TSHrbFKPoRXfsXlhpwIxl3kZJwS2F2BttFk5QfPdMtO/2V51HyX6rtBr4NBX7fAnm
	 Mbo12H210Mu0rxpwX3x/oqe8N+CIQ1mUlnZIhdoYNbU87xSCxSCgXUoF4bHd6DbwKL
	 +j3OY3s1TM2gTxkaNs9J/IL2QVgVH5IxrNLE7MfKcJzecIH3329B0ZuHStfd7xZVaf
	 22b7kkG0HghO1/nWUHDjQHfrEUUYYxXoIdcvDQSPYVjLfLisQaKQqnPzaqg7HmmYlz
	 7bNv+jsnCFNqTQbCbDvjVrZ0nnUx4ye+D9QI0EaF1Hfh3XWKkSdZs4NO48m/Ck6zau
	 udgcC2oFo/FuA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C5D69F40069;
	Mon,  9 Mar 2026 08:52:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 08:52:03 -0400
X-ME-Sender: <xms:c8KuaT6g5dfW3c5CvJAmOIXVGTkdvWPf_1QM9tkj9Uo4Ih2HRipxsA>
    <xme:c8KuaTvCc5M089GSvD9-x5Zb9s3cnu4ZwokOhjS_EvbvaTmzW5CmE8H91wSfVIP7N
    p3Ji-kBKSk56OzjrjYv0-oLOd1BiRoGgnZarhy-VIwNaMlgMTUK_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefhefgtefgkefhgfdvffdukeejheeuvedthfdtiefhleejhfefjeffieeu
    jeefteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppe
    hkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhouhhmhigrjhihohhtihhsrg
    hrkhgrrhdvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrmhgrrhgvkhesihhn
    vhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhrtghpthhtohepihhlihgrshdrrg
    hprghlohguihhmrghssehlihhnrghrohdrohhrghdprhgtphhtthhopeigvghnqdguvghv
    vghlsehlihhsthhsrdigvghnphhrohhjvggtthdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c8KuaWcjcsw5z56A4U-0I8TpxxtNTYgcBSta9LzT8FhkHsW1Wcpt4g>
    <xmx:c8KuaSehKYxjTOw8IX5vaHSFoeHSbpymWVwezyS7Qb0SdlgfkExq_Q>
    <xmx:c8KuaZyDumFDVKesUG2kbHmbcAltYywi6iHzDnG0QlWiUUaFGX8MSw>
    <xmx:c8KuaZ-fJ1kWTGjVJ6UgZEl103GiQwkGGpA2aoIzzhEstZoUcvWo_g>
    <xmx:c8KuaRilkN9J9Yo9bdHlekGBpuyCg3gIBWtOc77In4fmiYdaKWJgdz_p>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 999C9700065; Mon,  9 Mar 2026 08:52:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Al3Xjs-asQIN
Date: Mon, 09 Mar 2026 13:51:43 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: 
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
 linux-kernel@vger.kernel.org
Cc: "Soumyajyotii Ssarkar" <soumyajyotisarkar23@gmail.com>,
 xen-devel@lists.xenproject.org,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org
Message-Id: <2f8e9891-ef08-4094-ae86-c1b6d2dbe06c@app.fastmail.com>
In-Reply-To: 
 <cover.751f45ebbb644244b1d9da3aff289d6b66db4c6b.1773058629.git-series.marmarek@invisiblethingslab.com>
References: 
 <cover.751f45ebbb644244b1d9da3aff289d6b66db4c6b.1773058629.git-series.marmarek@invisiblethingslab.com>
Subject: Re: [PATCH 0/2] Allow using BGRT table under Xen dom0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ABC76239302
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6275-lists,linux-efi=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.xenproject.org,linaro.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,xenproject.org:email,linaro.org:email,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Mon, 9 Mar 2026, at 13:17, Marek Marczykowski-G=C3=B3recki wrote:
> For a long time Xen was invalidating BGRT table as it was reclaiming
> BootServicesData memory (where boot graphics is located). This is now =
changing,
> and the boot graphics is preserved. This series has necessary changes =
to
> actually make Linux use the preserved graphics.
>
> This is a companion series to Xen side at
> https://lore.kernel.org/xen-devel/20260305191810.31033-1-soumyajyotisa=
rkar23@gmail.com/
>
> CC: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE=20
> INTERFACE (EFI))
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org> (reviewer:EXTENSIBL=
E=20
> FIRMWARE INTERFACE (EFI))
> Cc: linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE=20
> (EFI))
>
> Marek Marczykowski-G=C3=B3recki (2):
>   efi: make efi_mem_type() and efi_mem_attributes() work on Xen PV
>   efi: Enable BGRT loading under Xen
>
>  drivers/firmware/efi/efi-bgrt.c |  7 +++++--
>  drivers/firmware/efi/efi.c      | 27 +++++++++------------------
>  2 files changed, 14 insertions(+), 20 deletions(-)
>

Looks good to me - if nobody else has any concerns, I'll queue this up f=
or v7.1

