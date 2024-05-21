Return-Path: <linux-efi+bounces-1053-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80C8CB2A5
	for <lists+linux-efi@lfdr.de>; Tue, 21 May 2024 19:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3351F22244
	for <lists+linux-efi@lfdr.de>; Tue, 21 May 2024 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094812FF8B;
	Tue, 21 May 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hszeFpKM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0C22F11
	for <linux-efi@vger.kernel.org>; Tue, 21 May 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311593; cv=none; b=IiTNk2bQP0aCWxkmk8wDIkDSrffVkTx2oIin9x812xD5rqRzNv1sjQoJRHj1UnCrKkNoFYvHr3fYp8baWxxuOSG42AcwjLcRUFOscTA11kMb/lmN/Q2UYboT/B2elUNEmHDBwUxX/VSjPt0CGolqRCfEgb7fmSy7ruHz78v3xAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311593; c=relaxed/simple;
	bh=tOT/LxjJ0u66XLjYiKpIFgHX+9pqbE0zX9PLwJPa4QA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tKX+687SqCmFZ/KISm8k4B0Sxmq6N+MiiSfP50FSMAV0hWhyQtCtXVGckqF9xkiHQjw3xMFctBaHx1Rdt34qSbHLHQaADN1RjSjWh9P+X5cGQDKyXcgTCA8/FUv0VyxjfmtBNYDeYCEIrZDu8h/5iScdkUGRnSYYZnjMBapPktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hszeFpKM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-420122cf3eeso50880895e9.0
        for <linux-efi@vger.kernel.org>; Tue, 21 May 2024 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716311590; x=1716916390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfP9Xg6cYkEWHf3nLVKtP7vq0zXQ2Nu99jrVTn2J/ew=;
        b=hszeFpKMPIRrclTEnWmCI9nKAlLeGQK1GqQGqdX4PzHY1SRikaMLQ6rTLB8SUQH1jz
         nKIKfIrc6eILY78TZ3aoDUf9x/LQC+tLMKo3HnWvqxAbSSHPpY0dOtlodGYkwK9G9SFI
         0w81Pj4hf6baJ5e8hm6M7Mb3oOwv39GPxDweGg6xRpyE5DBkCfA+DgsBpFOZQQfAihk7
         ea7oBLB4lyLpfjhoa996mpthnxmnPS6LjOWkkxN33WrtDV6VsO8p/WU5NSSA0y1Li2HU
         mHP8g3X52TSUixHNWkjwdCobK7xL+xZ/DiFl0DqO12Fk1Td9OVhS1YDKHxTgzvG4qvqg
         NBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716311590; x=1716916390;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfP9Xg6cYkEWHf3nLVKtP7vq0zXQ2Nu99jrVTn2J/ew=;
        b=Rue7S90mOXjd70xKhz/vQt6pnkV0//3CZvFFXgfRZqdktr060GxBENVDRJBZTSmgJb
         seFgsJ1hfDpwLKlmW9PRauh/xJHsDq+p9alooadg/jcmzaHK5t+1LQR7cW5I2FhEMBYs
         c2MaG2y5cjlGVhq3FgDbUvupsB0Bjioal/9++FDOY3NIHB5EFQ/HUas4Q28Cug25SP12
         jvr0viNfDwKQGtaDnvVKNRZ4HsJkH80N65D8yjDNBqZMuV1h20TQ07d7fcZ8+zBlTlH7
         x0JS39y3k8swKRliAZkiv1/O6ynnRGOoRCV4xesC3eWx7GUBD11PFcj+qypmTLlmidtZ
         Aj5A==
X-Gm-Message-State: AOJu0Yw5EOIX5Uenk0D3Ecy43dRA+FL85d3GlIUOn7VjEtPb8cEQIPFm
	9Xf5fsAYwQKY/haKaGlJ951DPoO83jGZMHsi2cqBzfXEHqEt6XmE/XUhii3oWeSfL2XOeQ==
X-Google-Smtp-Source: AGHT+IEOg/JhMMYZsx4ryXtd6IEbDenNtKZPOkDZksAMdD0iz27L19/tapZ9mSls2cFCFJQ9J5SO68wv
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3d9b:b0:420:29dd:84ce with SMTP id
 5b1f17b1804b1-42029dd879dmr477425e9.3.1716311589848; Tue, 21 May 2024
 10:13:09 -0700 (PDT)
Date: Tue, 21 May 2024 19:13:04 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=ardb@kernel.org;
 h=from:subject; bh=LbAD3xJywJEQtWp5dyt+d4aRzAQmaPFGgn61oDEEtI0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIc3nmoJDohbbt6Isq/PbeDb+mHX7qqFI0C3pY1opb66d5
 2zujefpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZd4mR4deFKN/8pRKnMtdf
 cPxRNa3KrpLB/GHE9JmnhEzMdb+saGRkeNbuk7/N8BiHX8m0h+94NsoyRL5tYlVMf7notdGTGcr WzAA=
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240521171303.3822496-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.10 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the fix below. This is going be backported to v6.1 and later to
address the regression described in the commit. Whether or not physical KASLR
for the cases in question will be brought back later (presumably by sharing the
physical placement logic with the traditional decompressor) is as yet
undecided.



The following changes since commit 4b2543f7e1e6b91cfc8dd1696e3cdf01c3ac8974:

  efi: libstub: only free priv.runtime_map when allocated (2024-04-29 17:47:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-1

for you to fetch changes up to 15aa8fb852f995dd234a57f12dfb989044968bb6:

  x86/efistub: Omit physical KASLR when memory reservations exist (2024-05-17 17:06:18 +0200)

----------------------------------------------------------------
EFI fixes for v6.10 #1

- Followup fix for the EFI boot sequence refactor, which may result in
  physical KASLR putting the kernel in a region which is being used for
  a special purpose via a command line argument.

----------------------------------------------------------------
Ard Biesheuvel (1):
      x86/efistub: Omit physical KASLR when memory reservations exist

 drivers/firmware/efi/libstub/x86-stub.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

