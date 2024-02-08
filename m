Return-Path: <linux-efi+bounces-495-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF284E509
	for <lists+linux-efi@lfdr.de>; Thu,  8 Feb 2024 17:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8CA281D56
	for <lists+linux-efi@lfdr.de>; Thu,  8 Feb 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7149F7B3DB;
	Thu,  8 Feb 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A08evnEq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0857149E04;
	Thu,  8 Feb 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409847; cv=none; b=TajsMk7uZSYe83/o+LJwcy+ZudYU00KmZnu+b5sCxgF3r1bS/To/OdL7C99JIuPT7ygmjSBDH8p1Yo45Lcp51/8URfdwWWG19l4FxMO1s7HSGnY2yVtDW3z+6YnX355MOqfGNYhTake85FoY9DmTiGvQ7uNYZM6NSIRF7ktFwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409847; c=relaxed/simple;
	bh=3bilr2S0udUPWaP4Keb7VMbboD+4Al1FIMWs8mnwqSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKvStHMRVLRg2JUxr0hxiyJ7voGRweunqZ5G3ESkO0th1nsrCslDOmbX8jVYozmZzpFUXFTRUKYFnF4h3QNRXixLL+uDWYyipQHxs8k/oa1DnJZv05bu+HUFXfwRkyotWEt7xce/V63w0h9N7x98Rumw4kEOhfmcOvuJSLItqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A08evnEq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51168addef1so2966235e87.1;
        Thu, 08 Feb 2024 08:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707409844; x=1708014644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxa9gRUyNtVY4d25DKEEurdVqxnFvTfKyQlJDNPyYRI=;
        b=A08evnEqdvI3vGJ0ya35Dz9W4rc37Nen/QPR0eRntd8TVMmVxfthLYwguMshYYuVi2
         xL0CU0ZiS1SJ5jThQ06DrEvV+E6Vy4KGDPHouVrRTNzmXklDemwE8X/JP8Z5a0Qv12Q5
         l/eRrg/3Kk9By4y7QwElwFYNPNmpBmwX7gEfyymp0iDLODq5lJUuV8C9BXYR5vtuQwkV
         oFcPw18h+U/IfAtGw9wtdt+wjlotmovt8nEObvWApo3pimfIKIXDz4CRWcgp3yDW0Inp
         PpQPVVv6bC8LMo+IyNQlc2Sy8fvB6tNOx+3+H8v1gnqgSRe+M7FLxDzd6I9/eV2se24B
         BKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409844; x=1708014644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uxa9gRUyNtVY4d25DKEEurdVqxnFvTfKyQlJDNPyYRI=;
        b=eRWgHP8z5plBN2Jbo+O8fwTPeEegHw37EiAKG6SxJWVwASwv6iIvhHXQMq0uGJEAOJ
         Re/gR71KnM6fCYrgjbYJDFPAFrfyqxmD5KN6jqZ2vnjWxo8d19fpCKXjFez+zoe8iJkf
         XAnAYIlBz5U93rYO3SwPpEACoDvkoZAXbmsrSTkMdp6yJD47HZtLJ7ZCGaPDP9CnqGuN
         yCuhK2gPtHgHZstpam4f5icMSQoZ1h2cViQNMfJKMig9CkjwGSDMhc8HbzLjaNnhiQ2g
         QzjiryNqo91nzHKhsz5PhlDaq4cQqoOelh2XiRZb8XNf+YlVO2XmH9R9llnHPmvJ3PDC
         mBQA==
X-Forwarded-Encrypted: i=1; AJvYcCW8ce+uuEI562s4ky7tF7wPjfzuoIJqbf4aTMCq6l3f+kY7/kzv3AecOQlMbwbXMUfIOfepXv3fA+N4xk1V2lG9Gh7cvYI/pk4yTFX1
X-Gm-Message-State: AOJu0Yyp9CmLh4SF6d0RPrTltUWpt9PAqzGShmKrU+rCuUGILFxohGvL
	AXUU3xlK9JYZZ5EQntQlrbNywZe3qJE9ObS01KOvZkeU/OLlIrfT
X-Google-Smtp-Source: AGHT+IFRTrNOiDNAkl7Kzj4zgqs01IlH1M12+NivZvsOx6PgF9lvS4AmTO6WrVnxxrDOhESB0Ar3tA==
X-Received: by 2002:a05:6512:3d0f:b0:511:1038:dcde with SMTP id d15-20020a0565123d0f00b005111038dcdemr7983918lfv.52.1707409843453;
        Thu, 08 Feb 2024 08:30:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvGrDev/EPYsh966CkRHUxwlOXevKgPlp3sqo3VizOgc2NpvOBmUvJLBI5hJmW0zdG8Yr2SIoOBsXAFdieoDkwBoAGLnQQCyFnEAeAY0XqqnamRlVIpT4NW4hEPETqusq51faVejps82QtAKqHDNfJk7cgB6Ob6sLfRobRGN0FQr3HgR+jWdHPmuv0l1J6D7E9IFoZ2zCNvYhOWyL51Ce6cXTRM51dLBpWsDEvcjq1rRZjf8sJa1vBRHt0YFMO4N182mC3P/bpeeLKRoEPHTIOC3rHQWJWJJqFzlkhfL8UL+6dRbGUAM4sSytqeu2d
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id d5-20020a056512368500b00511602c50cesm41809lfs.277.2024.02.08.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:30:43 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: ardb@kernel.org,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	alexghiti@rivosinc.com,
	palmer@rivosinc.com,
	arnd@arndb.de
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH] drivers: efistub: fix typo in docs
Date: Thu,  8 Feb 2024 17:30:38 +0100
Message-Id: <20240208163038.111870-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves a spelling error in the documentation.

It is submitted as part of my application to the "Linux Kernel Bug
Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
Foundation.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/firmware/efi/libstub/efistub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..8369f3adcb37 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -221,7 +221,7 @@ typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
  *
  * @events:	array of UEFI events
  * @ids:	index where to put the event in the array
- * @event:	event to add to the aray
+ * @event:	event to add to the array
  *
  * boottime->wait_for_event() takes an array of events as input.
  * Provide a helper to set it up correctly for mixed mode.
-- 
2.34.1


