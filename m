Return-Path: <linux-efi+bounces-1772-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42028978BC6
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 01:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692691C23D82
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40291178362;
	Fri, 13 Sep 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NdW3Hzi9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5414B061
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269644; cv=none; b=iB+SOYd9CKfZxXeNGQDJEaogF2M1IWR0RokqgDrr4agHSy9aZg10e0+uO4/M4yxU3IFqD1Td25N2qd3n/KVuqVm0U2+xhALmuaAwBA1BeBY7v5xni47Bo6oacRuUK/UCnlP/MWgDLkHnxCTr26bZQYuPrmZ6B95LGb422BQWXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269644; c=relaxed/simple;
	bh=EeRsW3l/bgx27sZwHgaQEJ/xtECgJGIfPbW9uZwGdhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gD97eeL8+Gj4wjiOo3YuVCNFh5j6p8lhlDQ8fxARQlWRfmNDpyfZ0Bey1DIbvDeOfmbPwn3dfLin19CuAr3AJlkvCpNzTFhZn76LgTF7+CNOEFf4hdSPmmbXvBVtbTaTJK0Sp0WAkc6vXqJ7R5IK9wFJWfjGxKlNcTNFV547WSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NdW3Hzi9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-458362e898aso22328251cf.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726269641; x=1726874441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B65GRKe+0vYbGgtddhBHaAOt9Gcud5s/LIbVtVdrK6I=;
        b=NdW3Hzi9U+VLC37W1aPoD7Z+hbbDhksb3JIQnupe1Th47C3DPk6rtxjpGcp5DYPUzG
         vgO5RMNw+QOJ9rdlpemugjq8RnDI1pyyzUmzjnHgs6uAQRwAjGm1ltEgmVqhN3hx1J27
         vwVyJe3ACjSjRp2MjaOc5dve9XYhy5AarM/em/wWUqI1SSYmzXh5PV3WlF0w7L/qeTi6
         XCBxBu9fHW92+Vz47DAz57SApn47CHwObin4ZiN/04etXEEBTMXisyXIL6mkAeP8MC4j
         RSNvq6zfGHcUimZaWSgN/to67BN6BGKeq/yz9FUcL8DW23i7kSxcUbkvIJKJb+mjRft6
         3K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269641; x=1726874441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B65GRKe+0vYbGgtddhBHaAOt9Gcud5s/LIbVtVdrK6I=;
        b=ngo0iAr/eRqeyXamjxoutGLXmuhK2w1wnSmTtIeBTk9hAr1oZ8He02tSNw04Az+JJP
         RBwTECChUUUpoiRJ8sSFxEnhZgji1Qf39H9mX/YPKfsuOT4eOx8ePG20Ee2ofaMoaQB/
         ITpfB8YfxOXcabFcdonu6VsFn8c/t88Fd12P2rymu2yrGFHj/cvI8ffXalPYSfWladAt
         Yn7/wpUSic/K1tAsNN5i4Q3tYTDoZ/wk1pol6b43oO8+zF4lEMqYQwP0Svg3ExO9twfe
         UG440yh35GwE/LqDjgdYg6PfVTACoJN0Ay7JYEE0Es7XCW4j8/VeUD+fV0gXcnMyK/tn
         RUkA==
X-Gm-Message-State: AOJu0Yx3mVSxlv56dCZiRky8dbjh0syEI52TB94Ng//puBieq3LZSx9N
	uUqYVOdK4MkAxi7dIOwBN0znWHmapRvt/9bv3QYnUC/zNuh1G6I7ProlWuLD7MPRmlHtQ+3vY6V
	M
X-Google-Smtp-Source: AGHT+IGZD12EPsM+AeHsInOOfJN7c9Oivml4pbnxnU151SvSbzhTNPTq8CdnsdUkSxgiO2o/WcbX9Q==
X-Received: by 2002:a05:622a:48a:b0:458:3353:9a11 with SMTP id d75a77b69052e-458602d9969mr156446301cf.21.1726269641040;
        Fri, 13 Sep 2024 16:20:41 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm1245801cf.21.2024.09.13.16.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:20:40 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH v2 0/4] libstub,tpm: fix small bugs and improve error reporting
Date: Fri, 13 Sep 2024 19:19:50 -0400
Message-ID: <20240913231954.20081-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The efi/tpm code has a number of small signed/unsigned bugs and
inaccuracies are prone to cause further bugs in a difficult to
debug manner.  For example, there is a signed/unsigned mismatch
in efi/tpm.c that can lead to calling memblock_reserve on a range
with an effectively negative length.

Additionally, there are silently ignored error conditions may
result in undefined behavior.  Address these.

Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (4):
  tpm: fix signed/unsigned bug when checking event logs
  tpm: do not ignore memblock_reserve return value
  tpm: fix unsigned/signed mismatch errors related to
    __calc_tpm2_event_size
  libstub,tpm: do not ignore failure case when reading final event log

 drivers/firmware/efi/libstub/tpm.c |  9 ++++++---
 drivers/firmware/efi/tpm.c         | 26 ++++++++++++++++----------
 include/linux/tpm_eventlog.h       |  2 +-
 3 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.43.0


