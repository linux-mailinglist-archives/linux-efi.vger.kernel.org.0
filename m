Return-Path: <linux-efi+bounces-2417-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F349F9108
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BAA16C169
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364B1C3039;
	Fri, 20 Dec 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjjjyRqy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349742AE96
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693761; cv=none; b=OecNAO/2eObyxb8qADhADQf9CvcsWdvVa3Kxdz8UEbE/QeI+OEzNaX1mGH0DdrG4Buai+Qu58Mv1uwqMVDwStV6abiA+Ih1DECCNFFSv+X5kz1zNh3rhsEZ69WSlcpo/mkbbPK5V6XKYRN9ujhM5yt5ZE+idOTFk7GFaKDMjCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693761; c=relaxed/simple;
	bh=ihtSIvxedJmGrTzj66wP7EcRb9mmAs+EUS4+g34KiWQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iuWbVkPGVWHW9+kw72tRDW7PLamR7P/nfw4QuBSmLW0xJjkqyDFw8UZ+at5tsDCbUTTSJFKEDaj1DViCW2/TMzMlSqho/hoBETFJ1Z9y6u5MOd8wnyUWeJA9hLXwsO25IzpDQdx2orYvAzIsal4olZAQdwmgmXzWPt/zlmpnb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjjjyRqy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so10529005e9.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693756; x=1735298556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrbRpqJQnbcKzfpfJpgvTLF1FyOQSBkypq55+GAgg3s=;
        b=tjjjyRqyltYWVnDRp4iEXt3f7HbWUfsi0PAbMUwHHKZiHLkw9tDKjz/5vorjDjhHo2
         OisjSAbnAnHJqvSyrhnGrPTkPyirn0dvCFoZjD08W+74OOjeXXfzVqtPWQqVH9tSC66Q
         JVUha9tOM+rdY9tHViCBICWXjSBjqmg9YMulMl+fD8TvwRvVxYFzBRoC937cZXrQzel2
         3g3EojEcF02Y3yhTuOAnM+cjIS9YjoQuJDY0WYqkKpAhwfeOvDrPH4B5BlywYmwo5hhj
         gdopI+GPt51Mcn+YtV4rocoAtZwHKFBNCQA1SDO+oOWbC53UnA7kNyOJtzCF+71dlXuR
         UGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693756; x=1735298556;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrbRpqJQnbcKzfpfJpgvTLF1FyOQSBkypq55+GAgg3s=;
        b=nzfHQPzP6HwgghXIj6pkFlHhRH0I+jWcG7NBOlXJolZWCW4qWuUWnhIPbmpShBu6zZ
         oEcOdzsBre2xb20FtvfAqKSxy2Q9thZSoCHmHO/2tstINpVafI2qx0ftRzCCVz8iHRsV
         p+nHp0VWx2yD7Fk1gdjm189p4ZqGjLsparzQqVLSfXuzP1rVO7VRcYBJhHH94jG+jX9t
         UcJgk5gPQUMCl9mhOhQ54Iqx1N6+5hyekUWeh2HiC6traOG5H4IVipMeXTozUnwkV4Zk
         oLj2uNJtRan4J6vuvWAkFX6TWU6mY+DH8kL+5YRBAGtKuJqYDIAfxiWQJzMds+B8VfWl
         0gzw==
X-Gm-Message-State: AOJu0Yw8VIcNvT3FjRFPC4kZ8l1ygezO1N16OQ61YQ+r3X1PDIV045YN
	4nTJpWIVAetrP1ue0HFLBrkppCdySbhWj9eMCmXCKRMRuvPoV6UucgAPxeoBHi5pUeazQJy/Eoc
	O6k5SxMtObQgZk7qDo7LCYBmdvZKw6O/0ziZ5vMbVRFVmoeeEpiNRVqczgyDpTzBKa5KjG+0PCK
	GL1LVGLHkjvmx4kVTVe7i5EVb0VQ==
X-Google-Smtp-Source: AGHT+IGiCdwQXxWRq5+8wDWiU78fduIEalA4L32vX4MwN6Smwpd3KTgBJ/RQ6tzE/lKJKRf9F/L6nlXR
X-Received: from wmsp24.prod.google.com ([2002:a05:600c:1d98:b0:434:a7ab:5eea])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c1a:b0:434:eb73:b0c0
 with SMTP id 5b1f17b1804b1-43668548301mr18852745e9.5.1734693756471; Fri, 20
 Dec 2024 03:22:36 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=ardb@kernel.org;
 h=from:subject; bh=45Yf+auFr7e7QAfQcac/EKl6kDZSpozjg+MSmfgIymM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01OP2+76Vza31jFqvJxRlLHg49uOhHSH6Fybwy89nrW
 PakVsZ0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkY72T4Z2P/SPyIjZ0wf+C9
 2K3X0yQajm/SDwn+qZix3Zkhye/2YkaGlf+2TH1R7dx1kYun0ODNvYnnA6QWcq6Rv7vc+/mRJfr /OQE=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-9-ardb+git@google.com>
Subject: [PATCH 0/7] EFI stub cleanup work
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Some code cleanup for the EFI stub, to drop obsolete code, and to switch
to newer and more ergonomic APIs for managing pool allocations and EFI
handle buffers.

No functional changes intended, except for the UGA removal.

Ard Biesheuvel (7):
  x86/efistub: Drop long obsolete UGA support
  efi/libstub: Use C99-style for loop to traverse handle buffer
  efi/libstub: Simplify GOP handling code
  efi/libstub: Refactor and cleanup GOP resolution picker code
  efi/libstub: Simplify PCI I/O handle buffer traversal
  efi/libstub: Use cleanup helpers for freeing copies of the memory map
  efi/libstub: Use __free() helper for pool deallocations

 arch/x86/include/asm/efi.h                     |   3 +
 arch/x86/platform/efi/efi.c                    |   2 -
 drivers/firmware/efi/libstub/efi-stub-helper.c |   9 +-
 drivers/firmware/efi/libstub/efi-stub.c        |  49 ++-
 drivers/firmware/efi/libstub/efistub.h         |  16 +-
 drivers/firmware/efi/libstub/gop.c             | 323 ++++++++------------
 drivers/firmware/efi/libstub/kaslr.c           |   4 +-
 drivers/firmware/efi/libstub/mem.c             |  20 +-
 drivers/firmware/efi/libstub/pci.c             |  34 +--
 drivers/firmware/efi/libstub/randomalloc.c     |   4 +-
 drivers/firmware/efi/libstub/relocate.c        |  10 +-
 drivers/firmware/efi/libstub/x86-stub.c        | 164 ++--------
 include/linux/efi.h                            |   2 -
 13 files changed, 198 insertions(+), 442 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


