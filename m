Return-Path: <linux-efi+bounces-1371-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64792A0D4
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 13:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E003F1C2104C
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAE7BAE3;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maSieSA3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24D39FD7;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437554; cv=none; b=pRWq2imM3r/Ms0ynZJSAoctMt84TlOGt5jz8pTvQP8wowAtfH1ZlXOKnTRAaHKAMn7hRqgS8Gf7ZO7aPvnNkfTthfIldn0/+YnA+LIBVipHsV377qoICHHIBoyvi2Wu7PnBNAbK7mSkcZAl7G4I1k0Qt2rQvmfxfii6iq4NQ428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437554; c=relaxed/simple;
	bh=jPOSGw8h3LTxme7xAjF29NTRuS0fIgaE9Bx1xOw0o50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL6U7JJLX+FiSbuJKZJKhw74+F3gTHndVN0RZmJt67Hs84JoGT+QijNWpXo+D6DUTo9SUwpbJFuMAPju0H/Ia68ne8wPZztDgwo1UBZx78ouPsY1oP7ymOpGB0VgMqbsYPnrFeO/8G2NhGjgFntrguXc1g42esinAzw+/AD8eFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maSieSA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0198FC4AF0A;
	Mon,  8 Jul 2024 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437554;
	bh=jPOSGw8h3LTxme7xAjF29NTRuS0fIgaE9Bx1xOw0o50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maSieSA3JmSQKEQVd7NmXYm1z4re/L6AIb6EHSiN4eX+qAitt8hy9+nXm8Bcf7j14
	 CakCb7I8I6AAFmIYk/Ycj26X/VRL3fV+qiiTf8ubDflqrnqCeH6U3ZZ1UodHie5msR
	 IexZlvcwsr8bOdGQPDNqNiQP2YQaSxLMYNqKWeVH8lBnn+kHkZFEQ/nPu2r+1QZvMC
	 merwvShAHvMZhGqjnBREw2V+sTg6A0XClU47gJpfb4VCtMcfLu3UlAGWABQuOkT1Xe
	 4/C/lIgHPmLPz4FXF257dTTHueBafdXcBAqSrXaM9L4Ju6tcrKqnjqpC2rtqj/zUdM
	 AiidmZoznoy7g==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sQmOl-00000001SQl-2bki;
	Mon, 08 Jul 2024 13:19:11 +0200
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
	Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] efi/cper: Add a new helper function to print bitmasks
Date: Mon,  8 Jul 2024 13:18:13 +0200
Message-ID: <b6bb6f96420975e91a5660ede6dc20e351c33286.1720436039.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
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
index 7d2cdd9e2227..f8c8a15cd527 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -106,6 +106,49 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		printk("%s\n", buf);
 }
 
+/*
+ * cper_bits_to_str - return a string for set bits
+ * @buf: buffer to store the output string
+ * @buf_size: size of the output string buffer
+ * @bits: bit mask
+ * @strs: string array, indexed by bit position
+ * @strs_size: size of the string array: @strs
+ * @mask: a continuous bitmask used to detect the first valid bit of the
+ *        bitmap.
+ *
+ * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits
+ * mask, add the corresponding string describing the bit in @strs to @buf.
+ */
+char *cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		       const char * const strs[], unsigned int strs_size)
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
+			break;
+
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
index 265b0f8fc0b3..c2f14b916bfb 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -584,6 +584,8 @@ const char *cper_mem_err_type_str(unsigned int);
 const char *cper_mem_err_status_str(u64 status);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
+char *cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
+		       const char * const strs[], unsigned int strs_size);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
 const char *cper_mem_err_unpack(struct trace_seq *,
-- 
2.45.2


