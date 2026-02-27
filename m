Return-Path: <linux-efi+bounces-6236-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGftAtPWoWlcwgQAu9opvQ
	(envelope-from <linux-efi+bounces-6236-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:39:31 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409C1BB8B9
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39EA301AF7D
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45D361646;
	Fri, 27 Feb 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+GmHxsR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A030346771;
	Fri, 27 Feb 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213806; cv=none; b=GODOHdgVUwE0IsHEp79Gg7DgvsyrLky/1gizGDAVNDqt6YE+MtmYoWXDIO4Y3r10T08aqsIFs+klLBP7Y8CWLp5gXKS/xlS6ukN6lAGRExtXTiDwzt6bpxhPYknMt5ViRc+482TJlQe7JGvctG6LqufFmrUkol22RlAmQHeskY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213806; c=relaxed/simple;
	bh=L/dza2/g/cNjdLIOYL+CdayQYJNeMzT0kTxtRSBUk0g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CoNtupLrP8XJ+dtjEMmPRs4GkLfEjUT1wblGgtYp8ZpFNPyLszkMZRNPrTcJSLgPNea1eXMNwwLBskPW6R4N8rjxFpp2Z0ppy2GqQiCaJX4KnBJBjOrwA1ydFbR/DnONFAYxWieOYPKZX28HSvp48Pda+RowpWJTflzpsRJB404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+GmHxsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA51C19421;
	Fri, 27 Feb 2026 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772213806;
	bh=L/dza2/g/cNjdLIOYL+CdayQYJNeMzT0kTxtRSBUk0g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=u+GmHxsRsbMad4FUtekbRqLJgu8/Da52N5wzo/uVjq2Nvh6oTfRKoYFebOSsvE+Wc
	 CLpH4flULySU10yv2n4c6U0cguKL+NKkgWB+s192tL0PvKLI5/WvYCe87xJOXhD3Wg
	 o0DxfvT8YBC30YICK7EAFx0CGxGQTqKQWqT8JCYm6Csj29I6erGU+ca3p+QE3OXXzM
	 +WspCgwOYmotLB1p1VGtT/zw6U6WyNvZ6nrngJTnoqnPNJOoZ4WExNbrc46A0d2Gvg
	 zOl3//fmq5KFbO0V2TL6SGut6Xm5afZoXEO1tB2JN44U5LsC9oLF3AFskTvs6lje2a
	 NK16gyhCsTNDw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id CD90AF4006B;
	Fri, 27 Feb 2026 12:36:44 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 12:36:44 -0500
X-ME-Sender: <xms:LNahaVzmdfCdgCeuPKo6ZM3eEMMr885B-Ci5LbLdD9X3WiMWWW_8wQ>
    <xme:LNahaQGRiE94kPVor2W5dob21delPXwzZd6ZwJ-2cwJoDwVeHB-gtKmRKFPxFuHty
    TqsFDJd_sSFko6pWHmrSDMDUT4HhhaYx8TQsPU3mPJG9_z0w9ca3NI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeliedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:LNahaXTDBYAEl7zsUT5BrvjlF_IgpY236HaSFWfp7maKtm6mNEcpLw>
    <xmx:LNahaVVXyu7liKg7uwRAQSctsC22jf84TS0l2ZeHeaE5IOz-79nEKw>
    <xmx:LNahaRTGnyJQGeW34brUtmOcIfKdPNJB9YPbtET5VhJy44pCLN4Amg>
    <xmx:LNahad1P4mwAfW3V7FgJfXhG3ozXpW9voyAsHAcMoUSnEf3GikGPrQ>
    <xmx:LNahaRdn9lG5YF44aCPzhpHH0Qctw9EyUMhTqa95DLNxCZVt8KmkQiaU>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ABB08700065; Fri, 27 Feb 2026 12:36:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aba-YR8suxqc
Date: Fri, 27 Feb 2026 18:36:24 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Tejun Heo" <tj@kernel.org>
Cc: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 "John Ogness" <john.ogness@linutronix.de>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Message-Id: <683577d9-f28d-4698-b332-34216c87bec7@app.fastmail.com>
In-Reply-To: <aaHT862yav5XxHMY@slm.duckdns.org>
References: <20260227170103.4042157-1-bigeasy@linutronix.de>
 <20260227170103.4042157-2-bigeasy@linutronix.de>
 <aaHQjt8bZsFLBwfh@slm.duckdns.org> <20260227171429.-Fwih-F3@linutronix.de>
 <98bc8bdf-e658-4018-a816-6cd75baaff9c@app.fastmail.com>
 <aaHT862yav5XxHMY@slm.duckdns.org>
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
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,lists.linux.dev,redhat.com,gmail.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6236-lists,linux-efi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
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
X-Rspamd-Queue-Id: 6409C1BB8B9
X-Rspamd-Action: no action



On Fri, 27 Feb 2026, at 18:27, Tejun Heo wrote:
> On Fri, Feb 27, 2026 at 06:20:47PM +0100, Ard Biesheuvel wrote:
>> 
>> 
>> On Fri, 27 Feb 2026, at 18:14, Sebastian Andrzej Siewior wrote:
>> > On 2026-02-27 07:12:46 [-1000], Tejun Heo wrote:
>> >> Acked-by: Tejun Heo <tj@kernel.org>
>> > Thank.
>> >
>> >> I can apply this to wq/for-7.1. Would that work?
>> >
>> > I think you need to take both since 2/2 can't be applied independently.
>> > Maybe Ard is going to give his blessing ;)
>> >
>> 
>> iIRC I already acked v1.
>
> Ard, do you want me to take both patches or wann pull from wq/for-7.1?
>

Please take both - thanks.

