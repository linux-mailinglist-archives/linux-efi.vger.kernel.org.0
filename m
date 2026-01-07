Return-Path: <linux-efi+bounces-5954-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D3CFF513
	for <lists+linux-efi@lfdr.de>; Wed, 07 Jan 2026 19:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F7FA35D2A37
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jan 2026 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AAD3876B8;
	Wed,  7 Jan 2026 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0WZFv8J"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAC3803F7;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804131; cv=none; b=dJB7E7fwy1nuz/xhZkPZEaBZJQgtZXO9/90cC/r447e7adjyFjVMiBpIuYiQuFesWmSJ8DHW7GM6VP85DFvuZSxKdaLUnxBwfS1WM3F/6SsJE1L3MDRafVbyKZ/bHFWME/nENtJBlKjT3gl2JWu+OrNETybiNgvALjfoM+Cu5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804131; c=relaxed/simple;
	bh=q8mFlp+bD20oQpXP27iO1F9y1ja315WcWvYnI369uAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3aLXbPrrF/sg2TcZLW098U6FGeMPdzAapIIcDZwtH/Czj0jYIwjdedZcOfY0YqacDWx75XbyNhDBHU0PTK0ort1n1R/GOXEq7nLHrcsYV3GsFg3XERGQW4ymB5aqks9Y9Qc5uipFZ7uF7FT9S7SJPfSyAufLhqgJBpXSI++JOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0WZFv8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206AEC19423;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804130;
	bh=q8mFlp+bD20oQpXP27iO1F9y1ja315WcWvYnI369uAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0WZFv8JcxMq1VizvtDNwWgqxu6kCyb3We/VPemED43l8vYwjOFpbNF8kT1rkX3A3
	 MpM4g+QDGnejPbr718aRBt8hGEBACJCAhJav0mewrn6/wZe5G2cpL5wvQWSdoI0nhz
	 UWTsWDNTdMiV0LFJKwOJTtyBkjbGKjpWl4+zehvMQbXnd4gV6Lseuh9u9zE7/hEfBk
	 r6D1TZezXQJqROVnddLt+mSYLWRWNA+RfUZQXcwrb+qlGWUAQfW14hsiiv8m28Qe6T
	 /WgpbhBQ9qWpBwvyetrfVlPagtQ3SIcBTsHUUUnNBAHCoAtITn/+xNjyQAxl9eROMM
	 DanBAGI37yPGw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vdWbo-00000001bUe-184I;
	Wed, 07 Jan 2026 17:42:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] efi/cper: don't dump the entire memory region
Date: Wed,  7 Jan 2026 17:41:52 +0100
Message-ID: <f47447094cfa388042ed3563acaeb06c98ee5248.1767804050.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767804050.git.mchehab+huawei@kernel.org>
References: <cover.1767804050.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The current logic at cper_print_fw_err() doesn't check if the
error record length is big enough to handle offset. On a bad firmware,
if the ofset is above the actual record, length -= offset will
underflow, making it dump the entire memory.

The end result can be:

- the logic taking a lot of time dumping large regions of memory;
- data disclosure due to the memory dumps;
- an OOPS, if it tries to dump an unmapped memory region.

Fix it by checking if the section length is too small before doing
a hex dump.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/firmware/efi/cper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 88fc0293f876..0e938fc5ccb1 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -560,6 +560,11 @@ static void cper_print_fw_err(const char *pfx,
 	} else {
 		offset = sizeof(*fw_err);
 	}
+	if (offset > length) {
+		printk("%s""error section length is too small: offset=%d, length=%d\n",
+		       pfx, offset, length);
+		return;
+	}
 
 	buf += offset;
 	length -= offset;
-- 
2.52.0


