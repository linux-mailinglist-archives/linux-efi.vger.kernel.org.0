Return-Path: <linux-efi+bounces-1354-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2F91E1E7
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C66F286F50
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544C1607A8;
	Mon,  1 Jul 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LX93Psqd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2D1607A3
	for <linux-efi@vger.kernel.org>; Mon,  1 Jul 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843032; cv=none; b=GsPxiiui9DLUss6N4+i2dRaGUJvbufB9qYmoHApYGPFpDYo+40BtJ9y5pF1nLc4SDd6P5TZ4wxfx8FLqOJiOE0HexcNRO5s58/pwzm24M9qOWSRV6YycpzLtKJMGOkoSsVg6hyBfykRBDi6REmH/ImXZw8G+DFF17ag8SJ7p/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843032; c=relaxed/simple;
	bh=+meXUlHYX39IvtHzyMlSdD4CA8/W1DMe5IkqgKbMtxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bSBxyHTluPnJXLCGGlBIwU/twjiiydAzQkb1OaBT0NsdJ+ZLzpSuwkiYqo5gl+L2d/hvFdpGjqv51dk5G3iR/lNUkYhBW0Xe947tW654YZid986zb//nUUN2zW+W1UGx1s1SJhssmumdaAQ/6AnM40Nv70ssRQbv2VCEOyYndUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LX93Psqd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e034f972e8bso5182345276.0
        for <linux-efi@vger.kernel.org>; Mon, 01 Jul 2024 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843029; x=1720447829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xm7gCNTjN0klxx6tovnvy/0uS85ngU8K1EvDYCGt6e8=;
        b=LX93PsqddmTSichuni2YK2yfLTpED0+Cv85SiAJ19jwJGFA4MM0rnDVSP2c4psDXUo
         KQEu1yhUoQmlY3lDFxaVHwYkca+eYMLRin0Q/2vB3E7AHQ0LRJdpijKNe88Eax51GsRf
         EyZwHEWB/XL53LzUMXN68UtRxv/+9wo8XZefmtuIlFZGhfCfCY8Ld46Iiln6TkA8Em/Y
         /chcc86o+HcvV4dDnMUIjb5gsnI8U8VutRlLJh65OnCe4sG10Wx/BiV47hC+qfnPW/k3
         1vnCyQlT/Y/7ZScrBFd2kw5Y2/hmTyqa9PwZziQ+miZhUrOAvS40d5OGmKhMYqOKfy9/
         g/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843029; x=1720447829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xm7gCNTjN0klxx6tovnvy/0uS85ngU8K1EvDYCGt6e8=;
        b=WIsEtgNnOTtsomqsech6sokKPyjtqGO9+sNnSGCniusdIJrE/EkzweDGTLLVFHfTI8
         PZdnJkxNdFSl12a1hSeMIQESL1VlV3wEWjmhXNVM4tK1/tsYW2PUs2CE6FN7UqUgrQjJ
         W2ZViptAJy7Nj8KPrsUdVpKuOhKgreSwVgpMetck1hi17uORXIhJwWVazTPz0OifNqgx
         pQmzCQ59BpZ1I5HcyE+Gp3TjhJ/vE7hfJpphc3GsHDRSHyehWrAOBxOGz5cG2Q7z+X24
         lWoYaaJpKLnnPOelXrhYwtiMmwVMJVola5P8sUV4fFB3o5hlu7lKXmqD+gT0iWn9P6qE
         2DLQ==
X-Gm-Message-State: AOJu0Yy9bV3vMrR7mXGBdg+1eDaJrz5RScb5OOoBfPlu8wqZSpqvSwdY
	QGmGvXojjXdC7bvPAbvX1no/LEF2LU50qkgzLankMmmchhyW8Xn11MS4Ytw2PQyx2/3YwxHKq/l
	QrpuDx8+WrIEb2jx/JvT755MidY5urWnU+5clFLx9I2ivGChvMiP/jjifYZLZ9y6zN2ujYkdrl2
	qx526iDtrnu7D/93s0Mz220tha6Q==
X-Google-Smtp-Source: AGHT+IFyGvWNkjohabajKk0DUCPr5cxYV/b1ecDA5W3PW9FG/xKLKP++NvSbyusdNb17qFzWf8syVTft
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1242:b0:dfa:8ed1:8f1b with SMTP id
 3f1490d57ef6-e036eaea1cdmr682399276.1.1719843029591; Mon, 01 Jul 2024
 07:10:29 -0700 (PDT)
Date: Mon,  1 Jul 2024 16:09:41 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=ardb@kernel.org;
 h=from:subject; bh=VfwgXPrDjPqhCTi1Z4L2E0I+/0yMfkpDX2LBefwxGvc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1px1K3X3deihz4v+ZSnFig/nT5lLP3haKrBCs/MjvKN
 7RsZHftKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPpT2NkuH983+ajsfLG5RPv
 9oqWy39ccjxprUd68avce5ftEm9IJTD8s79WteaA4+9NMVMmLtmR9/X+hT1/X6n71Byoa4kL9Ji 2hR0A
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701140940.2340297-4-ardb+git@google.com>
Subject: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

v3:
- add patch to make the SMBIOS protocol glue code compatible with mixed
  mode on x86
- update Aditya's patch to limit the effect to dual GPU Macs that are
  known to require the set_os() calls in order for both GPUs to remain
  active after boot
- drop mixed mode handling of set_os() protocol, and dereference the
  struct members directly

Cc: Aditya Garg <gargaditya08@live.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Kerem Karabay <kekrby@gmail.com>
Cc: Orlando Chamberlain <orlandoch.dev@gmail.com>

Aditya Garg (1):
  x86/efistub: Call Apple set_os protocol on dual GPU Intel Macs

Ard Biesheuvel (1):
  efistub/x86: Enable SMBIOS protocol handling for x86

 drivers/firmware/efi/libstub/Makefile   |  2 +-
 drivers/firmware/efi/libstub/smbios.c   | 42 ++++++++----
 drivers/firmware/efi/libstub/x86-stub.c | 72 +++++++++++++++++++-
 include/linux/efi.h                     |  1 +
 4 files changed, 98 insertions(+), 19 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


