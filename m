Return-Path: <linux-efi+bounces-6259-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMstN+z5qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6259-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:59:40 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A07802246C1
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CA42305F4BC
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C243ECBE3;
	Fri,  6 Mar 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0VvonVh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3E3ECBDF
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812647; cv=none; b=etg0UL9FJQLn1MlbkjpVjiY9sFlIXrhIyFMaZJUJ9nuFKPk/XClNd0JfxUgkNWlxboBNZVTQ6nlnHy7zCgNIS0bRQRWx9/HL8DOozcmSrq2Qi8HdD0ZQ5VSD/AxuCbp0ZONZqrZrcmZBhyHEZe0K6wbJF/zii8V2QZuBTY9wlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812647; c=relaxed/simple;
	bh=1307fs8XamZL7Wt4P7DAyoEiTy4wLKbb450ovEmio6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JWs+ZyA5BWQ9FM6MgjyhR3Mr2kg6GUj60ktAg4gDpLPtcQXmxQyHYb5T9WV/OuAnD/vlxV63JvDAtT+KAEn3LeUcPhxhjLTVWLq6qjNGQeyU37OLX3APKlkD//FMUbesqsu9o4nA5rXRBdgNBkQTohvgNArdrsIV4v+GCZ31UYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0VvonVh; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66184f62c28so2017840a12.2
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812644; x=1773417444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITFaBcrhAJjnw7yibj9RtbA12e7zZ2KLF2hSYHPAq2I=;
        b=g0VvonVhgw+40TZ3YvWWaQZbw+Eglk4bMiwcDgJc3vnB856sWGIxu5twvITR4ck+Vo
         1ITrty8KvFfguzniGUz+tteL2e+/q3gdJcybOBkG/f6pjDYVurcOIcAw2QWbMaww9vuM
         hEMJvctAuqKcWMjcKU9vhj1HHZ4Sa7mnN/262TRAD9AErzlI4zjOgFZBrTCIcEJ3WLzB
         TgFgGak51hwZZNbYIuwQ4cbaYlDou97LeUay2KKQuJpNX6pUQW25nYvoPgnH4jJmU+MU
         OP8eMsMjIf1g1mn+ZjdQHELj0miR+1mT2v1uHLUbcnXAZnV3wZHoeRVQw7APUcEBbp1t
         H4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812644; x=1773417444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITFaBcrhAJjnw7yibj9RtbA12e7zZ2KLF2hSYHPAq2I=;
        b=v/HSC8XyEjRePZLkjymWdNw3m3dmEomuIDst2QBa12lwzswLWKqUErdDY6ex3Y1Uyc
         +9rTOQ0xI2aUBMzQ5us9Dg2Rwct55g5fLeo9Ft4AttDdHFI5edsuJA9Sq0cRKH2MOpOd
         TwGj+B/91laE3JcQk4D6oQhJUTPCPCj0WAX83BTWM7N8t7rQhnnTGrfAZVM+LqDWFP68
         HaBAX9NQlnWkoNzebh9NhrlMtNt9ela2k/hEqG9wGfcSTtdD4KPKugCTa7/TLM9GFE1+
         iSV4AfkJuPQrAXq6CDzU3yXH3+KBMTwc7DkKZFxAXgPLSFAFPZLSFfDTwJwmHTxk6Tvi
         +IPQ==
X-Gm-Message-State: AOJu0YyuGLUCQE4ydJitj9SFyAp8lDn2/wP87M5p9Je679NJViyH3s9I
	M1BpW5Ysog+Fa74G5rSY/EA7D00dumr0qVqtWYITBrr5+HKkuJ1HugdB8+2fTS3BmYKy/vtGwg=
	=
X-Received: from edqi7.prod.google.com ([2002:aa7:c707:0:b0:660:a86d:ee96])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1d48:b0:65f:9c21:e68e
 with SMTP id 4fb4d7f45d1cf-6619d45a9f3mr1570773a12.5.1772812644211; Fri, 06
 Mar 2026 07:57:24 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:10 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=ardb@kernel.org;
 h=from:subject; bh=St8MkQamdXukXyHB8ojHbIf0pOg2QO7eOCnOt3Cl8f4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVz+CVD+fP4+i6r3Wi7v251sMnTjQ8KnHqamUQ8N79e
 P7/xhV+HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiEz4wMqwUZH/2NTM5e0PP
 r/ouez3NlUsSd3RdTNy85FtVg3hn+F2Gf/o9l6dODjv/VvipXfPWxfEW+gz/RNc9ZDTJlt/U9/u OJS8A
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-18-ardb+git@google.com>
Subject: [RFC PATCH 5/9] x86/efi: Unmap kernel-reserved boot regions from EFI
 page tables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A07802246C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6259-lists,linux-efi=lfdr.de,git];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.933];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Currently, the logic that unmaps boot services code and data regions
that were mapped temporarily to work around firmware bugs disregards
regions that have been marked as EFI_MEMORY_RUNTIME. However, such
regions only have significance to the OS, and there is no reason the
retain the mapping in the EFI page tables, given that the runtime
firmware must never touch those regions.

So pull the unmap forward.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 58d00ffb1d59..e72e8b23598e 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -442,12 +442,6 @@ void __init efi_unmap_boot_services(void)
 			continue;
 		}
 
-		/* Do not free, someone else owns it: */
-		if (md->attribute & EFI_MEMORY_RUNTIME) {
-			num_entries++;
-			continue;
-		}
-
 		/*
 		 * Before calling set_virtual_address_map(), EFI boot services
 		 * code/data regions were mapped as a quirk for buggy firmware.
@@ -455,6 +449,12 @@ void __init efi_unmap_boot_services(void)
 		 */
 		efi_unmap_pages(md);
 
+		/* Do not free, someone else owns it: */
+		if (md->attribute & EFI_MEMORY_RUNTIME) {
+			num_entries++;
+			continue;
+		}
+
 		/*
 		 * Nasty quirk: if all sub-1MB memory is used for boot
 		 * services, we can get here without having allocated the
-- 
2.53.0.473.g4a7958ca14-goog


