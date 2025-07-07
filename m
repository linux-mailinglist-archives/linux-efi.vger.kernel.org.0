Return-Path: <linux-efi+bounces-4164-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6CCAFB81D
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9D8189DEDA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E1221FBB;
	Mon,  7 Jul 2025 16:01:12 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F31CAA85;
	Mon,  7 Jul 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904072; cv=none; b=iIpmduxTf+A6Ct9P2L6Rxp9iO47tm42SOTkAT6RM+e5KcaHv44oOEiyMLOVO0D7BM3YwgE+wKwrZjnLK6/h4J3zvCLIi18LfJr2NTLDHmdmJFzFUCNW4mUPuQKyKmJ5jWTcEHj9XkM5+MV8YpHR5umh1SuwqIF7uVNgyDsE1Ucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904072; c=relaxed/simple;
	bh=Jq5rya2jqyIEw+gHL6Gmj9Aao7CMRSAv2UZUv0oVQc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMC1ZeXBZiG7ZkEOLKNBhsJ20zoOkI7PRShmpCyWdqB4vO7a2j437T4r0YCFoTaqa660cX2xDeMS41piuG/qRj9gNld0/Iek2Lk5JvFnh+FNOu/R1BiHi6Vjx/rDikt5Z1JyGqWZRT46uHrfVprV94kr6jbrdplE6ltln7kukq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d3f5796755so325566885a.1;
        Mon, 07 Jul 2025 09:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904069; x=1752508869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wI06xDd3KMPf7PBFbeho4f71DSOiqWBSCgPPOMFntI=;
        b=uz0XqsU+oG8uZ3VsxtAZW3BdnJsfEP+R4mLRVMth+0epiGbcFJeQ+UVzwtYR6cQ04Q
         z+oEnRs1Db446CRJn7Z3exsTqD3+uemsRLh/dCvB4glZXBZV+7shfKqafqT+g2YDfz9m
         OBW6tZiNBmM9iE5VBX8Ihq17Y2k+b9bcGNang99fKATdCS83JrGBOJAfnpU9DyPBhfE+
         jS+DpAXHK1BvX9YXxmZWEsa3EfCTfI38HCdTiSIOVhMY7MTYehv9D1YT4VHnGaYVZzCw
         RcWd4uusTvdy1SBlW8F+FKav5lq26gBCouf4ei8nJpxvuCkpyt41PegCGCKrf7Zv3yvZ
         YFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUyTeumexjt2vH2gzJbXWEkods24SbtHcKZHKxkScAyDsd9mYm5M0Paj0421lCEQbUMhU8NpKVjCqA81oXI@vger.kernel.org, AJvYcCVypvzXNTN4Uu3gEg7yxUqNE1gvK8/7rv2A+8NZL+LrxTCbG/mZnTj8VsJq75vtleHEjmTqQKjMjp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwXiwgoEy8EeW1HuRR/rrH13DWxcf/fHYAS0thhxPuQG1d/q4
	G8sDSHD07GZmV9fCehfufuKvrXsijMqdHVpng/vvQRDPzXL8rURQiV+W
X-Gm-Gg: ASbGnctjcx3ObPhON+gAZyVTPIzQMA5I4ZjS6OhiYjvdPVVn6Ioz0t71rFK2r1VCipR
	mTT08NZ1c0PkFIBHjNTdRFmEtu4a+Na3DkD5n/nQPI2sQ/8tKhASZwfFKQKWQ74K7137X/8KFm0
	2jHo/IZsNuH+IP0RtmidKH4YR/oeCqQieIvJbeY3oOKRx+AmroN/8qpBstcTrh3X19nLkkbg+oU
	4N/Yt8apth+75E8WdghxdYniobzNH36WYt9KFjASv3w0V65Kl9Py8jizM1fJ9gzGkm0VZWAXJ8A
	OCFcQ77cEtbP5J5KcXoEEoKZd7gC4ROYyuBTUou+1qb48qA/5tIjWbuCEbn7
X-Google-Smtp-Source: AGHT+IFPK9/gPx1ZbaGNaw7eswyMM2L310plt98IyfAdXroPLTHAMtNmSktqVWPPuuyEr8/IsRIHeA==
X-Received: by 2002:a05:620a:2949:b0:7cd:1d87:6c79 with SMTP id af79cd13be357-7d5f350e572mr1472918485a.53.1751904069330;
        Mon, 07 Jul 2025 09:01:09 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdbdb3dsm623109685a.46.2025.07.07.09.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:08 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:01 -0700
Subject: [PATCH 1/8] arm64: Enable VMAP_STACK support
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-1-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=leitao@debian.org;
 h=from:subject:message-id; bh=Jq5rya2jqyIEw+gHL6Gmj9Aao7CMRSAv2UZUv0oVQc8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9CB5n8SRVbBXjgzk5X9mZQlnynOZq78Sn3w
 igTEg7vOz+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQgAKCRA1o5Of/Hh3
 bRtXEACdXX7XUhp94ssDfTSb/2jAteNG7IBhyhvkmD7yAR6hzxGRGUfXpA8+CPQaog8WCcvih4J
 T95eFz6M28TAA0w0ex8v7q+YYx1ajEqCTlfb0WHV2R7NFaN6VLwrJ2/VyZwAxp+nLNI774TOIAT
 TobzjUGikd2VH0iKlOMRxfJ5QQNve1G/rAbDQ1IQF6gIZftlwR6gBaphOC8zLiWuZY94UzQwDur
 QOnLXZWqVhIavCYxaUza2P+Y21/ZsqWfrdHvGoRs1f+pLbggOH8WGKC/PjUCOmThnesQRHcOfBU
 Cxta06dLVOjEhwsbPXnUTOHfcm0RPWpeNCfMmMgUKLYPhhoJnezkVnfYiZPLZBamkvqcQQuOXCQ
 PvONA/9Bda0q9MKuHoaUWojFblxLnyANfshagyj6WM1mQVY0Zs+FhTjl5fyPDMD11fCgAM71m7u
 jZVc2r7O7wjfLHqVqZxHyXu2L5zjoNZkXEdszj9dfNdEDQ5vdF3uxSgQeK9cuY2C1QiBxVMj7Gu
 S08YM8QJgKyKt8fDB6xKJ0QCGCmnnBQE2dPR7lAURI9ucmzB/GL56lUXmfP878w1ms/h/Gmm+wK
 maqRdLgDTQAcc8XJWf0Mle0ZlnvD6iZ+nZq3KtM6zaxobuWEa6aFzucSOORC6qaXSd5jbyZelBK
 sWv3SigvwOy/4SA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Enable virtually mapped kernel stacks for ARM64. This provides better
stack overflow detection and improved security by mapping kernel stacks
in vmalloc space rather than using direct mapping.

VMAP_STACK helps catch stack overflows early by placing guard pages
around kernel stacks, and also provides better isolation between
kernel stacks and other kernel data structures.

All dependencies are satisfied for arm64: HAVE_ARCH_VMAP_STACK is
already selected above, and KASAN_VMALLOC is selected when KASAN is
enabled, meeting the KASAN dependency requirements.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 393d71124f5d..179b302f43c2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -280,6 +280,7 @@ config ARM64
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select USER_STACKTRACE_SUPPORT
 	select VDSO_GETRANDOM
+	select VMAP_STACK
 	help
 	  ARM 64-bit (AArch64) Linux support.
 

-- 
2.47.1


