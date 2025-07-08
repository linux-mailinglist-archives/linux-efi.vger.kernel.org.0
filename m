Return-Path: <linux-efi+bounces-4179-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB04CAFBF9F
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 03:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1516A3B69CA
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8247A92E;
	Tue,  8 Jul 2025 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8WUFU6p"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76DD517
	for <linux-efi@vger.kernel.org>; Tue,  8 Jul 2025 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936534; cv=none; b=MaI0EPDUPt4+hnmkuibXhXLVsruZWNVBN282AWhTUWDRWqcOjvNpUEOjwVpepfMZSRKnYScXBm5nuCkmv+tlnyPrHFRUBOE+Gi5W5FY6N8AZNyJpV3uolWYsO2CR4qQAgUS5xP0950SWduuxiIJJ9o13T7wvANiztRSrLlFvLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936534; c=relaxed/simple;
	bh=BmzOIdpCJSgwWBN8WoRKN5tIzMQZ0QGJ4sG6D92NzHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kNLHrB2g4EvDBLB7Wcf9Y3QXqpJHC9Q1ba8yIwfuac9kKgkENQCxAipXslfMhWgTMvmVsPIBv5BQlg3DbyjzhTkvG3/TS/ezngQ6CNZij0Siecid0A53Nu97+UINVhdQC+ArvZd8QmrojRUOzLYlarnCfFaRsBZD1ZTLjgYPUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8WUFU6p; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so1585666f8f.2
        for <linux-efi@vger.kernel.org>; Mon, 07 Jul 2025 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751936531; x=1752541331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oFhwaquvJqAlSi3vEGrcLgmv78XGr9Zp5hZQAcXjoXg=;
        b=Y8WUFU6pBeWFAIS5+3NTKPQYwiQWgtXVrB/M5yQlgHlKH0DQ6+n3oseL7QHuE5yVHH
         15hmQHEDQKGABoXTq8Ez4hvv58vdrrLg/RzLSHE/C5Zgy8FW4ZOHlRLS+pkuiRLv/y2y
         VtY+Opvkg1+gPMJDemcCHSAhcMGJPjwop+SXahKM6PvLORYHfaeAQhHvvph5uu57keJW
         /uE2M/B9/Z7CsJOMQJWXVyXA/2LBhBiLnAIfMz3WnimYu2laxUzSqofuCk3Oqu0ZHEuK
         MpLnNJKX30ResWPW9Di7c+dpWyYQlJdrlty7HecKpJ74dZuN4CegeGpGjBuSeovvz2J+
         3S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751936531; x=1752541331;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFhwaquvJqAlSi3vEGrcLgmv78XGr9Zp5hZQAcXjoXg=;
        b=gMZT9IKd5ZCucCFkAD/pz+B73wuJOusyu5e1ygvhWwGyfbk37lgM3NyOKNKw5ukrLG
         f63ppn5zFO3pSbpkhtaUEZa7qw/hC8KURg8ZLNO5eh+CZmBulsd+kSaZqxxPcbVSacGK
         7kUcpPA2K7HfhRcRfDXt/Vto0tAUWXGORcwNgv6sSrTiE3lVQ2nzBvG2ypEyxwPYeASG
         NaQu/x5VsdYq2IXPIkXC2E+sV3fgk+t837ZgrpH9kHpCb2tbKrrJ8q2ZS5rqUADY1VSh
         mP2uZCqN8C03TdEzgUWioQQhSn9qAiCU3V3R0k9FJSjVfS+aH0H6JzTN5hNlp/QnwOgk
         m30A==
X-Gm-Message-State: AOJu0Ywzd8ty2SBshnAPTeK25ej7Rr+L9pFDWY5p71oBHZ9MQsjy4SQ/
	3V7r840r0sUbBkmM9NrsM/ObdrXGocTJm1f/qbeLgwjsjjiHSXw+IfutPZPcddwatQ1fSgDfgQ=
	=
X-Google-Smtp-Source: AGHT+IEspFNMIKFaROPJH7kHW9hpg7BgnO/MUXRKJs+KNGVh4/YpiwoKH96I9eC91Ui9jVSIyQ0UYscj
X-Received: from wmbfa23.prod.google.com ([2002:a05:600c:5197:b0:453:7edf:24ff])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:98c:b0:3a4:eed9:755d
 with SMTP id ffacd0b85a97d-3b497011980mr9229776f8f.3.1751936531446; Mon, 07
 Jul 2025 18:02:11 -0700 (PDT)
Date: Tue,  8 Jul 2025 03:01:54 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=ardb@kernel.org;
 h=from:subject; bh=nQSVEF1LJzQGMRC1NtlqPf7x1Qh0h/Yyxf6wxUDoTYo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISMnj/Wi2pSK9Tzsc3f53XvZ0VnQ52tt0dlzVmzLn7Nue
 e/PhXp3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl4mzP8lelI3Mw2ReJs+V3B
 A/8uL0jsfFTm+Pnwf8ml94+emDbpTB3Df+ePenf4zI5eOrApZOvZpI6Xxf8vO2ionJ3mXXtUx+P lHE4A
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708010153.1323761-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.16 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull these two fixes for the new SBAT feature in the EFI zboot format
(used for arm64 and RISC-V by the distros)

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.16-1

for you to fetch changes up to f8b53cc9174c5980549f60c972faad82b660b62d:

  efi: Fix .data section size calculations when .sbat is present (2025-06-20 13:36:14 +0200)

----------------------------------------------------------------
EFI fixes for v6.16 #1

- Drop preprocessor macros in zboot.lds which is not preprocessed
- Fix zboot .data section size and raw size when SBAT is enabled

----------------------------------------------------------------
Vitaly Kuznetsov (2):
      efi: Drop preprocessor directives from zboot.lds
      efi: Fix .data section size calculations when .sbat is present

 drivers/firmware/efi/libstub/zboot.lds | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

