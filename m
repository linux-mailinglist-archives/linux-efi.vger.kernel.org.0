Return-Path: <linux-efi+bounces-3195-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99203A7B8DE
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3AA1788AE
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CCF19C55E;
	Fri,  4 Apr 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSoafmL3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAA19924D
	for <linux-efi@vger.kernel.org>; Fri,  4 Apr 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755375; cv=none; b=rmYuwjAd0d/d+zZHksiBq8mN3rSgUQlC3rFNlAGurBUIOkuntzBHZQ0rlGSd1wHxvD8WNt0Iy7h/Tmajwfe3Q0lnR2d+Tg8JnumEr60OJY9sFfRkOAsi7ninKM2xtyrf9B4ORHm0hm5nJFfhBHy8dbDi1Prz4qUg+HVZBXFM2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755375; c=relaxed/simple;
	bh=5ihZOaXE5oCKVov2nIuHQmmdCvuzb5oZZi07YzW87G8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Az3Qwwb6rAdfNi1V26U5QffJZx9CewpEWSKCMbtUCngp8r4n22hg5xEm09Y+rvXHDjAMNptHuTYxxfDy4kYnoR0xlOA8BXjhLwL9WvVRcuGQnDQ0ZpNShUTaL/2lGVYPCCtytEq1VeCMvQ48FSE0PMuqHO8yI/hyhqvy7GUxFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSoafmL3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso21053825e9.2
        for <linux-efi@vger.kernel.org>; Fri, 04 Apr 2025 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743755372; x=1744360172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNNs/vOxrBW2+fNw12dmqWnNPmh1/mCVwB6WN22RsMI=;
        b=hSoafmL3CXwmv7lNboS1TNLWiSeR3DVYWRWiGYKmsG0RGYcpOe1BR2ju2pqDIqdBTU
         DBsRdUJeP5wGU8XYCEjRlCAkqzRcsMNGxF2Y6dX3tgaODaAHQAm7Y0QxoMy2QzbNi+Dm
         zugb9QkDA8qtL2d85P+lLD0I85eKLEFCF6XYPXB3cmWLvXuRUbeSjiEl4GJAN5QvrYya
         Qc0RMXZlvmO7gZGMXy74+Zql5n+XjsmVogO38xNe73/t46js9VRNLt28TuMLhCTAQlj4
         y490QOBAKl9yZIVolPWX3e0PigiqtxpvcGeX7QEBNrZWI/GeA2nrd+Ys/TlsX/gE1Kko
         w2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755372; x=1744360172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNNs/vOxrBW2+fNw12dmqWnNPmh1/mCVwB6WN22RsMI=;
        b=wdBopNz89iKaYPnZ2pscqNt9Ggi5FYgL2FSbCnV5cLwgLiXO6aKMkJIFcr67RIOpeg
         9g+agExMi90+p+z3gXANKnjuZyGyw/fQ6Z4fC/l/ZuhTvWkr9MxmM2DzbG1DUyiyI+iQ
         FPdGR4c1WGZA5FVtHwPAkBZFoP17TDnATPCjGe4BrC1BsOFfqFo2qENREWjgIhkN5ZzP
         cEsaP6jNIn80vZ3cnGizY6kj73ICsK5R2T2mBeW9KDmUyggxT1LYQlE9fAoPnlPP9h40
         DOn5FRofsvS0nstUuOI7ZaN5OIg966N+kXAsCJMOM+0d2OStXNBolRxjbr0P65sf6ZSV
         N9+A==
X-Gm-Message-State: AOJu0YwtqGq1bwFUyDoszAjjPS9Oq7799p94MvLsDEFMRfLND/1/OTA/
	ngaU94rcs+MU2M5kwQ8LOK53+mQ2YtddltpjwUVQZuWKhxLYfk9ajooNlX9gZ6ff6RGrtbJQM7i
	uoZMklPWOrhpVic7C7PNiZUNjDb/r+O1wWZAJQtPvj0nRw/5lFzT5z26ok+TiknGj69Zf8U5gop
	gtS6+BhoBRk45DtsDBPLcgEKXEaA==
X-Google-Smtp-Source: AGHT+IEFX6WXwWxTdMEAsk/jeVa821KRYjXGBbTt+rQOXeMu9ORLEVozZXQwvI7fjUd3eb7KFMh7SAG3
X-Received: from wmcq3.prod.google.com ([2002:a05:600c:c103:b0:43d:41a2:b768])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e42:b0:43c:f629:66f3
 with SMTP id 5b1f17b1804b1-43ed0c50af4mr19455825e9.18.1743755371883; Fri, 04
 Apr 2025 01:29:31 -0700 (PDT)
