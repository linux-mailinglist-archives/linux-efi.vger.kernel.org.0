Return-Path: <linux-efi+bounces-5491-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5147C53D57
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 19:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07723B4FCB
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995CA34404F;
	Wed, 12 Nov 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7XS0Zyw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1313241695
	for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970011; cv=none; b=m0OtCDjQB8r82xx4+IKS6b8YvGtcPcKzvVl7KtoXyDj0JcdClDhBbmbuB7+nyOlpx35FUCcq0RER/J/Wog1wmSzA8q3mWVEMaFlz8Iy8eN2IJv29K/SrEZ1An+irIZf6GW0O3/pkg9AKE8j8ElFWl8GC5divT0jebvMDPHiKPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970011; c=relaxed/simple;
	bh=7I4LzMofdKoP1sTTMWy7AWAOrp4droN6xfs+9bF0ADc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dEu5UAGf9iVuLfcxoaSjkIWXbDTh9xp3XpeiqC7Vi2k3xYNJzcbGjAuy0SAj78J1WW01RA/5SF4YQm3G/0l6dtu2z6x6oP5UF3BqUrISlbWKW+FA2TV0zrdKTjjaqofHekKMeQz+Fb6Iwbnuun4jN0YYNpKQzrskufZizt8h954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7XS0Zyw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475c422fd70so8010235e9.2
        for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762970008; x=1763574808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M1eCAhXmDr9+kBNATXdCTz8d5iMFSVRFKM18smgzemg=;
        b=e7XS0Zyw1/IySRTJuNukfpTR12oq2RbfmxORhwDjskTkWBh/NUIGy1FE9YB9h03U5S
         xajgKCC3Mc0YzLnuOZ00lW2vADspL/BGbdELT5J89KFTQBNRyG34lhHBqDpBLtfsO7aH
         7mhhHf0lPtbEi9oOp7IRyJ0wR0evr3AhXqDZiSt7wgffQqp+8VhcJAxt2C1xXulgqzmu
         F7BzOWAWwwWsjH7cg0/+b5JjSplMIHARvdmPGdmPLRUYE+x8d4qKHt6SPc3nUdAA3uBy
         bzbIAXGQ0nIO+z0hOfa/ESMn/ea5I12JGwGHeeVaEG1vf/5JkG1dlP3Kl9GGZ0qMZZIn
         0bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970008; x=1763574808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1eCAhXmDr9+kBNATXdCTz8d5iMFSVRFKM18smgzemg=;
        b=BDHNRe+O+qDh4rnHjGGLhC1yzRV0KDm/1d266NW7G8Zpe6Qjeth55qTxK2eZxAZRZL
         v4nBwYium9WtJIhOM4gqSdzOLE7Jcg9amDP57VLhflSVuSwGeyXoq/p/ok5tqOzdr01C
         eQcjAy3eIEebB06hKmiFyLvW5HtRo5sjWInwXRaMmzvykfBn8Bv5Rd6ii4FgtJ4DcBx5
         BTM4x1PL/8SQIa285tcVYp240bNCYHLuC4Cs6ijpgw1aWzTpgTqrCP4zcd6ACau9/o1b
         KF5+vXiJtddKzUtzJvMWLszKtEZvyGZDV9yx79Pw9T33o17j9yNWOiTBhwxCeR5srYxu
         BBIg==
X-Gm-Message-State: AOJu0Yza3Xp2L1BuK5jG0QIw2FbIzEiE4KmzclrDan+rXxCSolzG3WKF
	nSw5Bb6VYXfwEEvHdnqaEu2dwa1IwagonNe9tEWjjFEXBHJcV+EdSO+KJyetvavDJbpS7LqKVg=
	=
X-Google-Smtp-Source: AGHT+IEebGJGBdHFsjiiDR5eFS/gIcIUAP221Wu8xdiSKNctgoPGWLYMxUjGOPTCDoUPoQqvagm6QWkP
X-Received: from wmg22.prod.google.com ([2002:a05:600c:22d6:b0:474:979d:a20d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b13:b0:477:28c1:26ce
 with SMTP id 5b1f17b1804b1-477870413femr35612675e9.7.1762970008205; Wed, 12
 Nov 2025 09:53:28 -0800 (PST)
Date: Wed, 12 Nov 2025 18:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=ardb@kernel.org;
 h=from:subject; bh=OcA6f2ob9JexwbEKAOgfU9lLkm1nmoT5BKN+Rc8QMNs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVPkZO8+rxsTspMZEmK/NDTOd/rLNdEg64pOAff0YyzyZ
 Q0rMqo6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESM/Rn+Cngdzch9I/d1ntma
 Pw6L/JTj9JSFeebsEvS6cDrC7E1fLyPDt0cOs58aB3/KDpey+/IguqF2yRfvPPmWnzXP98/wMs7 kAAA=
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112175316.2841017-4-ardb+git@google.com>
Subject: [PATCH 0/2] efi/arm64: Simplify SVE/SME state preserve/restore
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI specific SVE/SME state preserve/restore logic is unneeded, and
can be removed. Patch #1 adds some lkdtm test cases to emulate the
condition under which this code might be called.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>

Ard Biesheuvel (2):
  lkdtm/bugs: Add cases for BUG and PANIC occurring in hardirq context
  arm64/efi: Remove unneeded SVE/SME fallback preserve/store handling

 arch/arm64/kernel/fpsimd.c | 130 +++-----------------
 drivers/misc/lkdtm/bugs.c  |  53 ++++++++
 2 files changed, 73 insertions(+), 110 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


