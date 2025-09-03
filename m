Return-Path: <linux-efi+bounces-4676-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC2B4293D
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 21:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155A85438C8
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685D369969;
	Wed,  3 Sep 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Npy9YC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3C369349;
	Wed,  3 Sep 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925979; cv=none; b=WEGa3TDQjATu6/kDxg/hhYEL1X9c9apOvbN/avCVdokxDmTZLY0XiDs71X/6xqdJZgOUOe1zWq547fFrGGZaERerkflD+bSA86BaKk0t0JFXqdt5VSJvnpBU6l6azZrDUCTuSw+qWepiwS7PfoWos/RNiijBS087/J2bQW2CiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925979; c=relaxed/simple;
	bh=L9mBqIG1TiHreIDV8a0dfjkIxduVLSZagZOu8X4AsI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXgduMXpaEhkIzUDPUrEArQYSeoQXgIrd76QdbBVFtl0UsQg9B1DWJ3LOcXLYUeY+ZZOYDjq3Box/Yq5dpCWiqYi3gxb62cK5wzPNFVUVAeNFT4pu1TA3erZ24QOI8hs3oOnn+BsjghjtC/vyFItfUYsGDACyQC26RxYABDf/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Npy9YC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24c863e852aso2620885ad.1;
        Wed, 03 Sep 2025 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925977; x=1757530777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p96JFKpspRPKBmH2rgBynj/gu4bh0EGooQeUZ0NhcIU=;
        b=m0Npy9YC5qUlAeQVQc1BZVsvH5lS6tGTflqjmMmrBPVpz2RXKRSC9yzLaJBvNH3lPY
         wxoDahz3/Lh1lL4/p4pwOVBEC0t4sOAq6zPoe26fDRrAeBJM+E1yeXL4l6c4Ksc6xP/t
         tTbBV3YwO+FiWPESBI4yB+EjrkVexZ22Uw0RSYgQblPLYr2Fr9axA4U7RQyB16WMK2Uz
         P2R50/RBpb6m/KOWMuJ3fEn/iPpf0qzc37M42ZRyXxfvJyLOei2huRMyJgiA6QimoKWr
         WcSuxoHADZkecbEoGL3Q8wMtFHylwNW+/diLtHCEvOtJYQw4mF6uy2LyMk/Ay7A7tf8G
         g9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925977; x=1757530777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p96JFKpspRPKBmH2rgBynj/gu4bh0EGooQeUZ0NhcIU=;
        b=avrzS462eslJmAXLQQt0NQGg5FwqungEIDrzA+/Y+KEaT2p/0uokFCcsQPXU5voGd/
         uysob1dEcfdaHy7gp6axmuWYKuaUmE/KTvbxHjyw1NiQLxOVgHMeNXwl0Lk5VVtfBky5
         5D/IqhGl76u4vdeaeR8zpEylN1KanONRJf9IB97dsw2OPwfGNdQbAf44L7kaCSWY5T1t
         pYmamA/nqDxI6GYSIuerCT8RG6BzqMJrJy+G0NCelcuanGPg8nz/H9dCuzkNkt9K/qvF
         ZhpxJDcviTEcl0tAJ2Uvi9v8Ds1MpprAc04Yo0YBAOkFnDQ6m1HJC1hg5z14/cnAIiJ2
         9qnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx9lOsZv5MRCz8+iOXyBgJwBx4encmccTPfh7+BzbglPlb6XilvcLA5lrcgeKHfBqUXoK6hHO6ypUREA==@vger.kernel.org, AJvYcCVkMlOTwwQzyC6mStu/0rtmNs89IRKRhG55q1QQRlIvXi3yz4WfgCW08ZAZUY2DBD2BrNZQVqylOU6O@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBEzA6W/vxuUAh1r8uO/+AZ0GNvrTZ669AWNVRDUzYS9S4JD9
	EuOKeK4u2cvKF8EeDhH76cDHyCuSXJPn1UISPRdUbmcrCp6WbOMJqCI6iB4XiA==
X-Gm-Gg: ASbGnctZvqFo3IFQFJ/9zzSuse6GtiHI6X+Z4VbL+7Rj3CDefVJWEo0pF7ELJvWjvB/
	GbV+18pc7x6dSx75SOCx/6J/E7u3IxNzGhDiIYCLTh4BJVgYJIrLr1MEmeSb2b0qeTi2wCCx1Nm
	Qvqeuu5V8W2AzFKa4qAi+Uc8BSi9C0iqeY91KrotbH6Vcqrguvb3WC4AAdPO5qxMNGZqJHUl2wi
	fE1cn9HJGNvltYq8NZlQwKLX8XBnNmt1lZQ4OdfPP6767Dbs2KFjKJEVvsyVWNXDrl7/JbGj2r7
	8EYeFFD1T69IpiMPwQp+RRmCEwHm7xROX+sKgEgVeOjk5s+9veyF22gQ4Tk6ZRmenhPJHEXTP56
	cmBlDF46vxElz6xx5/q6LRnl6ULpR6gAXbR3evs++Rae1lif4lia+jF4TaVpUraUb+/uPFtr8Kf
	k=
X-Google-Smtp-Source: AGHT+IF6bU8SPLeBKOcF3DV0pz3IKcU2SprGWCJIgsDwHZ4utP76U3dUm2BhH0lDWIsPOTFAl0TAFQ==
X-Received: by 2002:a17:903:2f8f:b0:234:b743:c7a4 with SMTP id d9443c01a7336-24944b19ea3mr233283115ad.38.1756925977585;
        Wed, 03 Sep 2025 11:59:37 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:36 -0700 (PDT)
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v3 2/7] aoe: Stop calling page_address() in free_page()
Date: Wed,  3 Sep 2025 11:59:16 -0700
Message-ID: <20250903185921.1785167-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903185921.1785167-1-vishal.moola@gmail.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_page() should be used when we only have a virtual address. We
should call __free_page() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 6298f8e271e3..a9affb7c264d 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1761,6 +1761,6 @@ aoecmd_exit(void)
 	kfree(kts);
 	kfree(ktiowq);
 
-	free_page((unsigned long) page_address(empty_page));
+	__free_page(empty_page);
 	empty_page = NULL;
 }
-- 
2.51.0


