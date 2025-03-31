Return-Path: <linux-efi+bounces-3131-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481DA7604C
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 09:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA621886CA4
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E226189F3B;
	Mon, 31 Mar 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZW/ZIn1L"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE401E492;
	Mon, 31 Mar 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407125; cv=none; b=UvZOgC3rKlJZge8KnNi0jfIKgnBH7byaz45EF++jQj655BZIvs34e8+pTUdzQrNhwYoK5e2NMr5T1gd545BQBbnYGa1dDBckyNpVwIeNC1i7J33eyXn/WQi+12LqFqA3xM1xjI3hv0wvFDAaWzAyFbiAo4ZygKAJXeeVKqnhiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407125; c=relaxed/simple;
	bh=LNXjH/AYu3T8jMXUfQS1IQ2NyOdLgzMfHNz0sBh7xn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ISCiIqGWwdoJstIvUxw0KOTy+t7q5pXlBN+++lHh/Z00sH0Hq0CdlWYsWxI4t7Jwqfu/i1jemCwjyBQDkdlR8y9ILD71pgovT/YZX47l+Ox5/b7kC/5a/O+22YmT3O7Q3P2j3GNWfE228MDBByIili0KMB0N8TJVOySu2mpo3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZW/ZIn1L; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from canonical.com (118-163-61-247.hinet-ip.hinet.net [118.163.61.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 87CB03F2BB;
	Mon, 31 Mar 2025 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1743407110;
	bh=AxheEsUpH3+mm6//tzaZVFca3XzAr4o+WFeNiTzYoY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=ZW/ZIn1Lkcmvrj4h5PSOaH3UNIJMTsOkLN6dvA/DFAwImorHXmIyBGdH6GBZjuTiZ
	 TJNS5SIrS2fBWVDcb9X7OLVRSFfloAKvAd312GMU8W2AiTcxiT6FDy30zEPZzS7b+P
	 D5/C83+GFEZcC3SPEv4u7PV+8GOIVgOUWPkFNZq5Ix0LROaI9kFZ7BTxGB/VFErA8Q
	 aprV3HTNInnjNnoT806lCUUD9AYR23/VvykylhOf+Og/fVbTRUV7NNRLFIV8ki7V3w
	 9TCF2tm7Wd7G+qv0hwvLXoR+6I7cTahvJddQUyfKHQ+Lbp/8A3PD1INZPXa/6jETo+
	 PbZCsWksFqS1g==
From: Ivan Hu <ivan.hu@canonical.com>
To: ardb@kernel.org,
	ivan.hu@canonical.com
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/efi_test: Fix missing pending status update in getwakeuptime
Date: Mon, 31 Mar 2025 15:45:04 +0800
Message-Id: <20250331074504.4096087-1-ivan.hu@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pending status was not being passed to user space, leading to
false test alarms when using the pending status. This patch ensures
that the pending status is correctly updated and exposed to user space
when calling getwakeuptime, preventing incorrect handling of the pending
status.

Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
---
 drivers/firmware/efi/test/efi_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 9e2628728aad..77b5f7ac3e20 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -361,6 +361,10 @@ static long efi_runtime_get_waketime(unsigned long arg)
 						getwakeuptime.enabled))
 		return -EFAULT;
 
+	if (getwakeuptime.pending && put_user(pending,
+						getwakeuptime.pending))
+		return -EFAULT;
+
 	if (getwakeuptime.time) {
 		if (copy_to_user(getwakeuptime.time, &efi_time,
 				sizeof(efi_time_t)))
-- 
2.34.1


