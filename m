Return-Path: <linux-efi+bounces-4709-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D9B4A483
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4957AA95B
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95295244685;
	Tue,  9 Sep 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJLeQMvg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FE23D7E9
	for <linux-efi@vger.kernel.org>; Tue,  9 Sep 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405208; cv=none; b=KMVA5JqnA4CY6UVwWQuF7Mu57fS9eKii5npulLkNXcMiV8m8ZmaDDxXEd3oL/a3AcC/4JuBmEqI5S/1iZdUkAcgZdIkcLX5iuLeNyVIA7C6d+KF7oZ6zAjr54giNwMGoK5NG0S2jvQAwyQ+msCM5l66BU3IKIhAvLDCsD5wORDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405208; c=relaxed/simple;
	bh=d+U0eD2Lcxv9wkXcTK+OW3RwnExlgkzA8OS4vnSNHMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aY3sTTLnoTjE1XrTCJifzteGZGvYp2F8E+NeEXiiZ+xiaHIvSeSiLKExxOvwyyJ4ZMnLXOetVsGKKl7N44Q/QKMYO3tMbjtEeVA2DvNCAwaSL0xkTdVonjlWfYdfhJMj+puHH6bDVt1k/0NI7ZBuWSsB0nBxW7xwjUai6nK5TzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJLeQMvg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e4a8e6df10so1620361f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 09 Sep 2025 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757405205; x=1758010005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lj7lB1schWgm61Svtbzr4eTVgknBz4beDUKMEIQ/p4Y=;
        b=uJLeQMvgMBF9H/i5F7UxmCDu/JzmHxg5jmO2Sr+MQDhAo7n6aCdeOa5gujhMB1Ait1
         ju+Wmhl2jUuQyeXWeNNhbWB1dtOv+RcpYNUCLGt+/k+tCePYhlOsFLTx4Rd7m2ypKxOY
         ATTXV2Q20QnVb39HBQGCDUTrp3xMuYiL/56Vd5Z3i+zmbTogH4u2GRob9wQEhK/ta4Ag
         R1WModOn8S6U0jsUEFPu/DTaMqfun2nKfPwfn/yNCltIrr+oZ35EacTMdapFYk274b28
         nVxzBBMhWVY59br/OL09rAZQ19cX8uxGLzihwPdyBeekkM1B8B+lySE8uiKRcJsh6A/E
         RMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405205; x=1758010005;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj7lB1schWgm61Svtbzr4eTVgknBz4beDUKMEIQ/p4Y=;
        b=Z6I8gtrYgcqCN/659O6GHJe2HwqNWmbKRjb9skgZISFnpVKRr1WMRPYxLIi19ODECF
         JHl7LeYZGVxlwoVkIkym33gqEq+ttujApPUsf++L/SXCflJXwlVKOnAF0FHLUO0wqRI5
         O98OstKRTDEcAewfDMy27HXNCY+ZjUnERLG+W74BtfS1bMzuN0n+mmyK50TLeaHYz4/F
         LY8TdA4AptdeE7gzwJ+HBoTu8nh8xp5f5LM8Fe1mXWi3NxKhi2N894SPNBOAilnsdauP
         JgG5/1SlLWx12inqSUTK5Gx225oABO1tPUNbL18kAnDlfimUKRXo8FWcLgmFmQKci3w6
         JICA==
X-Gm-Message-State: AOJu0YwENP+vHk2CVa+WDgFN/h8RWAO8TQW0jUiwNka27bF5DJKLS45e
	qb/5ZgWylpaKuyBcQ1BVwjbUpBMQkaffKPp+WPuwau5tuvYxl9+KEvi/MDNjgaizvz+Madxzc2w
	azf0OX6ooEROOmZNy5bKSRN5ey6nxAC0KT+BRsuzr8VBkadefDCfo8Vuo8TM05kEaeYp+LmgOyM
	TByHpAHcQTr9Tcq0zhyflQ9Z75GhrOsA==
X-Google-Smtp-Source: AGHT+IF4OTna4NACnPq+n/I1xm9kNRy09/XmtQj6sX9SDuKm85EEljFNhS1+t7H5b973gSnfiDWY/uS1
X-Received: from wmte16.prod.google.com ([2002:a05:600c:8b30:b0:45d:d60a:8d7e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2285:b0:3e7:4334:2afe
 with SMTP id ffacd0b85a97d-3e743342e6cmr8173379f8f.5.1757405205136; Tue, 09
 Sep 2025 01:06:45 -0700 (PDT)
Date: Tue,  9 Sep 2025 10:06:32 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=ardb@kernel.org;
 h=from:subject; bh=qeieuoLZLIUqSRVQV57BfK2vQHUwDzAPKV2E97/EPQs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWP/A46d3fnXnq+a7zCHocb53X590/4ip0dxFuXt1mGh+
 hueykR0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlwrWVk2NA4Y/+CM8rfi2aw
 RrCVH3HVOr88TNfze6ikRrXI+bZDGQz/I9evYF4ak3uE5ckE9u772xucy8tmuMn8ljy8uqBu610 3JgA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909080631.2867579-5-ardb+git@google.com>
Subject: [PATCH v4 0/3] efi: Don't initalize SEV-SNP from the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI stub no longer invokes the legacy decompressor, and so there is
no longer any reason to perform all SEV-SNP initialization twice: it is
sufficient to rely on the SEV-SNP work done by the core kernel.

Changes since v3: [2]
- Drop patches that have been merged in the meantime
- Rebase onto tip/x86/sev

Note that the issue pointed out by Tom in reply to the v3 cover letter
has been fixed in the meantime as well [3]

Changes since v2: [1]
- rebase onto tip/x86/boot
- add patch to remove unused static inline fallback implementation of
  sev_enable()

Changes since v1: [0]
- address shortcomings pointed out by Tom, related to missing checks and
  to discovery of the CC blob table from the EFI stub

[0] https://lore.kernel.org/all/20250414130417.1486395-2-ardb+git@google.com/T/#u
[1] https://lore.kernel.org/all/20250416165743.4080995-6-ardb+git@google.com/T/#u
[2] https://lore.kernel.org/all/20250422100728.208479-7-ardb+git@google.com/T/#u
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8ed12ab1319b2d8e4a529504777aacacf71371e4

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>

Ard Biesheuvel (3):
  x86/boot: Drop unused sev_enable() fallback
  x86/efistub: Obtain SEV CC blob address from the stub
  x86/efistub: Don't bother enabling SEV in the EFI stub

 arch/x86/boot/compressed/misc.h         | 11 --------
 arch/x86/include/asm/sev.h              |  2 --
 drivers/firmware/efi/libstub/x86-stub.c | 27 ++++++++++++--------
 3 files changed, 16 insertions(+), 24 deletions(-)


base-commit: 0ca77f8d33e8136b8926775380506f78a8d04811
-- 
2.51.0.384.g4c02a37b29-goog


