Return-Path: <linux-efi+bounces-4564-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E55B286B7
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A425E5FAD
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4E275105;
	Fri, 15 Aug 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Xq1eH0Ft"
X-Original-To: linux-efi@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B013FEE
	for <linux-efi@vger.kernel.org>; Fri, 15 Aug 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287585; cv=none; b=eCpNC1AxtyCuTh52geP+5WtlbBpDv1OciTrDe0030nRFBDVcFm5PDHe7zxdRDb9RFv5IN+PPJdrZL+tOWRg3aTBviYyeTREO7rqwJYKnBvZGD6LmnwDYwbvF9GkMXNC997gjAPQjG1uyUIXAhTl+r1MzFImWGX6n9HWWGz9DnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287585; c=relaxed/simple;
	bh=SUHzG+YVz6tmPkt8PbQimgyYEQxXh/By0+v+cVDhWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erOCnr6+zqTBT37oMT7hMpHvymfrcCRyGM+J8V7CSzoGaG2L4FEh9vqZCllZCmPgyDDrDtMQoSnTqbFMPaRegEtca5/S9r7kyF7kP1Xd+uBkrtamWZGNn6fdODOHQw842tg3z7gTveDvljYY0wtwgm37UXpOYIlGBZojFh2T+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Xq1eH0Ft; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250815191243091e4108e816b46a57
        for <linux-efi@vger.kernel.org>;
        Fri, 15 Aug 2025 21:12:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xXGWVd566Z2K+snOqQZoB1IZL8d8mK8yVfnQMaQkZF4=;
 b=Xq1eH0FtgCVlzwt28fyg9CI33tndT8+pLzS2oFUBQTH5sHmaSpMc/Vgya+ojW93JrDNQ5s
 I9rVgEnn/nTSJYuoTnA8ZcJFgV+VYFZzYViF2jCCgcVTtx0NwzbJdpJo8/835XUbln6UUtNw
 yH5fNy5GcPRd7+WeFfaL0T0QjhaZwFoLrlXj2d71ilFatdfRJWrR0rlYOLWFWQk/Sj236tJq
 SXnfPqF2QideN8H+K+6tXbiT43dbWoR9YBWGDYjlTelApc1Ro16iggJgGBWDfKvM/wFECB3t
 C3zAXwQe9WA8hbQy5IeBJW55KnpjS0kH5w5vfGzQlTLiKngz5kJ0xEDg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 3/3] efi: stmm: Drop unneeded null pointer check
Date: Fri, 15 Aug 2025 21:12:41 +0200
Message-ID: <8b4aeccbc005087ead1c261745877ccdb7dbb9d5.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1755285161.git.jan.kiszka@siemens.com>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The API documenation of setup_mm_hdr does not mention that dptr can be
NULL, this is a local function, and no caller passes NULL. So drop the
unneeded check.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index bf992b42be70..ff41667b1005 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -191,8 +191,7 @@ static void *setup_mm_hdr(u8 **dptr, size_t *nr_pages, size_t payload_size,
 
 	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
 	var_hdr->function = func;
-	if (dptr)
-		*dptr = comm_buf;
+	*dptr = comm_buf;
 	*ret = EFI_SUCCESS;
 
 	return var_hdr->data;
-- 
2.43.0


