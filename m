Return-Path: <linux-efi+bounces-5102-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07508BFFE44
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5031A6070C
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A842FD1A3;
	Thu, 23 Oct 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RMu8PuwN"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A92FFFB7;
	Thu, 23 Oct 2025 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207774; cv=none; b=J0MVWqRTJ66CcFvdBuZNo0i9/7wjoiNihXqnRU/EDqsMNLKUwO0oYjsIVPZeQUriSHa/RoqgWRTvnQspgMJ0rpEyeFI+JyV4prAX/NBGo1uTAjeOmGLO4sILQ89Xfb/urwWbRgXz6/4hxHboszdwdJzUbfIHeSjrQ6lYpdmTnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207774; c=relaxed/simple;
	bh=R+gBMth60SuPuT+wgJJnhF0Ao/i4dyEqBxAyBFs2B4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPmKULCR8hhURsC8LRmH6Jwx071Uf1HlrP6PpDyi9BICtpjzzozRJ6ZzI05IWiwsA99ueEPiAb6Rt+TgO8k8dBl2L+bYdsTsOZRDNDV74bBWO1Qo/TOk9g9xC5pjvr4JgxQ4W9iENKsgPFN6/dVGb4sVboZe4GmLrDskn/+00fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RMu8PuwN; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761207687;
	bh=ULH0iKccBdyyGfKIPE8SP4G7gUUCYwe77y7PIyw28Fg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RMu8PuwNyWwVysi3GYFmcVSahB5oN9moyuTihwByGtDHXpY+VWx5YwLa9ho4Zqmju
	 tjwRuotj9zbf2yf4mllBSM3oXd61bAx7O/atSB7X0uAFbfWw1gApInmGV5eDxgxw4H
	 rlNMtLs65O/DkDV6IBIVo9gBqBpW2T9pAsZ5BiHU=
X-QQ-mid: esmtpgz14t1761207669t0c42400f
X-QQ-Originating-IP: e3alAhthGovW8qQgWjONEgVC26JHgxvMtn7tkZ6Ir2w=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 16:21:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15548364574209632140
EX-QQ-RecipientCnt: 6
From: Qiang Ma <maqianga@uniontech.com>
To: ardb@kernel.org,
	linux@armlinux.org.uk
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH 0/2] Remove duplicate function calls and useless message
Date: Thu, 23 Oct 2025 16:20:51 +0800
Message-Id: <20251023082051.75183-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NlWvLSkfVnGcnCndnoah1DKaYHvTUYsnQRFyON0Cg2sXiKIeOARTbw+g
	Kvg0gezSHv69PiNOktscNoSPLV7qmDyXa4Yn3oDzcuZlnDMGcrc6MsyezB2aGpZvF0A0iaK
	hf3QlldP+tKkFO2laQQiaowy+S8Ka/JOWGTWERLq3YexkekjGBpCLsmulxLBnwUDxDBBNfX
	1LcKPzmK3xyMIjbPo41Hr+sdygm7eaNy2CV+tVlEKMo49IOIOpWKwxL6tPCN7o0awt4/O3p
	KERnPVl4pFaLjlROpljizSnxJSxa+xqzURrXQCIvvGgdTIE28xnF1mrPtdzerk6KvNZdAC6
	xGThdYEcA26W+jkdnxtPIa2zrNl6q8yZihmyRO9xGbOVSb6CXiNvETSvDsV5RbG8S17EVBb
	JbRdifc/mO2L5YTz1zRkYy1RQJOX/JlR7r/m9ww4kbRLArG1keemKwoE3aaI0HSNB+QCtkf
	rA5nkOX8lHbFSFGm2gDi7EcGOT1sq52XB8LAbCZt00Ua60Xz20U7zfeD7gQAJqamLhK0K9l
	uZFkn6qmMVeoc8wGWemU0fLJ6WPnItlgxUyyNaG4P1wPKfeQjdYuYdmv7wFG7kno/Shq5+F
	QjUPUHrCCE6LKHvI3DHhYBgNAq4iZIeNefTWXicKnd1CoP8eI+t9SEiwebwsbBNK9ge9xJC
	BAxxhHOa7LH2qhysk5QgVxr1f/Aqf5c9TYi4rWMXmNZS4VgPViQeMO48VBV9OzLCJcCB/ZC
	Vz4EANCo88iiGBvNRCfqsEUauKjP8qHcaRTl+t5eJUaSm20Ifgy4QCNC9rNnEJVaD78tWiM
	Qr3vd10Cxb3l+OH2WNdp6HtUiHRxY+Y6JraJpMk+XeCpwvfOQsYoivL0miXmPzDv2wzE/3Q
	a9HVyvlfrnfvXPk84EP6seZriqqd0JRt/Gctcmo+YCnrUkvFoeJfQT9EiYvad3S57wqADqQ
	SLOexmLrBw8yPL46QEKzh5BGW6togFKYU8ZRf5DShjAWSf7qlLNkz+nhIjl8Mb3yYHq4XQJ
	aZorEGBg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

From: Qiang Ma <maqianga@uniontech.com>

This patchset removes duplicate function calls and useless debug message

1. The efi_set_mapping_permissions() does not need to be called in
efi_create_mapping(), because efi_memattr_apply_permissions() will be invoked.

The calling relationship is as follows:

==>efi_create_mapping()
   ==>efi_set_mapping_permissions()
==>efi_memattr_apply_permissions()
   ==>efi_set_mapping_permissions()

2. Based on the first point, efi_create_mapping() always returns 0,
so there is no need to print the failure return message.

Qiang Ma (2):
  ARM/efi: Remove duplicate permission settings
  efi/arm*: Remove the useless failure return message print

 arch/arm/kernel/efi.c              | 5 -----
 drivers/firmware/efi/arm-runtime.c | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

-- 
2.20.1


