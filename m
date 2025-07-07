Return-Path: <linux-efi+bounces-4166-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87636AFB81F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCCB3B227F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A22264A6;
	Mon,  7 Jul 2025 16:01:14 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2D22541C;
	Mon,  7 Jul 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904074; cv=none; b=sXANTAvaM5H0mMhe/tXCs+ppEk1po+X9qqYe5Wdq20cB7pTsMgyGc3fywlG4eMMK069VNOJfXIlVzPqY5QrmHXyRPrKCbQXG6ZtSIlhv4aVKMvq73/vQEFnKbhQembt4LqtHjLcsS62fkeMpw84zgN7dgCLxEZo/zf6V3eVmMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904074; c=relaxed/simple;
	bh=NbHeUY+lOtajZkUGdosjdc9I20/L5D/pDbD9Gk28XbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5tfEPhvhmxo0DFMiDo9xBeY/Y6PepXbkBSGHl9rscF56EpWazLDUSCqqBQYNVqR692paO2T+LPrfcS1nPb6RS1C4SD6pitkQa3I3iMRX6prZtO9JHyToet3sVdGJ/ZxnLt1FMWPK/hsS2s3EFIJaEJjQ/0ywUbEdOGyET6TjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a818ed5b51so25172661cf.1;
        Mon, 07 Jul 2025 09:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904072; x=1752508872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/qtXs9s+QdBQr0M8ZCKL9CCSiHQeQvxN6ttPMxUpz8=;
        b=sbif0bHxHtOScYXI0cZFTCo+vRfqi3IRFd+kmYl0I9hC2K/dn0tXYNg6ZRlHzlvWJC
         EWkpSKZM9qdwPLyx0ug2fGvgjYWzBbuGTf7HVImxf5ZUiJMiAA6e/YdbdrNlhk7+HvLS
         wganEzefOWUy3SHPNfzY/p31+K6UlDgwGDsC+Jds3ugp3z+UirWC7uJ3lYInbhdSSdEA
         tC/HFaCKbIeeXWOSgSCz10jssjgU24iegEBtFTuYzrCaLWuItd4Eh/E/iHxK0Zzw6j5Q
         mcoQR45Mg/TO6j/sCCmYXX7OkHEegzr7a66j4gZ29k81tEBwM2jA5O9KSkafKJumaROj
         V6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX1M4BpBJboWJUDK+qvT3pskhorLEL7iumGKSJ4HcLFMUS5QNw8/ibVHuKCYJ+0vvLPhDwZe12oQJo=@vger.kernel.org, AJvYcCXCLf7Q2oYm4qXHnwIC1xUD5hzcyBtueCbjMiSsOU7Q1ojirIcnAEpEXj8HyK5PJSRDhU0KRuOuyr9FMEHD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2074pt7VKtvwCm0RJqT4dMf32zg3X9r6LKdvIWxyXDh11frp
	F1DAkJ0xJe0Uo6PQ8MUYyGieCr9gcLxM5k0vxeBnLpwRWyl1x1bfRpiN
X-Gm-Gg: ASbGnctE4jpOuq1vRjOi9fBltM5y/+T/BdGWM+/wUj411ae+ljaYSzWImai17VIrpCV
	TrZsSonxZ93r0NUWeQpJDjOwW10NLr5HwcOVQwtiXcrUeuQ0lJ69k0paWClU7UqagyuggKKSo73
	rDYe7cyyvSZe+eB6Oi0OHLLjGfmQUziugluLF9NgRdDKhAU5E1Abh5ZxD/oFutwzVXV+sjms5Lc
	wwld/RzTVKBPs30Ce8RhPYRo945tWI63lS9ZU94hglsplTGdfz/dS+NkX2wsscMECK2J9VdZTNd
	2s3e6NBilBO0TCqYqskt5raR4MXAWL2tfyDlNbynsRC4cly94XlWdw==
X-Google-Smtp-Source: AGHT+IFpXMddctveiP/QMxx61ibzLPUrbrG9TwhgcDmq5K8qaNkqmg+HzPSadAi9ZoczsHtWQJPCSQ==
X-Received: by 2002:a05:622a:11ca:b0:4a7:62da:d0fc with SMTP id d75a77b69052e-4a998692482mr169244441cf.12.1751904071495;
        Mon, 07 Jul 2025 09:01:11 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:70::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994aa77d4sm64401341cf.73.2025.07.07.09.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:01:10 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Jul 2025 09:01:03 -0700
