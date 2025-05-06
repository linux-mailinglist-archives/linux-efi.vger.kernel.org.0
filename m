Return-Path: <linux-efi+bounces-3618-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A8AACB07
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 18:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DFC980DB2
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF926FA5F;
	Tue,  6 May 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o4H/tiub"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C552472AE;
	Tue,  6 May 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549107; cv=none; b=qsn2mK0Yrer1bw2JJKboHX9XRNavuYLYgC+c29fnjrxFXX0dk6iW4Dts5moBbq2Qo9PMNCnkwdZHl0MobtUuYfwrt0RGyasqW1wzBb/jSFoOt3Q0KbFaPdLUf8sHyQ6qETAo1kraHjl6DFLx3KnL6uIBYyi2VwPayZLTdY1cxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549107; c=relaxed/simple;
	bh=UYD3grwpS5uPohpdxt9dxakZq+YTUq9nRPZydmvnE44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nRi7vqhzwy2u3UVQ3+s8g4KKOUeAIXWjqCXmEaEw6z8EcPxx84wxDxS4nXWdXWt9u0EgSopgQCOpSeP71pb4//p66ZLvFj9DvMGZ3j83phJmVulTlx92Jj2ryQnTu0AoFo4qh9vwy6BAQrreinYZYH7DcxAXH/rKgf/K9Tt24jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o4H/tiub; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IJPjh
	/OuwLg/GQ59dE8XcmVS3DsJx6kJihk2+0gyrTA=; b=o4H/tiubGtsRPJnTdtLH3
	YeujoUTTzCFmCdzJfzTG4dJEW++Gsz86pFsO1BTVX6YQZo65C3bhQ7YKCA9YEO5o
	wLZHTc69125d+e6BJYN1HRUMrLkfGeM8fS0G8CMN6QlOYGVU6itW/I1wrJg9aICv
	3dJFzk44SYvgA4VOaesmEg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDn94JdORpomSVsEw--.1255S2;
	Wed, 07 May 2025 00:31:26 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hans.zhang@cixtech.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] efi/libstub: Describe missing 'out' parameter in efi_load_initrd
Date: Wed,  7 May 2025 00:31:11 +0800
Message-Id: <20250506163111.272149-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn94JdORpomSVsEw--.1255S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWUuFykXFyUWF4xtw48Xrb_yoW8Gry5pa
	9FgrW3CFnrJa1rAa18Ja1S93W3JasxG3yjgas7JF1Fy3Wjya4v9rWagF1UuFs7Cr1Ut3WS
	qF15tr17Wa48Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRwNV-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgtFo2gaMTHk5wAAsm

The function efi_load_initrd() had a documentation warning due to
the missing description for the 'out' parameter. Add the parameter
description to the kernel-doc comment to resolve the warning and
improve API documentation.

Fixes the following compiler warning:
drivers/firmware/efi/libstub/efi-stub-helper.c:611: warning: Function parameter or struct member 'out' not described in 'efi_load_initrd'

Fixes: f4dc7fffa987 ("efi: libstub: unify initrd loading between architectures")
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index fd6dc790c5a8..7aa2f9ad2935 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -601,6 +601,7 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
  * @image:	EFI loaded image protocol
  * @soft_limit:	preferred address for loading the initrd
  * @hard_limit:	upper limit address for loading the initrd
+ * @out:	pointer to store the address of the initrd table
  *
  * Return:	status code
  */

base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
-- 
2.25.1


