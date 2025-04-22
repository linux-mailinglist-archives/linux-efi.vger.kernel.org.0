Return-Path: <linux-efi+bounces-3421-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB0A97829
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7173D1892EDD
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329F2D3222;
	Tue, 22 Apr 2025 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4vEE4GW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5D223DE0
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355922; cv=none; b=sN6SWb77T3CeOCielEFeqhPA5e517tyDqULs26Fssr3vXCIERwHL0ZoP9MuBYCCM/c7AJrg/6z0jMKUG+qIuGtA/eLfQo8gBDRB21gwDXqp0SjQv1b6HcxryOpAXfAjcIBPBBTnYtGmEHbgXpi8QTatZ9mllSdpk8c7FGTWnXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355922; c=relaxed/simple;
	bh=v+uRwsLHOmfzDIF0pS527DuRyohTPzs55tPRSQDz0WU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A9r8pzySuVeNSz36UCdbS4QyLF8wc0397FoRMs8jI6XOt0O/A4KhMOc1Gh+84A/TKfuL6jBYg7He9fZSZGyTOd5sTNiU8eYBkKrwKqw88W3e5088n4m6hGO9N7xocs/aZ/pPd3misbl2GgY7Kwa95Fnw0EfsZOxoAmxXsLJmx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4vEE4GW; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so42245225e9.2
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745355918; x=1745960718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n3xzr97fcLCVm/TFf8Ltlpp7pDJFo4k3zJ++YTMvpc4=;
        b=X4vEE4GWloTFkz7UCl4A9lUXJLfHm5wVzrpWk5CUxwIwIqaXX+BgmKVavc62PuCvbc
         5a7+tAIWkjjQ3vTxwuJCygl9vTDCMFxey0o5wqVlQD0tbV3uDJhgFmfecdB62oRWFODE
         erxpMw1/SmQ12KtzjxxfWZGOx2IjiHKGJJSQTZxj01bEG9oLNtKw9luF4ZsTog0efPxh
         Qw3mH5lkuKpIBB7/MZh1yEPG4LTrKA0eX8cxbYV1r2sdpYKvY3CUL225wW3N1/o3QNGv
         cbwBG1tDyG4QAP21L70aMUagQwDGO9NL+CgOUudcyETAq+XK5Chuq+Dti7aF9hm8w3K0
         kRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745355918; x=1745960718;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3xzr97fcLCVm/TFf8Ltlpp7pDJFo4k3zJ++YTMvpc4=;
        b=eh1mrUl7Fe8qC8LeAAiHVF3E90z8Dl0LDC0kiQpsnRPl6ShAqhp6Fse4wKzV3aeDgW
         Kx9hxBwi+sh9tdUBmqHpQ61KTrFO+0nI8jEsV1XKqQnNLgarTigE7KEnTrN/qORMzsMh
         zCN/c0/BQ/woR7tTKxmYG4l458+f/OgXJuHl/ZGKXRm4pVSsCbs+zxUSSySEiyJa9ehE
         XlXbe9uUGd7HsMLRXFZ+CaHh1Pnzn1+b6oo7L44mRrQDnrUXnuaTR6UmRSKfiO11VYHO
         5FoMjYRnWlIQx6z7+fDccPCeqvtMcEKmEXFj6FxwESo6KxCdzyTR5Y/8LzY/4+KWq2D7
         aekg==
X-Gm-Message-State: AOJu0YxMd5dMosK6MJs5U4a8Duk+2Kv9EnuvaPYPN892nktzLtSgl5YJ
	UHLFhiJAktPi8J4MNL9SNzJzRmn0XhOzK1AA2w++YtpytxOi1eyXvYwSpvxj+bcVvQGUNw==
X-Google-Smtp-Source: AGHT+IEbPr6RfYyB6bDIsqR5ctTWIiR1x5gwGJliOycccBzchng1hfEmpr+1CfRO1M1GeUqnfz2YJHoU
X-Received: from wmbfo18.prod.google.com ([2002:a05:600c:6912:b0:43c:ebbe:4bce])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3107:b0:43c:f64c:447f
 with SMTP id 5b1f17b1804b1-4406ac163bemr114862075e9.29.1745355918724; Tue, 22
 Apr 2025 14:05:18 -0700 (PDT)
Date: Tue, 22 Apr 2025 23:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=ardb@kernel.org;
 h=from:subject; bh=v7Nzmlu0nL1IVS/E9VJILt/bwvWjc5W8Q425XyUylHY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYODpV1+x41zPoJv/pRK3okt3bQp0KTygdupeqE//7Ieh
 r+ekryxo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkawXD/5Tyl1P0Jrm9S704
 6fvXo9G8Ra/MExcae8r/7qg+OC+IIYDhv8eXaMnf1ySzektn2jDJX/mTVDGpcv6hp3KO/oei/db u4wYA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422210510.600354-2-ardb+git@google.com>
Subject: [PATCH] x86/boot: Disable jump tables in PIC code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, mingo@kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

objtool already struggles to identify jump tables correctly in non-PIC
code, where the idiom is something like

  jmpq  *table(,%idx,8)

and the table is a list of absolute addresses of jump targets.

When using -fPIC, both the table reference as well as the jump targets
are emitted in a RIP-relative manner, resulting in something like

  leaq    table(%rip), %tbl
  movslq  (%tbl,%idx,4), %offset
  addq    %offset, %tbl
  jmpq    *%tbl

and the table is a list of offsets of the jump targets relative to the
start of the entire table.

Considering that this sequence of instructions can be interleaved with
other instructions that have nothing to do with the jump table in
question, it is extremely difficult to infer the control flow by
deriving the jump targets from the indirect jump, the location of the
table and the relative offsets it contains.

So let's not bother and disable jump tables for code built with -fPIC
under arch/x86/boot/startup.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index e5f77e65c083..4062582144f6 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -5,6 +5,7 @@ KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 			   -Os -DDISABLE_BRANCH_PROFILING \
 			   $(DISABLE_STACKLEAK_PLUGIN) \
 			   -fno-stack-protector -D__NO_FORTIFY \
+			   -fno-jump-tables \
 			   -include $(srctree)/include/linux/hidden.h
 
 # disable ftrace hooks and LTO

base-commit: ff4c0560ab020d34baf0aa6434f66333d25ae524
-- 
2.49.0.805.g082f7c87e0-goog


