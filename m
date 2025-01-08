Return-Path: <linux-efi+bounces-2533-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE90A06448
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 19:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B1F1623EC
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3D20100D;
	Wed,  8 Jan 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nc5LeNmV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1F1FF7BE
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360566; cv=none; b=NRyxuv7Xd2Kq0+xhitKXl8LSkR/nCr3C8mMkhgUy2wIFWQ9jovnA6umvvqrkjul6n0lo1Yl5+W1TXIW6i4tX7cOBhuTf3vv69mN9lLERcTXtDtHOPtBhWX1XFjpJ2w7jGd6YpoVS1U0GF9B0zslWFtBoYeMDaWMVtQWohguHdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360566; c=relaxed/simple;
	bh=/7jghWJYOVSMdBW0kE/TCfFCVwLfvNagyHB+kll75is=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Tc//5cX+QRxqCc6GaO7zTBAvzdFewuPd/CRDCIQUya+hQbR/2zwi0tpdmLV7mPcKXFQqymrxlVEJBf40oECaEowfUg4g1Cy1LiucnCuLr5Hr5D4n36MY9ws5ZyBt6K0G5PTJnor8D06auGn/rypkz9EVwHrtsLvo+ol+f9MzrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nc5LeNmV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so942025e9.0
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736360562; x=1736965362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DIxUG+ttEFMyhlBsC5GIWbnlM4ZU8s3V5Wn5pKhpA9M=;
        b=nc5LeNmVgQEE78dWth8aJXjaPZG88aSHrRag1BJYtPrKjYLX3z9J+mwEyZXuqZzaP2
         LseR4IDZ0yqTQf/Kpk/CYUsjvn9CudsLxcYhANEU1n8M9h2etxNXAaytU6tTmB+dCF2p
         Mn7pGAY+B0QASqUwYpzws7jXWlcXmNt5kgRU/nApik2/C9SqmBWh6r+GAaFlxbOPlZQx
         xp67Wn57hsZY4eKyimccVsX0Ys7dzHbzYPkugvRHdiZDxitAPng3ajwHmZgax3R9r0Ej
         s1YqJcH7MyoXWyFTLLTVNaXq2ZNOtgizbXkN7WN9k0WeoD8NicM6K3ZjB+gd2WiO7O3U
         25mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360562; x=1736965362;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIxUG+ttEFMyhlBsC5GIWbnlM4ZU8s3V5Wn5pKhpA9M=;
        b=YvNBT/oRIOdqC43G/Mil1Lebx5kqJBsGk5GEHHBbh2kaMYpSwaKT90NZPYEO58mcmM
         sHED2vbdVpznnKgNOUH/aWP2101EqReJnUYy82vGdiL61eayKSbYbtDIbYwW7jBMcvoU
         2dZctdz2DXfW0+YItmaXXPiuqA+ExsIuKZ81jKbdqJVIgDgJg/HZbjJ4QeqoGpwnjSty
         qW2PGRKxHKAcEYpFUffAbx8suyvyhzHEFdjniVAoa5ljoYi89hmyJtfvzyP1Lk2fErxs
         DuiaoC3tGxZZWhV6jSjgtlL2mGbkHyBs0O4VvJNN3+4Rk98BlJFuVTLOB0hko2PHMZ5n
         1nZQ==
X-Gm-Message-State: AOJu0YxmfwiTStqyJyHCcuwpNk6pzDSl6KqGgkCvbLlNTEVbbxyNrcWZ
	9iRsDEmWP3xsg3DzLxq0dgG+GNUr8c7+BSL5cWIogu8j+/Gdka1lDTKVszmPWuFC4MLPrKPI1nO
	s4Q1CoT6SsT3j9pAlsjdpxwCX3wKImDKfmO+eFCpHWMu0lVxroqCWE+aULsQ25/p2cu4MtIifhu
	AhDlDNl2wWqvdlokoZKZinYdZVQg==
X-Google-Smtp-Source: AGHT+IEk2VCQJyHEq83LCAmEA+6QbToVTasU/f9RNxvQPFr6y3ljem7ZEMB3gNtT8EZuiZjuRHFiGfu8
X-Received: from wmbbi26.prod.google.com ([2002:a05:600c:3d9a:b0:434:a8d7:e59b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a45:b0:434:a75b:5f59
 with SMTP id 5b1f17b1804b1-436e26adfa2mr31995475e9.3.1736360562683; Wed, 08
 Jan 2025 10:22:42 -0800 (PST)
Date: Wed,  8 Jan 2025 19:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316; i=ardb@kernel.org;
 h=from:subject; bh=6CqBxTAqQNTY+K/fKXskLjXY4m+1lGaBNv1NuvfP1Ao=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3uUDS3zDTNRndDDwHFpIXzOtar2lwKkg+ePD/5bd2mg
 5tEdop0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlwVjD8T/x8Zq5g698Mh+cr
 Qhw05390ZCncp6kZ9Ozyp/sPXJcyTWT4H618r1veuqZXM6H+q64Ipyqn4kwnX4umCcKPNkyZ99+ VAQA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108182218.1453754-8-ardb+git@google.com>
Subject: [PATCH 0/6] x86/efi/mixed: Decouple from legacy decompressor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>
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
applied on top, the line count barely changes, but the resulting code
can operate independently from the legacy decompressor, and is therefore
moved out of arch/x86/boot/compressed and into the EFI libstub/
directory.

Ard Biesheuvel (6):
  x86/efi/mixed: Check CPU compatibility without relying on verify_cpu()
  x86/efi/mixed: Remove dependency on legacy startup_32 code
  x86/efi/mixed: Don't bother preserving 64-bit mode segment selectors
  x86/efi/mixed: Simplify and document thunking logic
  x86/efi/mixed: Reduce padding by moving some code around
  x86/efi/mixed: Move mixed mode startup code into libstub

 arch/x86/boot/compressed/Makefile                                                |   1 -
 arch/x86/boot/compressed/head_64.S                                               |   7 -
 drivers/firmware/efi/libstub/Makefile                                            |   3 +
 arch/x86/boot/compressed/efi_mixed.S => drivers/firmware/efi/libstub/x86-mixed.S | 320 ++++++++++----------
 4 files changed, 169 insertions(+), 162 deletions(-)
 rename arch/x86/boot/compressed/efi_mixed.S => drivers/firmware/efi/libstub/x86-mixed.S (54%)

-- 
2.47.1.613.gc27f4b7a9f-goog


