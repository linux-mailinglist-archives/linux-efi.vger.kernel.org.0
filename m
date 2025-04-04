Return-Path: <linux-efi+bounces-3194-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75490A7B8DB
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 10:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85332175474
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5918B495;
	Fri,  4 Apr 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I73KhTWG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC46199EAD
	for <linux-efi@vger.kernel.org>; Fri,  4 Apr 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755373; cv=none; b=iIOTEK0XouiGhYYlxHRKlzZPg/Y7JADZBYmvDIcuwDBVL4AkUN+oq+F4YIaXNgqbxtx4jebOFrlF6M54B/ynonBi2+TMV/5vRok9FWec8hS6+A5ZvdS8tg7RIFANSpWph6z6IkN4eb5KZEx6DSKdzwYzDAGp5uiRcY1JwrZkP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755373; c=relaxed/simple;
	bh=DFmNe5JvFiTNGZaZsBYdcCBsxvzaOJI5Rug9sW5SFEQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sfu6/jmbWFf7fRETBKULDJH8f6+waoBg5YxAx8sRlAb+s2t0sOSxfCIYzGNt4ZFmrzw2y495ijo9xTV2zn481g2Y8y69ecPQ55j1sdPFd1iwjFMdbem2Dl4IKjlBAMRvB8j7EH8CPGwd8FZOXJ4a499PC/aiXTy3vpGQZa6ZXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I73KhTWG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso21053505e9.2
        for <linux-efi@vger.kernel.org>; Fri, 04 Apr 2025 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743755369; x=1744360169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pYIyNXM0vwLPLV1EeWTDyUP3htQY9SK1l3EQuLAqMvA=;
        b=I73KhTWGmU/oLTytcnRywu0Bd/Xodp9gE1TtzdC84+P5lHrfaxk87w9y0HlPEPDiIX
         nvjlyYfQYoQ5nyfhridzyOmIYm0Mk0TNT5GPlRELQwssUnDT1TXVYuWTu0orx5nzY373
         xR+MACTKucN+47Jeo0LqAa//uSgVDKza8zMhG+OIg6lfCHBrklgX42RPPnZ0Y0ETRA0F
         Llo7ZGE7Sg5Io3yrM5xQr9ICEMxci+P19cVpU393O1UeW4W9wxo9lgsE62e05fV418KH
         /uJ0NWr4OsQUl12NIVnZgsZ8hXjYLSzcfA1MaPAitV7f6xTaJ890cLaYLElnUFS78EB/
         0X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755369; x=1744360169;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYIyNXM0vwLPLV1EeWTDyUP3htQY9SK1l3EQuLAqMvA=;
        b=gqC2ghhjjVk71bKfZDGjoeOFxmj5Kx2FjiJXCuCKwPCq514hFmE4QEVXwV1LB3jrS7
         IQxoY/aDFR4P8xd2sx6Xomp7m6JrStuz6EBfsr/N9ItkSexbucdyMNvO5UgwCBzDLNUg
         XMOyI0wfkvaXO7hv4VGbpGnRE+8TRNno6jyPsJagjRsmZlyoDE/6rE/Niv+UHeu9chNx
         PzmcnBX3oa5wFN5gW8Wq6ml07v+H97w+Wxw7AF5ingxiNxd5E+vZ2f9LmXi6ivTxQJ00
         ze+pZOibfh6ymXuJGAv2fKFrEjMKfZ0pc7bo0IGGlL5u2WMsJXCgkK1PP/E015tZzpgU
         Nopw==
X-Gm-Message-State: AOJu0YzcNH6++RRTOX373QR46pige9CeiRmdMt3hdtk2sRPsAJYWjL5A
	COvL0YiaZ8AZ8OHRgTP88IstQ7LY0c7i6HAbJQLkL7yFvlWtk41XaNJt5AHrUPtz8KRlC6EU5ny
	s3Zjd8D9hjAxU39sFR0i9uNpoNpJLdcNZ8X0xFNESNUYZM/i8rw9n7Ev6/XySyMAoy10dwb8GhU
	KpsTQ+Id5CeBb3+9qgkedCmWu6mA==
X-Google-Smtp-Source: AGHT+IGt1kx4p3tVXJXXQiU86uQVsuAjXKvnwGVk8rK+pbD8J+Ww+M5Jb8vb3MmrGdY1Db5pwBw8mkmg
X-Received: from wmsp32.prod.google.com ([2002:a05:600c:1da0:b0:43c:f6b3:fa10])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e13:b0:43c:fbbf:7bf1
 with SMTP id 5b1f17b1804b1-43ed0da49e6mr21629155e9.30.1743755369616; Fri, 04
 Apr 2025 01:29:29 -0700 (PDT)
Date: Fri,  4 Apr 2025 10:29:22 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=ardb@kernel.org;
 h=from:subject; bh=jvhLG3F6XWiSeBek2IzB7QFy6uo7jHqZMkjSa5K85uU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf39jKT55voNy7NZk3KjlhZ92cEie8X93fz5vNenCs5il
 vz+r1G6o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk+m5GhotCKwNKtH5H31mq
 0vlj9qS6xSfs2x5sW7hxdv+P7RJHZH0Z/mn8fvHm9f/XMkELf2mWmfTlLdfuDjU3X/J+4ZHDpVO ivnMBAA==
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404082921.2767593-5-ardb+git@google.com>
Subject: [PATCH v2 0/3] efistub/x86: Fix early SEV-SNP memory acceptance
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a follow-up to [0]. Instead of avoiding memory acceptance from
the EFI stub altogether, switch to a separate API that can be
implemented by SEV-SNP without relying on the shared GHCB page, which
cannot be created yet when still executing in the firmware context with
the firmware's page tables.

[0] https://lore.kernel.org/all/20250325091614.1203411-2-ardb+git@google.com/T/#u

Cc: Tom Lendacky <thomas.lendacky@amd.com>,
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>,
Cc: Kevin Loughlin <kevinloughlin@google.com>

Ard Biesheuvel (3):
  x86/boot: Move accept_memory() into decompressor
  x86/boot: Use separate API for memory acceptance in the EFI stub
  x86/boot: Implement early memory acceptance for SEV-SNP

 arch/x86/boot/compressed/mem.c                   | 47 +++++++++++++++-
 arch/x86/boot/compressed/sev.c                   | 34 ++++++++++--
 drivers/firmware/efi/libstub/efistub.h           |  3 +-
 drivers/firmware/efi/libstub/unaccepted_memory.c | 57 +++-----------------
 drivers/firmware/efi/libstub/x86-stub.c          | 41 ++++++++++++++
 5 files changed, 124 insertions(+), 58 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog


