Return-Path: <linux-efi+bounces-4183-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B1AFC40F
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 09:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E47A7A4C10
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C828221283;
	Tue,  8 Jul 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOWlbxv3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB3220F38;
	Tue,  8 Jul 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959847; cv=none; b=MJ8sK7+biqCKOvUCftIlpDYpsmAJamyWyoVwUx+xoO+rDm13INyWaLJ3z/TPsXncX6njeal9TelZhRy8WgjOvR8fQg66kuwNF5lrSY0j6PJzoK8isjUm4H701GCeUBkGvkchAStPC+uywg+I8LN6Wmo10E8/jDW5b35SuS++I4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959847; c=relaxed/simple;
	bh=xduxuR57W9POcc4TD/pZdEFQG4piTLlgO6F7+iSjm3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HeGtW+pzD7QbfYTUx3vtdxBFnKMOcqae1gi0X/u3a+EqPH/X69XY5G4c0AcLGKhHE+3rNWkB9MwUVhO99uPLCwhckv7pTUoZA7+7CRpY61Beb11Wqa+gtUiTjAPJB/9HuMv4Pgfn1PNlcaQFZsKBE698ZDFnsNUp3F8b9602xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOWlbxv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DA1EC4CEED;
	Tue,  8 Jul 2025 07:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751959845;
	bh=xduxuR57W9POcc4TD/pZdEFQG4piTLlgO6F7+iSjm3k=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jOWlbxv3RF28r0v5KKX20F5lp3tuWnEg7aIjFln8YS/Wl0L5CY9UuHaSQ1880PAoH
	 joxbleQrbBkWkqhoUi0nEl1Yhc8ZkOXMCbJMqPwEk/B1fiQLaufrQ5AL62TTZSKVbL
	 hRIx4lpEhhJOyzYoihQ1SD8pPTQ6Ft/P6FEnCYdOcK2+4WVaMMvi2fl3I00DQF+T44
	 tg7qst5qiB72o/lD7XS6pWpQWjxNJ6YZs4cM7FElnxIpBNZjQCK4bmqcdJOYwma9DA
	 nRESj0Fqyt3/h3DmMm/7+82OxZL8LmewRU6mh+3VHAFM7n8PJEKAshHSKNPFvey3bq
	 u4IiFkbdUtjRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832BBC83F0F;
	Tue,  8 Jul 2025 07:30:45 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 08 Jul 2025 02:30:42 -0500
Subject: [PATCH] efistub: Lower default log level
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
X-B4-Tracking: v=1; b=H4sIACHJbGgC/x2MWwqAIBAArxL73YI9rOgq0ceiay1IhZYE0d2TP
 gdm5oHIQTjCWDwQOEmUfctQlQWYlbaFUWxmqFWtVa8GZCdo2dHlT/T74jmxx9aSpqYzZIYecnq
 ErN3/dprf9wNJVExsZgAAAA==
X-Change-ID: 20250708-efi-default-loglevel-4da5a36cac87
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751959845; l=1284;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ChssDVXeeXa5KArbpSvIR/bGgEJum64xNRRJ9Dgia9U=;
 b=RtJOCFiU2aGfuqIawoZEJwZPTcljVs3ePx4Yx4kiqwjhMcNJ6DuCDFo0/JJg77PCkYtTCs7yx
 OHKIz0/ER86BiJcmOgWrfqwM6nizx1zDBYZK6Oz+m9eZIlPn/1meBh9
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Some uefi implementations will write the efistub logs to the display
over a splash image. This is not desirable for debug and info logs, so
lower the default efi log level to exclude them.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/firmware/efi/libstub/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c54abbbe61a4bf70f1a8c4 100644
--- a/drivers/firmware/efi/libstub/printk.c
+++ b/drivers/firmware/efi/libstub/printk.c
@@ -5,13 +5,13 @@
 #include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
-#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
+#include <linux/kern_levels.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
 #include "efistub.h"
 
-int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+int efi_loglevel = LOGLEVEL_NOTICE;
 
 /**
  * efi_char16_puts() - Write a UCS-2 encoded string to the console

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250708-efi-default-loglevel-4da5a36cac87

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



