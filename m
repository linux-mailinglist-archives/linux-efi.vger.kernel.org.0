Return-Path: <linux-efi+bounces-1776-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739A2978BCD
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 01:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60C21C21F1D
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 23:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E718E051;
	Fri, 13 Sep 2024 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="n8sNxF0e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0B189B93
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269649; cv=none; b=pw7ZtkKN6N7mIWwy8Uvume0nfasQ6BH8O5TnY2WOkzCR2MB05BXe0oobIt7OhKydH8vgfPzd753s8GDv5XAKhwHPcx7Z5nVG7z4ZeBAp3pRs3zJKFbcnr106+LqpyYC4myftEMswDb0p6Qy2q6POs306muZd2g/Ll/O9J2WTgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269649; c=relaxed/simple;
	bh=Crzg9hmq5LPADdASQA4zRbh7dPjZ1xqI+Kmgq3o6Oc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRr1GHkDvED1Sloq0XaEtXp3whnnMKZX/wtfxZHtlKirELOm1ZO1Gaxh9O1pTIO9lnvOQQN3c8OsnpoF7nsSm4wHKJmZrh0d1XHHZJPy8e16k1zgh/LNBEHNzPW7SQsnxmQJn4jb1Fn1iM1S+PosEDdigTPsXHEtKpSnux3Uicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=n8sNxF0e; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-457ce5fda1aso21503941cf.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726269646; x=1726874446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKowLLj1rEpuegkSJn+z8DbnyDQaIfPDvu9JHxdaX6I=;
        b=n8sNxF0eb8GprolGb4AdpdjfLnIqtI0ZYFhCotbgTKlhclcQlrkXmDhtIvNuzFkfAc
         i/dxGjS1hvgarNCOshEwqo7iImi238GXeUJn2/jZMOXY+lGdn17JTUBZc6pY7W4xiEmC
         bcF1PC02kxBkqGHGlYdUJMYz2U+Fk29QMfpKUWzN4OcaWoin/2lkZMSYBxAdLdXGLdwB
         TtO7McmO+lS1T2NH4rPbG+eg+xoDXvc5XmvKXKtfSGNEcVD3QuUU9P9N6k3QrTnC/q4y
         thxRds+TPwvUrxggef9bF+ja6qyDmY4HCXiKh8J0FPVse5baPgimOV4Q7VIrmr/k4qRV
         xMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269646; x=1726874446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKowLLj1rEpuegkSJn+z8DbnyDQaIfPDvu9JHxdaX6I=;
        b=wq3UVPC0CLl8kD5Y7mOP4VE8yx9MUKCh6JSpcnQbAb6bHDAQQOthLR3kVPm96vekJQ
         YVbKpW1IxMxYI2KsGtb14AnSTPm0sHusBXf7FKaQvkhRPCeaIQRAjCwFa44DBKCsaZqn
         tZyP89jB+AQ+mhdA6mEjVsb7wT7riVkk1tpDqvK2yK2fO9vPvL4scevUh2rVf3r7H+aT
         FFVN0He8IhWOPKLrzi5St9S4A5E1Qcq8sjOHFDJNCeTSipWksvfod6aMEq2jhlXTnh6B
         lVI1ehxZPV3/Eu9fm1VI8avpH8KUphR0NSipIKn+vSuhN+ikBEZz+nFh5s8dcPrnxyWh
         1PHA==
X-Gm-Message-State: AOJu0YxQRq0CPfe69wGLq0AxJWLg4oN/6NGJBZEzelqRZNj569zyeLqf
	Eiv9Bpczc7SCR6YRx1rRV7p/wvDgb3VrfFCLRXhggPY10702v214gDNM/6tUkW57+XSxTIDhGDw
	C
X-Google-Smtp-Source: AGHT+IF5NIHVlHuaEE4y3ptAaRlLmvMbZI36tTwSTYRpK7t/TOQFWvaJeuPFPNFrOnexOkgerUG54A==
X-Received: by 2002:a05:622a:28e:b0:458:3766:964c with SMTP id d75a77b69052e-4586032d392mr123607251cf.30.1726269646221;
        Fri, 13 Sep 2024 16:20:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm1245801cf.21.2024.09.13.16.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:20:45 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH v2 4/4] libstub,tpm: do not ignore failure case when reading final event log
Date: Fri, 13 Sep 2024 19:19:54 -0400
Message-ID: <20240913231954.20081-5-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913231954.20081-1-gourry@gourry.net>
References: <20240913231954.20081-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code fails to check for an error case when reading events
from final event log to calculate offsets.  Check the error case,
and break early because all subsequent calls will also fail.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/libstub/tpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index f194e43f00ad..8e04aaf428d0 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -124,6 +124,9 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 			event_size = __calc_tpm2_event_size(header,
 						   (void *)(long)log_location,
 						   false);
+			/* If calc fails this is a malformed log */
+			if (!event_size)
+				break;
 			final_events_size += event_size;
 			i--;
 		}
-- 
2.43.0


