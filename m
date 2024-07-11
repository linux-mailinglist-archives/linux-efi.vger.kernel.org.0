Return-Path: <linux-efi+bounces-1418-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C54392E027
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1D11C2133A
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 06:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9ED12DDAF;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL4focKa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAF1C68E;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679469; cv=none; b=ud3dJt0Qh5mGnPQd4o0HWmELgfsf73FwrmmRUBd9uDI6YrNE39YG6EdH1zUSxe+C9IBKmF0S1wKEMcLO5EIdvahEv3cCrmc6uOfutHUhHgARfpufgyp9AAkEIHnrtzrrmXRvb7H4l2wVsyaz+T7VX0PW+PIwjj9zgvnKzKaYrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679469; c=relaxed/simple;
	bh=BUannu00JepoL1Z7Ukw4YDCb+t7wSdorptXpbpSwoW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNoEfhSNVPuN2sE54b4swvDQUbw6H2S5za6TniBHjCbWYibZ3QGMH4pFWxk6aX2lHUpHwyfjGrHYlDih9A13sOrOZPQp/sCOsnHp0iUNA78yINTF9xLOrPiZM6V4HgHdh9/ilb5O3PLRZ4DFmji4CAGGAnxq0P8L+fkYlSQc4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL4focKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC41C4AF0A;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720679469;
	bh=BUannu00JepoL1Z7Ukw4YDCb+t7wSdorptXpbpSwoW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TL4focKaTYEsMI+Z06IxZbgs8CcmQvCzawXZvTI/fxggw/kyAh7jz//5YdEPHA/xQ
	 hxHdpjRR7+asmmp5SqLsgdOZbc9tPxarfD3HqlUUvfQbtetFgWe3VZtky4h00nzQmF
	 q+eDwKIo0NLVUxxexGo4hwza9oXvoufsm8tcGjHPXqOLx/26ymB8hL/+8I9h1yIafQ
	 xBzpkUv9cDAefB58AcuvCi7jwYew29Cun7EXBY6hsgZSSsxzral7P4bq8l0LQCyFb3
	 tcZwNPUPlGmV84s7Q1iokih1B94N51bUWtF9Eh8bbe/3RU8/qtx9s1Ss3U6jhecNVc
	 B8ip+bzg1ziZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sRnKc-00000002b5h-1ajO;
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
	Jonathan Corbet <corbet@lwn.net>,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] docs: efi: add CPER functions to driver-api
Date: Thu, 11 Jul 2024 08:28:56 +0200
Message-ID: <c6b1b295960779c25f235ac76263c5333f0b5888.1720679234.git.mchehab+huawei@kernel.org>
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


