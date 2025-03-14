Return-Path: <linux-efi+bounces-2983-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE38A60F99
	for <lists+linux-efi@lfdr.de>; Fri, 14 Mar 2025 12:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E0F189A1A4
	for <lists+linux-efi@lfdr.de>; Fri, 14 Mar 2025 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66B1F3B94;
	Fri, 14 Mar 2025 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnxZ9DWZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774801A5B82
	for <linux-efi@vger.kernel.org>; Fri, 14 Mar 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950540; cv=none; b=YgtlKgiJno+Vs8jYAQ7azyaOICHADtoqRKILZ/pAuddYR8nSUAXKImMCzieSPIxI0laFGRfwjDxTfFFiiQwYpEqIJwdRreCJbAah0Fr2IvIrUgT0wT/AgmctpSpAsZkqsWbf/oVvEMVW7yVMdraoI6B1MrsBSMwffUrQoXWS3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950540; c=relaxed/simple;
	bh=E8iF8oWyPdvUAglnFT0dHbI9wimCvz+4QmMo0HXqZcg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MtmMbeRLGHEZfMB+jtoP3vPlfML04eZlklSF07Spans9tIrV7UnnG9BwEg95B7iwGPBd6I4E7iGIX4au/KX0nnTvoONr42me9GaNx4UimaocxGz+zaQv1fDGvd3LX1s/A+UgZMwUSbkT/+qcata5w0KrRyRgaP6yyF/9G9FDD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnxZ9DWZ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so897128f8f.3
        for <linux-efi@vger.kernel.org>; Fri, 14 Mar 2025 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741950537; x=1742555337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNTOC7FV6xdM7uEThDA54pXldfk/yY8KmRhaaVRIhUM=;
        b=BnxZ9DWZBakNAj/1Ztirarxsh4KBngTOkk4OzHZjcoLMTNsNpQ2qNXr4RiyLq14wzi
         ikjNXB3bu34DzjO0bvqs0UN2MfReDXO1e4tF8M7KTT9r6pnyr/SnX96lbxrB2dBwM/U0
         3WO3pf+AnDfGzahypA+/NFBTQrHIm8lUCrBN5bn+g9AIBoOk1H3Jg9lKbSUDskYku0wA
         uUpYV7kxhESa2a29X9C7bp0VbivrOLHrDzU4EvjSIYBak31J/YtN5A3yhpmoB+aQKCmg
         dDvIqkDVFtuaMBcsl0Blz/5NrIftJJd+mDl/E9NyaveFwnNpjsECv6Vc8a7AfkBpl6yP
         sYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950537; x=1742555337;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNTOC7FV6xdM7uEThDA54pXldfk/yY8KmRhaaVRIhUM=;
        b=UhheoQZd9abg4rhtVfqcrxot47s0Eem1tEH2i9AShfgjHHwMGpdVGGwPsbPpqUH4Sj
         CD5Vn3eaQBC8lux70ZOnhQBy7f3i+IObWUqpKy/BoYjV7wjJHGs8faF2cfv0xrSnuYLk
         f8qWte6l6L1fF5FylMByvqOpkV2/Gn7vuEyKzEAY74vMkpv9sI5a7MV3Q3K6BFXhKGAd
         I/Ka5YVLnVeKXC5qUamugjz4HxFZFLkEVE+Wnt5yWfeNW8Kj682zlU25oJ8pn43laM0h
         8NTaYcGC1H5NE1pDkeCIAOk8uBPK6DB6t3DuitjNe9ejS6NgTE9sXqeLUI2MtHT+J4w2
         KJRw==
X-Gm-Message-State: AOJu0YwfWOW3wdNrEgD6qFClyQTiboonC+rqUz/oYbTEjXrmuZWKSEt0
	oySuJHbAeZsc42bVT1oiRtwU6w/boyVmaEwGWqkBZwhb7sgFpF8aZuUyg2ta34asrcgIWMuad++
	OvjMflFk80YnnC48LYe8yHCtlBBtj36d96t3t7lMnRdJCzSgqLkZvmStK1xxtEhBRtuwCqiNI8b
	XeD5fSKJoU0PMhflUb4RNaR5KyEA==
X-Google-Smtp-Source: AGHT+IHai/HTLC5J1t9U/w+QMuGAVLtIGNxRHJG6gN9zuIEW9dmYIU9JRCKQVa7XEe+B9TjdHF1hXSwv
X-Received: from wmbay5.prod.google.com ([2002:a05:600c:1e05:b0:43c:f8ae:4d6c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4025:b0:391:42f2:5c7b
 with SMTP id ffacd0b85a97d-3971d51fec1mr2815472f8f.16.1741950536845; Fri, 14
 Mar 2025 04:08:56 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:08:46 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=ardb@kernel.org;
 h=from:subject; bh=WZPdywFWv1OYfssxRiWJZFTbqtXSM9mx+P2KIwdgpEs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf0Kn52GTERdbaDDG9Pzd3tP7OqeX+FyfKLw5P6FzsYzD
 fflpM/pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPxqmVkePVJlc/cyn/+1Nmz
 OrQXPA7+uHSb3ZdqmX1Ta/9wzPza/Ivhf/4R/s9Hzjw/27nq1Q+/rm4ru768KDvnnctXtd8++jz oOy8A
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250314110845.1559302-2-ardb+git@google.com>
Subject: [PATCH] efi/libstub: Avoid physical address 0x0 when doing random allocation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Ben Schneider <ben@bens.haus>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Ben reports spurious EFI zboot failures on a system where physical RAM
starts at 0x0. When doing random memory allocation from the EFI stub on
such a platform, a random seed of 0x0 (which means no entropy source is
available) will result in the allocation to be placed at address 0x0 if
sufficient space is available.

When this allocation is subsequently passed on to the decompression
code, the 0x0 address is mistaken for NULL and the code complains and
gives up.

So avoid address 0x0 when doing random allocation, and set the minimum
address to the minimum alignment.

Reported-by: Ben Schneider <ben@bens.haus>
Tested-by: Ben Schneider <ben@bens.haus>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 5a732018be36..fd80b2f3233a 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -75,6 +75,10 @@ efi_status_t efi_random_alloc(unsigned long size,
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
+	/* Avoid address 0x0, as it can be mistaken for NULL */
+	if (alloc_min == 0)
+		alloc_min = align;
+
 	size = round_up(size, EFI_ALLOC_ALIGN);
 
 	/* count the suitable slots in each memory map entry */
-- 
2.49.0.rc1.451.g8f38331e32-goog


