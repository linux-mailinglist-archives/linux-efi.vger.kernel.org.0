Return-Path: <linux-efi+bounces-3372-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474EAA93877
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022651B64598
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A6172BB9;
	Fri, 18 Apr 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAtTnivV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9519AD5C
	for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985660; cv=none; b=cQ2t3CNXZwOeCW0eGDg1n9XZGoDFvLx6KhrW4y6W7ZKQj8fBMPAKKaD8nmzqLI4/ExZ/ziL4I4N95cG4iSduzw3MRzz2VLgTB/ilhB3+GxfkSIfTf/EcIyCLmGEaCkL/v+K4a6yeBEZNtLgPh7mmw1qCGJyB7TAEihkW/AyimOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985660; c=relaxed/simple;
	bh=P8pu/9E1xefDMZZYc1QzgyDKcdk7pIPUuqOP8rxmA6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LUpusZ10g016xPPASa12B9Sq4cygAUIWo1AAIiw1HNxb0V03U7I0xVe2kfwGGbwjO8D7G/0VmXFsuuPEwL0QcRXEXeOyqvCrDCrvRKBvvo3As0T3fKZ9Ypq3Dr27HWLwJEBb9y0QmIgKF05SXq8KG1GPIJ9GDL/MR717heAoyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAtTnivV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf446681cso10194555e9.1
        for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744985657; x=1745590457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwq5+n4TNOnJLSHAnNrr28KvD6+ZPBpkE676KvwvyKw=;
        b=XAtTnivVR5cDqWBOxE9AQxqO8CBsM3dMW8/eRljW/Y1wg8ulzlXbcyiEv6ktrPZSAF
         zuaDWJ8FY6A7n7mMefZukmjALERpRUlHuJTSShDpa1kdY38eXxhiDPVYMLdSBRoXPP3Y
         ZNHGWtFTkN1ex6my4CDoSR6W/KtmZsLV+JsMuNilmzucqubRCnV6N5/4inJxr73SIBx4
         MT4aEtWs9i2H853NdX3vJjA9TtEgvDL9ZM8cBsTLeLQtZ4g+HwoFdHglvyoZU7Stldj9
         D1r04n37wFrrHyPGTYPatLJCsHMgWajee/bECTPcIVnB5fQjI1W575j5Cb/W4dCJFSDY
         uPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985657; x=1745590457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwq5+n4TNOnJLSHAnNrr28KvD6+ZPBpkE676KvwvyKw=;
        b=IlK25fXkHQ7HwhoGLJ1x/AzVeBvnA/COHIks5wb7NOcAoY8ONNsmyLWB/uZxHZvfmC
         WTu9I34I/N/8vcGBA6K0mQLk31a+1WQ3LGLXJ8gRc6AgKHS1/MIRnLSgifCf4MbKwc9c
         Mrp94wJ4Kb4HLwRydQW4+zxYivllUluP4NE9MvGXHiZyo5qaVwaon1Dxa9p9o9S0t7rK
         NYl2j3Wt4LLKgmE6T/EyjVPawOULHB8Lkq43uQ+to9BYwKsmRNwaLizQc+hYAf9ShVYM
         76fTVfsyml6Howl3o+mdsGJx3B64xN+segsQpKMi7mKmtd+2VwCQg77L8gdI/OLvgs6r
         vAaA==
X-Gm-Message-State: AOJu0YxCgb/ilrtq46+kW7J89n3Ew7Ktq494iA74RmkKIG7fSCt9lQHB
	SohmMgGMXzcS8tZajYVPussIr/nfx0JnQQIgPI68D21DqB7TyKQK61ZYero3sRXKDUzotA==
X-Google-Smtp-Source: AGHT+IHQmR0+d0SQj+FIUVGlBmX/KKxhLHvpdzBymx/b4+HbD3xXpMpSHJ1AAbFfWRrXjjGskSBwIeNL
X-Received: from wmbhc5.prod.google.com ([2002:a05:600c:8705:b0:440:595d:fba9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:47cb:0:b0:391:4674:b136
 with SMTP id ffacd0b85a97d-39efba5c519mr2112808f8f.29.1744985657393; Fri, 18
 Apr 2025 07:14:17 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:13:00 +0200
In-Reply-To: <20250418141253.2601348-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; i=ardb@kernel.org;
 h=from:subject; bh=QeUiQEC4SC9V7bn5Rj098gGbfj8IuyRML/M6fUHi+QM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMp9t2rMxZpvq+mvHSYFMW+40lNl3Og3P+LTUyPGLIqY
 p+uP2zZUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby9QPDT8Yr12/eyoya5nby
 pvoLjSkXVnAGPrpSbeWa6LVjcsGV5f0M/6z/9tlcaj0Tyt/6V2BFpdafBKVr7z1NnnmrCaTzPGj ZzgYA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418141253.2601348-14-ardb+git@google.com>
Subject: [PATCH v5 6/6] x86/asm: Retire RIP_REL_REF()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that all users have been moved into startup/ where PIC codegen is
used, RIP_REL_REF() is no longer needed. Remove it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/asm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index a9f07799e337..eef0771512de 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -120,11 +120,6 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 
 	return p;
 }
-#ifndef __pic__
-#define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
-#else
-#define RIP_REL_REF(var)	(var)
-#endif
 #endif
 
 /*
-- 
2.49.0.805.g082f7c87e0-goog


