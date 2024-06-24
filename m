Return-Path: <linux-efi+bounces-1288-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9D91461A
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 11:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC14A1F2138F
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C0130A76;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQl9hJ1f"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1C4962B;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220790; cv=none; b=R2qPvwiTkBHgWWIUD/5h/lCLsayvfk3tNGbcDlj549inPGEs/TI9j6b/Jpz6Vlyaw58IUqqaay7h9c1iMvo0N8jipsXGWUTZmV29QyzXzLJlK8PFll1cCt9Ad/7E/eSwG89qmX3GkpZX8bdbR7ZN6frLJVv1xnaNOTvqWXk2H0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220790; c=relaxed/simple;
	bh=ueKAZu/ar61RH+7+SVha6r9QoHpXIuCXEquxTHmjDy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw4bR03qMI1GnjgBcbRcQpb1sc6t0/BiDgSzF3DUIjRcY0j1FUcBV4o0nROh1x1gLRV5dMWeXDcEvb2BSiPG21i7etd7cYLuIZK1ICewcq77zZYYB54HhDK91Z6w7ohrruU6xW5OkPfBrAC6GRKZ7MlTeAFPXkHL7MX+vZ6kdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQl9hJ1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B65FC4AF0A;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220790;
	bh=ueKAZu/ar61RH+7+SVha6r9QoHpXIuCXEquxTHmjDy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQl9hJ1fKghiq9MwhsYzEd3OPju43qMtQZqFVba1+dc/YYg3vbhEJGQ0M2Vnc+RHS
	 bSvzLEeiz6v3VQO970GB0JMALPfNe/5CBQn6rLji3tfKa7b7aCbP3kHP1glYN+nM+n
	 c6si/OcXorTEL68dH4eK/czp2WUx0hF11HjLBkHdJzLf6FftFTPc35Ii+q57RtS6Jf
	 7cBsl3l33TIvowngFXwOUeUaBKpXMXs/qHE7W27n0FwcwJDAjbxkR9kda7LHWZo4C6
	 3KttKQqA7Xpfrq3WytiVd3ImILwnATwJk0SjEYlkyNHWzNN9xDfA2qgVvGNpqhVCK3
	 KAss1erx/qE6Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sLfrX-000000085br-2FWa;
	Mon, 24 Jun 2024 11:19:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"James Morse" <james.morse@arm.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	"Tony Luck" <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] docs: efi: add CPER functions to driver-api
Date: Mon, 24 Jun 2024 11:19:21 +0200
Message-ID: <c159ef52241b263ffdc15140d7f3195b389b9166.1719219886.git.mchehab+huawei@kernel.org>
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
index 4cf56657afde..c8a432c5cb5d 100644
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


