Return-Path: <linux-efi+bounces-1549-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF419956DEA
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850831F2153F
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870F175D28;
	Mon, 19 Aug 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb4QFBCD"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8C173357
	for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079306; cv=none; b=hiHFoWcBIwdFOLrcR6D+pQfR3rWSdppIuoNXvybXULYMF1fRjLE4hpc//k0iNgAmn0J2WYznrsus2F7j+rVbwtsII3ASDuJKBBR5cqjkR4PM9s3rWHTRlBj67NIqpQy95/y8DA51RjlsD1C/yu+oL0Wya0gos4MmoOPOBxcyuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079306; c=relaxed/simple;
	bh=sPWPyK91Xn7Sv/iGrU2KXWFFhVGbbd9clCRXcFC1a5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAQxQz9/Y6HoBrVEIbJuy3FCI7suwBXmIywOX8CnbI3JcaQrSftc4H/R4B0kHpnzIzZYue5kWG9PK9U1MbrUbo8Il2E483uy8RoBlyJauPsr6d/HYFV4/oRlRCqlioS9so0VYIL3ygreQZHsDUHOMtIn0/thjEGdBDjW+xUqqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wb4QFBCD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiBxTOGq9aVdhn1+CpbHzQqObWNoKSOYg9dxENZx8/E=;
	b=Wb4QFBCD0lp1/IRyr7/AmBrZkK+swEyBvi8HHeMlNJ1WjIQrvtvzB/ZezsvfNCluHdtrSM
	WMcTWVv42Ewhvuchr30Qu/QpKAUNVuyTVNdcWR4LuRno74FMkb5ZrJmMCh5i/FpqOSil8s
	V1oy7JvRrmH80gFxC/xj58q2rGbamJU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-Ue7ktWKDOO-5JaPjXde9nA-1; Mon,
 19 Aug 2024 10:55:00 -0400
X-MC-Unique: Ue7ktWKDOO-5JaPjXde9nA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 897141944D01;
	Mon, 19 Aug 2024 14:54:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E114C19560A3;
	Mon, 19 Aug 2024 14:54:49 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip unusable memory
Date: Mon, 19 Aug 2024 22:53:34 +0800
Message-ID: <20240819145417.23367-2-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
but the current implement can not ensure the selected target locates
inside free area, that is to exclude EFI_BOOT_SERVICES_*,
EFI_RUNTIME_SERVICES_* etc.

Fix the issue by checking md->type.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index c41e7b2091cdd..7304e767688f2 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
+		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
+			continue;
 		slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
 					    alloc_max);
 		MD_NUM_SLOTS(md) = slots;
@@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_physical_addr_t target;
 		unsigned long pages;
 
+		if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTENT_MEMORY)))
+			continue;
+
 		if (total_mirrored_slots > 0 &&
 		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
 			continue;
-- 
2.41.0


