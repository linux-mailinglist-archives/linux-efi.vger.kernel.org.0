Return-Path: <linux-efi+bounces-5771-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1682C9E846
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A522B3A8D2E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B12DCF58;
	Wed,  3 Dec 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VXfrW5/q"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF629B8E8
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754806; cv=none; b=NWWh6vs40nTovj5Kcnm4/2Fn87PZF7tlm8MmjwbtIZZ4L2Zthe9fDx9udXcQZJj0v8D9gsNYDbfYftrrJT8lzXj7UzX27XppPzJLkrCSwBxTN+eG8UAcdHtSeQEEykgIFvmOuMN7zisBFg7qax/Dn3vd0oWY+X9PvE4aL/EOt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754806; c=relaxed/simple;
	bh=t38yCpXfhGaJFCv2dPQBYGAzzYCwvhd8rHTNjfldwL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9SvjQ+Va9fOlGXtVdgZvw7MMrshE1AqoDUlCBeX60Bka5LJvuat3qPBtWq0Z8kkOZciaO44+ovv+u317N4f4HGyixtwnITrHftnIvLcOOwhI6bsPuc1wtuSij3u7yUEYjgd/mAkWwm4XJ0BryWIit2pCIvJ5jd+vAxqYCGb2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VXfrW5/q; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=17ehAdCmd5GdNPJvcuXTDfiNmU96ZPGaXeDJlN/9omA=; b=VXfrW5/qAYXK1Yi7stmYrNslmM
	KD/mGuCSsmxgSFgYIAXO4CatNtxJRrj/J1FHXdq/raIX1M4kLtBMmoy0PhYr+7ZvqmZHPLJzDUlmJ
	mD+/dPq0hbxkmUrf4hsxc3cJNYk2aU9Bx+3nUfxMlhixlFVKbAeCY9T6rkOK5bwTAY1yMSl8KabxR
	d6Yow24xipWndkG5Db5+6UgHpAk20Xhxok0wlzacelVFHbCHBjIk23ccs+vH0BPfudY0mn1Bap9hq
	cozVWtIc9oECT9mhLd2Vo9GohMBaH9Bt8h4imO2SR4ZNguH6vzdaPEw8oIkn47VpjXttOtM8try/6
	9mQDF7Mg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQjL2-008CVl-Kg; Wed, 03 Dec 2025 10:39:56 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v3 0/4] FI fbcon fixes
Date: Wed,  3 Dec 2025 09:39:44 +0000
Message-ID: <20251203093948.54296-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two generic fixes split out for easy review, one refactoring as requested, and
then the last patch is the panel/mode quirk to allow for corruption free fbcon
with simpledrmfb and efidrmfb on the Valve Steam Deck.

v2:
 * s/unsigned/unsigned int/
 * s/pitch/linelength/
 * Removed comment explaining the Steam Deck quirk.
 * Added patch to refactor quirk application via callbacks.

 v3
 * Added forgotten __initconst.
 * Use separate callback for the fixup quirk.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org

Tvrtko Ursulin (4):
  efi: sysfb_efi: Replace open coded swap with the macro
  efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
  efi: sysfb_efi: Convert swap width and height quirk to a callback
  efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck

 drivers/firmware/efi/sysfb_efi.c | 72 ++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 8 deletions(-)

-- 
2.51.1


