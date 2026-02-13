Return-Path: <linux-efi+bounces-6131-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HF/JPxHj2kiPAEAu9opvQ
	(envelope-from <linux-efi+bounces-6131-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 16:49:16 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 119FD137B23
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 16:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6647F30720DE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92873363C7A;
	Fri, 13 Feb 2026 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHbMe4ts"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0425A2A4
	for <linux-efi@vger.kernel.org>; Fri, 13 Feb 2026 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997725; cv=none; b=gk6jw/TkRDm2Mv52KHoP20AR9cABC12Kc3YgFEKRat5GZXitOLXRdqxG75uMxi2AO8lXUbYld20Qn0NAxAOn8zJpoJpjU/6ZBHEntOVaNFULGjnNhHzf9u4SNyXBX9JxbArGx+f3kXR5KBUHFWR2emwpbAF7HkOL7ZyyBr4Miv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997725; c=relaxed/simple;
	bh=7dPdpuhsrQod7cEGqKBOY+A3ayeNPxUOOxb86J+eqNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcK6eDLYIYyY282SAQ+hRiSTUOG917/iVtQzZky7foLlm3yq7ByBKnzmPw2OlzWuDmBXrLNZyn+4MqSGPj+lK6fxBdKmA6SHyRaBVAWYPHIxZ8QCN0/GxgeqGkZv4KUW/DEFqeVnZCwS1r1XVU2mTgFJqI2Wlw7ulR8l0av3gYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHbMe4ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B99C4AF09;
	Fri, 13 Feb 2026 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770997725;
	bh=7dPdpuhsrQod7cEGqKBOY+A3ayeNPxUOOxb86J+eqNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHbMe4tsgtS4AB8kNPkasw4v4lIQx2jJiY4rmeA074j6L8cF3+MZQ4D51RAcKGB43
	 4YTjW61e3GFaBQOzYm2xXqtQtpaurWHtziQp8VyBgYcMVGPABU7oY2rzUqLCu5ER07
	 Wa4ClhCwTpRiKNhrBmIOljHVeeCDPYCVvS/A9R+afBGRyhi1v/uyBmk2U82Nc9o9Fs
	 qrQvn3KlaU3mV+SLsBL0JkV56mdYzxgg6U8rILsBe+kUuZUESqy3yEuO1K1DvvqsXD
	 xlo9CpXhJsSOMjPpoHROtxuMG06ANGKtIOFhqK2yD9B2cQ06Ss3tgvIjk665+gZ3Rj
	 QP1w4MCwP+xFQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0C048F40069;
	Fri, 13 Feb 2026 10:48:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 10:48:44 -0500
X-ME-Sender: <xms:20ePaRD4uHyBGkiPL0qlsL6WMm7clUVmDtpsRsplfW3OkwCsgKMnxA>
    <xme:20ePaXrQXgPrvB8_K3K2MT-KZugxXkMKggwOZ68tPOAwupc5DPl7zCv1ho7j4sCTu
    qsF_f9Fl4jjd769PKiznHfJoqEy_5wUOoUTMoXooTPZeP-3l25z5gYa>
X-ME-Received: <xmr:20ePacFtvWRWxsg15SbkfBnRGEcQgJjx-x1bdXUN-jYVPmudXx-W-AcdENewQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfmihhrhihl
    ucfuhhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpefhudejfedvgeekffefvdekheekkeeuveeftdelheegteel
    gfefveevueekhfdtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidq
    udeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgse
    hshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    htghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvh
    gvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehthhho
    mhgrshdrlhgvnhgurggtkhihsegrmhgurdgtohhmpdhrtghpthhtohepgiekieeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:3EePabufmfNv_zp39Weztfa3bg7vuToWgipf5ea4MOv4OWsder9ZUg>
    <xmx:3EePaSYmP6UlC7zglG4UoTZj4fRZYmOpd8FVyHvrhi8Mgm0sWFkP_Q>
    <xmx:3EePab4Bn5zc80_9mVKVvuAtvWVhqfeDSXXbzdLBxxPbvZJRam2O9g>
    <xmx:3EePaa98VoPFVzIQtw7DD7Ni_3XoLhpaUH8_tIxY9KLpcJbunBMzbw>
    <xmx:3EePaXac1mDMoNmUjKBgv3loiYU4PqbmRbjnF7nLh8WdPuACzjOQ8W9C>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 10:48:43 -0500 (EST)
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
Subject: [PATCH 2/2] efi: Align unaccepted memory range to page boundary
Date: Fri, 13 Feb 2026 15:48:38 +0000
Message-ID: <20260213154838.46567-3-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260213154838.46567-1-kas@kernel.org>
References: <20260213154838.46567-1-kas@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-6131-lists,linux-efi=lfdr.de];
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
X-Rspamd-Queue-Id: 119FD137B23
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
 drivers/firmware/efi/unaccepted_memory.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index c2c067eff634..9ddf3dedd514 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -35,14 +35,18 @@ void accept_memory(phys_addr_t start, unsigned long size)
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
 
+	start = PAGE_ALIGN_DOWN(start);
+	size = PAGE_ALIGN(size);
+	end = start + size;
+
 	unit_size = unaccepted->unit_size;
 
 	/*
@@ -160,15 +164,19 @@ void accept_memory(phys_addr_t start, unsigned long size)
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
 
+	start = PAGE_ALIGN_DOWN(start);
+	size = PAGE_ALIGN(size);
+	end = start + size;
+
 	unit_size = unaccepted->unit_size;
 
 	/*
-- 
2.51.2


