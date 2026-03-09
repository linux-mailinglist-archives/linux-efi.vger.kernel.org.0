Return-Path: <linux-efi+bounces-6271-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INCbKBq8rmn6IQIAu9opvQ
	(envelope-from <linux-efi+bounces-6271-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:24:58 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12659238C34
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 13:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBFE4311125D
	for <lists+linux-efi@lfdr.de>; Mon,  9 Mar 2026 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65499377541;
	Mon,  9 Mar 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Qhw3R8Ll";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFa9/9Qm"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DB1E98E3;
	Mon,  9 Mar 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058669; cv=none; b=drnARvfEdGCYyMxzy1w9XsbxLsOd/FRMFvC6GT5CdzNpWVENRKiXL4BDzvb2Koq030EhdLx6uMIs/hmxr0PZgstCJt0X+crbUvdJm4HyqHEpX8UFG8UBYtFJ1CuQIt0RgkYo0CVIhF5dNeKLositE1EJod+ZiV5meRqgiQJqZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058669; c=relaxed/simple;
	bh=wbBO9HotlguzJY2KiM/jC+okTVhlp9IZ267hTwu4e1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aw5qoyHzymd64xBC2QnApyySlfdVKiUyK1ZEpeB8op1IAXbwrJ9CSQgooJekkuuP4ctZRMh230c66GwxN5p7KVClF//ovpvg58oUdcVS76ksy0vJdF/myquO6uKzUlUsswoQ7YUpzkB+maOZrQVMfLllO5edq7eSs/QOMy0IXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Qhw3R8Ll; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFa9/9Qm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29D1D14000F3;
	Mon,  9 Mar 2026 08:17:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 08:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1773058666; x=1773145066; bh=YpKQcaQQ0Co1PPHvvVGmm/YJrK5gAvd6
	rTDRRxrgn/w=; b=Qhw3R8LlnKvaO+yPoBNDyI+Es8t1LeIdR95zYRIF1L9oojUK
	f/r0cWYGZJ0SNPeGM0MweELryPe7qmse5wH3RENIm/DRKmiSfs1fdo8OGMFUqtXw
	zGUkE82iPbtHmG4qdWBRSco3hNSD5nhgMnm6c50Ncawl6DeadoqL2lQol6H47YqL
	M9huUn6CBWxxK3ltASxuRARSlMu43KcfvOiuIr0lPASFtI6rrO1qFLgC8U1jGEmC
	xmrK6mXIgrG4P33as8TLvdaCgOCMdU094eLgYot8ApTBLQg9REkhydWmMOFLfy1a
	eNiO03mOq9td+PGwWWib3KpMq2XGLmEkznw3Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773058666; x=1773145066; bh=YpKQcaQQ0Co1PPHvvVGmm/YJrK5g
	Avd6rTDRRxrgn/w=; b=DFa9/9QmMsHdzfHVzfbaS9LHCjf7/BIHA6rrRoeXiRkQ
	J15KQ2vtiHoNOUhF/nqFsXdi7Ew4TTaM3H/oiv0o5Dq5pxYtLYwJMh+bsf+qCbPX
	0zUSs1UEOODu2o3C6rfwbMQyZicWhjjmcJVZE/5IyIxhW+CVWeBvZvA4U1AhuokZ
	zQgNy2B7r0726DN39nOD0fkXMUl/h5HMtIVtHL4xsk98UxD5NSB/WHTX+QlQv692
	7LBc6gxn2rCqDnMcQAV/kUgrfXqiQqwVUqDOgQmg6FtZOj4m2y2Q3GTa8oN4zuNo
	CjX5KSWaGP0rguhIFVGsYqZ+vY1w154or5fJkcp4sQ==
X-ME-Sender: <xms:abquaeAOTp725-iO3nxJwx6tp9PTqcmXooGfBD1guHO02MPBcRGeWg>
    <xme:abquaSn1ZtFe584fQy9KI3lWgxwoKl6IdhFVwzYq4QhrRLJF3foccr_uT1dJxpX-O
    lj665UizY7-g4plr0qoS6gNRuN4Xsd00hkF46TeNoqHnIE>
X-ME-Received: <xmr:abquaReUv6xJkJKlq5Q9XOMmLSAK4IaFkg8kXnW220BhvCDX0cnWpwVHE6gPI8hXkoRggOnbqdPAmUiWXw0K6QzXBUco9YQAZ1XyxTES6Bo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrvghkucfo
    rghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvhhish
    hisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeekkeeiveek
    ueehfeegveejveevuedtjeeiveeguefhvdffueetfedtuddvueetveenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhouhhmhigrjhihohhtihhsrghrkhgrrhdvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopeigvghnqdguvghvvghlsehlihhsthhsrdigvghnphhrohhjvggtthdrohhrgh
    dprhgtphhtthhopehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggs
    rdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
    lhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:abquaeSyO7IY9k3xkXIhcyTD-TANVtwzvhshxBu4bON2d_H-r7B5RQ>
    <xmx:abquaQvB4Lsig2u2tLLPDKemmVUYcBT74rUNkml-2Wj85a8CRtFSGw>
    <xmx:abquaXcxL-Gxq_bgpImmrtrrdBE-tvBWCtZVMqU6UevckmpqWWsVwQ>
    <xmx:abquaSaIezv1aoKzOiFbqiDyNANC1lfEw_7CIT6W3LDh4d_NEFTrDA>
    <xmx:arquaZkU6g1ycNUjwqaA3pCyyz_0MbVtgz_wtesb5XSs6Jm0OBmHQrdt>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 08:17:44 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
	xen-devel@lists.xenproject.org,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH 0/2] Allow using BGRT table under Xen dom0
Date: Mon,  9 Mar 2026 13:17:21 +0100
Message-ID: <cover.751f45ebbb644244b1d9da3aff289d6b66db4c6b.1773058629.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12659238C34
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
	TAGGED_FROM(0.00)[bounces-6271-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marmarek@invisiblethingslab.com,linux-efi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[invisiblethingslab.com:dkim,invisiblethingslab.com:mid,xenproject.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,linaro.org:email]
X-Rspamd-Action: no action

For a long time Xen was invalidating BGRT table as it was reclaiming
BootServicesData memory (where boot graphics is located). This is now changing,
and the boot graphics is preserved. This series has necessary changes to
actually make Linux use the preserved graphics.

This is a companion series to Xen side at
https://lore.kernel.org/xen-devel/20260305191810.31033-1-soumyajyotisarkar23@gmail.com/

CC: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: xen-devel@lists.xenproject.org
Cc: Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE INTERFACE (EFI))
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org> (reviewer:EXTENSIBLE FIRMWARE INTERFACE (EFI))
Cc: linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))

Marek Marczykowski-Górecki (2):
  efi: make efi_mem_type() and efi_mem_attributes() work on Xen PV
  efi: Enable BGRT loading under Xen

 drivers/firmware/efi/efi-bgrt.c |  7 +++++--
 drivers/firmware/efi/efi.c      | 27 +++++++++------------------
 2 files changed, 14 insertions(+), 20 deletions(-)

base-commit: 7e1526209cf972f51281558f1cb979d18e49cdd1
-- 
git-series 0.9.1

