Return-Path: <linux-efi+bounces-1459-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27284934A8E
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D174F286750
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAFB7A724;
	Thu, 18 Jul 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGW/hFXA"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709A7A715
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293125; cv=none; b=KQKw0SIH5N9l5ZYHtNJaMgGffVB10OObm/FDB31hrqmXl+w0C7wWbfAQPp6+px7q/RuHpGW3nnjuVPgYMgiuv7ik5mV8Sx5uYmNID5yeJUpCd6ir9M1mUUmmTsvfcQTfMWhFKfBe1TIh4c1MB1A+tmyrjhkm7E+azBCNPT/NfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293125; c=relaxed/simple;
	bh=fBrp5iDu610M0ODjEvFQW3GZr/y9VjeDVmnBgLVG3dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOT5FrLNIM3vYYW++kGmzb6zR5mk6VMandmTpzgeCUKKabVgJRBMiSqZt7U9fmtmQyiY76X/Czlv6VdYuYE1vjszFKk3qABb4iy3QCQ4FheMnXlhO7gK7S2RVzj2LhsKNkbxxgniPwd0fGYg5HDOgH81vqL7idTYYHezD8W0tYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGW/hFXA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9TZSR+BUCVNWRBqfa4q3I7rRgSk04YNeRsJlv/xLrE=;
	b=aGW/hFXAOLbfrU4B3d3rlYIi/2BRpVEKsD8s/+y2igKCrDqrzn9D4D1l0+tQYsa0SuEw93
	7jFFBAxtV0Q12n0e+yvMQalJu88JfXnNKa5tgCiD70+VIKAVLTLJK4IAzzJwK2iy/V+zqJ
	rRAPIa50/k992RKiithKLv/cITmI44I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-ygGD_SQxMmeyRCAbDROY2A-1; Thu,
 18 Jul 2024 04:58:37 -0400
X-MC-Unique: ygGD_SQxMmeyRCAbDROY2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA0631954225;
	Thu, 18 Jul 2024 08:58:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E5473000185;
	Thu, 18 Jul 2024 08:58:27 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC 2/7] debug/libstub: cheats to step around some boot service
Date: Thu, 18 Jul 2024 16:57:52 +0800
Message-ID: <20240718085759.13247-3-piliu@redhat.com>
In-Reply-To: <20240718085759.13247-1-piliu@redhat.com>
References: <20240718085759.13247-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

For POC, step around these four function, hence the corresponding boot services.
Later those services should be implemented and this patch should be
drop.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 3 +++
 drivers/firmware/efi/libstub/efi-stub.c        | 2 ++
 drivers/firmware/efi/libstub/random.c          | 2 ++
 drivers/firmware/efi/libstub/tpm.c             | 4 ++++
 4 files changed, 11 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815fd..19b31a4c7fcea 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -615,6 +615,9 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	efi_status_t status = EFI_SUCCESS;
 	struct linux_efi_initrd initrd, *tbl;
 
+	efi_info("cheat in efi_load_initrd()\n");
+	return EFI_SUCCESS;
+
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || efi_noinitrd)
 		return EFI_SUCCESS;
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 958a680e0660d..190d280e634e9 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -59,6 +59,8 @@ static struct screen_info *setup_graphics(void)
 	void **gop_handle = NULL;
 	struct screen_info *si = NULL;
 
+	efi_info("cheat in setup_graphics\n");
+	return NULL;
 	size = 0;
 	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
 			     &gop_proto, NULL, &size, gop_handle);
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 7109b8a2dcba8..3a647fea2fdd3 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -73,6 +73,8 @@ efi_status_t efi_random_get_seed(void)
 	efi_rng_protocol_t *rng = NULL;
 	efi_status_t status;
 
+	efi_info("cheat in efi_random_get_seed\n");
+	return EFI_UNSUPPORTED;
 	status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
 	if (status != EFI_SUCCESS)
 		seed_size = 0;
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a5..0c585466c0b85 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -33,6 +33,8 @@ void efi_enable_reset_attack_mitigation(void)
 	efi_status_t status;
 	unsigned long datasize = 0;
 
+	efi_info("cheat in efi_enable_reset_attack_mitigation\n");
+	return;
 	status = get_efi_var(efi_MemoryOverWriteRequest_name, &var_guid,
 			     NULL, &datasize, NULL);
 
@@ -155,6 +157,8 @@ void efi_retrieve_eventlog(void)
 	efi_bool_t truncated;
 	efi_status_t status;
 
+	efi_info("cheat in efi_retrieve_eventlog\n");
+	return;
 	status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
 	if (status == EFI_SUCCESS) {
 		status = efi_call_proto(tpm2, get_event_log, version, &log_location,
-- 
2.41.0


