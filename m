Return-Path: <linux-efi+bounces-1458-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164AF934A8D
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F15B2163F
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D55C7A724;
	Thu, 18 Jul 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBHgm4l2"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C77A715
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293116; cv=none; b=Aftam3G/KlkWlrQDBnMrK/WDsp3C8kqiEsvdLZuP1M2COa7dBVrbT0p9nTeTsPk9VI+oa+S0zpyn6z//1rRy0Z03bZ9T/I29oNvbsoitxCbR3JYpJqxs9IzJqHrmswy7D27YwnlKxlL1yQ33uG3j+h3lCfodN3DJP8ETWIoCgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293116; c=relaxed/simple;
	bh=jNKWwma2wIB7xOoVow0y9HbAhCuv6AZL500cFtiHR6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3EAOz+rMAi6g2zwa9Hg5C6Iy5/aRlc69oWRW7GqjdQDqSwHJFSJcANx1dn1ZW2ucoIwx00SW7sf8JYTEbFTEt6Mza5IBytn9MgZzz5Mz613KdHj3gTiAyGLg5ixXCXSkRIwfa4+KSlvueV7cRdlJpPeVnpkSxuaxK3TxDzBGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBHgm4l2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHkCyYGA8QyQuIMDt9RDR9WI4HDg50V1gQCoq7GDYhk=;
	b=PBHgm4l21Ebf48zClqRZ9CqRguD+iUAcrL2Q/pO0LFQRFiTNTJCQiKuaYTdpGwEfr//lWT
	p9u/Wqih/TZEM7lioFdC9gby+BWcOn4Z8JaJDdF7yVBwTmiSbI1XIw03KGYwxhQ3O2qoVE
	qLpmPTgw+QdpGR+4a3Powz+hTQKSB44=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-WrBIWUkwNUmEQKRxTQm2Rw-1; Thu,
 18 Jul 2024 04:58:28 -0400
X-MC-Unique: WrBIWUkwNUmEQKRxTQm2Rw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8AD91955BFC;
	Thu, 18 Jul 2024 08:58:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50E993000186;
	Thu, 18 Jul 2024 08:58:17 +0000 (UTC)
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
Subject: [RFC 1/7] efi/libstub: Ask efi_random_alloc() to skip unusable memory
Date: Thu, 18 Jul 2024 16:57:51 +0800
Message-ID: <20240718085759.13247-2-piliu@redhat.com>
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

efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
but the current implement can not ensure the selected target locates
inside free area, that is to exclude EFI_BOOT_SERVICES_*,
EFI_RUNTIME_SERVICES_* etc.

Fix the issue by checking md->type.

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


