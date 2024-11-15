Return-Path: <linux-efi+bounces-2149-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729259CDB86
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A22C1F22796
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701718C322;
	Fri, 15 Nov 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHCSyCHx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7118DF93
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662812; cv=none; b=k8a5Ej4wcvqInVMcFrBXxfrsCLM9j+xdq+XLdN5nXVvFjMzn1x2yeeosGmeP0IVj+G0WTkr8cdx2LX/39bEojGk4pjMxv9M/h8Ck+tyng7DTaqIIXVqGIVWU7VXi6m8YbUhatJhxq7VGIRq/UBzPkZvDZK1ZqgDTaazT/Qc+2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662812; c=relaxed/simple;
	bh=ndka4RtTDhv/hwaN/xK2OgPEU6dHNpia/TRG0qDPOQ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SJShs0Hhb0eeypCH3Vhh07qptLHIDTcvNLmhzQ02Kbn5Je4CoAGOtpq8qUYmOnedH25D3PxNnOW+keX5Hip3oRs/IIGyANIbxhFiBwlsjEewDBwe/81xnlA0LtZpSOKo+//nREeJE3vOYhD5jBm6fuPUPv93xUAY7uulszyO7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHCSyCHx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43159603c92so11072195e9.2
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731662809; x=1732267609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9kjUv4bD+RtvjfAVFSaaQqMBy8iE9HTCOQpTvVLpFRA=;
        b=LHCSyCHxaQ8htGtZXly6zXF5e/h35LwNIDKM25TNYFuKd2tN5GI8MvlAMBA5beOhcQ
         ogFpwNFkYuntc9r+oC4AyMXLJ/3ysiG30UyaWFlgyxv0txrKEgDWhRPXXIdg26VLWQkJ
         BYFjACbRS7En6CUzXvYzv5ym4vGvAOm09UtryQIUdcYClzJp54UQIPkZ0oNAiyCsUxpD
         qbqCB30GgbCW+Gi6+2IpQGOd82OB97NfOSpWPsdgJpjI47nD46/8G6NlfXwDIjD4qbfK
         iEK48azU53CYiG7+V8MtVv5G7osgOphBMMbnQsFiM+GetD7m2cdL1QImdlL14syGZzSU
         A/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662809; x=1732267609;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kjUv4bD+RtvjfAVFSaaQqMBy8iE9HTCOQpTvVLpFRA=;
        b=vYkSdY05uvi3hhJRAVrNajrUtuBfIPtgweyYogaK8Q3tgAXcZ9noVSjlp1zG+OjIin
         jjss8DqUkTWC6UvC6zRr50KROHSyZbbasAuEauMjcOa8NeHrHRANbwYTFPv87EAgjSmb
         vF4fYBTUT1da4cK1tn97KXwl/Dr6EO7u/Hj4mIp5VCrv8iKDhtMoOPuPVliYy4DHGybI
         vQXT5pVGYjQk096K1C2GUxtE/Lt8qVfe4O1ktI10EfDX9ZOJUClMWDrqvDONEN8KzhEI
         hEueIF6N5A9uZS5pCOc5YxHNsmkQf91fTO6BNqWMjQvOSqcTNwos1W+18+AEt54PC+Xq
         XkSg==
X-Gm-Message-State: AOJu0Yy0gly8SXrgA1Dsaq5HxO25Qmmg8a7GnOT3wgM3P0WqAp/XIVUT
	ECFwkYbGh8CmCnLuiEpx7dK9urytg+PuITvxCLTLBgYrcQXdOh0rNXXDEzZCAbON++dgkLZS61A
	YkLGcGvg2lWS0FDjwTVt/G7Yv5N2iFh+bNHnzXv/AsKcYBU+FOzql9tu9YjZQiJ3Hya9jpHPCOa
	amnKbgxwd1lgSda0FdyQLtOa5pYQ==
X-Google-Smtp-Source: AGHT+IFUqwlXKaGRvRf+djx+YZhulyEYnSd5MeGZFebyucuqR7QwcmjomRUikxtpKT8Notm0j0W/ZvHY
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:558c:b0:432:d8a9:2b75 with SMTP id
 5b1f17b1804b1-432df67e50dmr22495e9.0.1731662809279; Fri, 15 Nov 2024 01:26:49
 -0800 (PST)
Date: Fri, 15 Nov 2024 10:26:39 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=ardb@kernel.org;
 h=from:subject; bh=oxS9yaOn9ZAyDxStqFhmWcCxJnuwhpHvSl2uTw1KRHY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1c+Nx6kxKr7ap9s7xU56m3vVvWfzarbs1f6UPv5p31v
 CvoEBvbUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSdYSR4Srj1QOn9tbHznt/
 MlU9qMIy6YxJm8gchx33Beb2HTp68zDDH74Lk5v+uO9bKa00Z0seS1Xem3UXhS4Ihr8U/TI7uEw 9nQUA
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115092638.3080237-2-ardb+git@google.com>
Subject: [PATCH] efi/zboot: Fix outdated comment about using LoadImage/StartImage
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

EFI zboot no longer uses LoadImage/StartImage, but subsumes the arch
code to load and start the bare metal image directly. Fix the Kconfig
description accordingly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 72f2537d90ca..e312d731f4a3 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -84,12 +84,10 @@ config EFI_ZBOOT
 	help
 	  Create the bootable image as an EFI application that carries the
 	  actual kernel image in compressed form, and decompresses it into
-	  memory before executing it via LoadImage/StartImage EFI boot service
-	  calls. For compatibility with non-EFI loaders, the payload can be
-	  decompressed and executed by the loader as well, provided that the
-	  loader implements the decompression algorithm and that non-EFI boot
-	  is supported by the encapsulated image. (The compression algorithm
-	  used is described in the zboot image header)
+	  memory before executing it. For compatibility with non-EFI loaders,
+	  the payload can be decompressed and executed by the loader as well,
+	  provided that the loader implements the decompression algorithm.
+	  (The compression algorithm used is described in the zboot header)
 
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
-- 
2.47.0.338.g60cca15819-goog