Subject: [PATCH 3/8] arm64: Remove CONFIG_VMAP_STACK conditionals from
 THREAD_SHIFT and THREAD_ALIGN
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm64_vmap-v1-3-8de98ca0f91c@debian.org>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
In-Reply-To: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-efi@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 leo.yan@arm.com, kernel-team@meta.com, mark.rutland@arm.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=leitao@debian.org;
 h=from:subject:message-id; bh=NbHeUY+lOtajZkUGdosjdc9I20/L5D/pDbD9Gk28XbU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoa+9DPlSZXS9bOCF/XaXYyqeIru4s1W6wF6zBO
 BVU2VBp9JSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGvvQwAKCRA1o5Of/Hh3
 bdv4EACwqmPF3xqi38Scok1Gw7W+ofu+/uQeH0vwEOK7PobxMJzQgLb0L/QOe8DaSMrg2Cbnq63
 5xEsff8WqrX3KW0vqqUiwMVkTshGyWm08H8579SYW/T/LFfaMQz7ikDTR0GtETBH8ILxs8k1oA/
 0SCPggCCOFGoagXJjsFp0XO3fBBS07+t1UHpeooYP4HEcOM2NLJ/EYIqJ+i/BP6e4h5UtCHMS0F
 gTkPfQDco8ATKNsubQ7xKrET6cnxdoXoay2JMco4GpTsmL4AOCEHf1f1b1B3HgChGWrxX77E6g2
 LYJXLpxAU+Xa+cG8LDeRQpj9KwZaptmQCHtQ+SFmx3biVchlLmvg8DCPZ3lLmHezRVt3NLA8kTZ
 8hgjgYpkcc2WGY6kIsK7mQCkZl2smHj8ieiuWuBxFmuELclaLx3L/hQJdQ6qttgKHF8/s+cLdDf
 poJsCUg01hi50RtGNbIR/EY9VnbhtRMncplUFtycBMKCfI94juWbgxAZMHiytB2KOLUdBsQrs54
 qc+Hj3BcVk1jJ6Q9o9r7ahPzvXIIdr0nZGEpkDagRknWFxVApWRp8ObRJH71II/4hE4A31bOLbZ
 q66MzoSnxFGwdze26wZafxZ+tfjb3sHsnsJDYj61MZdNfQEYgLtf13TfG/+pkWWInnnxiYjUnb6
 8L1ZGwJKe7rDEMQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Now that VMAP_STACK is always enabled on arm64, remove the
CONFIG_VMAP_STACK conditional logic from the definitions of THREAD_SHIFT
and THREAD_ALIGN in arch/arm64/include/asm/memory.h. This simplifies the
code by unconditionally setting THREAD_ALIGN to (2 * THREAD_SIZE) and
adjusting the THREAD_SHIFT definition to only depend on MIN_THREAD_SHIFT
and PAGE_SHIFT.

This change reflects the updated arm64 stack model, where all kernel
threads use virtually mapped stacks with guard pages, and ensures
alignment and stack sizing are consistently handled.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/include/asm/memory.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 717829df294e..5213248e081b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -118,7 +118,7 @@
  * VMAP'd stacks are allocated at page granularity, so we must ensure that such
  * stacks are a multiple of page size.
  */
-#if defined(CONFIG_VMAP_STACK) && (MIN_THREAD_SHIFT < PAGE_SHIFT)
+#if (MIN_THREAD_SHIFT < PAGE_SHIFT)
 #define THREAD_SHIFT		PAGE_SHIFT
 #else
 #define THREAD_SHIFT		MIN_THREAD_SHIFT
@@ -135,11 +135,7 @@
  * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
  * assembly.
  */
-#ifdef CONFIG_VMAP_STACK
 #define THREAD_ALIGN		(2 * THREAD_SIZE)
-#else
-#define THREAD_ALIGN		THREAD_SIZE
-#endif
 
 #define IRQ_STACK_SIZE		THREAD_SIZE
 

-- 
2.47.1


