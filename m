Return-Path: <linux-efi+bounces-6193-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNjrNuAcmGnp/wIAu9opvQ
	(envelope-from <linux-efi+bounces-6193-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 09:35:44 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B98165B50
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 09:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D96F330039B5
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FFD3112C1;
	Fri, 20 Feb 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffp3rl1r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7D313E20
	for <linux-efi@vger.kernel.org>; Fri, 20 Feb 2026 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576542; cv=none; b=SLybHLEGiVi9/qdKxjkBDCf5M2kyXRS5MXmEpvpE70WqzjmEYdA4kqy4L+cIoOOSIx6yIwPQAZDLmwPeS1sfxbDiIG15FEkmHGltwoEIFgOPcovrpnZhjxNZMiNrt4G4IUlRENAq9weBGvYuFu2620MmU6jAqyRwSAx7w5ZJ68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576542; c=relaxed/simple;
	bh=VqhhWAB53BH0GowGYKptvnlsrvI6G10eP0xTtztaCBg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=okG+ey2zvfMzg9lUtrgvWWi2KmD14r9Jrh1Q6tYnrkDjWfbB7vkXWBamkkYNlSp13RvDNAszufnNPO5qz1Xs4FXC7cm+OAB2gjzEBe7/93OdyG5BSzXYqcXBAXQOm5hvbWYacjTEGMM1sj6tiw4O1GxROmDcIbVDnqCzXiQCBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffp3rl1r; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso20176465e9.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Feb 2026 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771576539; x=1772181339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wvH+YVVWVNQWsBs3qk+dy7aAbXXiPKtwOWSwPeYHWT0=;
        b=ffp3rl1rtliYE7j1EE6qkav14FDjzXnLTCE57XeI2v0jli6lcyD+6oGhG7KVU6UXQ6
         IVVdWk/pu2xJjqXnpthzO5QJ92BxvBIRpVs1XfgRY0gMXk12cvnIZawnZY1jtmAg3iJ8
         Ycmx7e75UWUcxKXU+HCFBJm/Lowu3yxqygtAzQTnsOv9YZ0NUTsSZST1cuF6Ml7NC+2s
         53sMv48SCbddzWmDft2tHIiHgUoRPPK8z/60GSQPion8kAHdOvg9Dhr+21ytajbqlfvD
         5xCsSOUMgdRSR4dnPZYZK+LS9DKWhKfzsP8vN2BdxkflTGOXhR5Dj4mFSgTDwRvcoSln
         4gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771576539; x=1772181339;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvH+YVVWVNQWsBs3qk+dy7aAbXXiPKtwOWSwPeYHWT0=;
        b=alNnESa0RxOy2FSRxnXaTG7XhCPkwXQN4w3qk3wG3CbHA/w7DvvwPayZWd3KtC2H78
         ph147UrzcmwODFhjuRLepgGXV2ke/oW5AghxT3ERCst0+ufQ8LSyaqOyKnH0oxmnzDrD
         32uSA4etrGp1bTozNKPByyEXzhsPtyf0vSLV7NGRC/FEuBV0XFYVeReGDwwc0Xsrj8nL
         F/1wH8c8m1wBcuY/7cdhTsCiMZ1c2xY1HabvPGr/Wis9MsD4oIx8ARGIvQr4euVEgKCl
         JEZqEDvAc0P5Z8/bfswtdusVFvUf+o3FdvdGfVxK+Rw/xRkTUjjnYSByVYlf5DXvKSKd
         13CQ==
X-Gm-Message-State: AOJu0YyqjHxs+n8+MZvbFKg22DWSU+MVyEBaeBhfczhgCGEDZA/oQII/
	l2BN1QE+1kdyGH+8AGUQhIOUb3jecFFtrp2iXUnyGmMJyKgm8PmMhiBECriWbM9tHG9iZeDAdw=
	=
X-Received: from wmpu2.prod.google.com ([2002:a05:600c:4d02:b0:480:2f40:9f85])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6814:b0:483:612d:7a5c
 with SMTP id 5b1f17b1804b1-48379bf5d3cmr371989715e9.25.1771576539336; Fri, 20
 Feb 2026 00:35:39 -0800 (PST)
Date: Fri, 20 Feb 2026 09:35:32 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=ardb@kernel.org;
 h=from:subject; bh=3UllcstwH+cuqxiFL7b5OAnpuEUWNvGuhxkQg7Oyp8k=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXOGzBVuyy17snJspZnS95TNeDAp4bzSjTrpiR3zqrx4Z
 lxVUpreUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbC5cHwh+ugstjetsRdAQ9e
 dJae17/h8+bLhfW8DI///l32sN5k9XuG/0mmLVdtwqKPFqxNl71VLHxe8cgjd/XUNayCLUtZSjp PMQIA
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220083531.1254723-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v7.0 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6193-lists,linux-efi=lfdr.de,git];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84B98165B50
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Mixed bag of EFI tweaks and bug fixes. Arnd's fix is a build fix that may annoy
others so would be good to get it into -rc1, hence sending this now.


The following changes since commit 9702969978695d9a699a1f34771580cdbb153b33:

  Merge tag 'slab-for-7.0-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab (2026-02-16 13:41:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v7.0-1

for you to fetch changes up to 948a013a54c47d5eba06e644b99d4927a8bc62f8:

  efi: Align unaccepted memory range to page boundary (2026-02-18 11:26:20 +0100)

----------------------------------------------------------------
EFI fixes for v7.0 #1

- Add a missing symbol export spotted by Arnd's randconfig testing

- Fix kexec from a kernel booted with 'noefi'

- Fix memblock handling of the unaccepted memory table

- Constify an occurrence of struct efivar_operations

- Add Ilias as EFI reviewer

----------------------------------------------------------------
Ard Biesheuvel (1):
      x86/kexec: Copy ACPI root pointer address from config table

Arnd Bergmann (1):
      efi: export sysfb_primary_display for EDID

Ilias Apalodimas (1):
      MAINTAINERS: Add a reviewer entry for EFI

Kiryl Shutsemau (Meta) (2):
      efi: Fix reservation of unaccepted memory table
      efi: Align unaccepted memory range to page boundary

Krzysztof Kozlowski (1):
      efi: stmm: Constify struct efivar_operations

 MAINTAINERS                              |  1 +
 arch/x86/kernel/kexec-bzimage64.c        |  7 +++++++
 drivers/firmware/efi/efi-init.c          |  2 +-
 drivers/firmware/efi/efi.c               |  8 ++++----
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 17 +++++++++--------
 drivers/firmware/efi/unaccepted_memory.c | 10 ++++++++--
 6 files changed, 30 insertions(+), 15 deletions(-)

