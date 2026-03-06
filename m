Return-Path: <linux-efi+bounces-6255-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JY2Aun6qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6255-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:03:53 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57622224800
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368A731883EE
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F403A37AA94;
	Fri,  6 Mar 2026 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zw3toSMA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAD3ECBC6
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812643; cv=none; b=WB/7ZatNBYz7U3y77RuEmiXEba+ZFU8E9xuXhWcmsImHZuR6QhuvUp9AyXCKChE7vaMQbrT+SQgQWzZKb2sJWk8BOy7PmDsOnowCnr/v68Sw9uBuQXj+CsUhfwQyLIqxOSs5XxR4sT9olg+651ixdnJQHHxfLlgxVHBxtD1SQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812643; c=relaxed/simple;
	bh=/MRK+SjiyRNaac8LbSy7nBfgg4IyeWFqijEC2lPSsQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eVC2AlTcgTNco6jrfXYpua0qt/TEuHgZCNfD2aeO9fUVFFKJOs8BAufCdRTBD2DjEXmiP/EvPZi3hW3rlu7Blprx7FN29dXoGy7ncKOqChBF4qLAkOgtRjy/reZUmG4rAubLlC0sBvxZdH2Wjvx4E/4U+orab2QeP6lFNG/98z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zw3toSMA; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8fa51ade75so1049205566b.3
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812640; x=1773417440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCYcLEMt7nWCnDNSdFlgn1zDzWox2lvsThVrYioJNy4=;
        b=Zw3toSMAIEkUnCb153MbvTSnL0AZiNSIXJvYhQyYo07Ep7VoPn0XYvkrYGpxVCmMK5
         yjlTGF5V/cHTZa35lS6mpdZsFz3tKthRNAOMMtbYTgpbEWpWUV3Gw28gnpZcgN1ZedfJ
         JVX8GFfmEEmBRPimDMFWm1vbeqq23nourVkG4w5Oe1uguDK050LrUEBl5vmDa1geUxM+
         oOu7dutZe6wA1j7IoqWuwmoRyfQkKb+MODJGsfGmZhuWGUv4LjlbyiJagsuFJcqTk2OG
         wcEUapun4nJJr3/D59rFpv0d4B61EykWU0JyNgGzgOXdsfO9PniAsN6ofGcwwFvtumJj
         CXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812640; x=1773417440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCYcLEMt7nWCnDNSdFlgn1zDzWox2lvsThVrYioJNy4=;
        b=k6+6/V8zTAWf/XDTfDq5XjNxvnlR+IwebuyWCfDXkhBPxhLkvnTbeREwHIhRbsfaEc
         vw/euYoYrQhCIpyR8xMIuHaiYhWQ8ufq1+cG6lSfhgTLkjYAoIwKgNpeUHJC3eDU5+ix
         b20A82Gvxchu1VcqQqdFjoTwsxAWTUEv2AhE/kgI7wnyLmNtkyoKqO+r1efH1Ko4RRHe
         j0kTDr0CWSm8qCqteIeDLwu2WNk/pEyZXsbVEOIUweVhTr09kRzGkgej5gVxMYRYXWx1
         ufE6XO5BDrOVUKEzA/kaFVvUYmYiN0Fy1mC5fh+fhnl7lscbq59YTuGLj/CNaBy/NRza
         rilw==
X-Gm-Message-State: AOJu0YyE9El2G0fQ5iyCel06eniTD1ADnNm2VIojl1vYmJuB/1GfukXd
	L6O8NRvhoIA4UwE0rN7ylrsbd7jXbIee7r6l1S8pYI631VU3ZNLmfE3ZULBldSLxsumeCdUPSw=
	=
X-Received: from edgi13-n2.prod.google.com ([2002:a05:6402:a58d:20b0:660:d4bb:7c68])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:f588:b0:b8e:d13f:e20f
 with SMTP id a640c23a62f3a-b942dfc6843mr136487766b.55.1772812640286; Fri, 06
 Mar 2026 07:57:20 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:06 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=ardb@kernel.org;
 h=from:subject; bh=ygaQ7rljKsyjeL4u3D3xh0peTcsV1i7sL8/+ssx1FjY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVz8CTYQtSWqY7zXJmUC02em513CfHL/DBjbirJt9a3
 uZq707pKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNh+crwvzTrm+RCvpnijLv5
 Fp4vltbe0nEp1cJUObTrn2ScXVyUL8M/ExGxxLgZoUc3nj+3/ysHi8+vuZm/5lg0Vd/9lKJ3Qjq DGwA=
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-14-ardb+git@google.com>
Subject: [RFC PATCH 2/9] efi: Tag memblock reservations of boot services
 regions as RSRV_KERN
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 57622224800
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
	TAGGED_FROM(0.00)[bounces-6255-lists,linux-efi=lfdr.de,git];
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
	NEURAL_HAM(-0.00)[-0.933];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

By definition, EFI memory regions of type boot services code or data
have no special significance to the firmware at runtime, only to the OS.
In some cases, the firmware will allocate tables and other assets that
are passed in memory in regions of this type, and leave it up to the OS
to decide whether or not to treat the allocation as special, or simply
consume the contents at boot and recycle the RAM for ordinary use. The
reason for this approach is that it avoids needless memory reservations
for assets that the OS knows nothing about, and therefore doesn't know
how to free either.

This means that any memblock reservations covering such regions can be
marked as MEMBLOCK_RSRV_KERN - this is a better match semantically, and
is useful on x86 to distinguish true reservations from temporary
reservations that are only needed to work around firmware bugs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index b2fb92a4bbd1..e4ab7481bbf6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -600,7 +600,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
 		return;
 
 	if (!memblock_is_region_reserved(addr, size))
-		memblock_reserve(addr, size);
+		memblock_reserve_kern(addr, size);
+	else
+		memblock_reserved_mark_kern(addr, size);
 
 	/*
 	 * Some architectures (x86) reserve all boot services ranges
-- 
2.53.0.473.g4a7958ca14-goog


