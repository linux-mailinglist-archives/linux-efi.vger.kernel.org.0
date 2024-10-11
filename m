Return-Path: <linux-efi+bounces-1935-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E942499AED9
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 00:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E181B23697
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2024 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6701E1A35;
	Fri, 11 Oct 2024 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="aXMGFVlw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB61D3627
	for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2024 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687119; cv=none; b=pL1kro47/NrVZAaprUctOGLY9e69RaigOWjaHIejOkAbOO8bsmD10QWMvPK6aJfL90/DT+JY8gXKaimslq1fYvVfHieUtuwaAQXLcsAYo/rg8kWC5Uv4Y7cw1/9eCFFDzUIbhhovyp3d/IFLe2Mw0E6+/QWCrU85Hl1Ig/JEUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687119; c=relaxed/simple;
	bh=IoOQ/r0ZEvEc+eVi8klNZRLpo3c1DnP5rtosTnOlVsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmVsKiFGSqJZmPqGZxg+ayxXGx8iZCpRtwkJnFnccoZaW3H90rrni5MW53m31lUT4vuu3SpSEPEJ5H2isz+k0S81A6XmaKvEnExkLXtC18mq+caEB7iSyc/EvMN9+oGNpTKHm7P4TMy3cjRNFCORhKvBbzm23ZnAKMoRKLyyuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=aXMGFVlw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b10e0fadbcso176599785a.2
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2024 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728687117; x=1729291917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs8i3hJKqoLYVeCM0Bl+MtsW82Opz2gCCGdl6r+uwhk=;
        b=aXMGFVlwhTzLJI/Ke7f7CIJOANQLsKA3sbKwoRdL7FE3hZjjETaEChgXfct3cnEfg2
         zWTGiw/5uWMYU0VfMdVc9RjPdvuGSdYnw4NiBLTq71oisPkwEBEwFb8+uImyY5S70GEn
         vn3bEgNtaNAxV0cz2aMpoaK+0OtbR9GxoOSf1ct0McWu79g6B7du76rB+ZOO/vD+da1V
         nRGEBSSb2CSn1R7TFwkawwhMR6/O6zz/+BX5cALCWPfipK51XyY329v2cgXOGYhuu71l
         OkNhWVlFZQP/X02h3sD2qgbOSeBVUbZ4+zzaYcnEPoVhFKQTp0bTAiSx3ojEtOyTTpt4
         fINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687117; x=1729291917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs8i3hJKqoLYVeCM0Bl+MtsW82Opz2gCCGdl6r+uwhk=;
        b=H4xTYXQB84wpq6HCbLOP6PL4GDrK51S+aKmnx4S+YxJoP2oTZNdCqX7G1wvqeNJLKG
         LbbeLp6ez1+Yg54HuuIJsqtKMQpRay6x1Cy8dduHn6GwmBQIBvoVMcVwGqgWh3h4FVzo
         Cj0JxBT1Ko303IY5tWhxB0oP3rQUbUjkMPr7FXi4l6OcV6SEqfZXgGDLFZk2EIIceHA8
         8mTsc5+xfPt89z7v2OZzSTAhmurS4y5C490vAWMUn/IqXYMmQx5cKRV5opCsRUTg8whA
         es8dfXbB8GdQlHO7k9xYuxF3jOG4DUSgJnA9kYij361Xnt5k1OXqE8EipR3c5WRsO6wZ
         929Q==
X-Gm-Message-State: AOJu0Yx4jGb4TM2RBTfpwQYJBfkmMCDwdRwj25f1BJ7GhWTHPfBmd/1Y
	uZHS6ogodFJ8xmv2/3rA4tS25R4OfX06EYgW8v2zI9BHBb8COD4NyT5jbgKYowkKm3KOkdfy9wk
	9T/U=
X-Google-Smtp-Source: AGHT+IGfcKfQvAo494+ULnaOqrFgouyNS9uXORG9tlC9J5V/tWbUOfuk02kfyO6Euv6sX/AQWC9nhw==
X-Received: by 2002:a05:620a:44c2:b0:7a9:a991:f6d7 with SMTP id af79cd13be357-7b11a3ad395mr522173485a.48.1728687117226;
        Fri, 11 Oct 2024 15:51:57 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149893basm176499585a.134.2024.10.11.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:51:56 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] efi/libstub: remove uneccessary cmdline_size init/check
Date: Fri, 11 Oct 2024 18:48:01 -0400
Message-ID: <20241011224812.25763-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241011224812.25763-1-jonathan@marek.ca>
References: <20241011224812.25763-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efi_convert_cmdline() always sets cmdline_size to at least 1 on success,
so both the initialization to 0 and > 0 comparison are unecessary.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/firmware/efi/libstub/efi-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 709ae2d41a632..f166614ef8432 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -112,7 +112,7 @@ static u32 get_supported_rt_services(void)
 
 efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 {
-	int cmdline_size = 0;
+	int cmdline_size;
 	efi_status_t status;
 	char *cmdline;
 
@@ -137,7 +137,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 		}
 	}
 
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0) {
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		status = efi_parse_options(cmdline);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
-- 
2.45.1


