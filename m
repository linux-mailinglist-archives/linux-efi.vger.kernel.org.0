Return-Path: <linux-efi+bounces-1178-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F58FE6C0
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 14:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA8E1C23F69
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C94DA14;
	Thu,  6 Jun 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gp25KpTP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F1180A64
	for <linux-efi@vger.kernel.org>; Thu,  6 Jun 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677964; cv=none; b=KIR2qUd4FZyAf/zcHWq7cBmYqR7i9+ZcRWk/Q7Doj3VEOzSb06i6v/2yRmwkY6gc9WzFw/gQTizgziYQ3FBNNes0w9QHnrG1SjNvWuEWKf05IkQCZVPIIjaKrvYTaQwmGMdNqNOL3JVH+nuj4n/RlZS/YsDu5yyHLc2bXSmVdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677964; c=relaxed/simple;
	bh=vCwQ+UOs6lA3bwt9Gxf4/DF76/ADplVJke49DQD29uk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jnUC7jxZA1VWGSg5W+N6F9uspTVUHWnTp1a+ob/49gCUFlZB9weS2Zq4nNrrSNXPqs+ZP7Mdl4Vw1qZscOz3cyT7h5EBYGgImZD9unhUNXIsvrrY+on/4ueG+tQ4b3BR7p+CnkhOkAHkIKB2CyB7E4MGnSwV6CC2uF3x4e8IHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gp25KpTP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42117a61bccso8396605e9.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2024 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717677961; x=1718282761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gnFSHXIA5tH1p+HK99iPQIajLxhweXL/1owKjLMbYw4=;
        b=Gp25KpTPIcYqNFVMmYNiAb2JNZQVV0rT6WvpJu5Qs4pV9oMvYkBV8FepNB9yitmlI7
         kH54q9UMCkGN/960MSAcx3OuGDq57kXSDaagDzk4lbt0UfScLKV3J84JcpBlyQG1zX7x
         8ZslX9MGq4M59wRh/Vth52V33fIP8mdXu3fSxjpwtlN5tZRWihqY9+yHf1hiuN7aHkiF
         Ayk1YmHmqs/Hz3P7z2ZHGJKOmG5z6uPMod9DPwcvRmozoiWVsHO/6p0nQrUf2hiMmN3Z
         jjGRLBFEtxQgqEe2ZK472c1Dgi5cEghJgXRyxI6xp1pBZAAjj45JIvEhGcBwZX9Vc0v7
         mwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717677961; x=1718282761;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnFSHXIA5tH1p+HK99iPQIajLxhweXL/1owKjLMbYw4=;
        b=kPmAJiKmRm2jJtcxk3f5WwrR17hGBnAi7D+dg9/VlZTon4AEI/267Gr/y78JBDfIpv
         PK0zl3RnGP78ofby6tmmkh/RNBktzq4bWyrKoMGmia1Py1mFt2EoomxtAvgyE6PDy7kM
         q/PhSY0kEAFhSAvPu0TF1poR7yfssnKiU7cvPnaL91YuUPYdvO8UP5BrthIMue5UDXjS
         SL45Hd+whtoDRbc/vKqFl6y2kgJ0npyhY8jrQDeyT4cWp8lcBVc3i9XfRuCPBnjHbVQa
         9pArDFPPMNmdr7AXyBRvMiqZ0iftbwI6lGoVlA2A2+Zsua1jI14getkxRM58TpC1rzjz
         0GnQ==
X-Gm-Message-State: AOJu0YwMogRyDZHs5md08pAJCdm7M/lKcG962R/BvL8pmBBPmBFQcOKL
	O/bxYF9C2CJR2MZn+sixiQfe41SVrpKUiwoAZVnDPjHhMLyCxM5CwP4iNEvDOCCSuU3NNg==
X-Google-Smtp-Source: AGHT+IE/zkSybYPq7ecd+O9e/fM6Zzfm2JQn/WMzguQLMXYVCcW6gqP7qgo9/h23o2Eg4AS5J3BAYLjg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:310d:b0:420:d54:7004 with SMTP id
 5b1f17b1804b1-4215635416bmr204805e9.8.1717677960404; Thu, 06 Jun 2024
 05:46:00 -0700 (PDT)
Date: Thu,  6 Jun 2024 14:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=ardb@kernel.org;
 h=from:subject; bh=Xu0/OlQ3MYAiscc588qH8Z4H7pTfa7+P6l39lAq2LZw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS1xff2p459YjlUa50r+mLSNx+pfSumhuIVdaq7ZL/WjF
 a5lMa/pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABM5/5rhf2b/Jq6S52sfqGgG
 XL9y9pSd+cpTh/00zVcYXUqbNFvWw47hr/wRvuP72r0ZWW1rq/oTgjXD+T+ki6/c+SJEmaH2wKJ EdgA=
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240606124550.3584379-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.10 #2
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Another small batch of EFI fixes for v6.10 - please pull.


The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-2

for you to fetch changes up to 99280413a5b785f22d91e8a8a66dc38f4a214495:

  efi: Add missing __nocfi annotations to runtime wrappers (2024-06-05 10:18:58 +0200)

----------------------------------------------------------------
EFI fixes for v6.10 #2

- Ensure that .discard sections are really discarded in the EFI zboot
  image build
- Return proper error numbers from efi-pstore
- Add __nocfi annotations to EFI runtime wrappers

----------------------------------------------------------------
Ard Biesheuvel (2):
      Merge branch 'efi/next' into efi/urgent
      efi: Add missing __nocfi annotations to runtime wrappers

Guilherme G. Piccoli (1):
      efi: pstore: Return proper errors on UEFI failures

Nathan Chancellor (1):
      efi/libstub: zboot.lds: Discard .discard sections

 drivers/firmware/efi/efi-pstore.c       |  8 ++++----
 drivers/firmware/efi/libstub/zboot.lds  |  1 +
 drivers/firmware/efi/runtime-wrappers.c | 13 ++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

