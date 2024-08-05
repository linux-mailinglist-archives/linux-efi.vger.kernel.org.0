Return-Path: <linux-efi+bounces-1531-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D3947B50
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 14:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E732CB21C1E
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103D159583;
	Mon,  5 Aug 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSIFIw5o"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285521591F0;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862446; cv=none; b=QruRAjjIyBFjhNZjUYgHdxDUZU5y9/k/MYyagkxo2+VvzA2OaQ2qRIEOqzFF1ZBQjmK8UYJSPr5gsOvHPNqnIOtI4VL7o5kjzvoqhJcrocU9SMRZ8TigO7jmfWpm9KR30zVGGuRWX/+q0dg8LF0U/dSHPQ1z+TTnuASQCK0I4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862446; c=relaxed/simple;
	bh=2ayTZSkz+6Om/td/hGkUrK8vPsiqWX26wgpjxmBwf7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+23hjOTImZlXQHzefn92k0qmJ9+jGMRzf9MseMTRKZBi3gpW7VIkR5z+Z9wTVk2cIqg814Ow7B68vt5ElmQfcRHhJWS94GLZWtCIbL/fFmuOk7cjN4poC6lhKuqF91g5VAVij2qMW9gObk8DqhBYxmaA+O2CloonpMUbQxkt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSIFIw5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B66C4AF0E;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862445;
	bh=2ayTZSkz+6Om/td/hGkUrK8vPsiqWX26wgpjxmBwf7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSIFIw5o9Nsgfn4abbpvSymgPWREtcl+xWFAmAEARQcov5PUPvDsrd1ZwMfQ/Md8w
	 3K6qqULna55TXrFlfLfOD+NhbD3148iGYJAALv5XwXZDVha9chOsC+0a9CaVwzFRa+
	 Ka2wAJY3qyymQp/4+dy6NzOjw9FH6DNBysse1PEAVu9bHn5YQMzl8d0em3iqGMJCaH
	 ML6DLoUVif4Vg+wr0a/h0lKw+qO9XZ4HaiAHpB3ISBvlPE3aXBGy6usIu5cO+wYn1Y
	 lRceKZSlykGYJfQDIUUG4oa7Am0XCGiO7WoyDgInfCFfby/3i4FJdhD4yTKd1BZL0w
	 ii0EVExs/sYVw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1saxDv-0000000CyYm-3lUd;
	Mon, 05 Aug 2024 14:54:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] efi/cper: Add a new helper function to print bitmasks
Date: Mon,  5 Aug 2024 14:53:34 +0200
Message-ID: <d66ab57c910b08c187b40099911b212cf51c3f92.1722861911.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722861911.git.mchehab+huawei@kernel.org>
References: <cover.1722861911.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Sometimes it is desired to produce a single log line for errors.
Add a new helper function for such purpose.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


