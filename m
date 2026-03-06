Return-Path: <linux-efi+bounces-6253-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNqFG2v5qmmqZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6253-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:57:31 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3AA22461D
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3541E302D9D2
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7883E9F9B;
	Fri,  6 Mar 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltlkI1Nj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52B3ECBF8
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812641; cv=none; b=SrzsYATicFJEpVyMX2IOnu4MLyUgA4aeDkp9wTK0SolSzVzs9+5inBCj9lR+FU07L95bcPwa5TNtJLiAASuG/Tw7YHwQWjQPdinsj2vV49aqsN9ipLMK8kOxWvUBZ/a/mbvU5RmL3oh3/EgILACHuJgkjdt+c1Vht3zYjjTp+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812641; c=relaxed/simple;
	bh=BOSjQSWNuMMq3dHmhqGAUuwvpo+SF9nDvASL8voRE1c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Df/yI2fDHygB3yA8dl7WtpQvM0IWamQ3HzYML8jxf4jFisLbMqWlw9/O4smGBMfVWy57Tkh80ts9UiP9w59d61mF87J5se4Q4gSlpXBDzQJQ2gwGiO4c++npFCXpGsxoTl+ZBZchB6B4L3sAmIEgyUVEkMQP/vb/D+NdWYTo5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltlkI1Nj; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-661aff85c3eso1475482a12.2
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812638; x=1773417438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UuxblYinXNecaYICTOrKINPrDE81S32atubgYPYisn0=;
        b=ltlkI1Nj0SPtUZCJzPyODYncYemARh1lSglmm1FO9Kp3cSTQSk2aYoeb+InAdfTVLE
         z7rAsUT3DKPo0uUTv08SXB+oWdYvBFxP917HIUcfB3YeBzW3ilb6YoglG8q0tx13b4jP
         KQ2CufhwLr3nAqgFICGW3HYrdvMuPcGU9qmuZ036UWbbE0Y4ld9qjiYRLpkeAa0fdjSZ
         PUwPWj4hZQmEtOOBa2QcpzfGINh+pDrrMfDxvwZDfhf5wcpPU2m8GaqHRHpFBnZITF0u
         mPs9Dwq+xaVHrPQPGtGd2wIqPNz21kGZr/MyK0jBBm4gU+V01SLgDoKU9bSb6kPwqvO+
         t1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812638; x=1773417438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuxblYinXNecaYICTOrKINPrDE81S32atubgYPYisn0=;
        b=oJtEY+hqm3LSwyRNNZgnCyiI/1wC3siHP7aQ+fv0ijz6JDvn4gWKyAyi0+x6eZTf7D
         Oy1ht1sVx5zsrXWB9cLVDCVUwUIRAqZir+dvbLAHfVv1THB+Vwzb55Aq7d+SBmunvrWV
         bM2XARqmnCQBc9A8i7D4IikLC5mabjykH/rpDJakCwA/Ipg4UUM/uzCdw+AplwAh3lkK
         0uVaTCaQMFd891sqmuLsSIeKboejqp89aRHp2iWdFU2NDQ6JbcvQjNCGvX6Q6XplNj/T
         L/u0FlykqNdlt+1lmd5KJBCnysFfo+c5iz4YXzM5hK185tt9QAzMUEnczdWVpMJnbjwH
         35MA==
X-Gm-Message-State: AOJu0YyF5alGtRaeGSYzJITwE4KVY2y5WBw0SxiL3jO2Vf8MCerCFqYy
	J7jgU1YeYbq4Wox9d82Ft1SEO0Gy5yMkSd2jse0zrjJfj7aTGmFmChio46DqEIv3n2A48H4cnA=
	=
X-Received: from edgi13-n2.prod.google.com ([2002:a05:6402:a58d:20b0:660:d4bb:7c68])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:354a:b0:65b:f3d5:ae79
 with SMTP id 4fb4d7f45d1cf-6619d4650damr1336655a12.10.1772812638105; Fri, 06
 Mar 2026 07:57:18 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2443; i=ardb@kernel.org;
 h=from:subject; bh=agwzAQN8xh0fhG1ZjGQK5HjaW/WZoekZsp4dcGNJdog=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVzwCXgD8XOB9IT2FokbBiiS/w3WP8g5WZjePMddXF7
 lMOLNzRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACai6MvwVzrxvL6nT+0Lz9jo
 4L5Hrq78MWoH1+7O6ffd6RpQdj9ElOF/iOhq2aju/f4iX5M6xd9JaQTM078Y+fu4UcFu50vMN02 ZAA==
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-12-ardb+git@google.com>
Subject: [RFC PATCH 0/9] efi/x86: Avoid the need to mangle the EFI memory map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DE3AA22461D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6253-lists,linux-efi=lfdr.de,git];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.943];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

At boot, x86 uses E820 tables, memblock tables and the EFI memory map to
reason about which parts of system RAM are available to the OS, and
which are reserved.

While other EFI architectures treat the EFI memory map as immutable, the
x86 boot code modifies it to keep track of memory reservations of boot
services data regions, in order to distinguish which parts have been
memblock_reserve()'d permanently, and which ones have been reserved only
temporarily to work around buggy implementations of the EFI runtime
service [SetVirtualAddressMap()] that reconfigures the VA space of the
runtime services themselves.

This method is mostly fine for marking entire regions as reserved, but
it gets complicated when the code decides to split EFI memory map
entries in order to mark some of it permanently reserved, and the rest
of it temporarily reserved.

Let's clean this up, by
- marking permanent reservations of EFI boot services data memory as
  MEMBLOCK_RSRV_KERN
- taking this marking into account when deciding whether or not a EFI
  boot services data region can be freed
- dropping all of the EFI memory map insertion/splitting logic and the
  allocation/freeing logic, all of which have become redundant.

Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ard Biesheuvel (9):
  memblock: Permit existing reserved regions to be marked RSRV_KERN
  efi: Tag memblock reservations of boot services regions as RSRV_KERN
  x86/efi: Omit RSRV_KERN memblock reservations when freeing boot
    regions
  x86/efi: Defer sub-1M check from unmap to free stage
  x86/efi: Unmap kernel-reserved boot regions from EFI page tables
  x86/efi: Do not rely on EFI_MEMORY_RUNTIME bit and avoid entry
    splitting
  x86/efi: Reuse memory map instead of reallocating it
  x86/efi: Defer compaction of the EFI memory map
  x86/efi: Free unused tail of the EFI memory map

 arch/x86/include/asm/efi.h     |   7 -
 arch/x86/platform/efi/memmap.c | 221 +------------------
 arch/x86/platform/efi/quirks.c | 222 +++++++-------------
 drivers/firmware/efi/efi.c     |   4 +-
 include/linux/efi.h            |   2 -
 include/linux/memblock.h       |   1 +
 mm/memblock.c                  |  15 ++
 7 files changed, 96 insertions(+), 376 deletions(-)

base-commit: a4b0bf6a40f3c107c67a24fbc614510ef5719980 # linux-efi/urgent
-- 
2.53.0.473.g4a7958ca14-goog


