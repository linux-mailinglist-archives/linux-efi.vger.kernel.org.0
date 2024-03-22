Return-Path: <linux-efi+bounces-854-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA728870C1
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79FB1F234A9
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B73FE28;
	Fri, 22 Mar 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2AbIvuL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F05787F
	for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124286; cv=none; b=j77eRnZ62s8mJo3cfWcxEtdlrUWaTyy6kgg9K7LcgUhl7zaOz7a6m64hq7DPcnXDYF+x2HIjq/tB0sE8ZP2KAYvD8u/pNENe9DW7nvte78+QWO2vpQSGa2twbSYc6db3JrmoL5K38LeyNOAysMZfjYlWtK0pXNQXsV6b3ex8Kig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124286; c=relaxed/simple;
	bh=P37VHxoA1yRdqPqIjZK2rbPddPpTTk5UbcYc9p20ywQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BmP62LT825Gg7GsiNRi2mGfnaAkWBNdrW39/nFuotPaiEfpLEins/cvzFTqsxQwrEle0YiUJQim1i76vte0O1QfaDZjZh4ZnzSLfRDrWFnek31C9mdswqm8+7Xd4zNk0YMlKZ9QsQMEYk8Cs1f0hbqGMAdjCpT7HkaGiVSBhFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2AbIvuL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41401f598cfso11237215e9.2
        for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711124283; x=1711729083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFk61FRARL/qHgAV+6TkE4xiuOcMJSxzm8BOAGYKOug=;
        b=q2AbIvuLFrOYBjzoPslvdjNwwNEHqGjSq33p+Fvo2xMamigChiyymQza+hVzjvJaPf
         PZHVOGOVXMZ9P+9wGZbBDsdoseWQjdPMgOEvmYyGHWjKWcT6LTs+ntpLIYjDrXs/lZzZ
         n9/drbfLe2EM13bJZQZHoWAmOAOBBkM2dZPmdCnaNGzOhkgplnU8/bmyvpqV5ZJEEh2+
         eeveuVprj5TmYgp4WDw3Tv3/fo+W6GCfAe2T4xK3oWc/28gxSpWZCMfs6bviP7ZR8kTS
         fS3BSkoCgJ+uUGA6un49/AiP0hmQRKCOXY610jihjT7N4Zkm+UsSR985U59tu3fU0qZQ
         L60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711124283; x=1711729083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFk61FRARL/qHgAV+6TkE4xiuOcMJSxzm8BOAGYKOug=;
        b=d9uA6+TheTjctQfAM7JzG5OFj3sOP/FN17Ux4Qz0qPnwSnX+OzB5Wq/pxEWMDl6b0d
         rwC+OYqxReV3UemJM0EWHtqi82bbHm4KU9csI8qbFpD5p5yVKc0OfzVXYFiKBWaJQAjV
         506CFD2BnM1yvnPfRiPloiSkWz/u5VWPXF9eGWMsTeSFo9cHqGp5ziUs9LHH8eQ7a3Na
         pbQsx2Otw7eZhmKgnpTwwGoWyty4qApYlNzo72weY8mGnzplsxeyb6YQj5WRo2lFQC6l
         3VsuFUjK2/uqHSMXNpXEUWH/qpIqV55Q/p/bsSpmKrNa07fnC2qfBA/797CRooBBEDRS
         xajA==
X-Gm-Message-State: AOJu0Yxvsem027JSNCQbou0R14BC1ofOONITlKZ3MLS0eAUa/Hn5okxm
	ns75CSjNs5xceLSy0GV7QW+mFjtF9nbiCpnoTF3FDQ1KkeUjX8+7yjvuvosi84oLzzrgyXen5zH
	Eiw54tJ5Lw+1kYACA1QOMiCOcSjfPfsi4Gvp0BiWCIDUhnNDn1QPR45Sxe5I34GlXmk9cspqJiY
	GGbJZCwMzJ1yvHMjl//Dd/rUw64A==
X-Google-Smtp-Source: AGHT+IGOxHy7Qz1E7ersGRQMRa81Z/TZ9rA4H2l2f/Qosd6+eDedqvvZizkZhM+YpJVn8/z5DyvuHv4J
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:358d:b0:414:a17:b5f7 with SMTP id
 p13-20020a05600c358d00b004140a17b5f7mr24455wmq.4.1711124283213; Fri, 22 Mar
 2024 09:18:03 -0700 (PDT)
Date: Fri, 22 Mar 2024 17:17:54 +0100
In-Reply-To: <20240322161751.3046943-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322161751.3046943-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=ardb@kernel.org;
 h=from:subject; bh=Y/uw19SLcCmt02yuzGlDeusQ0hoDO04Fu5E3EhaYWMU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXveuMdipOv3ftp9JT9w9X+1b0rWaZdkeqZa7L9dspfl
 SYOw/rZHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi7hKMDJMmJhQY5q2pOrtK
 daO1rHLRhSkH/Nn/Xmr/9FfixLZQn3UMf4XmeTYemF00RdLh+habq1mdAqX32sXzpSfE1nV5B+x 34AEA
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322161751.3046943-6-ardb+git@google.com>
Subject: [PATCH 2/2] x86/efistub: Don't clear BSS twice in mixed mode
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Clayton Craft <clayton@craftyguy.net>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Clearing BSS should only be done once, at the very beginning.
efi_pe_entry() is the entrypoint from the firmware, which may not clear
BSS and so it is done explicitly. However, efi_pe_entry() is also used
as an entrypoint by the mixed mode startup code, in which case BSS will
already have been cleared, and doing it again at this point will corrupt
global variables holding the firmware's GDT/IDT and segment selectors.

So make the memset() conditional on whether the EFI stub is running in
native mode.

Fixes: b3810c5a2cc4a666 ("x86/efistub: Clear decompressor BSS in native EFI entrypoint")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2096ae09438e..1edf93e63897 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -476,7 +476,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
-	memset(_bss, 0, _ebss - _bss);
+	if (efi_is_native())
+		memset(_bss, 0, _ebss - _bss);
 
 	efi_system_table = sys_table_arg;
 
-- 
2.44.0.396.g6e790dbe36-goog


