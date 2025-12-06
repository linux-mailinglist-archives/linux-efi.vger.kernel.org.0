Return-Path: <linux-efi+bounces-5815-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E46CAAC87
	for <lists+linux-efi@lfdr.de>; Sat, 06 Dec 2025 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BA203000956
	for <lists+linux-efi@lfdr.de>; Sat,  6 Dec 2025 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA263009D2;
	Sat,  6 Dec 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg0d4Hzo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE32C3757
	for <linux-efi@vger.kernel.org>; Sat,  6 Dec 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765047684; cv=none; b=Cixw8S4dSSbsBdE1h60lz+HSAj5oTRLaDajdEzCHvypAuNpsieDgyZxprY8yd09B1On2PHdIABUUtbwqbZQwGP1HIzWl5Q0AogtW72FXlcG0Jvc9HlufZuQQwpu5YuXIHSohenVwnVzIpxARDFppkH9H5c8+gJh20ohsRkxArLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765047684; c=relaxed/simple;
	bh=3ePID8OtexLHvKZJHnWPep8FkN/akgpFUVG9vEqC2Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NeDahmIr+1EVFjGsoPs3YFzrSebWdCjGGrNHzPOwQJ328GhZrWFkAqfGjqS2SII3dAZLAQNKl8uxzn00CzAuFvUCr261kuSusRRqs/XAhHhnkfdDg24RCziZs7mcukotNKHPx3XoR+TfO9s2Fxhazzu/owdDNxRoB8u8Vhz8uBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg0d4Hzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98933C4CEF5;
	Sat,  6 Dec 2025 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765047683;
	bh=3ePID8OtexLHvKZJHnWPep8FkN/akgpFUVG9vEqC2Mw=;
	h=From:To:Cc:Subject:Date:From;
	b=cg0d4Hzo+UMIJ8j3jDFDucbvx1CFJ1trH/NnZ0Lu+faaRp5vI0EeKAbUIEowQ5/zW
	 3sFz7kohgM9gHWJkOHXu0dNw8W9tpj38BkOmQFWc+jy4h5F82frII3ZT9sAmgS+/SD
	 Z1aC37JTutAHq8301i2KHCUsSstwinciA9WJtcAyFET71r9oI4MWXIYogwYECjAjFj
	 nviFY8EKBjUXFTMjT3oILuufiXRDUf2y/Rl0x3UzpCHmiOtApOqXO2fIF8BpIb39OX
	 ztuWx/8DIr5aGA3Sh5CUgFuFuT8CavwY9NpIR2sl5hXzsKlQ1AF0Xp6CYy/vhHefX8
	 eU4xcfK1Q8PuQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 0/2] efi/arm64: Simplify SVE/SME state preserve/restore
Date: Sat,  6 Dec 2025 20:01:15 +0100
Message-ID: <20251206190114.892262-4-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=ardb@kernel.org; h=from:subject; bh=3ePID8OtexLHvKZJHnWPep8FkN/akgpFUVG9vEqC2Mw=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JIdOkttrZ5e69aWETfbM/Ss/QLQ0x3LPr+ObNEQczw54e4 bKcvtyio5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkSwfD/+in4gunzm3+lFaf k+z48Nv7R5P9pfRUg3+l807QqjJgMGBk2JGiV7HLcO42F+ut3XVu69hebF0o+S7wQ29IEi/rFbd +BgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The EFI specific SVE/SME state preserve/restore logic is unneeded, and
can be removed. Patch #1 adds some lkdtm test cases to emulate the
condition under which this code might be called.

v2:
- Document that BUG_IN_HARDIRQ and PANIC_IN_HARDIRQ will crash the
  system.
- Add Kees's R-b
- Rebase onto torvalds's tree of today so it is expected to apply
  cleanly to -rc1

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>

Ard Biesheuvel (2):
  lkdtm/bugs: Add cases for BUG and PANIC occurring in hardirq context
  arm64/efi: Remove unneeded SVE/SME fallback preserve/store handling

 arch/arm64/kernel/fpsimd.c              | 130 +++-----------------
 drivers/misc/lkdtm/bugs.c               |  53 ++++++++
 tools/testing/selftests/lkdtm/tests.txt |   2 +
 3 files changed, 75 insertions(+), 110 deletions(-)

-- 
2.47.3


