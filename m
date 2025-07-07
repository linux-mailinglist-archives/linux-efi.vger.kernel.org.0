Return-Path: <linux-efi+bounces-4170-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F402EAFB828
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A0C1AA2CB3
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A822CBD3;
	Mon,  7 Jul 2025 16:01:20 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2B22B5AC;
	Mon,  7 Jul 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904080; cv=none; b=AIP6jVNWnO/zg7a/JTUw0JzyemJmp8OdL79DrBmtf9Y5vxSBePeXxrpKLSbP9Apxlfpj4CXpYH8Y/INgx67CRMePODQUeWNv7zRPtMWL5hY8OhuXbIJ3S4iBYbP16pkhL1fCzOPxHEHPW6WUP0Xu/hrPYuHNcoMqkm2KD/ibxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904080; c=relaxed/simple;
	bh=Hp7HNGXV/MgXNjT6THHxJ7gOgkHDeA1sjiSWQuHH9+4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pwWh+00qdcnQGXQ9zwrktAKSB4iE5VmSEjvVutPb800ExnXmNwqU+D+9ncUtFnHnw9I9hZUSh2QziFwA97j8AXcDDVfvN0VbSQRMxeUZ4cVZTqlTR+HeqPeBReEO7ozGF//mpYlfD7+o3D4CPQgFAe0urdl6kuNiHug4Syk9hhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6facc3b9559so55455656d6.0;
        Mon, 07 Jul 2025 09:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904074; x=1752508874;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7hosWBn35t4Uk2u8zfbBq4Gr7N31VV3afuofXRc6qA=;
        b=Yj1xwn009pCP2LMHmbFVhWSEKfTMLz/NU4fKvBRvANXUhISrlNdNDiJbisThl5gyJg
         AENXhMDF04qA+ApQOGbkuLsq8l1rNSpnSYm3a5VwlZXvEJaaGh+5ddSQXEJRmdGeqCBd
         O9Y3DruofwaJKLw1sVamtVrKmMuAYdw5lPGj7C6erMyHsk62BNRYDirmdy73KhJpbKLL
         voulC03B8eTXMecjoVWe4kcSyAHLOs8pusWNK7OauUtKDpDBdDFhUxkb6KgzibjHm6fx
         emczLviVwt3WJi9AsrAlQAypPM0QEtLoBWZ+LOxZhGSAdEP89d8+QbDSdwmHVzZkJA4k
         loUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYP2CunOAZiTdAcUpSMaPTFpOo/hU5slBk2rEH2Fclq3Hs59l/M5h5gZQOUT8t7UBpNZpZGvSoV0xVZZoG@vger.kernel.org, AJvYcCWiQ74F/if8Bc41tLAU5+ml4F4TfCuHv1xSWGkJ8jVNoLyR4ajpbMKBDOSuSZ0zo8yKfUKzqLuclFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaF1bfPy2nzaw1q4ZVXQ1ddHfv/6rEFS2STLvqXQfaXBjnNKQ9
	MepaodL3BypD6Xuu+JIL7MQ9zd3Wzo/4aeFMECxho8xxN2qfZiJV5js8
X-Gm-Gg: ASbGncuJsTKITuw5QXMQGI2EyK5cZ7NMzE8oq0lvLnaKCMKjX9YkQWQ4gW4052GmOMa
	XATaNldsIeJLEQpgE1EmNSd3VohvH6f3A3xelHsV9ez7HTUDjBX4w1WL7//MwgkFPFtThmaUtVq
	/K1XM5aMfMVgIJBhHmPcAvqenzKhZ4279ypMZP7jZHqlQr9cQPcQKxTghbCPtdKMcCx9YP4GBIF
	bKe5+41i9XN3JoPHcC+6ukeavGwKX/gFWhU3aujEMtOkMtYhWe+pU9fMRg0ZnTOkBDVhHmCruzj
	l9bZH6QLsoQ7qrm8K3f68h1ZBH4AENcWzSlUfDkOw6OzISDuOswYHIEunk7S5is=
X-Google-Smtp-Source: AGHT+IE3CmPzV/fhqf7jC7u04UVH+5AgGt2F4Bb0kNv0jDOEuc/afA1koRlX0ZFh4r2J4ny2rBHCog==
X-Received: by 2002:a05:6214:301a:b0:6fb:5ac8:2b79 with SMTP id 6a1803df08f44-702c6d3338amr218150046d6.19.1751904068420;
        Mon, 07 Jul 2025 09:01:08 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:8::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc765csm61512726d6.24.2025.07.07.09.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/8] arm64: set VMAP_STACK by default
