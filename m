Return-Path: <linux-efi+bounces-1373-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A637B92A0DD
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 13:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C241F21D77
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CC7E0F1;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhs5TBEz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AB7A715;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437554; cv=none; b=pzC8QDLw84t4FWXd7X3uXgV5waCuhNTjTVQEwjPk3wcumJfSPGqkI7vAqh2HN8Ma8EcIcMjYZ+oj33Sg05QGuTdYT1X3P/5lQtzWV7YHXwmN6Nl7hDerq1BgAp6mr09EQxLqt72iQrSIs3+fap4ksThAZBtD6c0pgpgBPRoNZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437554; c=relaxed/simple;
	bh=SghajJ93+iIxp1CCEYJcx9SzDpum+6rkVLD7R4JlgPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr3/KYAVGZWYNgpYzKAUvVi75aruJbARKqygcZm91EGufEFTXjhc1Kskum1Z9JAkUrjrR0y2q+t1F7KuLG1Lu5hICqljPx76pkP4gHCbt/N5WMY3vsLrqn/o/tp58CQ08jvFLffAoW4hBqaRAH99I+2EsJk38I6m54uVjiENmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhs5TBEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2508C116B1;
	Mon,  8 Jul 2024 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437554;
	bh=SghajJ93+iIxp1CCEYJcx9SzDpum+6rkVLD7R4JlgPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fhs5TBEz2JYV0lD8FKDqRKZhZmtCaLbzHlQgRf34jJzjM1eNk2yFwAnNv0AQkG6g0
	 YazbqT+fHQ+ZjkWucYkTCnLkcz22a3IjoFCXFsQ98Poe6LoNqRUkZqGwYsYQIAYCbG
	 tvY9LoyMsXSr1LY5iR+oHOZp1LhAeZbJu+eO2Jny6paEqmm2fKM3xmPH8ljTEWqdFh
	 f15paEdtYMe4ZCLuAmtSqu12nNJx1lXsUK1t5p2j30pueGUGLHxhTlWjoO6LGH6fkW
	 kpSnP2j+Vgg8cN6b/Z4yyw9MVMNOSaQV6XUuquKKq09DFvFqYBF1zXgx8JEq/SCUeR
	 Poq8jQE/qM6xQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sQmOl-00000001SQt-2qde;
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
	Jonathan Corbet <corbet@lwn.net>,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] docs: efi: add CPER functions to driver-api
Date: Mon,  8 Jul 2024 13:18:15 +0200
Message-ID: <2d0e11752d2bde41b61822b04b5b6f839d46b998.1720436039.git.mchehab+huawei@kernel.org>
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

There are two kernel-doc like descriptions at cper, which is used
by other parts of cper and on ghes driver. They both have kernel-doc
like descriptions.

Change the tags for them to be actual kernel-doc tags and add them
to the driver-api documentaion at the UEFI section.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/firmware/efi/index.rst | 11 ++++++++---
 drivers/firmware/efi/cper.c                     | 10 ++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentation/driver-api/firmware/efi/index.rst
index 4fe8abba9fc6..5a6b6229592c 100644
--- a/Documentation/driver-api/firmware/efi/index.rst
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -1,11 +1,16 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-============
-UEFI Support
-============
+====================================================
+Unified Extensible Firmware Interface (UEFI) Support
+====================================================
 
 UEFI stub library functions
 ===========================
 
 .. kernel-doc:: drivers/firmware/efi/libstub/mem.c
    :internal:
+
+UEFI Common Platform Error Record (CPER) functions
+==================================================
+
+.. kernel-doc:: drivers/firmware/efi/cper.c
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index f8c8a15cd527..2785c8ea8ad8 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -69,7 +69,7 @@ const char *cper_severity_str(unsigned int severity)
 }
 EXPORT_SYMBOL_GPL(cper_severity_str);
 
-/*
+/**
  * cper_print_bits - print strings for set bits
  * @pfx: prefix for each line, including log level and prefix string
  * @bits: bit mask
@@ -106,18 +106,16 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		printk("%s\n", buf);
 }
 
-/*
+/**
  * cper_bits_to_str - return a string for set bits
  * @buf: buffer to store the output string
  * @buf_size: size of the output string buffer
  * @bits: bit mask
  * @strs: string array, indexed by bit position
  * @strs_size: size of the string array: @strs
- * @mask: a continuous bitmask used to detect the first valid bit of the
- *        bitmap.
  *
- * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits
- * mask, add the corresponding string describing the bit in @strs to @buf.
+ * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
+ * add the corresponding string describing the bit in @strs to @buf.
  */
 char *cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
 		       const char * const strs[], unsigned int strs_size)
-- 
2.45.2


