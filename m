Return-Path: <linux-efi+bounces-687-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134286FF54
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FCDB2406D
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D08364CF;
	Mon,  4 Mar 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evxjfDGk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DD364C8
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549060; cv=none; b=ZjGHzyklscbWEe7D+8HbMDjjHS93p8INRc27PPcA6nQgEtZqL59j5GCgzjqmfeWSlRn8gIpeQV1mM0SLEVOQ3racImBn1YPC/Bl+mZ/RqxmOdS/kH5D0CDSNQmkIj9MzApm9QMeatuWM3rxCkngqG1rFNW0M6Tnx9N78vyBw96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549060; c=relaxed/simple;
	bh=7VA9ZPTgvH6gPoGO4GWWyiovbu1DI+3WwiFXY6v1dXM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CFa3160bfRAicUwVAml3pJqqUmxGYk4hmHqMu8eWn+0hFPzS0DazJOsrspEgWkvb/jD68VVQTxZ2hsVFlrUXpb6OmK5EyeWjY/axNGAUYRJydCoPzedkSwilyCx3EUwfEgQaZF5hddLtYeMm5P3izRwV/svTzpWKg5O2tNr5y8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evxjfDGk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso24659515e9.2
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709549057; x=1710153857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/NsTt0FXGAkz3GnIMDDVZp4hQbRhedLzGZAdO/yQoDI=;
        b=evxjfDGk81z8Eu8Jhh/0CNI8agjqQ5lph/rPSrccg7ojg19S+3t14+gZZ2KO+pbVVw
         l68tjFkTfbv8y+D6sC/8VekbSJ8vwmtY9/+32qXlGnf7GakQOV76bMyAVQb/fZJ+hZXN
         VzxIt3No9KVai91GyEcqJB3XdMqFYTaAzqyNeJ07oRI6VrcV4y+TbOcpt+8Dax9hoK8N
         xibCgdt2WRV9U6vixA6dGBRzO52TrnCGzb6h9sR56fH6VSqSisFHo6EQGSlhvcnu9bFC
         cbjs7nPk4DsXg2zPnzcmnDWYdGxVki0PiX2Qd+hBffUyltVa88MfCUT3HPuo3X6U5RRt
         m0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549057; x=1710153857;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/NsTt0FXGAkz3GnIMDDVZp4hQbRhedLzGZAdO/yQoDI=;
        b=Dw742eKDKeivPDEsP2VkYeo85qM4A0Eb0D4if2Ab719S6NbVOdMlYqhz1nYBC6PlpW
         MrkNyTY5UjmmwpTapegLbT1q5alAXnxpb67ZYABHFcFwkmgYIVRGVQYDHdGOGSB1T6nd
         VUduGGoV/i75z34jjmYlKQxoaS8NADGvq/x1NuE+KNYlfv+rrfO5G2dEhFV4jF/U3ng0
         IHx5qbuy7uzs3Ll92feue8X1qDO6dvqvBmohoK2jLBjz04BYQ8jlCA8oasCN2lbebKnb
         0itJocBsRQ+n9lpwvb/jFss6ZM7UA3jjttu6WxypDr1TdOkwSP+2WsxL1f0zj76kusCA
         TXmA==
X-Gm-Message-State: AOJu0YwmQeuFZLPCJ5elS9/k8TJjgv6ElikpVL40cagZh3dgFG+YogbN
	gyYW3LTGJZ/zlwEVBaU1SSLtkf7ZHQ8uf+lwb/oFB2+fnXRuaL7h68edWkAjMMNz7Q8ReI7PP8u
	UzJixUk2Q0uu6HK2fEUp+WMRZypzEsMI2eSWk+ecVKZoAiNhtGagdCaQwDxet2nCfvahCMl7LqY
	SXkZECri/nM2lep5ZKyLF/0hZZig==
X-Google-Smtp-Source: AGHT+IGyeEF915RVbKS0fxkPwbExZzc/8gjCsEwdF0wMZHwA1/FOsXFHyMQ7qln4HvQLL8F4ctv7wXHQ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d92:b0:412:e6b9:3202 with SMTP id
 p18-20020a05600c1d9200b00412e6b93202mr3168wms.1.1709549057219; Mon, 04 Mar
 2024 02:44:17 -0800 (PST)
Date: Mon,  4 Mar 2024 11:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=ardb@kernel.org;
 h=from:subject; bh=N4WCtbABARllQrodXeDj1oAWTSHdNolci2a1ylo7WGA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXp0p/6Z8xiopYmHuXwiX07S+tZxc5nvVcusn+f7vDu0
 9ojFY5/OkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBENDkZGU4oCL8/cbskafFB
 4YkcVzwLjbYIyVYnnrsQV727Ne6X0iWG/+kMQToqD/o59hzbfCFjgk+mvXlO8fRZh9daGOdOZI6 4zw0A
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304104409.2326422-6-ardb+git@google.com>
Subject: [PATCH 0/4] efi/libstub: Fall back to CC proto for measurement
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a follow-up to Kuppuswamy's series [0] to add TDX based
measurement of the initrd and command line to the EFI stub.

In view of time wrt the merge window, I've taken the liberty of applying
my review feedback to the code directly, rather than going back and
forth with the author to converge on something we can both agree on.

Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

[0] https://lore.kernel.org/all/20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Ard Biesheuvel (2):
  efi/libstub: Fold efi_tcg2_tagged_event into efi_measured_event
  efi/libstub: Measure into CC protocol if TCG2 protocol is absent

Kuppuswamy Sathyanarayanan (2):
  efi/libstub: Add Confidential Computing (CC) measurement typedefs
  efi/libstub: Add get_event_log() support for CC platforms

 drivers/firmware/efi/libstub/efi-stub-helper.c |  83 ++++++++++------
 drivers/firmware/efi/libstub/efi-stub.c        |   2 +-
 drivers/firmware/efi/libstub/efistub.h         | 104 ++++++++++++++++++--
 drivers/firmware/efi/libstub/tpm.c             |  74 +++++++++-----
 drivers/firmware/efi/libstub/x86-stub.c        |   2 +-
 include/linux/efi.h                            |   4 +
 6 files changed, 206 insertions(+), 63 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


