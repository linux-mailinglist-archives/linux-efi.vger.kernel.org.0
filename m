Return-Path: <linux-efi+bounces-2793-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E633A36508
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2025 18:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB953ABD1E
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2025 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18F267AEF;
	Fri, 14 Feb 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vy84KRQS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93F2676D8
	for <linux-efi@vger.kernel.org>; Fri, 14 Feb 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555652; cv=none; b=A6Fgzgaek8KBhP8xoHPtDSelAccGdb5+Q1+O4rFgooXhph4R1v3cpuxFUq8rOw8CPzG37BE8qCimJunxUMTyzVJ8lk17lwmhPtcoFRLmT1isCPAj5cWCKacpw40dI3oZYqQeyJEEniC4iN1wwbcGfNPZY13ld65awIkSvXIiSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555652; c=relaxed/simple;
	bh=g+mJEOgvJWC3GakbJpLmGe3FY/rOUiv5KYziL1lzlf0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=USNtCHiEcogZZQcwzmz3oCMOnd80kJ2f34+UUdSw5Zl9f1uV0BzrlfWib+TJnswOu7AKAPEHUt0Y//wbN5Qjx131aTtPhy/rWCn+mxoulmawGofGZ+bBdjMPytk+qZnPc0zTdFqBnex2hROKopyszyOl/pgBDKKErhqO3bkL9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vy84KRQS; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38dce0d3d34so1594754f8f.2
        for <linux-efi@vger.kernel.org>; Fri, 14 Feb 2025 09:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739555649; x=1740160449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LFqhns15kEPyBA+stL2WOuIyCGjZoi1rENHHYLBCJlc=;
        b=vy84KRQSUWRK5XM8QFM2Pg5IbcqhAVW9mYSKL0vZntowgObGhfa6xrnuhZL13avy4r
         B3KzA+d1J98i6bFHJcMPLwwmY8SRVteekRKjwFuvoxSzoW3gEVQTdHnBrcmRo7FzJ5B8
         7lZIKxJKcOUQQuMpHT/9oqaogqKkw2yiZPLAEvIXxFINS58ShBvDFa+xUsyjtItFiYaB
         V0jddUharBzMyf7srisWaEi1y9OXmuZ4KuOeC2/EmEifDzBMEUqfj1gKdI7w3cUQimOY
         cVX7r/HRrPdoGDDcHaWbQlS1xlE1r9BGuOpLlIuGypVlngi3EWd6qDi4nuE91dLVgGqU
         yTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555649; x=1740160449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFqhns15kEPyBA+stL2WOuIyCGjZoi1rENHHYLBCJlc=;
        b=Q9hSfKun7bTgw075nkzF3ajuBXBlQy74OBQAh7jlp78A6C29q/2EfpKi5zeQRYijjh
         BbN7aMVmzjwke1rRl0RWcyjLzqtGiVYDAUgou0PjMVGqciyXH0yygytUAtIzNwLiXcP8
         zAMcKkx0dI8ep1sHnIR3Hk01m+HJ2GmGJnPuBL0kE8Tder9cz/j483TBf4sUyI2fPBA/
         fitIiilpLGDZjHq8LAlVMGKDPMbe0hnjObvZqExauP4b52Fsxf0TjrvH+Zjx4oY8YFPs
         1zDtEZli43k/Mpvefs0KALzFdpCiy3ddNc915S725BcmJB6tq9VCLZICtiOYdXPxLJt+
         0QZw==
X-Gm-Message-State: AOJu0YwKJEtjvsMFvsl78wHBHLbZxj6wpGB/0pt1AXgrzttPgDRIwBln
	z3c9ykroCLcRG+r/uB1csHtZfNazvkW5C+4HZaMzMlG3xGkwpJYUlZtkNhcv4cX8Ccl2Qg==
X-Google-Smtp-Source: AGHT+IERsKPv8ngIzFdQKxU3NQkWuuJ4YNN585VXeQM0A7qDB+OOBGXYVBXWUN3oBWIEngrMohWrWsb2
X-Received: from wmbjb6.prod.google.com ([2002:a05:600c:54e6:b0:439:6413:1655])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1565:b0:38d:c99a:c1de
 with SMTP id ffacd0b85a97d-38dea3d017dmr13886103f8f.19.1739555649375; Fri, 14
 Feb 2025 09:54:09 -0800 (PST)
Date: Fri, 14 Feb 2025 18:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=ardb@kernel.org;
 h=from:subject; bh=31Ag7O13gr0HMj6o8PM2vY2wvDYJUisLCvbS/8Muqpc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX190y2RpS+kjR23sRgXFOxgOMFhEL3q7M6DBiLp2RaHJ
 PYqT9zeUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaysZSR4dX2Xf+Xztn+a+/R
 ox/Y5osud9bMynq9vfvHTet9lWVH70oy/C/+HTFpMW9t2sIqbs8y/c8960Mq67e6akQ80wp5ELx UgwEA
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214175225.544273-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.14 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the changes below. While not true fixes, these changes are best
merged asap so they can make their way into the stable kernels. That should
ensure that the new EFI_MEMORY_HOT_PLUGGABLE memory attribute is used
consistently by Linux before it ever turns up in production, ensuring that we
can make meaningful use of it without running the risk of regressing existing
users.


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-1

for you to fetch changes up to bbc4578537e350d5bf8a7a2c7d054d6b163b3c41:

  efi: Use BIT_ULL() constants for memory attributes (2025-02-04 14:08:22 +0100)

----------------------------------------------------------------
EFI fixes for v6.14 #1

Take the newly introduced EFI_MEMORY_HOT_PLUGGABLE memory attribute into
account when placing the kernel image in memory at boot. Otherwise, the
presence of the kernel image could prevent such a memory region from
being unplugged at runtime if it was 'cold plugged', i.e., already
plugged in at boot time (and exposed via the EFI memory map)

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi: Avoid cold plugged memory for placing the kernel
      efi: Use BIT_ULL() constants for memory attributes

 drivers/firmware/efi/efi.c                 |  6 ++++--
 drivers/firmware/efi/libstub/randomalloc.c |  3 +++
 drivers/firmware/efi/libstub/relocate.c    |  3 +++
 include/linux/efi.h                        | 31 +++++++++++++++---------------
 4 files changed, 26 insertions(+), 17 deletions(-)

