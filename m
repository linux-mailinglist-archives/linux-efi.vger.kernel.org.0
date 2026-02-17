Return-Path: <linux-efi+bounces-6165-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMDfBvxHlGn0BwIAu9opvQ
	(envelope-from <linux-efi+bounces-6165-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:50:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FA14B023
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0949F3030D19
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889E329C6F;
	Tue, 17 Feb 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbjV/W9X"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45575329C6C
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325419; cv=none; b=tZ+KfK6VehACNAd21E59OX0q3Uo9GY5WZi3mpwrJXv7hFNnSGfIs7Q42xP+jMDRpAAWjr7xe3LmLyulecLd5Ra3cD1T4OgIWKiyK7xSNKO/HKKRpmK+pjqi9fa3CmNAEsuULgRSmRts9kprSsDTINVYhm8qVLFGz8x+O6QTfjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325419; c=relaxed/simple;
	bh=xE/869Bo+esNtn+UnIQSf4BQa1m8IjcPxSsG7/pPAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP9zL5nZHFmaVJZqz2pEvE4okXj7tcZ8tx7QSYLPvbEp4NJ4iX2R5MLCS9UDMypR9aCqXV/bBOgsFjzejhsj3h7jruwnMCLPCroU0shek7/PwA5miNU+BgYYBn+Awb3m14bconQwoY5OZ0WGBMUhwgWVSeL9iO4blA/+4tgIZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbjV/W9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D86CC19423;
	Tue, 17 Feb 2026 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325419;
	bh=xE/869Bo+esNtn+UnIQSf4BQa1m8IjcPxSsG7/pPAWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbjV/W9XJxSiC75k/8A1lJn0OwBb771o6lywyOsF4sHJULJ7gQiIst6onqtmWMQb2
	 IaCAKopQ9Ktyk7vz/hTqSfkUtMx6FAgU4gab8z1BTX0Adjx3tzuDzruFvjSQu/uXJ+
	 Tkhde+mprxQ4SebqbMxy1m3oQYYApOkHBlUbcOwQUiPfRY3R/vBE/JAHaHB5A26UmA
	 BNbRyGoOe1gFEOFVTytNJ5tyWg4k6iffxMThca7oaTzZ7hqbWnbRfTtM/TMsw8WyJl
	 zRi39IaleaRISYNnSIG0ALgj22Y3TV+o4ITYlcmeohNeq5uKmElOmwK/EaHeDKG5zH
	 KnqdKCOfAa1tQ==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7660F4006B;
	Tue, 17 Feb 2026 05:50:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 17 Feb 2026 05:50:17 -0500
X-ME-Sender: <xms:6UeUabPidlUiMyY1cNH-JU7E_1F0RXxZHbv6oqE0w0PaSOg-ID57Pw>
    <xme:6UeUaSqk-Xcw9EHLXx7Mk8ud9ieI00AwsJbAD12ifnzk-Jir61JopRwOQIcPYt9sS
    sfcOu7v3BVYW03-7w_BtgvVBN7G1E4OR-ACLvyX2lBLOuzgvFiaxsg>
X-ME-Received: <xmr:6UeUaeKEbptCJgReUjtrSsgMmDGVAKTWweL3NJEavdOzdf17mmYGAvY7WMPd_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfmihhrhihl
    ucfuhhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpefhudejfedvgeekffefvdekheekkeeuveeftdelheegteel
    gfefveevueekhfdtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidq
    udeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgse
    hshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    htghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvh
    gvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehthhho
    mhgrshdrlhgvnhgurggtkhihsegrmhgurdgtohhmpdhrtghpthhtohepgiekieeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:6UeUaZ2Tj5N02RAshMwc6S3L3SQaDN9Y_iZErKl908KPJVg6quFT_g>
    <xmx:6UeUaXU19NSGbL8hBkfr3Nueg4cx4OSsvam_FWAH7pAl5iv0Dd_1ng>
    <xmx:6UeUaUwoXgJVvPyboC-wkzaN_MqFR-YbLhT_UBruB-DBsnUv_079gQ>
    <xmx:6UeUaWz4xcdhgrtttCgYi9XkKp_8JCEzKzJtjfrmJS0pAG18a3aVag>
    <xmx:6UeUaR0NKjZjRdksqhBwUwO1kHYtzdQaIAAFsyca4XHhXOye20BcHuxp>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 05:50:17 -0500 (EST)
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
Subject: [PATCHv2 2/2] efi: Align unaccepted memory range to page boundary
Date: Tue, 17 Feb 2026 10:49:57 +0000
Message-ID: <20260217104957.249340-3-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217104957.249340-1-kas@kernel.org>
References: <20260217104957.249340-1-kas@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-6165-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B66FA14B023
X-Rspamd-Action: no action

The accept_memory() and range_contains_unaccepted_memory() functions
employ a "guard page" logic to prevent crashes with load_unaligned_zeropad().
This logic extends the range to be accepted (or checked) by one unit_size
if the end of the range is aligned to a unit_size boundary.

However, if the caller passes a range that is not page-aligned, the
'end' of the range might not be numerically aligned to unit_size, even
if it covers the last page of a unit. This causes the "if (!(end % unit_size))"
check to fail, skipping the necessary extension and leaving the next
unit unaccepted, which can lead to a kernel panic when accessed by
load_unaligned_zeropad().

Align the start address down and the size up to the nearest page
boundary before performing the unit_size alignment check. This ensures
that the guard unit is correctly added when the range effectively ends
on a unit boundary.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/firmware/efi/unaccepted_memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index c2c067eff634..4a8ec8d6a571 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -35,14 +35,17 @@ void accept_memory(phys_addr_t start, unsigned long size)
 	struct efi_unaccepted_memory *unaccepted;
 	unsigned long range_start, range_end;
 	struct accept_range range, *entry;
-	phys_addr_t end = start + size;
 	unsigned long flags;
+	phys_addr_t end;
 	u64 unit_size;
 
 	unaccepted = efi_get_unaccepted_table();
 	if (!unaccepted)
 		return;
 
+	end = PAGE_ALIGN(start + size);
+	start = PAGE_ALIGN_DOWN(start);
+
 	unit_size = unaccepted->unit_size;
 
 	/*
@@ -160,15 +163,18 @@ void accept_memory(phys_addr_t start, unsigned long size)
 bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 {
 	struct efi_unaccepted_memory *unaccepted;
-	phys_addr_t end = start + size;
 	unsigned long flags;
 	bool ret = false;
+	phys_addr_t end;
 	u64 unit_size;
 
 	unaccepted = efi_get_unaccepted_table();
 	if (!unaccepted)
 		return false;
 
+	end = PAGE_ALIGN(start + size);
+	start = PAGE_ALIGN_DOWN(start);
+
 	unit_size = unaccepted->unit_size;
 
 	/*
-- 
2.51.2


