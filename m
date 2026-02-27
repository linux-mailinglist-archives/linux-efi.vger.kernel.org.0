Return-Path: <linux-efi+bounces-6234-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBWiHzTUoWlcwgQAu9opvQ
	(envelope-from <linux-efi+bounces-6234-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:28:20 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E71BB758
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3524431D1A55
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3B936BCC8;
	Fri, 27 Feb 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD3bsfme"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF844D03F
	for <linux-efi@vger.kernel.org>; Fri, 27 Feb 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212869; cv=none; b=dg56V+3tVXsNlUSbah0WvVGmRGhS+83q7PH8OLrH3TVYJyplwiepWwA7k7mzxRbBEwrF+CX7yeSEcAUVIoR965O5E4okqIb5FnKl54jDUkKgm4dl7DjFTQGUS1vS2k86CMay/DDSHSH/S2Abz5a/VCY9x2lav/DtQfVAjBs9dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212869; c=relaxed/simple;
	bh=pL9kC4+EQEdKk+hx+UewcfsBrGSoXKUdL/1dCccuFTc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RKwZmXVNdcXoGVNMXKYdyWkzE7mkLO7sFczWW/+GEBgfkY0ntXIr6MCFGsYwdkVxKa1irNFlIFJ/lanfa+cJnVMwV8D+rWN5016VQHkJP2lbBCWia7EgchFZvapsrmLtQch23orqjfQqtVtQkFKvLLQj2E7h25e4gdfzpyUCvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD3bsfme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14162C19423;
	Fri, 27 Feb 2026 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212869;
	bh=pL9kC4+EQEdKk+hx+UewcfsBrGSoXKUdL/1dCccuFTc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fD3bsfmecZ/bLrEuF6UQ13AVORbEXYg7m0zRH7NKwIsBHtmsToiLoj5U3Yse9cJdX
	 RrxQhaY+150DmSWopZ+C6kOk0ukBMVXDH1Mx37WWmQgNJSX0APOntfJMINDwtxjY9R
	 0DoeT/MPzOyUF10ZzOhx8rKpeJhzGLfQ8/c0snfJa91PhD9z+GF69oHR/Ct4sM1ARk
	 UsFftzdVRy4yJB6Vkp6EDjnq6OB+YsR812+AqIPKKSl7sVuSIhhfQmza5a0d6fqDo1
	 RUwXkObuaiCgMOoYx/feM5WJULPmzgm/cR54Uj5x4Cjb4VTGgOZbTZncdHa+wcldry
	 xaQ1fu3dAzS8w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id EFE0FF4006E;
	Fri, 27 Feb 2026 12:21:07 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 12:21:07 -0500
X-ME-Sender: <xms:g9KhaVzc1SfuIqyCdqK1a6aN5J_BD1rIBINXJUwuGQ4t4cQ1BfQJzg>
    <xme:g9KhaQFPaOLloPMD-FqkVe_FtQNxZwQdRq_VeLP8-zbCLVLOOjiyU5mwHMb1rA4YA
    xdcB7D67b_c3uikVGyXzsNfroRmpk_sjMk3EvO_wtMbWCcaBo8c3sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgtphhtthhopehtjh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhmrghs
    sehlihhnrghrohdrohhrghdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonh
    higidruggvpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihig
    rdguvgdprhgtphhtthhopehlihhnuhigqdhrthdquggvvhgvlheslhhishhtshdrlhhinh
    hugidruggvvhdprhgtphhtthhopehlghhonhgtrghlvhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g9KhaXRJ4epSgk8OC3Qa6XuJ_sM3suIsR9M_KWVbgo-HT6rsFk50Rg>
    <xmx:g9KhaVVlpjA16Oevyioo7yxpmQAeybUx6K01Klo7OvmvH-dRRjuIPA>
    <xmx:g9KhaRS85cliXKx9qmJRPe-Hr0xEXtRZlXsXwxDBbcPV_cUSXXCXww>
    <xmx:g9Khad0NsEj8ozJ9eaJizifagGgvIc5Pmh8oTJ4aOg0s4QXo09pMIQ>
    <xmx:g9KhaRdNROka7ChXJZ5hF7Hdu716Mj7iMDnyoT3Lv7Y3GkKSejOEFyCR>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C99B1700065; Fri, 27 Feb 2026 12:21:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aba-YR8suxqc
Date: Fri, 27 Feb 2026 18:20:47 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Tejun Heo" <tj@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 "John Ogness" <john.ogness@linutronix.de>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Message-Id: <98bc8bdf-e658-4018-a816-6cd75baaff9c@app.fastmail.com>
In-Reply-To: <20260227171429.-Fwih-F3@linutronix.de>
References: <20260227170103.4042157-1-bigeasy@linutronix.de>
 <20260227170103.4042157-2-bigeasy@linutronix.de>
 <aaHQjt8bZsFLBwfh@slm.duckdns.org> <20260227171429.-Fwih-F3@linutronix.de>
Subject: Re: [PATCH v2 1/2] workqueue: Allow to expose ordered workqueues via sysfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,linutronix.de,gmail.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6234-lists,linux-efi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 630E71BB758
X-Rspamd-Action: no action



On Fri, 27 Feb 2026, at 18:14, Sebastian Andrzej Siewior wrote:
> On 2026-02-27 07:12:46 [-1000], Tejun Heo wrote:
>> Acked-by: Tejun Heo <tj@kernel.org>
> Thank.
>
>> I can apply this to wq/for-7.1. Would that work?
>
> I think you need to take both since 2/2 can't be applied independently.
> Maybe Ard is going to give his blessing ;)
>

iIRC I already acked v1.

