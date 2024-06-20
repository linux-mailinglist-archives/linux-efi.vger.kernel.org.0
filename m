Return-Path: <linux-efi+bounces-1251-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F290FDDA
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3061F21A53
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C84D8BA;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+KdwF2x"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D045026;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868863; cv=none; b=WLo5r2LKXoz2j/E0xWdn7Vbckv8xKb7ipP+dCsMMH/h6CP10lSHZFN6D+GqS8q2z/vsvHB+vVGZw98zCT/fAq+ufJm6OQxNTYlh9FMZqsqX9cj7T8GdOt85W8exx3idVu9SO7YWZoKdGe9T+2IBd1reSs2ZsknE8EGnGEUT+oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868863; c=relaxed/simple;
	bh=zTlhVy3kZux1xfHgudT09np+XA8jgEQ4BvrungDrLNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc/hvHiw9aWbtTGVeBHz+i+wPpW9PYbyMJupKfNyZawc3rXrvTwhRVsIPoJG8w/CltIziK0GubC2KgN2o3wvOE3oYh7x6lqf+yE0qanUlP0jWwvKLk03VFBDtKjTe4XxddEhoMfhxqXjxms4PqguD6iiVTCdg/OFe2wvg0JaNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+KdwF2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7232CC4AF07;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718868863;
	bh=zTlhVy3kZux1xfHgudT09np+XA8jgEQ4BvrungDrLNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+KdwF2xe/vyDbxbPVkJXQNYYF5a96Aktbdcjq/cgWFrBRomFhf0QPpeAhyNRwKiO
	 UOwsTRpkTlWTHcoLSMSaCKsFgBTA2Qt2kC7Os+fdxp7GTLiJb+TzFkdNMY+4zHgEkK
	 WRUxtsduljtj4BJ+hchriBDD+N9YoMiNsqWOrJd6UpVQT22zhxD1/ntU+zfmD/5sxe
	 +WvbsFZaKOsYIfK3LGkxWEPxkvac8TgNrELYBr91dw3UqPI75XRd5IE6yxdXrX89Kx
	 BZkmxVo6a5Gi0/xPv4e3rqabszOWVlr+9K2Jo4HC/Tuy6sdf9iQPFYIU646CFfXTSr
	 A0qqdWjzgN1ug==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sKCJI-00000003c06-3aOi;
	Thu, 20 Jun 2024 09:34:20 +0200
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
Subject: [PATCH v3 2/3] efi/cper: Add a new helper function to print bitmasks
Date: Thu, 20 Jun 2024 09:34:13 +0200
Message-ID: <db8091327144387326ae28eb5c16212787a3eb51.1718868693.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718868693.git.mchehab+huawei@kernel.org>
References: <cover.1718868693.git.mchehab+huawei@kernel.org>
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
 drivers/firmware/efi/cper.c | 40 +++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 7d2cdd9e2227..f315acb6c19c 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -106,6 +106,46 @@ void cper_print_bits(const char *pfx, unsigned int bits,
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
+		       const char * const strs[], unsigned int strs_size)
+{
+	int len = buf_size;
+	char *str = buf;
+	int i, size;
+
+	if (strs_size < 16)
+		size = snprintf(str, len, "%02x ", bits);
+	if (strs_size < 32)
+		size = snprintf(str, len, "%04x ", bits);
+	else
+		size = snprintf(str, len, "%08x ", bits);
+
+	len -= size;
+	str += size;
+
+	for (i = 0; i < strs_size; i++) {
+		if (!(bits & (1U << i)))
+			continue;
+
+		size = snprintf(str, buf_size - len, "%s ", strs[i]);
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
index 265b0f8fc0b3..866e195819de 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -584,6 +584,8 @@ const char *cper_mem_err_type_str(unsigned int);
 const char *cper_mem_err_status_str(u64 status);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
+char *cper_bits_to_str(char *buf, int buf_size, unsigned int bits,
+		       const char * const strs[], unsigned int strs_size);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
 const char *cper_mem_err_unpack(struct trace_seq *,
-- 
2.45.2


