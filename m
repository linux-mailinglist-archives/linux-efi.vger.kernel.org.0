Return-Path: <linux-efi+bounces-6242-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJaCJIRwqGkkugAAu9opvQ
	(envelope-from <linux-efi+bounces-6242-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 04 Mar 2026 18:48:52 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4D2056BE
	for <lists+linux-efi@lfdr.de>; Wed, 04 Mar 2026 18:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4663E30CFF06
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2026 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28353CC9EE;
	Wed,  4 Mar 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHMcgw84"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88956472;
	Wed,  4 Mar 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646331; cv=none; b=lh7YRHFhgBVWK+n8G+C6/Xt32mPf71UtfDKBDmXfdFcwbZbXvHs3Q/Xx8lyBwmDPgtZc8nshgk0YuxBjPtZ6L07RqIGp0Cknhj4WFVfxanslcdp11aqkBs77UK7ZfUxHlTFKdwi7o6nMTd9lLkIfnAp8J2+kJ/MkNIBTVCiluJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646331; c=relaxed/simple;
	bh=hNkWCLZVO/R/KkvpTujUJ3BKfdAzr6K2wWaVXdZpqM0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PLiPMC5EVWURmdGqxuoJqrg61fyjLgrF/Z7boWudyVsfeePXrlCLcDQqgva66xCGpkeY7SD4ygi+876etUvJYaOl37nafaN3EcJtub8zQQzR6Xg/DxQVSPCzgij+b/V01EdhOZKoqc9U4bwPFON1Sk7YDSiuTo+lZMzjNDXzPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHMcgw84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE4CC19425;
	Wed,  4 Mar 2026 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772646331;
	bh=hNkWCLZVO/R/KkvpTujUJ3BKfdAzr6K2wWaVXdZpqM0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MHMcgw84pNpi+4xbHZkfaKt79WhQqTHhmGYQpiQqGCXmz6eVI34ZBHrOTFKn8O9KG
	 9SZw2Ks3OapLgEgEHbJ+kwgHVZ9RetmpfkWxEUAIbuBwvgUnr5vrZdajUtMg2OzbMv
	 T5sX71Y0bRd/ZOaaoPlohRaYfm+eZvtod7Mf+yAknHDT7b2mWqQf/KBL0EpJ9/kI4i
	 C1QsKOVgL5CX+nv2drefdCu73+ZE1TtVhsPYj8c7yIGxqiBLCykq7ERw4kXGaKKDg3
	 qCQVSm74KqNEFxOp0yu8vCvFZjTKzUVPXOL/uABTB1Wj1szknofSzXeJPuV6IVccE9
	 v9b5NPwb0nXnA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 95EFEF4006A;
	Wed,  4 Mar 2026 12:45:29 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 04 Mar 2026 12:45:29 -0500
X-ME-Sender: <xms:uW-oacZq077lgVTkMOUj-dUmbNfI0CFO3UK3vCOq9sewwCz6ZRLYkQ>
    <xme:uW-oaSMuCTAcMPMdY2K9pOm6V0vrj_aGoWMA8lPfrYYvn17WTgehsgPqUOONxZ_9a
    NnfXZcNOCkFlNv4Hx79VJC6C1yjdaxy44_GMdxhUt2dnGdJwez2lQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnh
    esihhnthgvlhdrtghomhdprhgtphhtthhopegsvghnhheskhgvrhhnvghlrdgtrhgrshhh
    ihhnghdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtph
    htthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghp
    thhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:uW-oaYUW-HFeBsSWBCuImA4czvoe58enckRE8o1gOQuit26bFJsvpw>
    <xmx:uW-oacA44J5IPwPqowvfeqBBjt_qgVWNF3W49UwEcqqMtIN0JXLLlQ>
    <xmx:uW-oadeun30kpt8nXeBr4Mbq_S3ZZK53JplF5gjKWptLAl-SUks2bw>
    <xmx:uW-oaboO8ce97anv0TZImuVWjBeAPz1YbCFdeJAAKHtXlwTM903y1Q>
    <xmx:uW-oaWTROfWloc601DO2gcNnQFVbnxDc9KpSdzrTQv1eNoW4K0nww2Yj>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AF94700069; Wed,  4 Mar 2026 12:45:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AusYBuezkfp3
Date: Wed, 04 Mar 2026 18:45:08 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>, "Mike Rapoport" <rppt@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, "Ingo Molnar" <mingo@redhat.com>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "H . Peter Anvin" <hpa@zytor.com>, "Thomas Gleixner" <tglx@kernel.org>,
 linux-efi@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Message-Id: <da9396fd-f321-45d0-8af4-566dec32707a@app.fastmail.com>
In-Reply-To: <e3585441-f225-4a60-9c48-aac2753eef36@intel.com>
References: <20260225065555.2471844-1-rppt@kernel.org>
 <aafqhcG67FoNrF41@kernel.org>
 <e3585441-f225-4a60-9c48-aac2753eef36@intel.com>
Subject: Re: [PATCH v2] x86/efi: defer freeing of boot services memory
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0DE4D2056BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6242-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Wed, 4 Mar 2026, at 18:44, Dave Hansen wrote:
> On 3/4/26 00:17, Mike Rapoport wrote:
>> Gentle ping?
>
> Ard, I _think_ this is one of the efi things in arch/x86 that you
> normally wrangle. Are you planning to grab this?

Yes, I will pick it up. I'm planning some cleanup on top, but those will not be fixes anyway so this should go in on its own merit.


