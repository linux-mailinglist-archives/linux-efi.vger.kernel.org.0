Return-Path: <linux-efi+bounces-6164-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HYjDQFIlGn0BwIAu9opvQ
	(envelope-from <linux-efi+bounces-6164-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:50:41 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F414B032
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84CB13037447
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E574329C73;
	Tue, 17 Feb 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfKh9WZ7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC99329C6C
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325417; cv=none; b=aODGnqVSUyONMAQO0w7O1GRW6RjUVmlpgCynMbZPOhJPKBGZYAaJC25yvmEtmxipGLueGPeq3061nOKB6RUWpFE0CHiZJV+wv1Z9/Jho3M0QQw2nmIlm8G1f3Ynp9DZGPVNqy9GeUUsJ+/8KcBiCV4YAK0zIqQM9Faq7BWMEEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325417; c=relaxed/simple;
	bh=PTJFDGkeSN26ugvAI4aRe+dHGTbs5yOXGvLemsc0sMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqztcZ3UsPlTXNthAYcBCOJMbOj5BwGWnc7IitF6mYdJFBA/P+q+uLATOfGEimZhFQFNAEO1Oy6JnV9R9B3T3BRnS55Y6z7uXjp4q87E5q1/pKiJff861UfPBtw3ZlfU0/JGDuCKlQ9EzSDpSiizzrEJ/KlC0Y8Gts4nUKBEM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfKh9WZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803CAC4AF09;
	Tue, 17 Feb 2026 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325416;
	bh=PTJFDGkeSN26ugvAI4aRe+dHGTbs5yOXGvLemsc0sMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfKh9WZ7rrdPHsMVJ8riwZwM6xKqp0tAAW1QxfpxaBVHwRnrQ8j6K0VMrZHUj28zm
	 NFW6ntHDBQ224IVEeKCS5Mz1szVhs8TuOD+2gbf1W3HnI+pHzEwlQiQwFmYCmPIHwa
	 +5d1CPmMbwc92MsdlaGwB5rUWNWBY4kQrQEwz4827MilsauUufQuD9ADJ3QKPp6wIf
	 DBGlEyVr557YXLyQMljywb30TtNFh8gLPF7B00FL4x4ZB1FMA1k5xnFRGtCprJ5Pgl
	 qQJ6P1Inp7tscdSnIEbSlA2cpukkyoH1Sqm3j4sOuS2MeRWPLawGY/Bh89GgQ3ONK1
	 KaMeOW4bnUlVg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 95F71F4006A;
	Tue, 17 Feb 2026 05:50:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 05:50:15 -0500
X-ME-Sender: <xms:50eUaTN-zJ2YoI9BsyfJ4KYVmkSmz7tQUmD8Q-A6dV6BZfTaIAkscQ>
    <xme:50eUaarZIYivTMVJy86fSRFsdeWQScruLEmIMbbUSAUt8UpIgAomhwwoTYWIGV5qX
    6b49YpzCnYu9Wpkk7zrDgl1sov2GStBwD0OqxMedg4CgIKytQrgl-g>
X-ME-Received: <xmr:50eUaWJMnu4uyx4NZfAoCyEjMgtP5oVNzjkyXTITJ0--XARlGEAnrmSfjPqCiA>
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
X-ME-Proxy: <xmx:50eUaR2FJNb3T37kQdwKG2HA4HE8kgK1ICVdlzN-lAxnZO24sHMRXw>
    <xmx:50eUafUIWKE6cryVX8K9-x29frRCRUar7SbRcFKEMGgdMgQWK5iqIQ>
    <xmx:50eUacw15LLWqSRq6K-ISZd42D9oVnuAjDMuzv6K5MZmftXvvih4aw>
    <xmx:50eUaey3-tJWgcKOJzlgQSnwvGWKdJmoFnkM9qqakzhOYh_AFCMqOg>
    <xmx:50eUaZ2WrOkUxRxjhasi7LnUhuyFrhllG0C81CZZgA_z4AljCjr9be2o>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 05:50:15 -0500 (EST)
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
Subject: [PATCHv2 1/2] efi: Fix reservation of unaccepted memory table
Date: Tue, 17 Feb 2026 10:49:56 +0000
Message-ID: <20260217104957.249340-2-kas@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-6164-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[edgeless.systems:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B04F414B032
X-Rspamd-Action: no action

The reserve_unaccepted() function incorrectly calculates the size of the
memblock reservation for the unaccepted memory table. It aligns the
size of the table, but fails to account for cases where the table's
starting physical address (efi.unaccepted) is not page-aligned.

If the table starts at an offset within a page and its end crosses into
a subsequent page that the aligned size does not cover, the end of the
table will not be reserved. This can lead to the table being overwritten
or inaccessible, causing a kernel panic in accept_memory().

This issue was observed when starting Intel TDX VMs with specific memory
sizes (e.g., > 64GB).

Fix this by calculating the end address first (including the unaligned
start) and then aligning it up, ensuring the entire range is covered
by the reservation.

Fixes: 8dbe33956d96 ("efi/unaccepted: Make sure unaccepted table is mapped")
Reported-by: Moritz Sanft <ms@edgeless.systems>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/firmware/efi/efi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 111e87a618e5..56e9d73412fa 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -692,13 +692,13 @@ static __init int match_config_table(const efi_guid_t *guid,
 
 static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
 {
-	phys_addr_t start, size;
+	phys_addr_t start, end;
 
 	start = PAGE_ALIGN_DOWN(efi.unaccepted);
-	size = PAGE_ALIGN(sizeof(*unaccepted) + unaccepted->size);
+	end = PAGE_ALIGN(efi.unaccepted + sizeof(*unaccepted) + unaccepted->size);
 
-	memblock_add(start, size);
-	memblock_reserve(start, size);
+	memblock_add(start, end - start);
+	memblock_reserve(start, end - start);
 }
 
 int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
-- 
2.51.2


