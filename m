Return-Path: <linux-efi+bounces-4674-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21ACB42932
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA26541DB4
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3453680AB;
	Wed,  3 Sep 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LteysHPW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810F322C78;
	Wed,  3 Sep 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925976; cv=none; b=Pa+4O2d9I/gaDfbDmZRItMlVfdeNVCnI7pXkFW1cA5slR6K8Uh7Z2gCB6qdJtXoCDVPWXZUrWUZSWdL7q3f/s6j6bK53r75dkWdDOYhBfV+amQbpEPZE/Hr7T+lBnsLQA8bqudLuXaqKUkDJSH/UyAUS5CtsJG/k7rzcByyKXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925976; c=relaxed/simple;
	bh=CmRuSfLVesYC6zLMzuuR1yKrwX/yrIq9Ukf9DYSfjYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYVHPnlQkGxtCjcPsn2IXHSikzzRv7SMbVfFjbJHhPlurtPwJC6OUA5kjh868ue7aJFfKZCBGSx1QlQ6c6rxx19B3oqK/0SectxDciHh6fbHGOHLuuGr8TivK+s2NwU85MF/Lblt/bzx6E/IjiHoag17G0RpDj3Qk6Sj0Fil5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LteysHPW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248d5074ff7so9497455ad.0;
        Wed, 03 Sep 2025 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925974; x=1757530774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZy30c40uMQ+C5mAmU5IprjDTVrN2KgzxusGEfWx0IE=;
        b=LteysHPWigAK3EfnDMgvLdCW2Y63LMedgiShFfXhPMyyI3nnCi1YjB4Ub+Kfx2Tq4X
         NR/1sA2Jtj6RDCuf9LnTjox65lLtFDsQvQYnsZ1Y4NsrZIut25cZSIT6AD8RG5zO3pdB
         IcmtsRQYKRcgOh4Luft2QNXmKTvuQKf0D+blb0bFGsZGVRKRUsxSoUrJWy4eaZ29kbW7
         d/FqZtKoMJKHUrkvX+KFqKxcbUCTO+w4hy9nwNt7xyGgCo2BPw3Z7UD6OhZFp69jYsTX
         EDJT6L59C5QxGNLj4CeJYXCm/uvg4U5RJIe5qoTkc5HoSGtXN5Qjq5OYsTvafI+4rVbT
         9iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925974; x=1757530774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZy30c40uMQ+C5mAmU5IprjDTVrN2KgzxusGEfWx0IE=;
        b=GfAf1TguTbxCNijhZcqI9Ai4JTzw+ccgWRdP+XWQjkNwr6joLWWDipd5oQx8Bf9GIx
         TjXknmm2/Nwn7EggCf4k7wE5dowYhwPa2yDmXuVj4bdqQ7y5036UcCz0RavAc0KYIR01
         WXsyWmYMYrQ4TBTnldYdsAZ4DesUn/9lpjDNNpupJh2ZwoFuSLGTNUJamElcpLsKwOck
         /HvD1L3mOVwYtY0XJeYwnQui6Tln5lX04U6IEt8/OEg1MWjaM6pzRJBRNLBwTVDnCxwb
         gLGa9SqMgXRsE8e1VLTOPB7wLkvxFMlSbW/1rZ54CpFH1Fl6XpnhdDo3vTmPl8W6u8ic
         hI0w==
X-Forwarded-Encrypted: i=1; AJvYcCVbt9cbEWYz7bjdsdkT+3o2PENkMf5w9IqGBa2mM5fp5kZyAJdu6W9B3xwnwiXredEsNoZKV1XRgCKxrg==@vger.kernel.org, AJvYcCXSraXu+g9jnx2SB/QYRUBuyT4T/sfvl7O00hdmmW1sy23+IOY6TWg/Xw4TpO3nuQGtA7qxUVIRTQ3z@vger.kernel.org
X-Gm-Message-State: AOJu0YzisABAyE2V6cbB2NPR7SOStmsdLO4rfb0xvWvE9ytzZ0Xr2suq
	1nPAfSWI7Yn89Eypcbs2nSY1a4Z00agi6SM+ek7xyu/F5lpk8Shp9B+Z
X-Gm-Gg: ASbGnctoYf4SzLa0QrRnY11W1FARuUpavflqoSG5U0lpP7AnJ6AEDafMYjWdX+FqlN1
	zKf3KH7e36Osm+VB69/843nclhvomJJVPeMmJ8MKLP/Vth1/oMXdzVqk53t7cCDLHF4ukd6b9ff
	SOmez3YYKfRRKkh+y/rvOkug5WLQCrtziBd6wosKgmulB0SPX5I97vGTkUmNi/UcUhDjweT5USW
	YxwUFqMsNS02KMhk+PQaUHBrW+Z+h3PQyDZH0KhwQgg/S1yfPqpPAr5k85O2K9i7lvvLeeaDcza
	you961dQ1XHa2VEGgWNeiN/C6eIjj/2C1M8F7RaFg9B1gGKjvb/nIIC3CWoMKqRUCVe5MB5gK0Q
	gFhDFxXkPBhUYN9wB/lI4OZV6rguvy5fForHg3JlVRgly/j5KwfnLPw==
X-Google-Smtp-Source: AGHT+IGc1hOCFlrmhtuYXy2RF4eOcL1ED3xkJpQYquvPOenW1RGNO8PJflQF3KtC2IpnrJ0auNPnsg==
X-Received: by 2002:a17:902:f642:b0:234:986c:66cf with SMTP id d9443c01a7336-24944ac387bmr203183595ad.16.1756925973872;
        Wed, 03 Sep 2025 11:59:33 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:33 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 0/7] Cleanup free_pages() misuse
Date: Wed,  3 Sep 2025 11:59:14 -0700
Message-ID: <20250903185921.1785167-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() is supposed to be called when we only have a virtual address.
__free_pages() is supposed to be called when we have a page.

There are a number of callers that use page_address() to get a page's
virtual address then call free_pages() on it when they should just call
__free_pages() directly.

Add kernel-docs for free_pages() to help callers better understand which
function they should be calling, and replace the obvious cases of
misuse.

-----------------
Based on mm-new, I intend to have all of these taken through the mm tree.

I've split the patches into separate subsystems to make it easier to
resolve conflicts, but there aren't any functional changes.

v3:
  - Collect some Reviewed-by Tags
  - Replace remaining free_page() calls in patch 7 (all other patches
    are unchanged from v2)
  - Add all appropriate mailing lists that were missing from v2

v2:
  - Reference __get_free_pages() instead of alloc_pages() in the
  free_pages() kernel-doc
  - Get some Reviewed-by tags
  - cc the subsystem maintainers related to specific patches

Vishal Moola (Oracle) (7):
  mm/page_alloc: Add kernel-docs for free_pages()
  aoe: Stop calling page_address() in free_page()
  x86: Stop calling page_address() in free_pages()
  riscv: Stop calling page_address() in free_pages()
  powerpc: Stop calling page_address() in free_pages()
  arm64: Stop calling page_address() in free_pages()
  virtio_balloon: Stop calling page_address() in free_pages()

 arch/arm64/mm/mmu.c                      | 2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 arch/riscv/mm/init.c                     | 4 ++--
 arch/x86/mm/init_64.c                    | 2 +-
 arch/x86/platform/efi/memmap.c           | 2 +-
 drivers/block/aoe/aoecmd.c               | 2 +-
 drivers/virtio/virtio_balloon.c          | 8 +++-----
 mm/page_alloc.c                          | 9 +++++++++
 8 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.51.0


