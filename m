Return-Path: <linux-efi+bounces-853-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C98870C0
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 17:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C581283202
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73541C6A;
	Fri, 22 Mar 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcUQwXI5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A83FE28
	for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124285; cv=none; b=rWx0+PWdVmY3fa2ImXmHszbpQKGFbNA8/ABdomy+meen4UfJWsX5z/i4WHIb4sCURCg4eDyM02sbYeg6nzyzzORJFOmpknNeSeHcsrGausu0jVFQsGLYYp+NCc2uMuWh73LJqSgk1rc3kBQHF4gryR7FrCNLFtkGffLnSm0PuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124285; c=relaxed/simple;
	bh=U/RW+p7Ayzd5HuLDTA0oLqdTtnVl+uvtvLYjf8iRvLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DhrX1CLVh1UPUiSow0d/RzM4YSvw7NX/ApW6LsnuvRs7Uj7mrFkhxxGYulGpX/u6SnMLQIS2kuvJq4rtSN2LB+9qOsyjCizwBKlt+4QAP4Q3I6eaP8GxiuOCcWVOgWrbAvNGaYl8qETLRLeSnzD6WyNbEMBQS7JA8/+wJPahUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcUQwXI5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4147f96f58aso161215e9.3
        for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711124279; x=1711729079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1EJDfoidssQnE6NuSKywkoVkgyAyd+tPg8IDGSTq5A=;
        b=fcUQwXI5/49S55u5jmjyjNQqH4h3tog6n+SBo+E9zLeTf82fh+1vI02czJuaLJmIuK
         ROkEv1TL0wUV+6qtyosjuo0i++Dyfc42ru73Z6Sd3rsCCiYX0LqdnKNUHhowsoIgZcMi
         EtzEklnq0SVlpCcwBww/D+e168zUKvbB7ryEethQDKdH8kRuXGHy2H1ORNApA21t1ytY
         UzYaiZuS9HEjBghYGLwZSMdvSv4ZtFtzE+EnEZ8gFv6qN4RNB+zYZCDU2JRSy1Nc2ccc
         dgI/2h4X4NS/keyirMFCIAIAfleqmJGsC30NY4mM1YJpnB4W+HOzyqRreHBmqcvBCh2n
         BZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711124279; x=1711729079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1EJDfoidssQnE6NuSKywkoVkgyAyd+tPg8IDGSTq5A=;
        b=I5YfQACwQ+hlijqplJFRrpckzMR6es7INk/0EW2xdcbEKUPPV1hI/TOZxGhk9kWBC1
         /7Zj0Dio2q8/nL/YFVkMKiY2rYIQXW1ydPgSL2zppQuhzezf/n/z3sI8400QXsBaGnUA
         mMlzAgRXpfx6TrU9cuhoP/HmtNOnHGCKGIXTH+dPMlnCOgTtIl6ZMyBj8iUE12pg83rF
         gu4N+f8yOdGfv1eq7XhrxsYP03DrRNEuLK2ZzS53BWppABX73gLtytKlArpGlgNa3LjI
         d2d2zJkgNDnQpGa6lAKGflfiol9K+N75Jwj/VcDf+4AH9WDeEbjG+M4lMFhWhiJEtwci
         WD9Q==
X-Gm-Message-State: AOJu0YyZZ/XcgGqfcSqumtqJJuaBYjjTd10hQcfTy+LS6w/85qkFVM6s
	in/uCKmVs+V/RdFz41HlbkJs0s49cN/lAplG0oxtuY440Em0pPduetp7Sv4ZCGvIcsBTVNOjr3t
	d2nmKMdXjFHEjF+Qf/HU2LzAZvJ4jiHvgNoXItpsCLcVOIsp3MtFwawWktIn7CMRDw1T1wiWe2y
	jmRgSVEcNU+nPgTM5kZGRDWycV4w==
X-Google-Smtp-Source: AGHT+IFvIOavL+uzvRlNlt7FsHFI+bqN0RWOc1x0NCrsG9IT+4Hw8mBxCEGGjtMAOn6JsW+YmkU46iPD
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c9a:b0:414:7dfb:8503 with SMTP id
 k26-20020a05600c1c9a00b004147dfb8503mr22260wms.6.1711124278668; Fri, 22 Mar
 2024 09:17:58 -0700 (PDT)
Date: Fri, 22 Mar 2024 17:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=703; i=ardb@kernel.org;
 h=from:subject; bh=3LqXZN/yDnfbxSkZwJJVgHKRhoi44PmvbEND7QBya8c=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXveoPYuA/q//dZKLZ2npbr2Pn2XpzxrrD5eYxLjScfn
 nreZpZuRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI/zpGhs/2ydd7RLKaF+Tw
 nTuz9GDyi837uqQSOf+wRHg528d2FTEyHF0r2yg5l8frft3VA9uN7Mx0ZbIYWxpYLi86N3XyJn0 DHgA=
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322161751.3046943-4-ardb+git@google.com>
Subject: [PATCH 0/2] EFI mixed mode fixes
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Clayton Craft <clayton@craftyguy.net>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Two fixes for mixed mode:
- run EFI boot services from the firmware's stack, to avoid overruns
- don't wipe BSS twice in mixed mode

Whether or not this fixes Clayton's issue remains to be seen, but these
need to be fixed in any case.

Link: https://lkml.kernel.org/r/20240321144541.GD8211%40craftyguy.net

Cc: Clayton Craft <clayton@craftyguy.net>

Ard Biesheuvel (2):
  x86/efistub: Call mixed mode boot services on the firmware's stack
  x86/efistub: Don't clear BSS twice in mixed mode

 arch/x86/boot/compressed/efi_mixed.S    | 10 +++++++++-
 drivers/firmware/efi/libstub/x86-stub.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


