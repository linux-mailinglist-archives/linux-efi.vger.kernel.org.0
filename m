Return-Path: <linux-efi+bounces-1649-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4C96B0F1
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 08:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318091F26670
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8E84A5E;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtiwccD/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9384A22;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430064; cv=none; b=eBpiO3COOVFEF8IoCe0dyXvwhIMGal4E4fSpaoz0C/H3dJicxqah8ElCpXafx5hkv2GdoepHQlRwFPkZajkOFDqyvJjgQNgeisM9JqeDnnTwvgvl4rZJCrZUSVGSc1XjkgrPUllQNu+ifd2u7MHoezPBhFlt/jBbS5UVDIJmvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430064; c=relaxed/simple;
	bh=szmbRmJSlfecOkBadwIdFwUwMXBdeouQ0p2zpgLwy48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO9mDajLePu7EYMCPlGtF5E0l/pSdB0D3TfAKLL2wibOaS1LGFNtYW8UeF0qQTISy5oNxMumEwie+G/EHo8CYDuWoSEUOp5B/zDI7MnQ5Fnu5rX9mYrJ6N9wF5C3bUQLh+C3Y9Nz7ZMMPZTJz2PMfXKB9IJ4qEiSvlbmvjA6zMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtiwccD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E73CC4CEC2;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725430064;
	bh=szmbRmJSlfecOkBadwIdFwUwMXBdeouQ0p2zpgLwy48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtiwccD/dgAPuksiF++CRE/xjmFEjFQD+ZBQjStVaSN46vY853W56d5HfpbLEr9q4
	 jabqT32QhyOhDrksDBf4Uac0cR7+jmEEwegZp8j6CfIfG9LlGdzKb0zn5LHHl8RRia
	 0drQksrzsTmeFN5EHdnMdRaYd45i2mS2bob83RDiBn9mNcxmz3nVC7UmNlTGQqoDtt
	 7pExm044XvEjm1skz01RLa9E6ubXHGpNjkBR7EXAsX4ngesvz0A7XucrjodGPF2jjX
	 0QwlT7CERsePjgAHnnSEgcz9QyzXfwm2BnPfG9LvVuUVuK0QPJsOqgSdPLrM3lN5bM
	 wC5coMZwZQIcw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sljB8-00000006Itn-0QpS;
	Wed, 04 Sep 2024 08:07:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] efi/cper: Add a new helper function to print bitmasks
Date: Wed,  4 Sep 2024 08:07:16 +0200
Message-ID: <9622036364ffe91a22120a47bd02df4876e46a87.1725429659.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725429659.git.mchehab+huawei@kernel.org>
References: <cover.1725429659.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add a helper function to print a string with names associated
to each bit field.

A typical example is:

	const char * const bits[] = {
		"bit 3 name",
		"bit 4 name",
		"bit 5 name",
	};
	char str[120];
        unsigned int bitmask = BIT(3) | BIT(5);

	#define MASK  GENMASK(5,3)

	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
			 bits, ARRAY_SIZE(bits));

The above code fills string "str" with "bit 3 name|bit 5 name".

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/firmware/efi/cper.c | 60 +++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 7d2cdd9e2227..f60fe7367e3b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -12,6 +12,7 @@
  * Specification version 2.4.
  */
 
+#include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/time.h>
@@ -106,6 +107,65 @@ void cper_print_bits(const char *pfx, unsigned int bits,
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
+ * A typical example is::
+ *
+ *	const char * const bits[] = {
+ *		"bit 3 name",
+ *		"bit 4 name",
+ *		"bit 5 name",
+ *	};
+ *	char str[120];
+ *	unsigned int bitmask = BIT(3) | BIT(5);
+ *	#define MASK GENMASK(5,3)
+ *
+ *	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
+ *			 bits, ARRAY_SIZE(bits));
+ *
+ * The above code fills the string ``str`` with ``bit 3 name|bit 5 name``.
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
+		if (!(bits & BIT_ULL(i)))
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
2.46.0


