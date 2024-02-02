Return-Path: <linux-efi+bounces-453-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F958474EA
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 17:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60673B20A36
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056961487EC;
	Fri,  2 Feb 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GtWBhmZb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FD148303
	for <linux-efi@vger.kernel.org>; Fri,  2 Feb 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891689; cv=none; b=h9r7rNk7u0m1K/g3n7ie7tELPVNa4snqUrkJZxWp48C/VcfmwAG+M/XIfOm/211ecndYh8kIzfwJkxMfTBnQuyMU4QWE0Gqung5yIGLWiwn8n1EQFZHefnZfyLD8xCgpMx21yASI2Ghj8jWnbeGopqCCsvSTo1/qaoFL0Q+P3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891689; c=relaxed/simple;
	bh=Ikc0whWoh7rMxU2EQziFijF9n08K3zToYOOQC/gU6Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D5XJ/T/mLA2ZrtQQuCy8dNKNZzG8oOMbNKfJ1ld7fE0wjTUf5OnojY7N9tHew9fZi9l1/rqhRF9kbOuMnqrEb1hMzUrUEc9xZvFS2j0sHOpbeb2iPNW2Sx2h1aVTUBcQ0zu14fZm0oy0UVdRlRk9bMsz0lcG4ND8A0P44/uIdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GtWBhmZb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-295d22bd625so1709969a91.1
        for <linux-efi@vger.kernel.org>; Fri, 02 Feb 2024 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706891688; x=1707496488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4XLcspDZ2svWPCn3b1Mu60aWYrbol9SnEepXTKa4KE=;
        b=GtWBhmZbc3MF+D7n2KyuoyJXPFF+HpI+Bqz01BA5dmLByc7hGNPyLEdNMO+eZJiCkY
         bAAm2PgUYmuSgKja+nie+Tmz/EP43bpN74WBcZ5G6dUwB49GkMuHxFrfMVoXlBscf5MC
         bHidPyQdE4LJDTH6i5xYH6T3b2DDqxhAmRJgbqPvm8EZwHk367pohy39O+rn7oXBM0Eg
         cKuPScqAr6jSfLr73WbqVPhwsGoND7b1XkjAmo2bDfJnzBhnDPB1qg1nNpr6wSA0OWH0
         NZe02HBJmUgTqVP9LpJLYkzBU8ZlAOWiqW11c9UhGplh8OHI4c+eKxTiWnOj9CJYdv9n
         8bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891688; x=1707496488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4XLcspDZ2svWPCn3b1Mu60aWYrbol9SnEepXTKa4KE=;
        b=gx6SKjYvl9wsvQxDZuLlB7msDFRaMM1vQbOha/1Chqz44ONDMkyKQMH+rwzSwbLdfd
         eO5C6vLwrRP+icfOdIOrqliM4CVb/anLyGdAKjddXOskuDhWx6pEr4WUOj1pCiS+U4Hm
         BXV96acp94P/C6sqTIK1n0VOf+Wwu+uJa+qcHZpMQHs0/sc0Tf60bPBqYqv711KwoCa7
         mSTh661vGyqNjVwGywWTLOhiwnPTB72TDUSzR5jYmaUwKKyG+luKua1TEIqVTnVsTJ7W
         mKLjrAa6gDLgw8Np5+YdKW3oEHbnyMmfwvh7LgGqpl00PZzyNUrQqSPFx7vdXtS6mBUA
         TEAA==
X-Gm-Message-State: AOJu0YzkSChRE6NSpNJKRf3ofXcKfyq1I2xI7nTfZ172Hxzl8oLLSWw0
	JJwVEt0UdeGTBY+uA0k9QyDHrSG1kyrkkZPgMIIluONUPnQVIZ0ADvUz2AYG9PETBWIz0J9d6jv
	9qPc=
X-Google-Smtp-Source: AGHT+IFSaOJGmU3nV35wyc0qbUGGVGRDpxLFzEIabMTzgK3Mk6BNdYPxuXKelnyByl8YF5H8/0qHBA==
X-Received: by 2002:a17:90b:80d:b0:295:ff5a:5e4d with SMTP id bk13-20020a17090b080d00b00295ff5a5e4dmr2634953pjb.20.1706891687915;
        Fri, 02 Feb 2024 08:34:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWl8eUkaFifVQfTIqx1jcOjqKGs+PzcPRmEeuWoGgHYEFqPgSWmGUEk8Z+2QzGzXhmi67UxDhC3lP11ZX5isxcEAUwRnOHIaqKRDQhDpW4rFHWMP1CsvPVVId7GnG8mz2+Jt2Ytj3xxCuaJFJNofafO/EUbReVVwNNgGdkYaB1HYH+faUsW9CNoLYFgaTphCuhfzUaQm+OE9phqQRx9H494jbkBk8ioZi7E7f3gLr5F4VRW/AMwDA/pj6h3qCnsXoDtCNPo2DsMQNL7
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ju15-20020a170903428f00b001d75c26e857sm1784870plb.288.2024.02.02.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:47 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH 1/2] efi: runtime: Fix potential overflow of soft-reserved region size
Date: Fri,  2 Feb 2024 08:34:32 -0800
Message-Id: <20240202163433.786581-2-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202163433.786581-1-abrestic@rivosinc.com>
References: <20240202163433.786581-1-abrestic@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md_size will have been narrowed if we have >= 4GB worth of pages in a
soft-reserved region.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
 drivers/firmware/efi/arm-runtime.c   | 2 +-
 drivers/firmware/efi/riscv-runtime.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83f5bb57fa4c..f369256c7003 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -107,7 +107,7 @@ static int __init arm_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			unsigned long md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index 09525fb5c240..9da79b8169d2 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -85,7 +85,7 @@ static int __init riscv_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			unsigned long md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
-- 
2.34.1


