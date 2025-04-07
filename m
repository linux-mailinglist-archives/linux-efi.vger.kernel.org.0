Return-Path: <linux-efi+bounces-3205-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA10A7D3DA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 08:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88B5188BF34
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 06:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCC4224AE0;
	Mon,  7 Apr 2025 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w4zUzxvl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9412135A4
	for <linux-efi@vger.kernel.org>; Mon,  7 Apr 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006303; cv=none; b=VwD3Zfap8eyDhm1qicY3yQcblLOQTcT/EeSEtJSiMZ3bhEyZNHm58BmGGOVEWFzf7yH95uA/QrEMr7Kzb9YBhdrFqHKoCr2Pxz/3I5QFGghqEzoVxdkbJLovZCej/Bv8V8OeA/JDyWMMzA6NJgybUpCQ3uzkDye/wy8EiqBn5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006303; c=relaxed/simple;
	bh=johCVffHBwXwPn+VACYLIlckbSDvdY6HzsAP44XJBko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kgvp8EmmSvfSewdQN3pC/UhALaOEogAvGVFYgeYFkTBthRrxXbbK4DTbX/pTByM3CNhZCiocfU/KS5hBy4OwUmySm8XcTiHS5SJKc3Q1kUVpcS54Cy/7dm6Im6ZYau+QPXxG26/UsHmR79E6xouChWcf0nkqUDtE1Hd+SWP4l7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w4zUzxvl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so25283425e9.3
        for <linux-efi@vger.kernel.org>; Sun, 06 Apr 2025 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744006300; x=1744611100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1fncJPo7aQnGIYZudABpt3L7OdAn0sO4d22e4yf3+O0=;
        b=w4zUzxvlqK5CCzf92VnK7j+apBFRwICIlxOQvII9idgAbmJDlUgpCoWtZkYuNI3EOd
         4NUAU5j4+GQu3Q11Lqv0dVqw6hs7p2Z1rYbLZOieXn38sxT4St62vLY9n9jHmsO/t0dl
         CrwbNXta5oT9B7yubpFXEUKHfUQwORAZydqPpEKxdFsnqVrQJKlNSWEiOruOBr4nXNl/
         v5UsuWmbk/DbQ0Zb1X+Frlhs9G20MJBm9Bb12tUNJ+khrEUrsdHUlQvUEH6Lw/v4tGYA
         89jWdcJe2O7+/cV3wShsAF0GI3FlDXvX3ojqJ7v/aSSLxGCrL0upFM6ZLXnRFy9HUj4A
         2RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744006300; x=1744611100;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fncJPo7aQnGIYZudABpt3L7OdAn0sO4d22e4yf3+O0=;
        b=cZ2KWYZvCBtpn2skOHymGaTsX52TzL0JUsY89i2IOnB37Ov6SEH52NratjFOMjQQQB
         L6m+na4UmT2Medz2jytPc3ryzJvHH+BjSNRAQE6L+LS5mNigVR+clrPCeq7sTW/Er9s5
         8cOOs+J5oi3LHPcSPe+JPgy3vasdPdUtxve8yYXQgUTH6dm5AehwzGgW6dSCUBWilsuj
         uMQaPaURkZxDFNSZGluuV1U0DMuvsXzsi8ZG3GHMUTTNn5ZdUvKci5RZ0DmgLwRRKW8T
         PWcp0FIXsp8jnMAfG2lB2DfP1TSaR7DbonExqKP8mu7r9zOoXlFlnKjlhMSD5ZFzSnxe
         NlQw==
X-Forwarded-Encrypted: i=1; AJvYcCXFcEevK++lK0aPa5HL6RP1/UPXJekz0+bxiEX4wb8etjzgBCeJi4EGusjkoNM7dN0VQRROIi5hnb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJjs5mSJaUgkqYHrqeUDftdD5MY3l6NeEDUc289KuNJYtV/Cu
	o0aX4N8du7gmT6/hosSj2ZEXoPLr96SoQCzV0OFhF1vqDD3uQ9ThAn3ot+YJJjWeCYNn+A==
X-Google-Smtp-Source: AGHT+IFb5e008xC88X5coR+R5CYtLmjie5anqbgwqo4QgWoC5H7DhfztX9jvqjlWRydxlXCZLxpXQBT/
X-Received: from wmby23.prod.google.com ([2002:a05:600c:c057:b0:43c:fcbd:f2eb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a51:b0:43c:fc04:6d48
 with SMTP id 5b1f17b1804b1-43ee3e9c7d5mr68576675e9.0.1744006300162; Sun, 06
 Apr 2025 23:11:40 -0700 (PDT)
Date: Mon,  7 Apr 2025 08:11:33 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=ardb@kernel.org;
 h=from:subject; bh=OecyqHWbxypUbRHwC6/qGLkDKK9F2SXXDNoNq9pakes=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf1zzlSPNYlLIv11Bf5d9T/wnNfytIME51Y/hxOXed6qB
 y37NH16RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIpExGhutMDO7XP7NPuNa/
 LL30Wr5jhUR/VFpg6ErpddJ3fju0djMydN3OP5S/4tf06f72X1/+Zjy3+Wo+0yTjCRqV9yq9rZX uMgAA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407061132.69315-4-ardb+git@google.com>
Subject: [PATCH v2 0/2] x86: Refactor and consolidate startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: mingo@kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

v2:
- drop queued patches #1 - #4
- keep exported symbols out of startup/
- rebase onto tip/x86/boot

Ard Biesheuvel (2):
  x86/boot: Move early kernel mapping code into startup/
  x86/boot: Move early SME init code into startup/

 arch/x86/boot/startup/Makefile                             |   3 +-
 arch/x86/boot/startup/map_kernel.c                         | 215 ++++++++++++++++++++
 arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} |  45 ++--
 arch/x86/include/asm/mem_encrypt.h                         |   2 +-
 arch/x86/kernel/head64.c                                   | 211 +------------------
 arch/x86/mm/Makefile                                       |   6 -
 6 files changed, 240 insertions(+), 242 deletions(-)
 create mode 100644 arch/x86/boot/startup/map_kernel.c
 rename arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} (92%)


base-commit: cc34e658c6db493c1524077e95b42d478de58f2b
-- 
2.49.0.504.g3bcea36a83-goog


