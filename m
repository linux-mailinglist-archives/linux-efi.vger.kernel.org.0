Return-Path: <linux-efi+bounces-1650-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C996B0F2
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 08:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F405B1F26655
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D684D0F;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwDdPWTo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0F84A3F;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430064; cv=none; b=P2b9dvS+PISaAAdmMlVsrD/lrlVbHiOn/rc2fuVVtUF2BQ0FZjBTOYW3CzYMvV0jkvkVW2O91nAL8PkAQN7pjVZBccGNdGuwArVQCvvxNmFefNDa2E0uk1pSc5WdRnqneukXALEIIZlRQn92H6dr+XWdCN0/dmuYWB5OJEqg2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430064; c=relaxed/simple;
	bh=GGUYM8uddYydyFnCiFRPf4PhRiNBc4g1TuHOUZ5NcQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2ECnt1lEckwInjHPA3QoYUgVCe0sjqwNvvHIh7xi4kXtTNxlTQWkHitS+MovjGAWJU2XZ05v00tMR4UVtC02W1nAqd0GiPjwqVdQs7Wv2eR6zsHY+GG/dFbe3Rfqv40Zyhe6Niu5+thbdSSMuFAs1ueDRynZ3zpi9eKoyBt+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwDdPWTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126D0C4CEC3;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725430064;
	bh=GGUYM8uddYydyFnCiFRPf4PhRiNBc4g1TuHOUZ5NcQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwDdPWToqJVeuNxGWy4xP75j5FeLMEH+3BKqcExa2U/lMYf5hXEZkWFJ97qYkFIHc
	 RB5TPSipF6j97woQYKqp98fSW6mRSMVNBh20Df8qgCd8HPMlhUpWXAIHwWXtJF2gA+
	 4FmsENqPQCW7FQZ/PjKNpNKMfwW2/1UkQzEyp8+qTypX3Edljsy+cH9ruGkWrtBRYH
	 TPoe4dwfeNMR/4RfasZ++FMIVveU27zAntBw9bAzDbkObgDV4jshSqW2q5aGjrNpnn
	 R74XYINGzEuSJdXUJ+Cm2Eyu7vC+Jq3o6knFRVeQYIHGGkugNbknYBfzEpYtKtsHQv
	 BuJAhaa9GqNlw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sljB8-00000006Itx-0e6U;
	Wed, 04 Sep 2024 08:07:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] docs: efi: add CPER functions to driver-api
Date: Wed,  4 Sep 2024 08:07:18 +0200
Message-ID: <1aaa0292d3a3361f1802accffaa184243fa769eb.1725429659.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725429659.git.mchehab+huawei@kernel.org>
References: <cover.1725429659.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are two kernel-doc like descriptions at cper, which is used
by other parts of cper and on ghes driver. They both have kernel-doc
like descriptions.

Change the tags for them to be actual kernel-doc tags and add them
to the driver-api documentaion at the UEFI section.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/driver-api/firmware/efi/index.rst | 11 ++++++++---
 drivers/firmware/efi/cper.c                     |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentation/driver-api/firmware/efi/index.rst
index 4fe8abba9fc6..5a6b6229592c 100644
--- a/Documentation/driver-api/firmware/efi/index.rst
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -1,11 +1,16 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-============
-UEFI Support
-============
+====================================================
+Unified Extensible Firmware Interface (UEFI) Support
+====================================================
 
 UEFI stub library functions
 ===========================
 
 .. kernel-doc:: drivers/firmware/efi/libstub/mem.c
    :internal:
+
+UEFI Common Platform Error Record (CPER) functions
+==================================================
+
+.. kernel-doc:: drivers/firmware/efi/cper.c
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index f60fe7367e3b..4d2dfcc746b6 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -70,7 +70,7 @@ const char *cper_severity_str(unsigned int severity)
 }
 EXPORT_SYMBOL_GPL(cper_severity_str);
 
-/*
+/**
  * cper_print_bits - print strings for set bits
  * @pfx: prefix for each line, including log level and prefix string
  * @bits: bit mask
-- 
2.46.0


