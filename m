Return-Path: <linux-efi+bounces-5920-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1CCD8FCF
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 11:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A544530399A7
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DC328259;
	Tue, 23 Dec 2025 10:56:11 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3632C309
	for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487371; cv=none; b=bG2HzrJ4q3qInCav98T0exTElCoRuGjuoc+t68azwvKaDILhevqGHe/UojKC2iViP3yUULiZy0BAx0JoXuyiWQpJfwH1x1HuqFCIcTEfoxgvsgPpfnFiG3oosLURl/SZ6sWX33LR209n64rauI8s8MHpeIghHzSR64VLwAktYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487371; c=relaxed/simple;
	bh=JVkzh6Mj6r18BxTCZYOIUvNWS/o6kmzf/4mUqtZjoM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GG3C/4sN2BF7dX0ADM983ldKlItmzN+l8wlO5qVq4bblpXfKLk3QWXFxdGU8GZKtkc4FGt6HSmF1+7yMaoshtvsk38DkT2HmZzM9e2ZVncv8Mpb+ADj0/LrLRq2uzDjGVg6Nej+3EeLEUSoqhFNLOYGpbuwAMj2xdBN23oHd2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c71cca8fc2so3010261a34.1
        for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 02:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487368; x=1767092168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t1lrhud01Tkkm4DNq9b9beIZ4pRUP61WPiTcci3k5Fk=;
        b=aMl7JsKG6FRWjOsrkSYeyI0zAKdLzuPS1mFehe0fXredWlfXdUhjPKBXh+X/qe7B7l
         D0RhnXMBEFRXugMalISzyIrqHJeNWfRwXv1UPldeeY2oh7Tm8g8KQUolgJdFC1XlIl/s
         3VaN+hgwHQGyDVQhA5h4kXqIrudxvjKMd3/+RpnKzgRXck7dw6nUyrLEiOAmWdn+ECqz
         Z6+uXY9xziQXGNM9/uY9kMmpW+YWI3gQKQDk69uY0zMdcEVBMaDq4HjE3tlRysGmFSz1
         m6zY431HvZioUxOoRWF8Ykyo8wdAQKHp5AWWWzqgO0c0kX4Nfpkg9BL+TLWOkhOtJq+L
         oiwQ==
X-Gm-Message-State: AOJu0YxmypUx6YL76HMgdU2t9dYNVKiEift/2/17HRBFzMY6hp47SPvw
	gVKzAhgFha3YHRn97Fr0O05XbohKvGS71YOP/X2Gtgh0NkL3DqHkBmy2
X-Gm-Gg: AY/fxX6V5d5cG6L8Nas3PToqNCL30DpEG3jKUX1xvkq88nmACVd0+Agrn36e4MwfMjF
	cWCU6xdc5x2hcnAcqhd5awn8IlTvyK47kJhdUa856jVuhnn6bGZ6PKn8OBqVHf+c+g3dwEZMlYZ
	EfvC5ADfa/AjGVpeU5MZWHvjyV4/pyJZGEtstrPwhvB9AyaEqrHbjn6xTmd9QTKv2jtfzrzxVaJ
	R1g+p9g/9fSv8bnVV9KHbqzn2LzXCexfvETtqyQiXkrnFNF7N4FLXRPBi7s5Y/xB8vVdOatqiKf
	2LsEEbhoRtSd+ob3BiqaPN2kY5+kWovPZLfk5Ow6tVqeJz+fz8JOzt6KHSeLFAUElJoQsKxrCWG
	kxpaZonP8sm3c3SyjJuIV8UHaq0rhzaiE+Ye39qVfMwNKW8gEzm8/7bj9UJYU0ecgtdXX1rU+6z
	UvdjD6+fLjzTf3Zg==
