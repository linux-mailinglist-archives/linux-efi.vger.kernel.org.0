Return-Path: <linux-efi+bounces-1256-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC891106E
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2DB2888CB
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6C1BD51C;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaCtYhb+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AA1B4C3E;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906515; cv=none; b=h2DdtfJv1KXh8vUGXBmHKDW4+yPAz30qtxtjMvZLqcBPA+acYqQUkXa1sZZZjMnOYmWGpnUKW80mj2IfGPvD3Ud5b+5QaaPa48nz+xu+O0gH159QANYStOBZquLL9/q9MKbkeejPEYEjtCZeip8ZwJGNckYyDUluqa46f0lRgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906515; c=relaxed/simple;
	bh=fnFLD8X+GZ0LRDzA58JeKG1w6W0C+HoyHq/6kakLuVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH+k4BzebQgnofvD7UaaO9qxgF+3L74vohz5ieedp6HH4OcwWfK0dO4bI6psuYmAjwLhS3hCKAmVlfvSfaphu/SDM/NE9CCDxQVss2z7rBmh/bXPE8YP0kkZlufjtxfKIb70zfR7j4X5W6owLycSY+SfBZxbSAm1LyD+j6w5hWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaCtYhb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CC2C2BD10;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906515;
	bh=fnFLD8X+GZ0LRDzA58JeKG1w6W0C+HoyHq/6kakLuVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaCtYhb+0borQiXOf3V4W10tRrhEc6GV/zFqh1RDQRLr8OmPdIfbt2fgDxNFjs/jQ
	 /lf5A+A1JO3HBmoKVY/vYOgukIGFHTp5oGoQZl1j9/cOKjV9ifO6+Thsqq9NgfZQaW
	 6K7nZ3evlqTXCCeyJ3ee6yhx/Vju0/mBggipv++1JL0DEqW/b4BaM7r9npYj/sDU+E
	 oDff/dKLVaSB0ZvTFRcxDreMmt+CKNe3hHbbXmX7aNF1fTY1W6IwPTntc/oR4MfM9U
	 +80hPv5t3i77/yo52xJH/s5L+pUneM3S3ESyKq0nhPWOxR6xDV0VqJKqIKiJPKvyvm
	 sVQfVfMfxAKYA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sKM6a-00000006MRm-1PQ8;
	Thu, 20 Jun 2024 20:01:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	"Tony Luck" <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] efi/cper: Add a new helper function to print bitmasks
Date: Thu, 20 Jun 2024 20:01:45 +0200
Message-ID: <fcc8a699c9497b788ac99aa0d57dedd629ac4945.1718906288.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718906288.git.mchehab+huawei@kernel.org>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
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
 drivers/firmware/efi/cper.c | 59 +++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |  3 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 7d2cdd9e2227..9bf27af3e870 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -106,6 +106,65 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		printk("%s\n", buf);
 }
 
+/*
+ * cper_bits_to_str - return a string for set bits
+ * @buf: buffer to store the output string
+ * @buf_size: size of the output string buffer
+ * @bits: bit mask
+ * @strs: string array, indexed by bit position
+ * @strs_size: size of the string array: @strs
+ *
+ * add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
+ * add the corresponding string in @strs to @buf.
+ */
+char *cper_bits_to_str(char *buf, int buf_size, unsigned int bits,
+		       const char * const strs[], unsigned int strs_size,
+		       unsigned int mask)
+{
+	int i, size, first_bit;
+	int len = buf_size;
+	const char *start;
+	char *str = buf;
+
+	if (strs_size < 16)
+		size = snprintf(str, len, "0x%02x: ", bits);
+	if (strs_size < 32)
+		size = snprintf(str, len, "0x%04x: ", bits);
+
+	len -= size;
+	str += size;
+
+	start = str;
+
+	if (mask) {
+		first_bit = ffs(mask) - 1;
+		if (bits & ~mask) {
+			size = strscpy(str, "reserved bit(s)", len);
+			len -= size;
+			str += size;
+		}
+	} else {
+		first_bit = 0;
+	}
+
+	for (i = 0; i < strs_size; i++) {
+		if (!(bits & (1U << (i + first_bit))))
+			continue;
+
+		if (*start && len > 0) {
+			*str = '|';
+			len--;
+			str++;
+		}
+
+		size = strscpy(str, strs[i], len);
+		len -= size;
+		str += size;
+	}
+	return buf;
+}
+EXPORT_SYMBOL_GPL(cper_bits_to_str);
+
 static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 265b0f8fc0b3..856e8f00a7fb 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -584,6 +584,9 @@ const char *cper_mem_err_type_str(unsigned int);
 const char *cper_mem_err_status_str(u64 status);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
+char *cper_bits_to_str(char *buf, int buf_size, unsigned int bits,
+		       const char * const strs[], unsigned int strs_size,
+		       unsigned int mask);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
 const char *cper_mem_err_unpack(struct trace_seq *,
-- 
2.45.2


