Return-Path: <linux-efi+bounces-6257-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PMyFrn5qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6257-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:58:49 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA75224684
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CCB430804E2
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570483ED126;
	Fri,  6 Mar 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abpJgkS2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB33ECBF8
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812645; cv=none; b=Nga49kd3IYYBR8W4aOoxvcGH42O/gEq5xIQHowKL3egCyXo5bIRD5Fl7TKVSmb9MZTJ9vX+RF5VlL4gUEM/KRVtfnD6AhUk+tbhxU/eZViDNf5XaPb7L2N+tGu4523MquoyNtwZ+/SyTxLR5Kbb95gBZcZ9jX4+BZF5UYrIZ5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812645; c=relaxed/simple;
	bh=ZTnS4RveV5BcCOB3XTR/KA1YUAH3LEITzjMxI69JZuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VIFAAJqFiGwZUYFPHUXP2WlNhl7qUUzPPH1krvo/nGjHchMg/iM9W8UT8nUzuZ7Eke41iM5bPxg27tLeJ0/h/4C0ZaGZSRyPY/KPUtcUY0zjX+ai2Ym14Em9A/4qt9BkNcMEH+LULDtj+QVjD6aRLMpnbwlAhWKB2e/PQHnjaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abpJgkS2; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-660ae93b90dso3736818a12.2
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812642; x=1773417442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pemDVNzQpQnPK8E+QcSXNZ28feWHqXpZeP4jd6MxjXo=;
        b=abpJgkS2I83f6noK0Kkn6TYYYZojjrnXymvZ4g0qS2uqK7wuEWI/jJXDZ2OvKtq35B
         jJujoR3UgsPiaAigf8QoFarbg2t5GDmxMBkmHD5zmZDTg/3CYDXvLFQv8Jdg4GS5OMti
         2qgP5LaO3HEjQALIgYyAy8vBZcdzAV4+KDA2pgIa29mq7JtWRIsw+aGovRq5fvTT75SZ
         tOuZXFJdUKHayd78uGHlz/P2fdRNjCfLH40UkZxjoQGGYT/gTTzgM9yLpiTjyOnjY9VS
         6KJ0IGQTcqjO0fa+qJsc5VRWOTKYwm+R5/oSNxAv9A8MgZ8QxR012ty7PuW8tTgFVCnZ
         NL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812642; x=1773417442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pemDVNzQpQnPK8E+QcSXNZ28feWHqXpZeP4jd6MxjXo=;
        b=UOt+lcuu8mZcIJdem3YwdTDlvxDjK1RuwWIDgRTiUkgJYk99OioofS9PANGmOPp1pz
         m7Ziee8A3gjDP8MG0ESsFyOZBu5+BaMbJvZAhwfLa11Lo/z/lsJhFiRGOMtnPJTZYkEl
         41gLvF0X2xW5wK3Ib3HxAJk21QNiUZbZSqhvE5AgtWul1hKaFf05rxHAD61Z8SzvwW0D
         z/viff1n/QSgz3bOoKx3fZbt8PYGqR7MG4VqnB6zk6BfX6QGNjnEmqm8ezcFke8CEHzr
         R4xI46ZgFfTEw/Yno+K+kYK+bH18KYooxxauRBt1m+tSxbi3X5KHpMEVTKgg288ch7Cx
         6Q/w==
X-Gm-Message-State: AOJu0YztND7oGuFYdoIU8OXuOdkz7L91YsmBv7b767DqRuQJDZlV32iO
	mifIIEb5EaL5YqZPOuZCg/u12/e+A5g0PQw641vcqFiABDmiXI05NlZEYBmIxwezC/+OQ08m0g=
	=
X-Received: from edcy15.prod.google.com ([2002:a05:6402:358f:b0:658:115a:7265])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:520b:b0:65f:aecc:4f0e
 with SMTP id 4fb4d7f45d1cf-6619d5274c9mr1386700a12.19.1772812641980; Fri, 06
 Mar 2026 07:57:21 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:08 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=ardb@kernel.org;
 h=from:subject; bh=EeSnSz6nXHhpEi61P5BRppL/JAG5B1Jjj0fvpIrf2nk=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGmq+VKjBinn9SsHx0HzQYNL4p/cP/eaDyxrHBrlmpnpshxTM
 Ih1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmmq+VIACgkQMG4JVi59LVw8kAD/Q3j+
 rAfLCupT/TsV8nAZg4bilFrBYtQPH2fEwGiACM4A/1r6ZLGhfH7UgYqkLjkVkRpq10pUntP74mz TKx7qHWAK
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-16-ardb+git@google.com>
Subject: [RFC PATCH 4/9] x86/efi: Defer sub-1M check from unmap to free stage
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0FA75224684
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
	TAGGED_FROM(0.00)[bounces-6257-lists,linux-efi=lfdr.de,git];
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
	NEURAL_HAM(-0.00)[-0.934];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

As a first step towards moving the free logic to a later stage
altogether, and only keeping the unmap and the realmode trampoline hack
during the early stage of freeing the boot service code and data
regions, move the logic that avoids freeing memory below 1M to the later
stage.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 21 ++++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f896930cecda..58d00ffb1d59 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -475,18 +475,6 @@ void __init efi_unmap_boot_services(void)
 			size -= rm_size;
 		}
 
-		/*
-		 * Don't free memory under 1M for two reasons:
-		 * - BIOS might clobber it
-		 * - Crash kernel needs it to be reserved
-		 */
-		if (start + size < SZ_1M)
-			continue;
-		if (start < SZ_1M) {
-			size -= (SZ_1M - start);
-			start = SZ_1M;
-		}
-
 		/*
 		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT parts of the memory
 		 * map are still not initialized and we can't reliably free
@@ -579,7 +567,14 @@ static int __init efi_free_boot_services(void)
 		return 0;
 
 	while (range->start) {
-		freed += efi_free_unreserved_subregions(range->start, range->end);
+		/*
+		 * Don't free memory under 1M for two reasons:
+		 * - BIOS might clobber it
+		 * - Crash kernel needs it to be reserved
+		 */
+		u64 start = max(range->start, SZ_1M);
+
+		freed += efi_free_unreserved_subregions(start, range->end);
 		range++;
 	}
 	kfree(ranges_to_free);
-- 
2.53.0.473.g4a7958ca14-goog


