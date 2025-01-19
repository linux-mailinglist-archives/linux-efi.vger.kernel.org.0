Return-Path: <linux-efi+bounces-2686-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A4A16365
	for <lists+linux-efi@lfdr.de>; Sun, 19 Jan 2025 18:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995CE1883F3B
	for <lists+linux-efi@lfdr.de>; Sun, 19 Jan 2025 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43E1DFD83;
	Sun, 19 Jan 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t4c.dev header.i=@t4c.dev header.b="Lmbcn3g6"
X-Original-To: linux-efi@vger.kernel.org
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD11E00BF
	for <linux-efi@vger.kernel.org>; Sun, 19 Jan 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307942; cv=none; b=rCL9B1xk/kzQEtealzGyTcSNyprkjywSMWYVHJJsJXMzKjg9gY+eaLzButTRSNB9/SY73VMVN7gT2S9moa2VRfu2Ph0dFayRXcy13CbnIFa2dfZ9MweNT/qdpFQg7oAYaouyNtRshAJdrqQ8nTrQV9DkOA7GIYdzfmr13TKJy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307942; c=relaxed/simple;
	bh=TLhs/gILxa2wbWGiD482sqCxASPDicFHnLv53sk/2hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J615PTWJwybjezscKKiIvGdlYp7r6IhOcGkH4lfHzR828g5+yng630O63tUnLJu6CM9bLeiWoKhDKC8vUpGyxheqQ1ZHscyQOprZlko2MK1786Re+fH7H4JLfSP4hjGTY5ujp38ozSY0c6x6UYiZrjE2B0MtY+ShDp3389i+x88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t4c.dev; spf=pass smtp.mailfrom=t4c.dev; dkim=pass (2048-bit key) header.d=t4c.dev header.i=@t4c.dev header.b=Lmbcn3g6; arc=none smtp.client-ip=17.57.155.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t4c.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t4c.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t4c.dev; s=sig1;
	bh=n3cYYSROnnOT51wYvYcK0RHdr2LVCZwk/pVs/4rATok=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=Lmbcn3g6jw3QMkVx1H2tlRmSE1nVUKojhbT9QlNp/FQhBhkWScoHfedJ2TJQXBHkK
	 RRTq8vFtIvFzF5zVUhCyjxJ33fc9kiguf5rxtRvh4+HdEEgZovu0N7YtYGlGFdqEgE
	 5KVK7ZNugSaQA8sMPqBe5BSGez82417D2zPKAFdpbqWPfsNQ9i1IlzLVHxG07SzUh0
	 9KYfzegxkJsoqTuht8EqdCNp7IgkqEmVaGztXMCBUC+kTY7CxSwm6IkZbJr48iifh9
	 /rLvunCvXbUw2GS8LwzR+QEb5YTERKEPUOzagYQD/LwAJTinGeGgFEpyn8bISdYhEw
	 494g/XZ5HYf9g==
Received: from localhost.localdomain (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id 95A9916803D7;
	Sun, 19 Jan 2025 17:32:16 +0000 (UTC)
From: Hendrik 'T4cC0re' Meyer <linux@t4c.dev>
To: ardb@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@t4c.dev
Subject: [PATCH] efistub: add efi=quiet parameter to selectively silence efistub alone
Date: Sun, 19 Jan 2025 18:32:05 +0100
Message-ID: <20250119173205.2965649-1-linux@t4c.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAMj1kXGLGmKU1Nvz8oo-aui1AtWo_8YDdT9cGtVweV9d6K6D3A@mail.gmail.com>
References: <CAMj1kXGLGmKU1Nvz8oo-aui1AtWo_8YDdT9cGtVweV9d6K6D3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iGeDECdHh-dtEZ--NT_PvUDMMUU90k8f
X-Proofpoint-ORIG-GUID: iGeDECdHh-dtEZ--NT_PvUDMMUU90k8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-19_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1030 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501190138

Hello!

> Could you explain the use case please? Your concern is that removing
'quiet' from the command line is producing a few additional lines of
output from the EFI stub at boot?

Sure :) I boot a UKI (with Secure Boot and TPM measurements)  with an
embedded splash image, and the cmdline
'memtest=2 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200n8'

The stub by default (without 'quiet') will print messages regarding
the UKI and it being measured into the TPM on the efifb (I assume)
rendering on top of the displayed splash image.

"EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path"
 and "EFI stub: Measured initrd data into PCR 9" to be specific.

> How is that a problem compared to
the fact that you get the entire kernel log printed to the console?

Very relevant question. Because of the 'memtest=2' flag, there is a
delay during boot, which should be logged (with memtest progress) to
the serial console. 'quiet' will silence these logs.

> Is every single line printed there relevant to you, and only the ones
emitted by the EFI stub are not?

Basically, yes. I want the kernel's printk's, but not have the output
of the efistub dipsplayed on top of the splash screen of the UKI.

I did not find a way to redirect this output, and adding a 'efi=quiet'
option seemed like a low hanging fruit.

Hendrik


