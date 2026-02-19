Return-Path: <linux-efi+bounces-6187-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA+eIkbXlmm/pAIAu9opvQ
	(envelope-from <linux-efi+bounces-6187-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 10:26:30 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E044F15D5C3
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 10:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169E5301F999
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA033509E;
	Thu, 19 Feb 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKrqWnrx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578D33344A
	for <linux-efi@vger.kernel.org>; Thu, 19 Feb 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493183; cv=none; b=Dp/+U9DABZyxJgmmPeMQnDw2U0DRSuj2UbvR11ciaBiK8kv+lMHGVMSer3WVpFddXbNYJqkA0sqVBesdqhWBS3H2dpnc5kxGvxDEQrP1Mu0Gyku78QckLR95XUFUXgUzQxNvTt+Er7/5R1GIPiBNYXrNBPmXZdnYqJLWQOsbgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493183; c=relaxed/simple;
	bh=9IclTx3lnPUxxtiARPih/U1FVwMbLyJFU7PQnzSllf4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k+yH9iMILNQU/2ZC1Z0E4vbJ6GZvGrTJ/8HHv5qH4jxuFBSvuET3CoHFcTRdlwCeSGBe7EQJRfZ0FYls1zmg/rEPaOiB2+EoQhfLDXicaND8nd5MW0pY542jedCAYa/AZyWoTYnEDZ+sJMJJ4GBjgaBtacLts2ZlmxVea0CadOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKrqWnrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601BCC4CEF7;
	Thu, 19 Feb 2026 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771493182;
	bh=9IclTx3lnPUxxtiARPih/U1FVwMbLyJFU7PQnzSllf4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nKrqWnrxk/UF0dc76GuL2WEo9lMnE1oUET+8joSutIUpaRDwFkIK8uX4+648Vntz8
	 soSrP7DfJNcuaYzBuyopcgRG7XVcUvaD495M0EGVcBaKexwxKL2CDn7UpryxTuC8W+
	 z9lhtmdxX76GZPH9oBopTHBsdt4jH/kwusOZg0yf6gVpzD3RxeSb28rTwoW18zm14s
	 fgEMkOBatQPpfdQhtiKHraGzhWZXjkL+6qNJw/s0YBgy+BcS777batPgK6Nw5hrGZm
	 t5QEQTKTmNjxgSDYywE9agrNNwyUdq21Q1/IkRphl+TNllhLQ4wNalV85+Ne+/rMWf
	 iQaOMDcSnE5Aw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 47411F40069;
	Thu, 19 Feb 2026 04:26:21 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 04:26:21 -0500
X-ME-Sender: <xms:PdeWaaL57vk_1COZZIQFjL4Dy6xZ6DXR_kBQO3NJwzcZYEacKHLPIw>
    <xme:PdeWac-p7pc2D-xHGqmciretbVvoYIq_sfUwA5dId5dNmzXsWVJtqUdoQDsOXF89F
    PXpgycYLGRTlaTH5sWZGGTvlMxDsEMYm-fueMSzm3SzVuNtiOeufg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepthhhohhmrghsrdhlvghnug
    grtghkhiesrghmugdrtghomhdprhgtphhtthhopehmshesvggughgvlhgvshhsrdhshihs
    thgvmhhspdhrtghpthhtohepkhgrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprh
    hpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnhes
    lhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:PdeWaWGJ4JKNBbaRHtrJy2N7yubZn0XGriWmBSs-toscvywI4ZkQtw>
    <xmx:PdeWadsi3lp9f5SwXY3TIQUfXhVIO_zbp6ngv1WrTxToDj2Jf0FHvg>
    <xmx:PdeWaca6ucxo7Tk1NDYil-QaQxTs0hz21exYyeG1rUZa20e6MylB8g>
    <xmx:PdeWad4J2FByyZ4bSF2zAnu4_f7ZB2eQNSjwWnSmtHJb3JeNJekx9w>
    <xmx:PdeWaU-ya7pKWP8ckaNRTTuOvZYK7wSv-wmwkkV7iHk7-mUQmqagEw-g>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 27767700069; Thu, 19 Feb 2026 04:26:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvPcN72_GPoV
Date: Thu, 19 Feb 2026 10:26:00 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Moritz Sanft" <ms@edgeless.systems>,
 "Mike Rapoport" <rppt@kernel.org>
Message-Id: <2f46f365-160a-4a06-b8cc-b2d94f68033b@app.fastmail.com>
In-Reply-To: <a45b19ed-149d-434a-ac80-4ea74a2e0f10@amd.com>
References: <20260217104957.249340-1-kas@kernel.org>
 <a45b19ed-149d-434a-ac80-4ea74a2e0f10@amd.com>
Subject: Re: [PATCHv2 0/2] efi: Fix alignenment issues in unaccepted memory code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6187-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,amd.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E044F15D5C3
X-Rspamd-Action: no action



On Tue, 17 Feb 2026, at 14:56, Tom Lendacky wrote:
> On 2/17/26 04:49, Kiryl Shutsemau (Meta) wrote:
>> This series addresses two issues related to unaligned physical addresses
>> and sizes when handling EFI unaccepted memory. These issues were
>> identified as potential sources of kernel panics in Intel TDX
>> environments due to incomplete memory reservation or missing "guard page"
>> extensions.
>> 
>> The first patch fixes the reservation of the unaccepted memory table
>> itself in efi_config_parse_tables(). It ensures the entire page range
>> covering the table is reserved even if the table doesn't start on a
>> page boundary.
>> 
>> The second patch ensures that memory acceptance requests in
>> accept_memory() and range_contains_unaccepted_memory() are page-aligned
>> before performing the unit_size alignment check. This prevents skipping
>> the necessary "guard page" extension for unaligned ranges, which is
>> required to avoid crashes with load_unaligned_zeropad().
>> 
>> v2:
>>  - Fix 'end' calculation in the second patch (Tom)
>> 
>> Kiryl Shutsemau (Meta) (2):
>>   efi: Fix reservation of unaccepted memory table
>>   efi: Align unaccepted memory range to page boundary
>> 
>>  drivers/firmware/efi/efi.c               |  8 ++++----
>>  drivers/firmware/efi/unaccepted_memory.c | 10 ++++++++--
>>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>

Thanks - I've queued this up now.

