Return-Path: <linux-efi+bounces-2736-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A0FA24B05
	for <lists+linux-efi@lfdr.de>; Sat,  1 Feb 2025 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6381886B45
	for <lists+linux-efi@lfdr.de>; Sat,  1 Feb 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A401CB501;
	Sat,  1 Feb 2025 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3HnG7SsI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F21CAA8D
	for <linux-efi@vger.kernel.org>; Sat,  1 Feb 2025 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430509; cv=none; b=MtAKtrTpD73Jhz4ww0g5uMqsj/T7MXkJcJzXyerREZFI+vOlfqJLgrl0+K76HAXqylQfiNzmMtnWeRoQGW80VmI6y80XgkHcscFe8TeVTIlzsxnHONYKn1JGCRoM98kLhybTc1fc3IAWkkPzSx+91pnsAuGJbf8e3G8tuXDjBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430509; c=relaxed/simple;
	bh=w2yE63sC9zTFdtn+p5RI02eYUbqFYisRzY88vTigVQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y17pn2lHbchNYVeQfiDd2uQCel+3R+9EnYHZPKEcJemNbVcEGeVqw0M0fwK/LiXbBkS1zC7vBb7chEsh9f5pm2NiE3aWbYQJyupuOBpT8quHA8A2z1Cngpz1FYqg8h/VhRSr2v4tafwYvll9sX+mMv0/K70EmUG11TpLL84Z5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3HnG7SsI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so14425265e9.3
        for <linux-efi@vger.kernel.org>; Sat, 01 Feb 2025 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738430505; x=1739035305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKhrV4FS3BfHHv6JJTxTRxWjSBLuqt9pDuTg8aZsHJY=;
        b=3HnG7SsIWIsRo9+jKmIuReiOuRYnWgQ/WuSOsUMI8DqP/TpCPKxzohpo8fBFFcZZlp
         lTYg9cgvDofn6mC2W0nD39vGBKqqPIKa+hS1qAyjoQg27X47JmAp3aJtvGsqoZf7vrE4
         gnyrUMmxZjCzl9WD8ntjiaMpLJHpCtnXYySmOrqJTa2SXqvFNd9u2z1Lp+SS4wI+2sUo
         6jvsR1fyYcR0jUnFLANH+DKxPfdYDU4agbKderV/qiNtnkGSl/ldJGVHGWV5bmw9VkQA
         sKu2VNVYJwGpp65v4vXNBVrBjP9y94toBDtznzYOAyQYoULzJmlC9cmEzRNZHo9T5WVk
         uewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430505; x=1739035305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKhrV4FS3BfHHv6JJTxTRxWjSBLuqt9pDuTg8aZsHJY=;
        b=LapIPG01QNZM856rdCQoOrh4U4Xy4B7kaTCFRSt89U49a1beU6+SywzS0Sx5b+qIgj
         hImGmwDLpExF2IPxoo4Vc9I4+j6IRB8/jJeY1kYwYE1G3W45lo9jEQVw8aoPjW0iFanx
         phc5odLo1TjtzJUFNVavQNGKr0pS7oxFdhEO5QthQ70kDC78QMstfom4m1ufJ2PVNxoE
         9+zAWRN1UVWNHzOFObhjh4vnFFIrQWdZNywPoBAPqJaF9CGUAs3hJWGneHoO+rjZY1dP
         ZjNmtyERfS5xOPu0+Eu0RzDIF2cw9etUSiMJYw+U4BC6uuhjQELgpNRrQEemDB0ZGNu8
         tziw==
X-Gm-Message-State: AOJu0YxDX5SFK8V22rwB2vVkK+p2SyZCj/9vu1O1bfOwXFMnn7J3qnGI
	1Vi4QE0U9DhFUgr0xKxyr4dER6Dnfj6aFKcUAV5mD0RBBhRPcpfgUOeiz4F/Q+dCdZsPQAVqusZ
	wkqAZ6i8tqNEPk3n7B7sUwvaWf/YEDl27STfFBoXPlYJYRaWh1SDj2VRyByuZOXff9mtm5xjgy3
	HUrBuzpeLzhpd39k675RqguibmWQ==
