Return-Path: <linux-efi+bounces-6273-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIk5MCq8rmn6IQIAu9opvQ
	(envelope-from <linux-efi+bounces-6273-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:25:14 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60743238C44
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23208314B79A
	for <lists+linux-efi@lfdr.de>; Mon,  9 Mar 2026 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90463A7853;
	Mon,  9 Mar 2026 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="stkVUOnK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uOhkoL1E"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E838F941;
	Mon,  9 Mar 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058676; cv=none; b=J487VCjCvL9XotocTfGXbGxb4PAl7zcl+8+SkehVMX+cLlsR2hRsXlRbjBgeUi2yd9rUBZaZ8pos1cpmLV3JAZQBb5B0ril3TiTSy6B2Pc7hSszDGJHWy5KFffdMjDm1UJwnJ5Q2Dqes8iuuVhtLFSK7zaDM5s5tSiczKCLtzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058676; c=relaxed/simple;
	bh=nbRursth3NAOvheA1s6ueSqBViTq09Y3HTTMFy/tR98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2a6Eb5F2K2tAGCk4TfMr052Ai05aM75IbmFmov++TeosY125bQMH148MsWNjMCWhb56+qtL6Yb24L0YH4tfb6N9Vu7TzjuNovpqhuF/BHAIctyPZrK6+7J2V6VV+SDKyz7GqIpVZnsNiu15i85UhtMJcViJLAOoPfbIgPhgZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=stkVUOnK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uOhkoL1E; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D0090EC04DC;
	Mon,  9 Mar 2026 08:17:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Mar 2026 08:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773058674; x=1773145074; bh=vxQTTI3dqC
	AbknZWRjEqDbjVPMeCodcJdMqbuNqpGws=; b=stkVUOnKviF3cZ0l4UHwr7x8TD
	iQxAuWDpin2T6RvJFpnaPTD5gwimiUMx0k+WR7+ruRUG/cnD+kNbkWrNPw6o8p5E
	nOTkm501LswWKF9AZmCC6mwEQIFaOTzuWdjscdi0stunYP3g6ytAFpGZ/K2eP9rX
	+MWqvvQHhYpOGzZC7lKrGp7kig9sjdMhlSq4DogKW8GXPfbjiu60om2aITYYuEmW
	3PzgHGQ8BpFb7NGaTTpXOTOZmq3Dc1m/ozSUk7mf9odJpqRIbeq40SgPoV9tG2zx
	LbNHIkwPgGoUgMZ7O7NRdZpy869uohejeJoSakkOT9WlpzUVtXritXmqKKCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773058674; x=
	1773145074; bh=vxQTTI3dqCAbknZWRjEqDbjVPMeCodcJdMqbuNqpGws=; b=u
	OhkoL1EE/l9xCqGN4gPTo4U3frn5K1lfoODCx0Tmxhodn43l1oYPT8iqiVSqwcHc
	9XArMpkDY9NXe6ZfhhV0oQvqG8P/Pa7uM3m7zyFOVbi7vWo00jsnsh0liH3d4YXR
	6PwC6S03/TPB020MFP18n1bHxe/Ip9Y/LjIW/1xmroOTzX13t7HBQgm7tO6IGsz8
	RFo93xsHiY5aKdC75/2PyQSuq4Hs0eJoznfce6CsAo3v4VwVaegtJvgHwWyd6/C0
	BoxOZQw3Y9AMBHr3ZZ80K6Y8aUGAKsNhrKQIuAd/chMqEzCqDjFli4bZX8gw43Uo
	o5HiaAUqTErTvi213XCXw==
X-ME-Sender: <xms:crquaUgmgfrIN2Ez7The3_b7rRECLV5viJz-OWFOHAsPQ6lXKuq5eQ>
    <xme:crquaXFcD76IiLie4ykPVLTgyf2mgC-v92TfnXkSwBsCnVrwdz5lqT1kpk-kXMeeI
    rgCQ82abf55ei5ZrTNG_ZHgBLQUuBpU1fnJu2HwWsPQUKZk9w>
X-ME-Received: <xmr:crquab89nmMMZObDq0oioqqyDA84_oeAQTY0pmuhjm4hxx6h-BUVufZ9q3Wu-BwRfeJq-tQiBy-Rt3zLtjj6x7tjgG1E58HayCFF-PYoiN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefguedu
    hefgvdefheehudejheefudevueeghfekhfehleegveduteeuiedugffgffenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeejpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhumhihrghjhihothhishgrrh
    hkrghrvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgigvnhdquggvvhgvlheslhhi
    shhtshdrgigvnhhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepmhgrrhhmrghrvghkse
    hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdprhgtphhtthhopegrrhgusges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhmrghsse
    hlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:crquaWzfVrJE7TBUMTIlk7LQ8eU9d-ttfS9MwAC2HDAaDEXT1aQyQw>
    <xmx:crquafPm1C4HDzrGo4AgEMchtP29i7dwl8cl-QJ4-zQT3GLyAgxvnQ>
    <xmx:crquaT_FEU8k6QiHto3nqw-5DnQphFph5LQ3gW0e4zcZtyrvw1znlg>
    <xmx:crquaU4kGkI3Bhps-FVElWi9T3EpFIt69mUzJKL7qUpm9jCWwbHCWg>
    <xmx:crquaaGHDGDXYDxMfWXPPvPa-f_AG1fXnBVEM-sExvj8kWFoOH4v53L8>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 08:17:53 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
	xen-devel@lists.xenproject.org,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
Subject: [PATCH 2/2] efi: Enable BGRT loading under Xen
Date: Mon,  9 Mar 2026 13:17:23 +0100
Message-ID: <e5b932ab7558d82d5db018fd737da5ef2870aad4.1773058629.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.751f45ebbb644244b1d9da3aff289d6b66db4c6b.1773058629.git-series.marmarek@invisiblethingslab.com>
References: <cover.751f45ebbb644244b1d9da3aff289d6b66db4c6b.1773058629.git-series.marmarek@invisiblethingslab.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60743238C44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[invisiblethingslab.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[invisiblethingslab.com:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.xenproject.org,invisiblethingslab.com,kernel.org,linaro.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[invisiblethingslab.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-6273-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marmarek@invisiblethingslab.com,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[invisiblethingslab.com:dkim,invisiblethingslab.com:email,invisiblethingslab.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

The BGRT table can be parsed if EFI_PARAVIRT is enabled, even if
EFI_MEMMAP is not. Xen will take care of preserving the image even if
EfiBootServicesData memory is reclaimed already, or invalidate the table
if it didn't preserve it - in both cases accesing the table itself under
virt is safe. Also allow the ESRT to be in reclaimable memory, as that
is where future Xen versions will put it.
This is similar approach as was taken for ESRT table in 01de145dc7fb
"efi: Actually enable the ESRT under Xen".

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/firmware/efi/efi-bgrt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index 6aafdb6..1da4515 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -29,11 +29,12 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 	void *image;
 	struct bmp_header bmp_header;
 	struct acpi_table_bgrt *bgrt = &bgrt_tab;
+	int mem_type;
 
 	if (acpi_disabled)
 		return;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	if (!efi_enabled(EFI_MEMMAP) && !efi_enabled(EFI_PARAVIRT))
 		return;
 
 	if (table->length < sizeof(bgrt_tab)) {
@@ -62,7 +63,9 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 		goto out;
 	}
 
-	if (efi_mem_type(bgrt->image_address) != EFI_BOOT_SERVICES_DATA) {
+	mem_type = efi_mem_type(bgrt->image_address);
+	if (mem_type != EFI_BOOT_SERVICES_DATA &&
+	    mem_type != EFI_ACPI_RECLAIM_MEMORY) {
 		pr_notice("Ignoring BGRT: invalid image address\n");
 		goto out;
 	}
-- 
git-series 0.9.1

