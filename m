Return-Path: <linux-efi+bounces-303-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7021E822F37
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 15:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD5C2822CB
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADC1A27A;
	Wed,  3 Jan 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egDg1wsG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252C1A28F
	for <linux-efi@vger.kernel.org>; Wed,  3 Jan 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ea6aa02fa4so147107507b3.0
        for <linux-efi@vger.kernel.org>; Wed, 03 Jan 2024 06:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704291112; x=1704895912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N1gohNDvDYqnLgBsdSNZRUvoOfZRwL36SC5qX9w2Hxw=;
        b=egDg1wsGsPyvwkn0PAiI6TR2lfiLIZxvI8LRb859lhTMLviv/GF2+84P0mMDfAQUhG
         F+aHPq4Se6qCz830ciscohWnjYVGcaSRNGE24ZohCFbfRxrCi4Yvhdcbh5FhvEjX6U40
         igclG8VlwYuJ3qvsVvwDmQTNGbTkllfGzTyS46YjfYotTMz+ZerRHfijVlVPk5M+G/u+
         f1EDyU+ky9QRfZ1cCbX327I5D98k5fkTJ/YfQpJqZ1SD4sFwURX91l1chyUiK7i0bUU5
         /17WbLkveHybozR/MbZ4gMjxC9Lj1LKfNm4MFy0bb6W7WgPkwth7SkhVYKf1E78V8O/6
         GTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291112; x=1704895912;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1gohNDvDYqnLgBsdSNZRUvoOfZRwL36SC5qX9w2Hxw=;
        b=lcbmdyBH9EPPOb7wJSXQIuW4bL48vmPFmBF4zevuioygirTgqhgG9/wwcAr6zDvV0c
         reRcf9GzIr4Y6tjPzbHFHLFaQE7ZJqPt2h/TVu/uKzFYxgNv+n6xGoDbd41jlFHdLmmI
         OOYGHhf70q2bVJelEj5o7LV1FbIBlVU4lCE8KtCpmVt35J0fPQI5bEbYqshI8fmGaNc9
         CcwflVm1/pSvXXviFsj8ezRgcRdAGUFsF9h38BgphIFG27yFa/22dW2T8i39ugoLVyla
         KN/6cyWIxBvOxqalSgvmFmaZEdunmL9U7PuTLIpnZKugQrlMzRWb/F+taY8/0zaSQUT4
         ZBlg==
X-Gm-Message-State: AOJu0Yzg+T5jsm+dbwr9aW9Asbl0DM0jKRteUBNyZ9NnOmNUrMPb19Iy
	kcl1cqhaamb8gnmH9ZOJ7NE0U8PlyFu/fUY=
X-Google-Smtp-Source: AGHT+IFpc2tYIJN3F3QYYTji329UUXI2i5Vpj3+MSLMBCW0/qmAp58Mk8LlAH8WEOsQVrv5M530Un/h7
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5b:782:0:b0:dbe:53ef:cb6a with SMTP id
 b2-20020a5b0782000000b00dbe53efcb6amr3355956ybq.13.1704291112533; Wed, 03 Jan
 2024 06:11:52 -0800 (PST)
Date: Wed,  3 Jan 2024 15:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=ardb@kernel.org;
 h=from:subject; bh=bRBdufwc9G+2crrKdj5gwvJZ8dLKNvG2ASmVYZPAxJ4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXVqNmdjSHnwkoURoVbT5xWwulS+XrLvdfZb8z4LvvYP+
 snnrHI6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQEljAy3Ps8neNSkmsay7uu
 2CL5lZq+c+MW1E3Mf7Y27MnHQpuqnwy/mOZs3lNnIZGiVG7f+8Zza6v6RdVPMrVtnGx7Hm/I3i3 DAQA=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103141120.1646106-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fix for v6.7 #3
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull this final EFI fix for v6.7, which addresses another minor issue
caused by the EFI stub overhaul in v6.6.


The following changes since commit 50d7cdf7a9b1ab6f4f74a69c84e974d5dc0c1bf1:

  efi/x86: Avoid physical KASLR on older Dell systems (2023-12-11 17:57:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-3

for you to fetch changes up to 01638431c465741e071ab34acf3bef3c2570f878:

  efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags (2024-01-02 16:51:28 +0100)

----------------------------------------------------------------
EFI fix for v6.7 #3

- Ensure that the KASLR load flag is set in boot_params when loading the
  kernel randomized directly from the EFI stub

----------------------------------------------------------------
Yuntao Wang (1):
      efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags

 drivers/firmware/efi/libstub/x86-stub.c | 2 ++
 1 file changed, 2 insertions(+)

