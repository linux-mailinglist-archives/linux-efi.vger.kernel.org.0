Return-Path: <linux-efi+bounces-6163-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Au5DfRHlGn0BwIAu9opvQ
	(envelope-from <linux-efi+bounces-6163-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:50:28 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB2314B013
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1458D302AD30
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CB329387;
	Tue, 17 Feb 2026 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpbmehtU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC4329369
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325415; cv=none; b=pTFBkLrT06O/43ddKIDfVKkMf3Xa6TqEAJIm209VYHtdXl/efKV5/yxfZE9OwdkdqBa5vIRsacfrIMtCMk/38K6vvG+wWWKNgA6fu9lDtMLbYD7KjffI9DXCfCelpBCezY4WuZrsnIrb8DF5nFoFlmNtwmoOS+/M4dqy+LGC974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325415; c=relaxed/simple;
	bh=RrFGvE/E+r3nDli9pSyZ0W1is+dG3zskCpfHLCnPiFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6jfaE5ApUWSqQ7vQLdHtnnsLRVvudy/h+b4nCRPW6liCzo9fPZA6iyyLPF80b7KdpvIxbvVH3pKyvNoaQWWS1BMEyrGf9ubbYL8GRKvch1IzIkHAl/qzU4EHNA83k8QrliFc8ZMrfh8zp6D3OIzM+kiz0jiPumn/eAayzwvguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpbmehtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD78C4AF0B;
	Tue, 17 Feb 2026 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325415;
	bh=RrFGvE/E+r3nDli9pSyZ0W1is+dG3zskCpfHLCnPiFY=;
	h=From:To:Cc:Subject:Date:From;
	b=NpbmehtUS5Mxrwk9DiPWIknJsvzZZAo5fmW5FHMYYLh4vbrfLiu2x98/no38fJlME
	 LczK7X/9Yn+H7YvHhJkYkPdC7Tjx5/Rd5bA6Kr7Px96cGil+5IVL+pkMMwmHGcF6+M
	 E46HNoLkPiyAIs9Uy3sdXiUj+0P7l3zDsFGuBrjEVO4xrOoMVHdtTjLephqGVv1h+M
	 28nM0dQeHRsJrzSOM0e2c4RoDV2eoEuM3xyfBBEQDzeke6rOwpPbbHnDvH2JyaaWer
	 /fulF9N3lQv/Abg84pdseMqxoWMiab0xH76aBrWRKGuz3d+dKTuWHNM1dkB1J1XGDN
	 d3Ut+oiZ6IDVQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1996F4006A;
	Tue, 17 Feb 2026 05:50:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 05:50:13 -0500
X-ME-Sender: <xms:5UeUaQjfLHGWfnMCzLadRcl7NV6Lgh2VQG4R2MraIMnx6pdRcws2wA>
    <xme:5UeUaVtyhhmvUshU5ZeHgez7QJqf_hbml6T7NUKuqm3bZVqZRCiqXxYyLOoGWV6pq
    yjeRDAlidgTMiXOb2BMZJ97iM9Pe61Yq5UZWGBR3iDceCoDi8Nerbs>
X-ME-Received: <xmr:5UeUab9VznicnhaiR2CDxh5TMnkKzn1pSduDkc3vRFw9eMtphToAuIfDeQvR6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepfdfmihhrhihlucfu
    hhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeetieekffduudfgheektddvgeetieefteefudefheekffeiteff
    ffelieeiueevhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudei
    udduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshh
    huthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtgh
    hlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrd
    hhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehthhhomhgr
    shdrlhgvnhgurggtkhihsegrmhgurdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:5UeUabYPvhx6m3e7QpQGHKeG-2Zo7ILfFuifgy0PNHx7bc8ZUVqQMA>
    <xmx:5UeUaRqCSRY-oYkoR1w3ScSdzVxW6yTt71RAkNrmaHUicw9eVW6_pw>
    <xmx:5UeUaY0IqDT33IclvFQiSBKLpZgs6k86D1xRhkSPybANyKggwigJrw>
    <xmx:5UeUaRnaoKqbzD5t46BTcOVYQz2zGUJy01zmaTugMEJ9ILF1AlcjhQ>
    <xmx:5UeUacaRmYXL-qGnbWneWlL7Ro6UxG2SMzA2vJOWubUW4SpUvNj2CFIW>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 05:50:13 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Moritz Sanft <ms@edgeless.systems>,
	Mike Rapoport <rppt@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCHv2 0/2] efi: Fix alignenment issues in unaccepted memory code
Date: Tue, 17 Feb 2026 10:49:55 +0000
Message-ID: <20260217104957.249340-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6163-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8CB2314B013
X-Rspamd-Action: no action

This series addresses two issues related to unaligned physical addresses
and sizes when handling EFI unaccepted memory. These issues were
identified as potential sources of kernel panics in Intel TDX
environments due to incomplete memory reservation or missing "guard page"
extensions.

The first patch fixes the reservation of the unaccepted memory table
itself in efi_config_parse_tables(). It ensures the entire page range
covering the table is reserved even if the table doesn't start on a
page boundary.

The second patch ensures that memory acceptance requests in
accept_memory() and range_contains_unaccepted_memory() are page-aligned
before performing the unit_size alignment check. This prevents skipping
the necessary "guard page" extension for unaligned ranges, which is
required to avoid crashes with load_unaligned_zeropad().

v2:
 - Fix 'end' calculation in the second patch (Tom)

Kiryl Shutsemau (Meta) (2):
  efi: Fix reservation of unaccepted memory table
  efi: Align unaccepted memory range to page boundary

 drivers/firmware/efi/efi.c               |  8 ++++----
 drivers/firmware/efi/unaccepted_memory.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.51.2


