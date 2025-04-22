Return-Path: <linux-efi+bounces-3405-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EC8A96569
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 12:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6DB3B0222
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903C8213E66;
	Tue, 22 Apr 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIzOz6Cp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6D21018A
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316471; cv=none; b=qXaj8wvDFenLAIYXTV8Na/vTTrQsQ4Gz2ZVsy/SuO9KhlnYD530bKklT4kmlwNczAa63uCluE7qxriI0issvWQMCFfhndxD9MN6U0XYmE9hGOo9mBi6Ic7R2FuIw8qckh6e7xitlf7kXeKvVTEh6bACwWT+iJakakTbHrt8yLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316471; c=relaxed/simple;
	bh=vOVJK3EbxOu+deO48i5WtceLXMWoAqrF7kmKB3PVP3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XqlNeXzGPteRGVNPfQix22HN10oUpvawKL2xnp921C0xsVotrjqIIm9BLHeSLy7Exs+SLEiDbH2Rfmy9wURZzpG0gAklb1MW/CaPGprJLZw50Twt/vrC/hbmTrfjNTfDF7daZeg2AhJjcUyyDpPShklXfPT3E9mnDmiv8eEYYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIzOz6Cp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39134c762ebso1528852f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745316468; x=1745921268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkJZNpcXKKRqW5nXae/vnTG+jOdvaVmSWupziVGr+E0=;
        b=nIzOz6CptACendDPKgY0ZTJO53clW+ax11ZA5THjMw5eho9Sj6DV9AH04rESGIG2dA
         Tyv5xVmlYcU4Lx00+NzUceilgvYB0AJV87oeotUXo3PTfs7rDCsDBlm9XLLXuys7QEsz
         em9I9632ikA/g1VPvLVm/CBmWSqipQV37CNVPHEiGltyxN6bFGnnyB2TDWO67u5KpmQF
         xMOWaGIkqig4a+cnLx26WvcQpicCgR8oNeetAVZDsp+rSG2YUQ/yv+/IGbGjPp313CWB
         +0x83QL/9MKeAWi4zsvkFgzqgD5lqvmL1erOn9Um7RySdYGZqpIjJ1hB5O1LWZN3YMGL
         J7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316468; x=1745921268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkJZNpcXKKRqW5nXae/vnTG+jOdvaVmSWupziVGr+E0=;
        b=V/H1XfByQAOG1OEkM/vqmZDOZ4CTO9ai+U+ILjW396brYWPYz9gqoHJeBoBcwKg2dV
         vt/ZlWzdbb3VYgBhjU6h2LON6PcQXpkmQxTn7saZ1B//I9D5edewmuj2le951kHi9Klu
         rKih8sHP1Ew0YmCw0blH+VyKziLG2d+u9pIhq7rEEXtMqCcKhVUgrhwqyjWz5MgUEYwU
         T/foc1TtFogyDfO4GVmE+ZGbebIGFjXWU31Q53wlq6vZGCsAK8MqnnMy6Qw5sTGGavgy
         L3dlmIT77BhNF1iWdDGkExZcPpU8DEwIZ9I35ILDXDV96Y7bkwZ/oEsT7upj91Dhmtox
         y94g==
X-Gm-Message-State: AOJu0YyB0pT6EmE8Tucn4zuVJDcbkCwcSv/IFe6YOiRrT0BMzXHcdMT8
	8pdif/kfapMoTTSPk1Mfjo1bERIB5VZ1PfG/+ZVU2X6dLjNy7tbNuxS3cV4tm/WXnp8Gq8YRaZ6
	Z2plun6Cq7ttZePxD+c+g49SrZekKnbB+LqiqaZOcxWcsGbwMIA3SIex2gEbIg6HLtBmUVNVywT
	/omXrzG7w2HBTe/gNkgdCL6cCdAw==
X-Google-Smtp-Source: AGHT+IH83U5+f0fJgse+Cc6ugxWy2ZiXy+6kHj05xIz1Cod8wiojISaH1CXIu+ea0J3O4lUYdw/zJ6n9
X-Received: from wmqb15.prod.google.com ([2002:a05:600c:4e0f:b0:43c:f6c0:3375])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2481:b0:39a:cc34:2f9b
 with SMTP id ffacd0b85a97d-39efba3c712mr12081987f8f.16.1745316468108; Tue, 22
 Apr 2025 03:07:48 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:07:31 +0200
In-Reply-To: <20250422100728.208479-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422100728.208479-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=ardb@kernel.org;
 h=from:subject; bh=uvFzfFDFC8UgTdlhkUvlnagkg29HZGy26l1GyMrYNOc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYM9K21P0Jo6O1aPDO/TjekGB2rY9m1tee+9Zd0DA8u21
 /cEtpV3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlsLmf4H33j15GYW5H3Sm0u
 ZnQerV2782tk5tGKdYFRjPlLg9es2cTIMP3HArHT2z0vWKlJzThysniRh59RRKHI+e87TrkvPMQ czwEA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422100728.208479-9-ardb+git@google.com>
Subject: [PATCH v3 2/5] x86/efistub: Obtain SEV CC blob address from the stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86 EFI stub no longer boots the core kernel via the traditional
decompressor but jumps straight to it, avoiding all the page fault
handling and other complexity that is entirely unnecessary when booting
via EFI, which guarantees that all system memory is mapped 1:1.

The SEV startup code in the core kernel expects the address of the CC
blob configuration table in boot_params, so store it there when booting
from EFI with SEV-SNP enabled. This removes the need to call
sev_enable() from the EFI stub.

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


