Return-Path: <linux-efi+bounces-4848-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADBB5A191
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DE9166C82
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 19:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6982DF6F8;
	Tue, 16 Sep 2025 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPRJjjtX"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95C2797A4
	for <linux-efi@vger.kernel.org>; Tue, 16 Sep 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051542; cv=none; b=fseVSk8LOzBGP+kQtHFOryXEB95k2UlEeXbgvfzguk2DGQyZohmY3qd7qj8Fu+DEGChUa46rhEGbN+4e3Zg6BnHQNyzgu4dn/yq+FCFMj8qdIx2gPnxVXYJkjjKmXcPOAnIrKDuZk4IZxUdKOS7wdV8gxTa10v3a/HoK2l7I2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051542; c=relaxed/simple;
	bh=Q4kVru8i8IIfSOoE84wSITyzfCl6oFTOK7yBiPxJkJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brLHeQz9Tdukf2z/FdfSI5LBz8tlUOPPKcOPj9bw5wZxnKO8p09vozK3c0adKMuYfk3eomBuZCA6+Z79R+79ZHqty7JK2zh/+9AKAWwiPyymLmlaVubybrhdTEhfnvCMo8P/5efDjcfuiFetcJYhKsIf+tyf0B+JkspqjR9Bbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPRJjjtX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758051539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+7hKGgfCrcGGIhnxPu7A9Ry/ZimHce+9evBu/ut+yg4=;
	b=OPRJjjtXPMJcNtzYzFQm6Z8aExhRi18JaUTq1oVSDKTp4G1CTaSNMQd0EfNfdt/G9MLKJY
	azPQWBwBL6+CH8eRE/oC/bdXB8JlhMQtt51+AF3VlhGtbwjlTcWxoy1JDLwXVq2g1HAgci
	LLl6w0GwQ9nYTTob3CCSGRTIq68sewU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-P4f2Hq3UPwCRNeYxT_NYNg-1; Tue,
 16 Sep 2025 15:38:55 -0400
X-MC-Unique: P4f2Hq3UPwCRNeYxT_NYNg-1
X-Mimecast-MFC-AGG-ID: P4f2Hq3UPwCRNeYxT_NYNg_1758051534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3A1A19560AF;
	Tue, 16 Sep 2025 19:38:54 +0000 (UTC)
Received: from lszubowi.mht.redhat.com (unknown [10.17.16.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B40C30001A4;
	Tue, 16 Sep 2025 19:38:53 +0000 (UTC)
From: Lenny Szubowicz <lszubowi@redhat.com>
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/x86: Memory protection on EfiGcdMemoryTypeMoreReliable
Date: Tue, 16 Sep 2025 15:38:53 -0400
Message-ID: <20250916193853.410189-1-lszubowi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Check for needed memory protection changes on EFI DXE GCD memory space
descriptors with type EfiGcdMemoryTypeMoreReliable in addition to
EfiGcdMemoryTypeSystemMemory.

This fixes a fault on entry into the decompressed kernel from the
EFI stub that occurs when the memory allocated for the decompressed
kernel is more reliable memory, has NX/XP set, and the kernel needs
to use the EFI DXE protocol to adjust memory protections.

The memory descriptors returned by the DXE protocol
GetMemorySpaceDescriptor() service use a different GCD memory type
to distinguish more reliable memory ranges from their conventional
counterparts. This is in contrast to the EFI memory descriptors
returned by the EFI GetMemoryMap() service which use the
EFI_MEMORY_MORE_RELIABLE memory attributes flag to identify
EFI_CONVENTIONAL_MEMORY type regions that have this additional
property.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..0f60a12401c2 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -300,7 +300,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 		return EFI_SUCCESS;
 
 	/*
-	 * Don't modify memory region attributes, they are
+	 * Don't modify memory region attributes, if they are
 	 * already suitable, to lower the possibility to
 	 * encounter firmware bugs.
 	 */
@@ -315,11 +315,13 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 		next = desc.base_address + desc.length;
 
 		/*
-		 * Only system memory is suitable for trampoline/kernel image placement,
-		 * so only this type of memory needs its attributes to be modified.
+		 * Only system memory and more reliable memory are suitable for
+		 * trampoline/kernel image placement. So only those memory types
+		 * may need to have attributes modified.
 		 */
 
-		if (desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory ||
+		if ((desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory &&
+		     desc.gcd_memory_type != EfiGcdMemoryTypeMoreReliable) ||
 		    (desc.attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0)
 			continue;
 
-- 
2.51.0


