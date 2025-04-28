Return-Path: <linux-efi+bounces-3473-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54CA9F1DF
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 15:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E294D1889B31
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4052638A6;
	Mon, 28 Apr 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="QmaiHsfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXkRDEfA"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91B1F6694
	for <linux-efi@vger.kernel.org>; Mon, 28 Apr 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845957; cv=none; b=fomYWKc2s84ikvHrOruIxrnLwVBN6Eg9dNs2SQdLxXpiDaWzJ0+7UCxyoLhc1aBqsIWhpGxRP43y9fpHVQL8l4K55pCxfPByxZdWB2ERoTs4OphQULdXaarMzFAL973KtZbIKwDrthb3oxkdP4yDXMChQVApS2qA+shlVO7B7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845957; c=relaxed/simple;
	bh=5ouWE/IEQcfmGU5ZG/q37tlWKkGi5Ceus+0ZLijB8C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCi8Mb2S/kMYMOF/KYqwom+VzMD+hxs4wc7Z90tYTUNZDRqrRGOnEwWVzzRN7X6Bqh+lCgT66jfxRa7CvnXAPkedxPTFwdLZYcsPJ+U1aCLWyzYSk4SO13ZwLxjLeURhoFofE8ODdZz4gpgPZ/t82+/CX5JYTTyEpx5AymNxkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=QmaiHsfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HXkRDEfA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 413CF13800D3;
	Mon, 28 Apr 2025 09:12:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 28 Apr 2025 09:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1745845953; x=1745932353; bh=mQlHTazT9B
	kBUsR3GEXmgwq8BmvpqHDBT8L5xARTUzY=; b=QmaiHsfrxQ7ZlVgcZZdeEwBdQN
	PGcOxaS/ZBfr/tH02rllUm3idxz+lvePQtSqNarHOdweHmnJSQD4Bc3hUKSJ1OJr
	J4aH2YDWOyZ0uqGodzbLdSnx2JmgtQPwQn5WR1Ydl65WisUVJg0AIGWvq07/EaRU
	XbvTXFyBHWQ22+oeaLCi1b2DBsY4N+42QjiTLRX+DZFH9dxeBLnc50IMFGNbVE0w
	QBugChG4Ib3HTiyySwQfDYOon19fWCvUJn1/65jhB9Nk9mUL45SKI+mabuz7GIUq
	fNUyH/IxH4V/WMA/u49V6rXSWpSlTLp2Q7dqptjsqXgRibLcmBYOH81rCOIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745845953; x=1745932353; bh=mQlHTazT9BkBUsR3GEXmgwq8BmvpqHDBT8L
	5xARTUzY=; b=HXkRDEfANX9aW7F+r9tF6znzc/tXaYxeBGvTF9+yEtR5RuIGrLl
	PgMWjUEeqKtYIlDmNk0hMnul3KZdROsz95KIz4pPNRAHqTUyoiue5JBLr+Y9D54q
	Oq0i5bU52rcbbLDLNklZAZqOsVGbpDR/8a/ciBLjhgKaBRu2AtUlXi/byiNAEyWX
	8c7UsVcGQUQVO8AMePlAzvOc9Ok+Y6RWzol5wJIXtHdk6XKnUrwLL+Fp73a3OfFP
	gGo1Ay+muus9rv8Xuz3umFmIeLCpIFcD4+2vyQpwhElgXG3Pv1HHeRBOhHy7LhVC
	/b2kpBdSqmjg1dIRhEf5NghIbk+iUX5reOA==
X-ME-Sender: <xms:wH4PaAaipyeV-1yc5rqZFcVdYmYDjL1U30WVtm75UCS7Zjnk1sBaKQ>
    <xme:wH4PaLZ8b1dByHbO90tM6yGj1yr9RUwrPX_rWcf8Kvcd-eRuNzvNUrYAwuVHiyyLq
    imWqUDyNR4ra6lNvw>
