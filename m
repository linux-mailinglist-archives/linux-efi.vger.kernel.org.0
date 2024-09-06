Return-Path: <linux-efi+bounces-1676-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B896FCC0
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE91B1C23926
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EFE1D7987;
	Fri,  6 Sep 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m1eWSad5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD91E1A0B
	for <linux-efi@vger.kernel.org>; Fri,  6 Sep 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654509; cv=none; b=OoG8BCEfVtGIyYVYukQHwrO5jrgX/vAi6hk3c5mFyRiOr4SpH2+4Ai7tEJPgfweicry7+JAsSwfN2qP6vHD79UAKCBLT97vGVLbGlypHV8KPZeBOezZe1Es06RKHUQPRMTwIfRqcss0ouI1azIsRd7noheVBEzAFw2IFCLz+sNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654509; c=relaxed/simple;
	bh=JZ41Hb7/UZd2+fA36sYxks+5a7KG3YyM6CyHkbkpwr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV4XCTtIXHEU4XduFq2yr9viSRF/Plna50xDYdzRoDVb8OXdBSpOmGYQAtb1Hl9EmNO76iKk8gfdItIi+FZB06/QjYn+VoNq1fnbjpEFjMqro7NBEzhJXbJRMJvhgBOR3zCJ2S7UaEuueDOc/2Q38gAm7okYYvgyqhZpn1pYmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m1eWSad5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99fd5beb6so61515685a.0
        for <linux-efi@vger.kernel.org>; Fri, 06 Sep 2024 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654507; x=1726259307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qY1HTk2ePHnVObjiUrKBcGOuLQv3wyl16cvFBMoBIo=;
        b=m1eWSad5PBFvwie1QaX62vmL8UuQRjMFUROf/tNySEOG5ARrGOKO6JrEs84OnHNWLX
         ncGh0b8ssIFRNS6fBWBtqqQ+ZCNWOrlygYWTb1L5zZ+2iWWyxzpoWNyXH7AKhtpyNW3V
         +Iv4qux7FlABozayIJN3odj3YaHsyGSFEK+JgHd7WeZgqUruCpN+oLLsXxpKBMolLxjg
         ZmS8fPrFbmNhkYbU/7Yye+iLM0pO+JxjakSE6KNsIBRDON4xNN5s369U5rlLJxMDbcBK
         NbkLu/HXXCbJZ2chTf1Hrs6C8E3CVRZ9diLFmfoZT8dv0oi5q0l7cx2Df3gjejAFfXiI
         7/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654507; x=1726259307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qY1HTk2ePHnVObjiUrKBcGOuLQv3wyl16cvFBMoBIo=;
        b=eZoD0x3Q6IWRQMrfgS1BW+94IR/tjTLP5AaUg6R8YAmy3Rp+lUe9/at9ERHDuiNgmX
         BM0zsJ/pBrLNPejIwkdnx34Mk7j4NUm1C0H559gSr0Vb7be0mz+FQdMJs3URumzHPyns
         NRVkUXNeUilgT6CLSWWjkB43b1KBsdtE942tQsrXeGnim91TOi+shXqmU7cEZm1l0BCx
         FewzmABQ/DXLwfIZMAlOWI6Kuh32k3lHCpyWcCxrMzi0h3UY6lDzhOVegDn6xHklSkR4
         pp2P5kfU2snh3Do5hh87m8XTQ+2htKXidLMRBvJf8gtZEj6GOh/u87SjuE9UEQUW8VaW
         ZYIw==
X-Gm-Message-State: AOJu0YynU7iNioqdtcEgRWv2jxBt5mCpPFDiIdNNPSoyvIBupd5W/VL5
	8EsY66p5lwS3QyuwuyquLWQmUNx8y5rLJ62UKghK63QFQ3Mt6ioGY08pLQfKfFPkA2O+a9Nt8fo
	V
X-Google-Smtp-Source: AGHT+IHFAOsyAS1saP4F/TdfdR3JBN+Ae7crbCz/ei1WfpsqQgWENY6HB+FbK+cs01k0KPOEVsJfTg==
X-Received: by 2002:a05:620a:3187:b0:7a8:512:b57f with SMTP id af79cd13be357-7a98870d102mr1939603085a.0.1725654506873;
        Fri, 06 Sep 2024 13:28:26 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:26 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 6/6] libstub,tpm: do not ignore failure case when reading final event log
Date: Fri,  6 Sep 2024 16:27:45 -0400
Message-ID: <20240906202745.11159-7-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906202745.11159-1-gourry@gourry.net>
References: <20240906202745.11159-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code fails to check for an error case when reading events from
final event log to calculate offsets.  Check the error case, report the
error, and break early because all subsequent calls will also fail.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/libstub/tpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 4f9f0e049a7a..c71b0d3e66d2 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -124,6 +124,10 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 			event_size = __calc_tpm2_event_size(header,
 						   (void *)(long)log_location,
 						   false);
+			if (!event_size) {
+				efi_err("Invalid TPM Final Event Log Entry\n");
+				break;
+			}
 			final_events_size += event_size;
 			i--;
 		}
-- 
2.43.0


