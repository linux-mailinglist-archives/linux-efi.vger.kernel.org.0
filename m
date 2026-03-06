Return-Path: <linux-efi+bounces-6256-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Il7Fun6qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6256-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:03:53 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1800224808
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86CB6318ABFE
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB983ED117;
	Fri,  6 Mar 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4kBmzXh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95873ECBE2
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812644; cv=none; b=CZ+Tsr0GjEuaSDQyRVAKY8W9JZ741HG9bTymqOUmbT4JScux1m3voLXZooTCD7ByYN4VBRbJ1sF1kt46SMK+j1SaWNdTJuKvFM5en+5mV6YCUYugGkIVVl6+PFazS8krtpW1PEEdYUed0+iW1spT34txnLVnYoA2iCUArL4n0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812644; c=relaxed/simple;
	bh=sKSDOBrHSWS+dLKRjI5r9/gcEPNpg/wY0lNM7xnUL/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rSd1OMCVRl3yfk1AFv+ERGjOZqDilVoKAxMvrmErCrQCIagI3GzQs6e0Z2/QC43c73gBKShPdRvLAAGjphYO4vgL/C1PahzhUW5rqOYbmS9qBfvC1VbKHGrl6NxQwVdAIq71z7kYs164Tj0emGLXhAV1/FTk7vMl/FFLrVaLevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4kBmzXh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so100858295e9.3
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812641; x=1773417441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnaHIt/OTaWwpYMzS8k0B7qGsuGw8MKHCh4rNU5dnyA=;
        b=r4kBmzXheYFfouHNRG0qJ2GD5Yxqm+WcvB/5r+bxsduKtf1g41GRKYUgN+clOK16iY
         9NZsqTG+LqVyNFhTQDF+Vc2XNX/GqV2NXulZl5Yruj/5IfHre6/4K5gH8feMorRh8Iv4
         oOyqeCHenqGZj/yxdMDu/Y9ZepTpKYNIPdWocJemtlwPmC1WSonmk5SluyO2BU2lcE8J
         LpGThIGjLZIEacr7sXOXZ370HTD8K78TosHxFvDguziXYbYBo9JIck6dWnhdDmEgUYBT
         9ef6oeq9OGHzT/kvLaAw5IA0Sg3SLLWGxhFgNWYeB/7Dsb0CwjwOVcBChSaxFdqsZ4Im
         3cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812641; x=1773417441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnaHIt/OTaWwpYMzS8k0B7qGsuGw8MKHCh4rNU5dnyA=;
        b=bBZHYw3/EtacdbQRojlIz49cDZmPO/caSyFuMhes36XVYx6rT/guxXg86q4RvFxj/F
         aSp66MhJ5ieRgOCBZ7EDbdECjaB+Y2uOARFaN8XSVJNv9gH1iiWkqCmKBE10/Hn96K0S
         WVxXlK/5opp1kkjYQtfo3znm7PMZ/nOcFkSC2zcQ22M1zaY2H5z4ZPJqfwyxnyvcbmRN
         fHbZ8B64thiVOpO+AVhtm5KiKMPauo3frQq4qvLjAozaQDNxk1sWpbD4jgYl1l2GoEaa
         FmSjoUDXDz7SyVZA6K8sIdU25Q6YUO/O2zvtQK27ZB7shIq+xv8Uhp+F7t0/tAThWfxY
         mMBA==
X-Gm-Message-State: AOJu0YzcExNl/0Vfho0BTmdf8RqNsjjxljMFlnFEfrrCJg/Om6UWsknW
	HOIhLIm0lfEIIbJ98FVgLl/A2Jk2gWOwjgkQU3hYFpoFRCh8Mw2jieCuiDK7V+772/1z9FZBFw=
	=
X-Received: from wmkg17.prod.google.com ([2002:a7b:c4d1:0:b0:483:29ff:3c47])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b8d:b0:47e:e946:3a72
 with SMTP id 5b1f17b1804b1-485269692e2mr45231865e9.27.1772812641095; Fri, 06
 Mar 2026 07:57:21 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:07 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714; i=ardb@kernel.org;
 h=from:subject; bh=nBMjymnVgVsODc2LWGkG56q+yyVl6fsi1H4MendJiyU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVz8ANsvuXZv7tEJZ32G7yUzQq+cbHZ2ua22qjLoboS
 83fWy3XUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbS3sLwP5/7+6Ybq/+/9kiN
 vdfkfVZFRn15/gPexgknLhov8mewLGFk+FYU773fLv+owGtzlvbZh3ZmLi6ormLqlTzOViV8KnA bKwA=
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-15-ardb+git@google.com>
Subject: [RFC PATCH 3/9] x86/efi: Omit RSRV_KERN memblock reservations when
 freeing boot regions
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F1800224808
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6256-lists,linux-efi=lfdr.de,git];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.932];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Instead of freeing all EFI boot services code and data regions that were
preliminarily reserved during early boot to work around buggy firmware,
take care to only free those parts that are not marked as
MEMBLOCK_RSRV_KERN. This marking is used by the generic implementation
of efi_mem_reserve() to mark things like informational tables that are
provided to the OS by the firmware, but where the contents of memory
have no significance to the firmware itself. Such assets are often
passed in a EFI boot service data region, leaving it to the OS to decide
whether it needs to be reserved or not.

This removes the need to mark such regions as EFI_MEMORY_RUNTIME, which
is a hack that results in a lot of complexity in updating and
re-allocating the EFI memory map, which would otherwise not need to be
modified at all. Note that x86 is the only EFI arch that does any of
this, others just treat the EFI memory map as immutable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 40 +++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 35caa5746115..f896930cecda 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -536,6 +536,40 @@ void __init efi_unmap_boot_services(void)
 	}
 }
 
+static unsigned long __init
+efi_free_unreserved_subregions(u64 range_start, u64 range_end)
+{
+	struct memblock_region *region;
+	unsigned long freed = 0;
+
+	for_each_reserved_mem_region(region) {
+		u64 region_end = region->base + region->size;
+		u64 start, end;
+
+		/* memblock tables are sorted so no need to carry on */
+		if (region->base >= range_end)
+			break;
+
+		if (region_end < range_start)
+			continue;
+
+		if (region->flags & MEMBLOCK_RSRV_KERN)
+			continue;
+
+		start = PAGE_ALIGN(max(range_start, region->base));
+		end = PAGE_ALIGN_DOWN(min(range_end, region_end));
+
+		if (start >= end)
+			continue;
+
+		free_reserved_area(phys_to_virt(start),
+				   phys_to_virt(end), -1, NULL);
+		freed += (end - start);
+	}
+
+	return freed;
+}
+
 static int __init efi_free_boot_services(void)
 {
 	struct efi_freeable_range *range = ranges_to_free;
@@ -545,11 +579,7 @@ static int __init efi_free_boot_services(void)
 		return 0;
 
 	while (range->start) {
-		void *start = phys_to_virt(range->start);
-		void *end = phys_to_virt(range->end);
-
-		free_reserved_area(start, end, -1, NULL);
-		freed += (end - start);
+		freed += efi_free_unreserved_subregions(range->start, range->end);
 		range++;
 	}
 	kfree(ranges_to_free);
-- 
2.53.0.473.g4a7958ca14-goog


