Return-Path: <linux-efi+bounces-3347-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2510A90978
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 18:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E62B7A3018
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94052215174;
	Wed, 16 Apr 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B74jDL48"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5632135C7
	for <linux-efi@vger.kernel.org>; Wed, 16 Apr 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822685; cv=none; b=e1xCl2GxzztkBuOpBoyrT9HZn4xta3wWSkGbGEBNccgTxLB9XuvRcVzhdm2p1tvd91k8RnMoA37q3HuMhI5/vQRiGOZU0mb5dsFVuYG/yGY2moF7LVRDr18xk+FMIfjtA32HuimeGFYdrv2JtoqJbcJ+cuXAtPCIfe+PceoR6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822685; c=relaxed/simple;
	bh=hLfvkW2dil561oNPEdZlU+Dh02P84Pkkg+e6wBeW1xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VwTOgKEpTOcQJ4Oj4iFBr48M7m7BLOh/cOiNlAtF+rjf7va5nte3Pr5gXnEFIj8T5zGA8uHkOkg725Yaor/A26Hfnu51gxQO8hRsjDt19K6ZipcYDHY1CmxH4FnXYagTxkig5yDcqYGcGEQixixk+5jLmXa5wBOiUI/EYfEtgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B74jDL48; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912b54611dso3925825f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 16 Apr 2025 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744822682; x=1745427482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=upqUq0Fa7EAF72jGlng+4tK3QC6Z7kLIehCFLXDq35M=;
        b=B74jDL48lJ/YoXD8IuAsPtH+uhi6wjwq2Qme8pKEKau6I+TvFSocreQQl9QoZl8eFW
         ZBiq5VN989I+3lbNFXldLWlMlBKQhrlMTGTC6vrJBUacdANa7NT4+Bg1BwRiQ8BbaGQ8
         N+eFqIzQYgAgiUTtKakq5uGEkWh82m62TuMOBHtQKK+jxnxeYOAwJ3z3f4FbpsCGPApb
         laQgQxH+nyba8aTtBi3icw31Q9Z9aRC2AtrefgUfQf4Kr/i9jMdwiZ+wHr59MbKRO52Q
         N5ICfiJWwO5Q2YfvGdhkYmFUolBkCdDgktLz10+pwizku8sMWocdU5fcpJ9TC2wrLhcc
         +IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822682; x=1745427482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upqUq0Fa7EAF72jGlng+4tK3QC6Z7kLIehCFLXDq35M=;
        b=Eu/zY6P32zRQujK5EyYiGgzQEmytFcG2F8G23iLHh9J7R7Ug+vEndRHU+fLLf34J8N
         kCl9glLj7n3Fu5bJNxdVBKL86LWuggPFUlvh91eoqRiHQash2wKHsyUfJJXJ91pX/e2B
         iOSbyx/3PD5V7WZcb06ZsCAOFd6aIh+iCydbIrNipRos3AJy0II0lSluwL6L6neB8tcl
         ddNnxUQKCXSJDQysc+6C54GSUMg5yvZUHYxzt1kB2DETn0EXV6eIbK8fCY6dSolc3IRZ
         Yk33AKrdjwBWNrkaKQ0pCDLl7wKjy43GCWo03bachcuYRk8mWm95PFOk9WZEYxH4K94o
         Effw==
X-Gm-Message-State: AOJu0Yz21dUcJpi3HfRNfb0aMRKEKSiX4xKeHfGCYMqJTrxK/xTzkp7q
	kE/eYvPvGjU+SlNa9qD2jN55r+MxoVPUivUzvN7kMtRRIWP9PqpdpcIeRD2vrmNbBzvdrb5ukaR
	KmP5e62tmV9I2vawQE8UJmAwSH7M+zcYAAGIeikhDh8ToN0nbk7O7mFm8VDdw5xibCs9pNQdvS4
	WFJhOeZlOoPU7mjnVEITiJ9D4HOw==
X-Google-Smtp-Source: AGHT+IF3ubUXtqkFiF/bLP26+ML6WQicJcyTwlloYZXgaklZzd/7iVicbPvQV1q9gab5qSCOg9NeqFCb
X-Received: from wmqh2.prod.google.com ([2002:a05:600c:3502:b0:440:595d:fba9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:184e:b0:391:38a5:efa
 with SMTP id ffacd0b85a97d-39ee5b163c7mr2836685f8f.23.1744822682232; Wed, 16
 Apr 2025 09:58:02 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:57:45 +0200
In-Reply-To: <20250416165743.4080995-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416165743.4080995-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=ardb@kernel.org;
 h=from:subject; bh=zoTGlyeTZ8cicOcp90d6H9mDgz3rJQHzXOqjzEb0s/s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3/w84HUzf0W75LeWF6fdPR43GNi3/ptuSXe+kLTDEo1
 bIzDnrQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSw8HIsMm8LzPgTecT4ah5
 Z3fsnVx5sk5v66fNH6+KfNivpLNgRjEjw957VcW3e6LKeRfFbxa6EbHW7738W/unGnsvPl7Hqua ygRkA
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416165743.4080995-7-ardb+git@google.com>
Subject: [PATCH v2 1/4] x86/efistub: Obtain SEV CC blob address from the stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86 EFI stub no longer boots via the traditional decompressor but
jumps straight to the core kernel, avoiding all the page fault handling
and other complexity that is entirely unnecessary when booting via EFI.

The SEV startup code expects the address of the CC blob configuration
table in boot_params, so store it there when booting with SEV-SNP
enabled. This removes a dependency on the later call to sev_enable()
(which is going to be removed), and permits the EFI stub to fail
gracefully inside the guest rather than terminate it entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 21 +++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..d9ae1a230d39 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -681,17 +681,28 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
-static bool have_unsupported_snp_features(void)
+static bool check_snp_features(struct boot_params *bp)
 {
+	u64 status = sev_get_status();
 	u64 unsupported;
 
-	unsupported = snp_get_unsupported_features(sev_get_status());
+	unsupported = snp_get_unsupported_features(status);
 	if (unsupported) {
 		efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
 			unsupported);
-		return true;
+		return false;
 	}
-	return false;
+
+	if (status & MSR_AMD64_SEV_SNP_ENABLED) {
+		void *tbl = get_efi_config_table(EFI_CC_BLOB_GUID);
+
+		if (!tbl) {
+			efi_err("SEV-SNP is enabled but CC blob not found\n");
+			return false;
+		}
+		bp->cc_blob_address = (u32)(unsigned long)tbl;
+	}
+	return true;
 }
 
 static void efi_get_seed(void *seed, int size)
@@ -829,7 +840,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	hdr = &boot_params->hdr;
 
-	if (have_unsupported_snp_features())
+	if (!check_snp_features(boot_params))
 		efi_exit(handle, EFI_UNSUPPORTED);
 
 	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
-- 
2.49.0.805.g082f7c87e0-goog


