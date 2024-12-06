Return-Path: <linux-efi+bounces-2302-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1668D9E6778
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 07:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E737E16779A
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381261D7992;
	Fri,  6 Dec 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wcirUkeG"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB1194C90;
	Fri,  6 Dec 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467962; cv=none; b=NtHYaH1jhgbb1PKQ4DXD6gCmWTZJLG3UbIeIcx0nYIN2bjYJE6MNz4yWYicOzP1hU3z5WkVvVCCxBWFEaNTf9rAvO5ULQQmCSkffgPTQ+W8lMT05rLWdsfrqsrA3XGrWwIcE8iX1Pa45pZeubNmEOel66nB2yE20L8SkgxQbm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467962; c=relaxed/simple;
	bh=QKI3EUNW1rltt1s36s5nrBPDRbSosk0rGpu8ypiC7tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5Fd9gv5VCVEeCFlsfpXW113WPkMifEKQ/yCTf3LmRjnLzIU40UgyOPSiMbGW74vfHFCUOFeLGHvYTiipxLf3TqCRMzei/QjqXrgUWPhQnC35YeBHOPR5yWwKX7lJ/hSgFyyznw3V/fAbA7VKwiIVIm5C/ldtgVeERphJl8xsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wcirUkeG; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733467953; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=umjZ89dcPp2AdN2NcW0dKshyLIVy+5W8nFL33J/yuVk=;
	b=wcirUkeGQtx5WgnfUa3kD8ufuB8aLncWtYzevu9+tqP4dHHcLBpNohiYdcbB0mL+/srVYSLe0Oi2VoVAs8M3q8z+B8FCfxOHmYS4mNGN24zhhHplg2/DKCbgGsm1i0H9zXTmhDwnR+EzN3/DJagIKA/JwisqHPt7OF/jMbqRb7Q=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WKvfT40_1733467949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 14:52:32 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org,
	ardb@kernel.org,
	tianruidong@alibaba.linux.com,
	xueshuai@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH] efi/cper: Remove extra space in cper message
Date: Fri,  6 Dec 2024 14:52:27 +0800
Message-Id: <20241206065227.66889-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cper_print_mem print a extra space like:

	{3}[Hardware Error]:    error_status: Storage error ...
	{3}[Hardware Error]:   physical_address: 0x000004099099c400

The correct output is:

	{3}[Hardware Error]:   error_status: Storage error ...
	{3}[Hardware Error]:   physical_address: 0x000004099099c400

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b69e68ef3f02..aa86171f8531 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -364,7 +364,7 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 		return;
 	}
 	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
-		printk("%s error_status: %s (0x%016llx)\n",
+		printk("%s""error_status: %s (0x%016llx)\n",
 		       pfx, cper_mem_err_status_str(mem->error_status),
 		       mem->error_status);
 	if (mem->validation_bits & CPER_MEM_VALID_PA)
-- 
2.33.1


