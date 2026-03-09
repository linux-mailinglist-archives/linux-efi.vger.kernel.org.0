Return-Path: <linux-efi+bounces-6272-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMD1C0i8rmn6IQIAu9opvQ
	(envelope-from <linux-efi+bounces-6272-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:25:44 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A559A238C61
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EE4D304B5DC
	for <lists+linux-efi@lfdr.de>; Mon,  9 Mar 2026 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094043A6405;
	Mon,  9 Mar 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Sma89FvA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3iJf9fG"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E343A4F36;
	Mon,  9 Mar 2026 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058673; cv=none; b=m/1Pz6/ZopjCf4CDwwtBii9LyvJwBDUcAbft6EgrFQVUuvLHLwYhi2w45pVBwPgHJlT8Qo8LUTdH55Fa1MEsWj6atUxKeuIiuYgK09PrddTmLHvuq0CUgDEb/iYJGMsdgewxan8UwkNKaTcOmKjkzvdTL9rRYsJp4hzqzWY2G+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058673; c=relaxed/simple;
	bh=XXyv1vSsKiZDP+TYzA3/8dZFNT5luObHH7rpvbRp6+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAX0TRlPELzIGwE7O/BxXr8pjiwAsHp8nBoczxIOYsdJvWeClh9kCOlx8MM1YkFHBMOgiBB/eB2frk2LSh5BEHNQuxbiDxDkgcLZJnbCpHsU446cw26/kXJO6wtXlEDraQXB/AxAfVvfwHYfEBaTrSZ0iZq5PCmHDjxIWe0fueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Sma89FvA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3iJf9fG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 88508EC0273;
	Mon,  9 Mar 2026 08:17:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 08:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773058671; x=1773145071; bh=xqkqiee5wa
	QOwJic/qsVej/NyQDtai116ygtpOvqQAM=; b=Sma89FvAZfg+PfEybOMR7l/fwT
	rxENHYi4ncZEa/Cg+/5PzFbUUvwuinrTDsBQn7HkwnumkDeFXEGob8/urYR50baK
	KKncY2UTXLfQKHjyZXzIBHBv/Py2Jpa1jbYo2yPGipUoTyx1Ur/e0sjUYc7o0h+j
	ywa+7LxcqG5EoIQaRrtxkfo1Y/tATDtOskwUuXcC6j3AzZIUo0OhX11bTA9NsrUs
	Hj1bVc+93nY5ENe9TSWYH8JA3ZSesapebYIeDyZjw6525B/jRZG0SqNaEzud8CEb
	YPnnkRJFfrV0IklTGSuGceBLrYazGDHyOyRPmLsozdy1PRCnBX7Nu346xpzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773058671; x=
	1773145071; bh=xqkqiee5waQOwJic/qsVej/NyQDtai116ygtpOvqQAM=; b=o
	3iJf9fGiYSG9zva9TE/RZ7hSCNjmmW6wXi4FKXEC+5meY9aPS80pmTumuDiyxO7g
	77YfnaYpXPF/7WPg+gTlyBkvXykVWlpZO4Om4XhspdH9oZfKPdG13UzrInX2EiV8
	bS3jq3pxx48r32/u5C/zDOx5wKGPX6Zsfy1MkavSS4F7wG3SDdWaJdLSyO0Ezl/g
	9dpM6OKMlm6mmlZ8ijSt//ypG1zO4IwPfJ8eaMOmR7mFQFitQqmX5iHEUUf6X34F
	/Rqm9NFp+sVeaCPeGVk9GBLdUODZOTpLBMD/olink7HCU3vpGB4Gop7nzBWlh2mU
	33H2yW+SpGJGZOiNzcJnQ==
X-ME-Sender: <xms:b7quaWwcuRy8ZenpEmZ5o6I72EvhI1iaNyToJhaMFQyZPh2gP-WPPQ>
    <xme:b7quacWBN7hwKqDPtK8DcjAyie6VDpBX950KpCOG6tYBuzlKOgt71hJlaSjUWeNEe
    vB4ZQ1y2741gk5KBYAPii78E3w6y0Xei3K4Sa1dJjnYIQs>
X-ME-Received: <xmr:b7quaYOarzkovhs_jM9QfO78FmYgGw9UUHtugkEVV9rHi5QJLWxX_iq27PsYNIF64yoJSONel5dCDUjyCCn21og4ek-XoCB98UfWE3dRDBI>
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
X-ME-Proxy: <xmx:b7quaeB2w-2PSr7ho1pTIpPcMe22EpMBM7lIOmVQrMwXrbI4vqP7eg>
    <xmx:b7quaVebE0NZxnFhjln5iYJ_P1RKQ0AtxQuJ-q7_YpU-5mbuwZuPzA>
    <xmx:b7quadNrBkjiFVOBTTZ2L0zzUXSG1TmqyW8iDNjauElcLkXwZqPFcQ>
    <xmx:b7quaVIJXvg9OtXLvdZ5BriDUfDUBG7WES-EdZ95N5jeCYb-ngJQHA>
    <xmx:b7quacEMpCO7V6N7R3P4Cbvki42lQAfkh1ZhVMidq10KPBwQAvUrOUtA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 08:17:50 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
	xen-devel@lists.xenproject.org,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
Subject: [PATCH 1/2] efi: make efi_mem_type() and efi_mem_attributes() work on Xen PV
Date: Mon,  9 Mar 2026 13:17:22 +0100
Message-ID: <952b54025f836c19f57d7207d3881cacf937a50a.1773058629.git-series.marmarek@invisiblethingslab.com>
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
X-Rspamd-Queue-Id: A559A238C61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[invisiblethingslab.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[invisiblethingslab.com:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.xenproject.org,invisiblethingslab.com,kernel.org,linaro.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[invisiblethingslab.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-6272-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marmarek@invisiblethingslab.com,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[invisiblethingslab.com:dkim,invisiblethingslab.com:email,invisiblethingslab.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

Xen doesn't give direct access to the EFI memory map, but provides a
hypercall interface for it. efi_mem_desc_lookup() was already adjusted
in aca1d27ac38a "efi: xen: Implement memory descriptor lookup based on
hypercall" to (optionally) use it. Now make efi_mem_type() and
efi_mem_attributes() use common efi_mem_desc_lookup() too.
This also reduces code duplication a bit.
efi_mem_type() retains separate check for -ENOTSUPP error case (even
though no caller seems to rely on this currently).

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/firmware/efi/efi.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index b2fb92a..36efc92 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -983,18 +983,12 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
  */
 u64 efi_mem_attributes(unsigned long phys_addr)
 {
-	efi_memory_desc_t *md;
+	efi_memory_desc_t md;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	if (efi_mem_desc_lookup(phys_addr, &md))
 		return 0;
 
-	for_each_efi_memory_desc(md) {
-		if ((md->phys_addr <= phys_addr) &&
-		    (phys_addr < (md->phys_addr +
-		    (md->num_pages << EFI_PAGE_SHIFT))))
-			return md->attribute;
-	}
-	return 0;
+	return md.attribute;
 }
 
 /*
@@ -1007,18 +1001,15 @@ u64 efi_mem_attributes(unsigned long phys_addr)
  */
 int efi_mem_type(unsigned long phys_addr)
 {
-	const efi_memory_desc_t *md;
+	const efi_memory_desc_t md;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	if (!efi_enabled(EFI_MEMMAP) && !efi_enabled(EFI_PARAVIRT))
 		return -ENOTSUPP;
 
-	for_each_efi_memory_desc(md) {
-		if ((md->phys_addr <= phys_addr) &&
-		    (phys_addr < (md->phys_addr +
-				  (md->num_pages << EFI_PAGE_SHIFT))))
-			return md->type;
-	}
-	return -EINVAL;
+	if (efi_mem_desc_lookup(phys_addr, &md))
+		return -EINVAL;
+
+	return md.type;
 }
 
 int efi_status_to_err(efi_status_t status)
-- 
git-series 0.9.1