Date: Mon, 07 Jul 2025 09:01:00 -0700
Message-Id: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzva2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNz3cSiXDOT+LLcxALdtERzg6RE42TL5LQkJaCGgqLUtMwKsGHRsbW
 1AI9YSptcAAAA
X-Change-ID: 20250707-arm64_vmap-fa70ba3c9cfb
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=leitao@debian.org;
 h=from:subject:message-id; bh=Hp7HNGXV/MgXNjT6THHxJ7gOgkHDeA1sjiSWQuHH9+4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9CFdUxQt/eVM2JgHj/tHQ/mYlGIUbwuXKE/
 IfZ7+aKK1aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQgAKCRA1o5Of/Hh3
 beqZEACwK1m/IBiWsuZm/yCweFTl5CvloY8Omq7+onAp9NAmo3f3fq3dWNvd1fInjjIp6USlV4T
 3i9TffnzmSZLQgAiZsBYTnKA4N1tcOIFO5eCTXUYYFEewG2LnIaFs3IzDqIkd5wI4CQ/s4FDJmV
 tKcgvDAzFmqTEiBdK+re5/18pEZNyNkmXjel83K5NRnK5slBYOKGtJ61CkzUiZTye6oza/vQhYl
 hZzW6B56W26AxpieyGwQBGD+4YsevmxZeXCzPkwijUg3gD0ikrgPILnwzaQ4mpEFq5zQzFZnmSQ
 0JhAvJvCvQW07yFK9k9s7HbCNtGN3ZBehVZzZMAk7mu8E7f6B6/nG6c4w65BnOtKGH/41fLkNXG
 j2mV5p5B/rcE5v6iaPQ8lvdVz0DBVrMQnW7ko9NOCF9rqcCYfjyDngxaTluIEmIGiYCgHuTxQuB
 rHvQK/UOgaYRNF9it5XieDiejviBBTAjfku0UdbYAzxcjMXNiVN3at1OQabS/k8g6wpYnXSvPdP
 ArpsCqIZaz3tzbWrKOwcXHu7UQD5ud3f/1oISW3vkMdBYhPecgGmAytUr0rkbdz/EJrAUoad0wg
 hBkd8j2PMfbfNsFE5dULVs0QOsanR7JIumvN4BnXV8Qhjx9BT6nAv0oSC+z00JaCWPnFvdTPJPC
 K2FdLBzpLZuS4Qg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Hi all,

This patchset select VMAP_STACK on arm64 by default, and cleans up the
code by removing all associated CONFIG_VMAP_STACK conditionals.

This is a suggestion from Will Deacon from another discussion[1].

With VMAP_STACK now always enabled on arm64, the code can be
significantly simplified, reducing complexity and potential for
misconfiguration.

Overview of Changes

    * Remove all #ifdef CONFIG_VMAP_STACK and related runtime checks
      throughout the architecture codebase.
    * Replace runtime checks with build-time assertions where
      appropriate.

Link: https://lore.kernel.org/all/aGfYL8eXjTA9puQr@willie-the-truck/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (8):
      arm64: Enable VMAP_STACK support
      arm64: efi: Remove CONFIG_VMAP_STACK check
      arm64: Remove CONFIG_VMAP_STACK conditionals from THREAD_SHIFT and THREAD_ALIGN
      arm64: remove CONFIG_VMAP_STACK conditionals from irq stack setup
      arm64: remove CONFIG_VMAP_STACK conditionals from traps overflow stack
      arm64: remove CONFIG_VMAP_STACK checks from stacktrace overflow logic
      arm64: remove CONFIG_VMAP_STACK checks from SDEI stack handling
      arm64: remove CONFIG_VMAP_STACK checks from entry code

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/memory.h     |  6 +-----
 arch/arm64/include/asm/stacktrace.h |  6 +-----
 arch/arm64/kernel/efi.c             |  5 -----
 arch/arm64/kernel/entry-common.c    |  2 --
 arch/arm64/kernel/entry.S           |  6 ------
 arch/arm64/kernel/irq.c             | 13 -------------
 arch/arm64/kernel/sdei.c            |  8 ++------
 arch/arm64/kernel/stacktrace.c      |  4 +---
 arch/arm64/kernel/traps.c           |  3 ---
 10 files changed, 6 insertions(+), 48 deletions(-)
---
base-commit: 9dd1757493416310a5e71146a08bc228869f8dae
change-id: 20250707-arm64_vmap-fa70ba3c9cfb

Best regards,
-- 
Breno Leitao <leitao@debian.org>


