Return-Path: <linux-efi+bounces-3403-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F025FA96566
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41773AF278
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD220DD7D;
	Tue, 22 Apr 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdLxnP2X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB001202C58
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316468; cv=none; b=ONP3lUjPnCE32YZQq5OTSoePN60JMVQxrCB9H/j5gT1IehkX1oc6ihSVufU1V7uEv4Oy+kAPtlu31fHx0Hbvm4611bmJxs3h4NgjHD/G+RBvutzkMwqCaZ5x1M+gR9wUDFeaAcwXcpL+fUEooWxVLX1T7w+4ESys14qmuUOdS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316468; c=relaxed/simple;
	bh=1fR0dH0RintstbFqdmCL2UAT0LsEVGuHzSa6RyPdsaw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kQmVgVfB+JqjDabwDbP6T+8xQy5ywjO7Z2HQoMnOe+UoNJvjbhYlncpVrfKvWwWPoW0q36LumHfB9AN6mw0swEuHsx/xdzShAe6P06eZgysVjyUiIc5cw+LJQWC4QRZSNURvdulBKHXTBx8RAVCwvKKMR3IB41sGY0PGNws2N10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdLxnP2X; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a064c45effso157855f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745316464; x=1745921264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QDftWqKzBlMt8XCi/V/Dahfsag84zMOHOMka9GDde+A=;
        b=QdLxnP2XUueIscvv9E79caySR/LwTN6e/6i+86LKzHZSh7PUMhFZlSQYNyiIg3glGK
         DoMkFNOBQCW5SiAhPHVUHwZAzU8+jxhopQUXOOUw5AYuYwp4ar0QQr68A7GiT3o4VlGx
         TlEBdm2w96LV3V5+HN8i2/GTVwUVR4D9d/gxCTFqYC63wVD1LUMeddLoQqSAyph8AraF
         tD1wFxh38W8CgPsAanzco9tKWgzwvGPsC/kW+lyFcsgbUoOzGwCFA9upod7idiY7KAvO
         gDyYW8lIGsxYuVID9q7PjfKQHPv3ND7kxMCeUNMHhHD0msPr54aFpC5lB8hJ2EZ7yWLL
         EPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316464; x=1745921264;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDftWqKzBlMt8XCi/V/Dahfsag84zMOHOMka9GDde+A=;
        b=QAECp75GOGRVshuBvGpsdVihjuF/GVeaz6RdJO2EjGcVgz4sNTVk8mQDslwoP99Mki
         jmJiDiMQLUvJ2Ouw0Xur5NcfLa1QDld634BEX1qVZ2/MKjgW2GroAgLcsG8gH8BWSdoa
         ys/b+RHCDtyBR28AfP6RSqPZUVfCWQL6HGDO2lRtuj5rW2labzy5FFsmGEIaLTc0HvrJ
         etJc7CA7oeErNqB2hCS72YViW08jjasa1Y2Xs5pJjW5NttxExrUqByGHge+CFpqPAgBJ
         7dgEc18R17O52Xc/px5G7pTo6B5JovTnYRyTXPjMUbVmCueiWYXoeTmjxAnJDzFZlixI
         Nn+A==
X-Gm-Message-State: AOJu0YzPzSuyxeaIUNdUwnwmtWKV4iQMbiEYkTIrmMiuu+CbjJTMjH5M
	WsY7vj+mcnJRYo6LpnCEotWwHoXwPBxvwPCpHewSphWZf1SQG7cJ86i4yW8qTcx1kMQeNo3K1mG
	voz+pPL8J6cXCS7D8WByvdLp1nwq/sp5Kgj99OU9KS8vRv4io7JHNzWOner+3UynRB4VgbFC+jT
	CaBSeepdz8SmH20JQvBWZXNXvkCw==
X-Google-Smtp-Source: AGHT+IGebj0qNJk2EemHV9syWL6Bji6qtR5p43PHcYDuuG3MkT7auWDh6gJqd2jdVjcHGKOREjTkWg5Y
X-Received: from wruo4.prod.google.com ([2002:a5d:6704:0:b0:39d:7be5:b8fa])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1862:b0:39e:f9e8:d07d
 with SMTP id ffacd0b85a97d-39efba3fe8fmr11328319f8f.20.1745316464089; Tue, 22
 Apr 2025 03:07:44 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:07:29 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=ardb@kernel.org;
 h=from:subject; bh=W86JfsY6FfgryqNMQ3l2xd2Agk3plBhuN6POLUQIVIQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYM9K/FBmeoNxvceFRs1z3zqn/JQMtgjSsXfXLN4yjWjz
 gPXZJw7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQKcxj+yof0MS4592zexD1b
 J+bvnbOnt4rzo+f1FVu0XzI+lUszEGdk2Gw54bbIwm9MnyLXzDjx6pTKzZ7KOiaNzc8DDN9FHfj 8mBEA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422100728.208479-7-ardb+git@google.com>
Subject: [PATCH v3 0/5] efi: Don't initalize SEV-SNP from the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Changes since v2: [1]
- rebase onto tip/x86/boot
- add patch to remove unused static inline fallback implementation of
  sev_enable()

Changes since v1: [0]
- address shortcomings pointed out by Tom, related to missing checks and
  to discovery of the CC blob table from the EFI stub

[0] https://lore.kernel.org/all/20250414130417.1486395-2-ardb+git@google.com/T/#u
[1] https://lore.kernel.org/all/20250416165743.4080995-6-ardb+git@google.com/T/#u

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>

Ard Biesheuvel (5):
  x86/boot: Drop unused sev_enable() fallback
  x86/efistub: Obtain SEV CC blob address from the stub
  x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
  x86/sev: Unify SEV-SNP hypervisor feature check
  x86/efistub: Don't bother enabling SEV in the EFI stub

 arch/x86/boot/compressed/misc.h         | 11 -------
 arch/x86/boot/compressed/sev.c          | 33 +-------------------
 arch/x86/boot/startup/sev-shared.c      | 33 +++++++++++++++-----
 arch/x86/boot/startup/sme.c             |  2 ++
 arch/x86/coco/sev/core.c                | 11 -------
 arch/x86/include/asm/sev-internal.h     |  3 +-
 arch/x86/include/asm/sev.h              |  4 +--
 drivers/firmware/efi/libstub/x86-stub.c | 27 +++++++++-------
 8 files changed, 48 insertions(+), 76 deletions(-)


base-commit: ff4c0560ab020d34baf0aa6434f66333d25ae524
-- 
2.49.0.805.g082f7c87e0-goog


