Return-Path: <linux-efi+bounces-1534-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB42947B5F
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 14:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EB32821AB
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E715DBAE;
	Mon,  5 Aug 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fswYaPcs"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41A15D5BE;
	Mon,  5 Aug 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862449; cv=none; b=EiQ1sDEaoixzCEUaP2qPRsRXULPmc3bpkISbiPv7meRw8PJSS0rS8c0Z/urg9KWti6fbRnwEoFbHo7kbdR2Eluv9PXH2oXwGaPiD6H8xebRrnu6e5+s2UA0oPQCIXF9fGLibA+LJ6XLIBOPwGkyS3D/g5ejFA/SkofyzShJqlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862449; c=relaxed/simple;
	bh=BUannu00JepoL1Z7Ukw4YDCb+t7wSdorptXpbpSwoW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZCqkc2B5uCt8Q2IpYjWGgTMBBpSCoiKdDK/niIVbQjJVUECRSqyCstGUHAub5euGpzWWzfc8p5xdC0DucMot8AtEj9VmJfN96iyhGaaZIwQKf1L7JHAnZ+j6pbap70othhAZjlVHkRdqi6wmXEo7YA6jy3X/Q8wCqIwxRJRO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fswYaPcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9059DC4AF0E;
	Mon,  5 Aug 2024 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862449;
	bh=BUannu00JepoL1Z7Ukw4YDCb+t7wSdorptXpbpSwoW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fswYaPcs6a/b3lq8DhDNOcQU8A+n9VxOD9+3cysxw316lXiOz6QYsZcUJ73fM2Cj8
	 ZiUltn/G324MN0iVTWTwbTQLOqPx7YAZFaTEoqLHeOBqt0uBm4LqF0EjcH6VkUZ1V6
	 36x4CkPTf+RTYrO4eRq5tN5yWZSHgEJIWbnWiRFY5a4KNGkc9MxeIjPM0v1v38/R/o
	 rfd+Fb5D5UR5T342vw425XiAehSwKBWtvPNGIAV+Ostvj1LIMI8lt2RgiUputmgd3D
	 sEwUhobQoKfpukz0lcfYCEE02CW5T/oH9KU+khjxWxlZKx401abpIb0URFIYA2rIqI
	 QG16wJbCqRCtA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1saxDv-0000000CyYw-3ytP;
	Mon, 05 Aug 2024 14:54:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] docs: efi: add CPER functions to driver-api
Date: Mon,  5 Aug 2024 14:53:36 +0200
Message-ID: <64dd3a377c4ebb1b8cfd2b406fe3f1c24cce0e4e.1722861911.git.mchehab+huawei@kernel.org>
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

There are two kernel-doc like descriptions at cper, which is used
by other parts of cper and on ghes driver. They both have kernel-doc
like descriptions.

Change the tags for them to be actual kernel-doc tags and add them
to the driver-api documentaion at the UEFI section.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/driver-api/firmware/efi/index.rst | 11 ++++++++---
 drivers/firmware/efi/cper.c                     |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index 462d739e8dd1..295f6f339575 100644
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
-- 
2.45.2


