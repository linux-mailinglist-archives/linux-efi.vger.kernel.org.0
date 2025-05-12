Return-Path: <linux-efi+bounces-3657-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338D6AB4488
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FC01888B77
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7FC298C11;
	Mon, 12 May 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="24NcXgf2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D92989B8
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077099; cv=none; b=eeNwqjR8v7Um0t7W2F3tz7+KElMTX8z1GdxGHi/thSMdfiPdwQ4BsRP16Mi94pYHDw3Az63heStc9RdQIGasYZaym41e1C3MG68H24PPX24REzw5uxZtFD/b4HQO1Hl5mxFyY/9O5VUAdJUkQ+abbvScRGgYHHoVhJmmb4MKfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077099; c=relaxed/simple;
	bh=k2nJHzJI79JTiEUmZ2Lm7CSeKjm3kcKUtV1vGbAlOxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mi2mkBteT0SqGTvCciNrsLnr2tFnpFijVxyufv4/xAL+/GJYMQV660FYlh1vR7/Sn9l4w3ewKGBmITmggmQeO/mwjxv+pCwoGNl+buoF0FveFHniumqXvLPV9No8L4Tm/UiClZeVZ6kPpznJNA13p6g4i1LK8FU98G/a69dH58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=24NcXgf2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a0bcaf5f45so1413345f8f.1
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077096; x=1747681896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2A4QOYtd+e+YapxsnA4mVLLZLavidWLily5bwA/VPvU=;
        b=24NcXgf2Yhi02ZD9tByE5DmymhLuZgiGgs6sMg0cwnyhfeYi5+eFnMunDr18BOYP8x
         65vohHfD2HiAiqbTcEPVb0AaI2YolCUHuEr7s0p3u2WWzXvC0zFk6kC8OGx7F8l7hnZO
         IEroOEkQ+03tW+7iUXE+c6xo08odB5gCk+jE4MPHrPjFEtfIjDqOa+85eKdCrh3DUcZa
         I/iEP7qDVNmYGsUSPuq1ry1U1WG23Su+PypvzV0xJze8pjWm4N0I7vwTQHEp+Z0w9d0X
         H7HI3Zt84UKXtAY2akYr9xOFnQy1TTXRl+S4+NzlrsDMG432Da6+dC64Nctvwgk2t1bF
         lOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077096; x=1747681896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A4QOYtd+e+YapxsnA4mVLLZLavidWLily5bwA/VPvU=;
        b=uLxHEaFY1cYeOOdX49Snrjk76E1XFDsdKiMBiUuDjWvp3kqdkI4eHQS3rdW082B62X
         K1s+KKhLw+H6e+1VLvfnZ3/aKA7eehyGMFyomnh0+7OouMLqmqktw3ztz5mVmzW2vwpa
         ng2UftS5+/lxRSHxXiwe2Erf+UMw7iZs+GbEwdoc0DfdxR3wpP3YfkRwFwDcLXtqqMgP
         /OscnIsWq0GzB+Q36j9Mkb68YRE4L3p4V7L/S/FTezgAT/zxWijSvZ3dzuOxtVFXfLEO
         qNn5iA40b5NdljIOmOPzqXbv/oC+DttW7B5zqTdOfjrcYZe3+WIUGNsNj0hdSgwQ952b
         MKEQ==
X-Gm-Message-State: AOJu0YwOhdEeZMMrXE6krnnYHUISVdtn7ZRWDFc+l4NCWmU7RpUZOx6J
	8vjrDHSASJ+xr3FTBiQAXPyLsZFHOXAe7cH7pPiM0AMnmGQJB8NxzJK3UBaMKnJ672TaSg==
X-Google-Smtp-Source: AGHT+IErwosD9vJ9JrYgrLx7V9RG6j5DmK6Fk3l/BmDVN9yfDorOHyQFkGdzbGclKBnt8rsqb/4LW6To
X-Received: from wmbhh12.prod.google.com ([2002:a05:600c:530c:b0:440:626b:cdc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:240d:b0:3a2:3b9:5c97
 with SMTP id ffacd0b85a97d-3a203b95dfcmr5365332f8f.10.1747077096579; Mon, 12
 May 2025 12:11:36 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:37 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=ardb@kernel.org;
 h=from:subject; bh=etgeXANbrFUuOBqj8tjP9eeHGfbZA0Naim5ziEeTbkU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3WL9V9YldTk75PhN3ZKf2BtO3vD1eEvn01X7nk5SU
 d4e6Xamo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzENIyRYbUlq+7P21pvJ/Bq
 MUd7Hvd7Od/uZ/+5tak7UtzPTNKtB6po5okQ/rjIvX/T6rpmpnu/maomGwYkzvk80/3c95Xc240 ZAA==
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-25-ardb+git@google.com>
Subject: [RFT PATCH v3 02/21] x86/sev: Use MSR protocol for remapping SVSM
 calling area
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

As the preceding code comment already indicates, remapping the SVSM
calling area occurs long before the GHCB page is configured, and so
calling svsm_perform_call_protocol() is guaranteed to result in a call
to svsm_perform_msr_protocol().

So just call the latter directly. This allows most of the GHCB based API
infrastructure to be moved out of the startup code in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sev-startup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 435853a55768..a1d5a5632d58 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -325,7 +325,9 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.caa = svsm_get_caa();
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
-	ret = svsm_perform_call_protocol(&call);
+	do {
+		ret = svsm_perform_msr_protocol(&call);
+	} while (ret == -EAGAIN);
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
-- 
2.49.0.1045.g170613ef41-goog