X-Google-Smtp-Source: AGHT+IEEdQF/gHgq3UyLobX8GobuVX0tUFKwYAoMjIMFsmgE4CYjBTAFdX7i1k9CtrdDm1Wa+O8GLQ==
X-Received: by 2002:a4a:de8f:0:b0:65d:be3:311b with SMTP id 006d021491bc7-65d0eafc4ebmr4785903eaf.78.1766487368481;
        Tue, 23 Dec 2025 02:56:08 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4c::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f723ab6sm8713620eaf.17.2025.12.23.02.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:56:07 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 23 Dec 2025 02:55:44 -0800
Subject: [PATCH 2/2] kthread: Warn if mm_struct lacks user_ns in
 kthread_use_mm()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-efi_fix_619-v1-2-e0146b8b9d73@debian.org>
References: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
In-Reply-To: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, riel@surriel.com, puranjay@kernel.org, 
 usamaarif642@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=leitao@debian.org;
 h=from:subject:message-id; bh=JVkzh6Mj6r18BxTCZYOIUvNWS/o6kmzf/4mUqtZjoM0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSnVE+bi2ZoQldtZ7u8jeYGlbnlyMfIcy78o4u
 qgOXEr0OzmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUp1RAAKCRA1o5Of/Hh3
 be7LEACHOsztZael5tTqpe9CNoDWhqU8isXgl0v5yAwcqk8Fjm5MKLgC2z7XxxeuUgCxNF2dQba
 3ZNyA7Xh/twezTl30dyVRJX+pW3qbfL5irGxa1AV5ua9kSUObxME9BJRk3AReZ0+v+/Cdv1NIbm
 hYeTxSZg0CBZuWtWvtB2JkNna3nH954ALoHtSiHdSzAI+JBIXvbwP/6bHrhzBioX8g9A+JRbkXb
 DZtAnS09cTmABI/gYH3ydpbK8zM1ATWLIH5cVVm6oGHT+/ocSpW98EuJdvwV04VcUr6S2wCha9v
 iULKzhEB7ZJJvA4e+f2lS8Wol22Ka52YSCv9WTUa1lJKhhR/JQi5niFZoN2A7+qD2oCyjUxbKj/
 Z5W+R1fChfCj1Ak91hQCKiYh0QHa3Sy7q5Emgo8hvsEekSTwRd+H3lfZaSgZ2/pyGSwkWh6myh5
 IxzvT0EWz83bMSv1DPXp0wEOdvLFBzRpo2lOEzrtjsIPoMx7v5V0L5p1XrLrt1IdDmV3MMs7Ijy
 yD2Mcu36gtbS0aukBFiGH/E57s2DMKGS3mFcvU57Ug4BQMo1eFcBRbAu9jOvdi6r9EUn0p6oaEb
 tyz6zNpBvpfoFJdwrZ5RMszVcrHK8lxuJqPrcbz6+RQcKL+A1lRn/H+9PA6wOcYnUaYvT63Su+f
 MnT0qjGWX+M7iVA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a WARN_ON_ONCE() check to detect mm_struct instances that are
missing user_ns initialization when passed to kthread_use_mm().

When a kthread adopts an mm via kthread_use_mm(), LSM hooks and
capability checks may access current->mm->user_ns for credential
validation. If user_ns is NULL, this leads to a NULL pointer
dereference crash.

This was observed with efi_mm on arm64, where commit a5baf582f4c0
("arm64/efi: Call EFI runtime services without disabling preemption")
introduced kthread_use_mm(&efi_mm), but efi_mm lacked user_ns
initialization, causing crashes during /proc access.

Adding this warning helps catch similar bugs early during development
rather than waiting for hard-to-debug NULL pointer crashes in
production.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/kthread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 99a3808d086f..39511dd2abc9 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1599,6 +1599,7 @@ void kthread_use_mm(struct mm_struct *mm)
 
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
+	WARN_ON_ONCE(!mm->user_ns);
 
 	/*
 	 * It is possible for mm to be the same as tsk->active_mm, but

-- 
2.47.3