Date: Fri,  4 Apr 2025 10:29:23 +0200
In-Reply-To: <20250404082921.2767593-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4096; i=ardb@kernel.org;
 h=from:subject; bh=UZ+b8Yi8WQmsR+vt4vQblpJ9pbegiTibK3Qjm8rxJkE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf39jOSlH7mW11quljcWbpjquM1fNbCYp+VaLKfCMdd27
 9SayXkdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCL7axj+B3ObdfPVSS9UfyTk
 eLZTLmXbDfWLKnv5m2f5N9u0yzg6MDKcbNA+VcJZpsETVp+tuVyi/+XaMt65Mso1QVv5UoU1uBg B
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404082921.2767593-6-ardb+git@google.com>
Subject: [PATCH v2 1/3] x86/boot: Move accept_memory() into decompressor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

accept_memory() is only called from the decompressor, and uses an API
that will become specific to the decompressor as well, given that the
EFI stub will need to switch to a special memory acceptance API that can
be called while running in the firmware context with the firmware's page
tables.

So move the function into arch/x86/boot/compressed/mem.c

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/mem.c                   | 45 ++++++++++++++++++++
 drivers/firmware/efi/libstub/unaccepted_memory.c | 45 --------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index dbba332e4a12..6a888b80669e 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -84,3 +84,48 @@ bool init_unaccepted_memory(void)
 
 	return true;
 }
+
+void accept_memory(phys_addr_t start, unsigned long size)
+{
+	unsigned long range_start, range_end;
+	phys_addr_t end = start + size;
+	unsigned long bitmap_size;
+	u64 unit_size;
+
+	if (!unaccepted_table)
+		return;
+
+	unit_size = unaccepted_table->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted_table->phys_base)
+		start = unaccepted_table->phys_base;
+	if (end < unaccepted_table->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
+
+	range_start = start / unit_size;
+	bitmap_size = DIV_ROUND_UP(end, unit_size);
+
+	for_each_set_bitrange_from(range_start, range_end,
+				   unaccepted_table->bitmap, bitmap_size) {
+		unsigned long phys_start, phys_end;
+
+		phys_start = range_start * unit_size + unaccepted_table->phys_base;
+		phys_end = range_end * unit_size + unaccepted_table->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		bitmap_clear(unaccepted_table->bitmap,
+			     range_start, range_end - range_start);
+	}
+}
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index 757dbe734a47..02040bd6a330 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -176,48 +176,3 @@ void process_unaccepted_memory(u64 start, u64 end)
 	bitmap_set(unaccepted_table->bitmap,
 		   start / unit_size, (end - start) / unit_size);
 }
-
-void accept_memory(phys_addr_t start, unsigned long size)
-{
-	unsigned long range_start, range_end;
-	phys_addr_t end = start + size;
-	unsigned long bitmap_size;
-	u64 unit_size;
-
-	if (!unaccepted_table)
-		return;
-
-	unit_size = unaccepted_table->unit_size;
-
-	/*
-	 * Only care for the part of the range that is represented
-	 * in the bitmap.
-	 */
-	if (start < unaccepted_table->phys_base)
-		start = unaccepted_table->phys_base;
-	if (end < unaccepted_table->phys_base)
-		return;
-
-	/* Translate to offsets from the beginning of the bitmap */
-	start -= unaccepted_table->phys_base;
-	end -= unaccepted_table->phys_base;
-
-	/* Make sure not to overrun the bitmap */
-	if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
-		end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
-
-	range_start = start / unit_size;
-	bitmap_size = DIV_ROUND_UP(end, unit_size);
-
-	for_each_set_bitrange_from(range_start, range_end,
-				   unaccepted_table->bitmap, bitmap_size) {
-		unsigned long phys_start, phys_end;
-
-		phys_start = range_start * unit_size + unaccepted_table->phys_base;
-		phys_end = range_end * unit_size + unaccepted_table->phys_base;
-
-		arch_accept_memory(phys_start, phys_end);
-		bitmap_clear(unaccepted_table->bitmap,
-			     range_start, range_end - range_start);
-	}
-}
-- 
2.49.0.504.g3bcea36a83-goog