X-Google-Smtp-Source: AGHT+IGl49RmvVvO8Sge+Xfhu5Xb697EHYs3pjwLnJJB9vvdkzBIhC9IKEmbhFm4+dhHZDqj4Kiz8Dwm
X-Received: from wmqa17.prod.google.com ([2002:a05:600c:3491:b0:436:1796:9989])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5119:b0:434:f917:2b11
 with SMTP id 5b1f17b1804b1-438dc40bd8dmr126035295e9.21.1738430505708; Sat, 01
 Feb 2025 09:21:45 -0800 (PST)
Date: Sat,  1 Feb 2025 18:21:36 +0100
In-Reply-To: <20250201172133.3592112-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201172133.3592112-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=ardb@kernel.org;
 h=from:subject; bh=ATsogwx9msMMPfBwlwd/1Ve/e6sf91DL+ruiHYM3nIk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1ehGLFp8w1E/O2M52LujTDf2ON7vl3m2dttKjJlwn02
 d1yVqG0o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk1BmGX0yi+V2zeVdcW1pn
 POuBeZbQ9k0dkmuWu0/JPtydySNcycvI8FeLOW1XONMtU9eGKStmzDVp+Vn7eOeHYC/mdq0uqQe HWAE=
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201172133.3592112-6-ardb+git@google.com>
Subject: [PATCH 2/2] efi: Use BIT_ULL() constants for memory attributes
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

For legibility, use the existing BIT_ULL() to generate the u64 type EFI
memory attribute macros.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 30 ++++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index db293d7de686..7d63d1d75f22 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -114,22 +114,22 @@ typedef	struct {
 #define EFI_MAX_MEMORY_TYPE		16
 
 /* Attribute values: */
-#define EFI_MEMORY_UC		((u64)0x0000000000000001ULL)	/* uncached */
-#define EFI_MEMORY_WC		((u64)0x0000000000000002ULL)	/* write-coalescing */
-#define EFI_MEMORY_WT		((u64)0x0000000000000004ULL)	/* write-through */
-#define EFI_MEMORY_WB		((u64)0x0000000000000008ULL)	/* write-back */
-#define EFI_MEMORY_UCE		((u64)0x0000000000000010ULL)	/* uncached, exported */
-#define EFI_MEMORY_WP		((u64)0x0000000000001000ULL)	/* write-protect */
-#define EFI_MEMORY_RP		((u64)0x0000000000002000ULL)	/* read-protect */
-#define EFI_MEMORY_XP		((u64)0x0000000000004000ULL)	/* execute-protect */
-#define EFI_MEMORY_NV		((u64)0x0000000000008000ULL)	/* non-volatile */
-#define EFI_MEMORY_MORE_RELIABLE \
-				((u64)0x0000000000010000ULL)	/* higher reliability */
-#define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
-#define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
-#define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* supports encryption */
+#define EFI_MEMORY_UC			BIT_ULL(0)	/* uncached */
+#define EFI_MEMORY_WC			BIT_ULL(1)	/* write-coalescing */
+#define EFI_MEMORY_WT			BIT_ULL(2)	/* write-through */
+#define EFI_MEMORY_WB			BIT_ULL(3)	/* write-back */
+#define EFI_MEMORY_UCE			BIT_ULL(4)	/* uncached, exported */
+#define EFI_MEMORY_WP			BIT_ULL(12)	/* write-protect */
+#define EFI_MEMORY_RP			BIT_ULL(13)	/* read-protect */
+#define EFI_MEMORY_XP			BIT_ULL(14)	/* execute-protect */
+#define EFI_MEMORY_NV			BIT_ULL(15)	/* non-volatile */
+#define EFI_MEMORY_MORE_RELIABLE	BIT_ULL(16)	/* higher reliability */
+#define EFI_MEMORY_RO			BIT_ULL(17)	/* read-only */
+#define EFI_MEMORY_SP			BIT_ULL(18)	/* soft reserved */
+#define EFI_MEMORY_CPU_CRYPTO		BIT_ULL(19)	/* supports encryption */
 #define EFI_MEMORY_HOT_PLUGGABLE	BIT_ULL(20)	/* supports unplugging at runtime */
-#define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
+#define EFI_MEMORY_RUNTIME		BIT_ULL(63)	/* range requires runtime mapping */
+
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
 #define EFI_PAGE_SHIFT		12
-- 
2.48.1.362.g079036d154-goog


