Return-Path: <linux-efi+bounces-2776-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE79A2F5CD
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9D7A1175
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728AA25B66E;
	Mon, 10 Feb 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxM5pjSl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1025B673
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209804; cv=none; b=nXI/Av0YJBPdUJA7Xql2frrl0rQCoIB7d4bxNezGlWUMGfNxIPvQaqlyfXYW1LxlQUgPccTQIYRbOYCOGWBSIbKq7/hh9UkTkWcRfGY/5iEs1eVBwn5/RAljzeFmHTZxovpM250qUq9tpaSEzEnDtpophJbSyTQfdgEe0SGMhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209804; c=relaxed/simple;
	bh=diNM0p7uAvRVWS+gNZb3H6iw7o8rfA+CWK5+t6WthY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UDJQM+Is7/Tags7KTQiQEPaemXTDUP8U7n83FCaZYYt1t6RmbutHtxsdZjdZb0jY33aV87iOSjJxYtBAfIUSPmR2wqwcvPux81sorGZbYzzpibn5H0kDCmso15nQMxyvYkhv+zy2xDYolEqxyNjXygAKTMHIUIG39OwbG/PN+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PxM5pjSl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so2991865e9.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209801; x=1739814601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bAzTuE6lkoeTvcVZ3g0jE5mvhYXXen8G4VNyLoyk4tY=;
        b=PxM5pjSlE5GBpd8ey/QdchBSj2RBe/mB1M7Eg95SBX0IR4NVz+N36G2B7gDsvfXm5a
         LBGXEGR4wSn7FgaklypZChC9FsWP8Mo/4m4/Z33V9EOaySg21Pj92wZYpO5pN1/Ofouo
         m5LsydJgkv8USevp4TyKcPOa/VQIEXExPrUus7dSIkWqbcblD6g/5yjUODgRJMoEvqra
         ogrXc/fLEIbWhaorCI7qDvASN7AGUqMefGcVCRc7SnPwH2exkQUT3e+643/PBXxSOwf+
         vQ22Z/H8GXTxC5cYbh2RmsRbP9HtcybvDUIEfXpHy9Vh/J/UeB2hG+izlhcU0A7iFV1Q
         Y6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209801; x=1739814601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAzTuE6lkoeTvcVZ3g0jE5mvhYXXen8G4VNyLoyk4tY=;
        b=GXzPbPJNkj2s07U/XOwevWK7P5tw3eNnxdK0bZsKNF0VPOJuRkcIXuw/iz48E1S2YL
         zl5pSn2S9jxsCfShNFLKJYXGt/MeocgOtM2QvfNzIJySxMPkQudDmMRa22wBczH9HjRU
         RJsAzD05gpZFLSGutdHrTERWl5hciues3JYofOttKCdoQDL1eoSk325hvubw31++Sf55
         rtAh/+Bjh6mn0BFY6VRzXcTrFg69apOVq+61N6WOsuG2UuGQwpTh05xWiBPrwGuYSnjf
         Ie7wopRtIyVw37dz9FFic92Snf/UOCSzZ//5ZkCO8L9Sf/R7B6y+L/MojT+TIFnXGgz4
         f0/Q==
X-Gm-Message-State: AOJu0Yz7RwFqDwBLSZ5JG4Dp7uKysikgOoNs84r+gSxZDAw4lpiSS+BR
	ZTPCQF6BqLaU+K8C1hOMm/E8jgNotUCvYn6mP6BhAI+WpttnKCco2Cd3HapZ78+Hn0V38YXinvx
	d/cI/AzDOQNbYrKivDcwucyF+1jYJwLw+RlTItOeDz1TqtA0e9IKJiPFvgPfYTogfOND80L8oyf
	BGDjdcYaeGjXDk1PR/d97JJBQjxw==
X-Google-Smtp-Source: AGHT+IFoLS5gvlrQmZxemqSo5hgCOWiWTl66V92ESvgDRYlHMw54KZ4gKFZi9fN/Y87H4caSgaLih4i+
X-Received: from wmpz17.prod.google.com ([2002:a05:600c:a11:b0:439:4918:fc55])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6a85:0:b0:38d:c75e:b208
 with SMTP id ffacd0b85a97d-38dc9375829mr9346901f8f.54.1739209800964; Mon, 10
 Feb 2025 09:50:00 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:42 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=ardb@kernel.org;
 h=from:subject; bh=mBiv1Gn6ENPTCZMDsy4M8CfREgIXmUNxwe/3+5F8hKE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2Vjdmn4qb7aovfO39PmqvvIJuce86H5dBTz9vlrgq31
 HI/m3l2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIn87GFkOLXoV0bVMj1Vjo0h
 7Zvkvh2/+3OCffOkH2+KLwU+fTPFYRXDP+OZ1c/kl90JPnZ279/7q+YGCyde4Wj4m7n968FI86j 9l1kB
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-9-ardb+git@google.com>
Subject: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")

booting via the EFI stub no longer relies on the legacy decompressor,
and instead, the kernel proper is decompressed by code executing in the
context of the EFI boot services, and subsequently invoked directly.

The only remaining dependency is the EFI mixed mode startup code, which
makes a detour via the legacy decompressor's 32-bit entrypoint, in order
to obtain a 1:1 mapping of memory, which is a prerequisite for 64-bit
execution on x86.

This detour requires some fiddly setup on the part of the mixed mode
startup code, which has to stash the firmware stack pointer and boot
arguments in memory, and create a fake struct boot_params to trick the
code in startup_32 to behave as intended.

This dependency also impedes reuse of the EFI stub code in other
contexts, such as generic EFI zboot, which will reuse the EFI stub but
not the legacy decompressor.

So remove this dependency, by replacing this detour with a minimal
reimplementation of the 1:1 mapping code. With some further cleanup
applied on top, the line count drops substantially, but without loss of
functionality. The resulting code can operate independently from the
legacy decompressor, and is therefore moved out of arch/x86/boot/ and
into the EFI libstub/ directory.

Changes since v1 [0]:
- Create new long mode GDT that extends the firmware's 32-bit only GDT
  so that preserving/restoring data segment selectors or swapping out
  GDTs and IDTs is no longer needed at all.
- Rebase onto v6.14-rc1

[0] https://lore.kernel.org/all/20250108182218.1453754-8-ardb+git@google.com/

Ard Biesheuvel (7):
  x86/efistub: Merge PE and handover entrypoints
  x86/efi/mixed: Check CPU compatibility without relying on verify_cpu()
  x86/efi/mixed: Factor out and clean up long mode entry
  x86/efi/mixed: Set up 1:1 mapping of lower 4GiB in the stub
  x86/efi/mixed: Remove dependency on legacy startup_32 code
  x86/efi/mixed: Simplify and document thunking logic
  x86/efi/mixed: Move mixed mode startup code into libstub

 arch/x86/boot/compressed/Makefile        |   1 -
 arch/x86/boot/compressed/efi_mixed.S     | 341 --------------------
 arch/x86/boot/compressed/head_64.S       |   7 -
 drivers/firmware/efi/libstub/Makefile    |   3 +
 drivers/firmware/efi/libstub/x86-mixed.S | 253 +++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c  |  52 +--
 6 files changed, 285 insertions(+), 372 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/efi_mixed.S
 create mode 100644 drivers/firmware/efi/libstub/x86-mixed.S

-- 
2.48.1.362.g079036d154-goog


