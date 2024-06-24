Return-Path: <linux-efi+bounces-1287-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE948914617
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 11:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C79280E4C
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A291304BF;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGYP9MFX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9412FF8C;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220790; cv=none; b=kRJ4qnp4/4FOzYfMu1ufGjbpMIHJuNODkKwpoTXttPKkes4J4TnR1PfacDEiE9gcJEp5HTGzAKxHrLjd8PDAtkffcD3RocgyW4pdVQvTxyIwu4B8b4lYdFgoN5YQhx5+8HMiSOgnKO9YUHWCUSapGuH29ln90H+CmnK+FPxLn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220790; c=relaxed/simple;
	bh=MiJu506E02sUqMejKu5a4CpTEW7a3bv6SgfhjAqtNZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnS/Xj03BY+9+n3wFp2MGxfpWdNnqBSzFz/hUEj1FqMjRTZbU7inGD5fQZ2EipGCxFJ7Q43bKhJN8IN0fwuHeY0FLCGqVUeAP6fLYFMdP24XTEeKWwVcwpVtVi2UWQVs8jvaN/MrmAYNVp9b5M979nLZKXe+Y8TsTwu/geqpMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGYP9MFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0936CC32782;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220790;
	bh=MiJu506E02sUqMejKu5a4CpTEW7a3bv6SgfhjAqtNZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGYP9MFXOpjlu+0DM1dR1AdDd1EIvzeJ4btWbao7hqc2LxltXn0sLcJYhNUEr6Mwq
	 548Ptdnx09TP1zDcwf8ot2vLOXmzc+XsfW87qDZJ9XyTfh2Y+CqgWAReyjT7jtnD+j
	 HTUEwLg8PQKYOGXUyn3xcDmJc/VSJ4wxSuhjCf35pRr4TP/yGMaphDlcvhlV9FHxl6
	 Z7H+J5xaMFEcDtN9+hk+Z7TEU7KdBdGcIASdwOIoYX6vfg7D9s98IIYgDG0FmlX1WV
	 EAdlaemWJCagRjpA3E0UTHCzHWTqWVuk2PozvT1zROqQHnZmdwdrQfKCgD+1NOvOzd
	 CFz0N1MZ5YWUw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sLfrX-000000085bi-1s15;
	Mon, 24 Jun 2024 11:19:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	"Tony Luck" <tony.luck@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] efi/cper: Add a new helper function to print bitmasks
Date: Mon, 24 Jun 2024 11:19:19 +0200
Message-ID: <b5a425bd61f211a17a2b296a3c9ac251b3c3a20b.1719219886.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719219886.git.mchehab+huawei@kernel.org>
References: <cover.1719219886.git.mchehab+huawei@kernel.org>
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
 drivers/firmware/efi/cper.c | 41 +++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 7d2cdd9e2227..4cf56657afde 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -106,6 +106,47 @@ void cper_print_bits(const char *pfx, unsigned int bits,
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


