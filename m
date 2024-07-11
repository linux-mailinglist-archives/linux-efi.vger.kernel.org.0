Return-Path: <linux-efi+bounces-1417-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E192E028
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D282BB2144D
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAB12D1E9;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puW4N9or"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC81182DA;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679469; cv=none; b=KizPlLZsyUKJtHRlNOSWOk935acKCFzC4GjQhz5W9fTMIIF0R1D5aV8tRtqeYe5UtQEiYYFKaPhYeMHntX3Zyx+22wy2zCvdjj5F6W+N6F78Lcnw2FlSfVLRllAJh5YGqftet4RthiISuqRmN9/Tu+hqaGmq04KNz96R5S9BkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679469; c=relaxed/simple;
	bh=pDWUn66c00AEjO5QIKQqjetMLx+EhsGDSyPhrevLOvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0ic56syMR4R/AJL2wyUYUc/X8XFsCZ0W6J327LQNB1Y0VGk2KlD2/unki8MVeCl55zXGd1yy1wbcsbngNXNy8giAg4MuOxLzfCpp8u1XLB7PQTyU3c7DquzTLDQFDIS20Xa5ZzvCwrFEyRy4GuiXVayFw98Y+QfFFEvI9jpiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puW4N9or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264FDC116B1;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720679469;
	bh=pDWUn66c00AEjO5QIKQqjetMLx+EhsGDSyPhrevLOvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puW4N9orj1UR9isGtPixD3tTPAzAEed7ABLXI4kVs1EkJgc4SjDcE+gkzk81MamdG
	 XMNxazdrpk4siJv+UIn8IxGVjUqnse0sh923WJb8zSa88YnhJFPoE9h8vTBX5voMPQ
	 wXuGDB97rMGLUDjOmF4sGS/KGUZyn9y3Pza/dE4t4MxNC35Xl58GKMq1ZJ+ygR8l25
	 0cowhqcajKi2ZTycSiw0Sm8A40TJJ0JDF5lEgWzfXd9PGoIDRMHi9HNZLcwHOYCH0O
	 iPe4iZfskPUzRSE1wwUdbNbKkOTGfq/4UDQRjGGLmtcmmG45WDZ+7LeX7KUPzhE8Gy
	 gZhA5R8YHpLrw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sRnKc-00000002b5X-1M5S;
	Thu, 11 Jul 2024 08:31:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Ard Biesheuvel" <ardb@kernel.org>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Len Brown" <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] efi/cper: Add a new helper function to print bitmasks
Date: Thu, 11 Jul 2024 08:28:54 +0200
Message-ID: <5bb5f806a763b295401972fdff17bb455bee2e82.1720679234.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720679234.git.mchehab+huawei@kernel.org>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Sometimes it is desired to produce a single log line for errors.
Add a new helper function for such purpose.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/firmware/efi/cper.c | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 7d2cdd9e2227..462d739e8dd1 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -106,6 +106,49 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		printk("%s\n", buf);
 }
 
+/**
+ * cper_bits_to_str - return a string for set bits
+ * @buf: buffer to store the output string
+ * @buf_size: size of the output string buffer
+ * @bits: bit mask
+ * @strs: string array, indexed by bit position
+ * @strs_size: size of the string array: @strs
+ *
+ * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
+ * add the corresponding string describing the bit in @strs to @buf.
+ *
+ * Return: number of bytes stored or an error code if lower than zero.
+ */
+int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		     const char * const strs[], unsigned int strs_size)
+{
+	int len = buf_size;
+	char *str = buf;
+	int i, size;
+
+	*buf = '\0';
+
+	for_each_set_bit(i, &bits, strs_size) {
+		if (!(bits & (1U << (i))))
+			continue;
+
+		if (*buf && len > 0) {
+			*str = '|';
+			len--;
+			str++;
+		}
+
+		size = strscpy(str, strs[i], len);
+		if (size < 0)
+			return size;
+
+		len -= size;
+		str += size;
+	}
+	return len - buf_size;
+}
+EXPORT_SYMBOL_GPL(cper_bits_to_str);
+
 static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 265b0f8fc0b3..25858a7608b7 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -584,6 +584,8 @@ const char *cper_mem_err_type_str(unsigned int);
 const char *cper_mem_err_status_str(u64 status);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
+int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		     const char * const strs[], unsigned int strs_size);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
 const char *cper_mem_err_unpack(struct trace_seq *,
-- 
2.45.2


