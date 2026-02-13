Return-Path: <linux-efi+bounces-6129-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEiQGN9Hj2kiPAEAu9opvQ
	(envelope-from <linux-efi+bounces-6129-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 16:48:47 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC00137AFE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EF9D300DCDA
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA28246762;
	Fri, 13 Feb 2026 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9vTnF6F"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F923183B;
	Fri, 13 Feb 2026 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997722; cv=none; b=A+NQMY7QC8vxuyVtHTg3NtqIq0ZWoEM16ciz19cD0MG/gfDVQJfBjxwQDdrP0ZakK+fTjujb0CVku79FfKsl612m/kejAkqlKmKJvERFf7tDg/2LEheoAKUIXfR20GnbNkX2EQU6o4RFScZDYcb6KYgl8Xs2/h9P/HMRBlXBNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997722; c=relaxed/simple;
	bh=KwYTy/KER0mm+nMwgJa21Fhpvad7CAER+z8MsqYWKgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDGxcQqIssTYR9vOPuuHEDGrl3yIvnJKwpKs+EHKQWEhl0zNt9IxRfOZL5vTqt9ShPYatLrl79/LYhqs/IG5Z/ZUi0Rul1D+LxKBVKQBzrX5hTRIeWyy89itE7RsgfBYYGQtHGAAbBXHyVCR0z4l9aUoahxI9t6BAxxrNlwbAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9vTnF6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1CAC116C6;
	Fri, 13 Feb 2026 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770997722;
	bh=KwYTy/KER0mm+nMwgJa21Fhpvad7CAER+z8MsqYWKgs=;
	h=From:To:Cc:Subject:Date:From;
	b=B9vTnF6FaSCyUscgOrG289uLgSL/FAJ5yiCLue58AxvbtjIbJ1rNZXPBy8q29UuwX
	 TnXc4W6y23jKXAN6kHKo4s9y1FncZtY0wLyfN+GV7QpDHU7tUNBQLQ4/LiVOsKCCUO
	 baEyhUCxhPgmqAMCnWs87x/dBbnj9Vmd1w6WChMz/2x0CfoKrwQhKyOJP3k9yDgrfS
	 wvk7jaHs/fzPwGmOZNj8vLOzrBVHCaHbkX27Lxy66JvPutaOTVJRP6wZ6i/E2CTTpF
	 p9YjNEFO/e9vuQ+nbqzPGA475H1LpHmjyW7Og7SoDa94qpb3qFzJOwZTXycuA37LGB
	 T0WXFoq8rtveg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id E6FFAF4006A;
	Fri, 13 Feb 2026 10:48:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 10:48:40 -0500
X-ME-Sender: <xms:2EePaVZ1HzW-6_WabKbFZ8XYv-QV44Rp0a0cUprXtSBpsT_xVmrX5Q>
    <xme:2EePaUgLF8z4oU_w8785Qb-joNz68g12MJfLy-RTjaMynXTnMIjgwlInlmp9XwxFd
    lqnrmaV6MMUKSOAkqlYrkd3AcHDjB1yv5F0Yiy9NTYg-ZMAArenQW8>
X-ME-Received: <xmr:2EePaXeL6zl1gKjQMAPnPSkLGh0pLG7QdastRgrj7C-FF5RTx1H0cOiKR9-fjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepfdfmihhrhihlucfu
    hhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeetieekffduudfgheektddvgeetieefteefudefheekffeiteff
    ffelieeiueevhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudei
    udduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshh
    huthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtgh
    hlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrd
    hhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehthhhomhgr
    shdrlhgvnhgurggtkhihsegrmhgurdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:2EePaTnKtV7zM8w4j6y1oqot6AhCwsNfCp6rOHdtBPgXMjSTRf7jVw>
    <xmx:2EePacxxkv6diwEtz1mT9xxVOmBJ7skD3wwlfNaS3vBrou06s8bSOg>
    <xmx:2EePaWxbFSz_t59i6ufq2nZX2Rn-s5QUlYcBFN_ftfMZ3AKzS-Z0Xw>
    <xmx:2EePacX_tH2SUKoXCdxQuTOxF_eMqR9_PCNJvVE0DHmGXxXHGMq7yQ>
    <xmx:2EePadQwItHf1mHrlooEFgoPBNkgOpzDx-BuZ3qwni-13pItpsjrTLTA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 10:48:40 -0500 (EST)
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
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH 0/2] efi: Fix alignenment issues in unaccepted memory code
Date: Fri, 13 Feb 2026 15:48:36 +0000
Message-ID: <20260213154838.46567-1-kas@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-6129-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DDC00137AFE
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

Kiryl Shutsemau (Meta) (2):
  efi: Fix reservation of unaccepted memory table
  efi: Align unaccepted memory range to page boundary

 drivers/firmware/efi/efi.c               |  8 ++++----
 drivers/firmware/efi/unaccepted_memory.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.51.2