X-ME-Received: <xmr:wH4PaK_1qyfOd62bPWE66_0iPIdNFXOMvcPisavuzU5SlecewZk3ShUDVKqm5wo5MOtCXXEi6sg_yDsV-oY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepjfhughhoucfqshhvrghlughouceurghrrhgvrhgruceohhhughhoseifhh
    ihnhhothhhuhhgohdrnhhlqeenucggtffrrghtthgvrhhnpeetveeutdelkeejvefhtdff
    ieeliedvteekleekvdevfeeiueejveefuefgvedtveenucffohhmrghinhepghhithhhuh
    gsrdgtohhmpdhsrhdrhhhtpdhmrghinhdrrhhsnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhephhhughhoseifhhihnhhothhhuhhgohdrnhhlpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhn
    uhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhughhose
    ifhhihnhhothhhuhhgohdrnhhlpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:wH4PaKpBKufnjEGxLF_z0RWfhpKXOnKGo9vxv0qTN5Q_VtjnzIs92g>
    <xmx:wH4PaLp1-JTHZKedTbcu4CjWZUP0ekxR-OFqOZZd3gHRwy_Fri5yyQ>
    <xmx:wH4PaITY7ftwWI3bUz3--DkdgrFtvC3nYweVTKiEqBLFpxFyZFx3hg>
    <xmx:wH4PaLpZGXlL6PR_m6zMpkxEJXC6jmps0zaiDS8Y2VRShe9cJrXjew>
    <xmx:wX4PaBmF1DkyRyd3FAxlXVzcWDcsEB2_kL0WrvHVS5_SWuUl4QjywBby>
Feedback-ID: ib8c04050:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 09:12:32 -0400 (EDT)
From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
To: linux-efi@vger.kernel.org
Cc: Hugo Osvaldo Barrera <hugo@whynothugo.nl>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Date: Mon, 28 Apr 2025 15:12:07 +0200
Message-ID: <20250428131206.8656-2-hugo@whynothugo.nl>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the Handover Protocol was deprecated, the recommended approach is
to provide an initrd using a UEFI boot service with the
LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
approach has been no more than an admonition with a link to an existing
implementation.

Provide a short explanation of this functionality, to ease future
implementations without having to reverse engineer existing ones.

Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
---
 Documentation/admin-guide/efi-stub.rst |  5 ++++
 Documentation/arch/x86/boot.rst        | 36 +++++++++++++++++++-------
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index 090f3a185e18..3af702259f1d 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -1,3 +1,5 @@
+.. _efi-boot-stub:
+
 =================
 The EFI Boot Stub
 =================
@@ -79,6 +81,9 @@ because the image we're executing is interpreted by the EFI shell,
 which understands relative paths, whereas the rest of the command line
 is passed to bzImage.efi.
 
+.. hint::
+   It is also possible to provide an initrd using UEFI boot services. See
+   :ref:`pe-coff-entry-point` for details.
 
 The "dtb=" option
 -----------------
diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 77e6163288db..2fecf89910ec 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -1431,12 +1431,30 @@ The boot loader *must* fill out the following fields in bp::
 All other fields should be zero.
 
 .. note::
-     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
-     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
-     loading protocol (refer to [0] for an example of the bootloader side of
-     this), which removes the need for any knowledge on the part of the EFI
-     bootloader regarding the internal representation of boot_params or any
-     requirements/limitations regarding the placement of the command line
-     and ramdisk in memory, or the placement of the kernel image itself.
-
-[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
+   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+   entry point described below.
+
+.. _pe-coff-entry-point:
+
+PE/COFF entry point
+===================
+
+When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
+regular PE/COFF binary. See :ref:`efi-boot-stub` for implementation details.
+
+The stub loader can request the initrd via a UEFI protocol. For this to work,
+the firmware or bootloader needs to register a handle which implements the
+``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` device
+path. In this case, a kernel booting via the EFI stub will use the ``LoadFile``
+function on the registered handle to obtain a reference to the initrd.
+
+This approach removes the need for any knowledge on the part of the EFI
+bootloader regarding the internal representation of boot_params or any
+requirements/limitations regarding the placement of the command line and
+ramdisk in memory, or the placement of the kernel image itself.
+
+For sample implementations, refer to `the original u-boot implementation`_ or
+`the implementation in candyboot`_.
+
+.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
+.. _the implementation in candyboot: https://git.sr.ht/~whynothugo/candyboot/tree/4097b2538d7f1cf85f03922bf42409490b666202/item/src/main.rs#L225
-- 
2.49.0



