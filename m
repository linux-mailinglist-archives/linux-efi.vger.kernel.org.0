Return-Path: <linux-efi+bounces-5767-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D956DC9E66E
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812BC3A687C
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244532D77E2;
	Wed,  3 Dec 2025 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ldaT57Rc"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9C2D73B0
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752839; cv=none; b=pZdAW+gC2jFbiT2DgDO6B5Bic+KXcxIQ6DMUMsdCxFdDIWCyKa5g9a05m6Y+1MUaPT4qWPL/WieaidIfGDqsL7kLv6Ie0NsISQ/Y5AcGKCGzb5bWjFXBIshoyDkww2CwB5BzovfM5weIZs1rlC+GHrBkNrYI6EYA5zsv0PDg9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752839; c=relaxed/simple;
	bh=u6vlBWgj0lwI5+6om/sc68MdYdO6/cDEAT+HlF53HoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJRwRb/1ShEszq8/TKMk3HvCsW7QqlbyKqT/OGRKkK5ODM0kO0pzOfhu0TUvDXmz1cdyaSIBMw+QfVbgd1MLasdS3ni0dOdy7XjFndDLvKkhevTb7SQ0F0j7LBSF/qSgAxRJUUxaSxOps8O+xUJ6v8NtvqhAw5PQsTjxg9+io9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ldaT57Rc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Vs5lt6mdnpNHHugizVfBqfWtqo6gOtmBDJ0kNaBstCQ=; b=ldaT57RcjgMogfekPj2VPTkYen
	ei0yzwsg83UPWA72hk/nByOXIxF88SUApT5CoP6GqUpt8JfMeUIRH/UIG0XndFmI7OY0BVwhsLGl6
	3j+04jQxa6a55JUniNiMP884Xr+/2DOXrM1Xq0bjoHvDWV4+hHszzebXHEUaq37C/+TGctYcp/+pt
	BpJ2X/be4NUsO6aXHXoWVht95gaPmPWlyUPwKwbCLlcdA8gBXDGtuf2adaHNX05KYAOndhioeqvHs
	odqz87H0sVMdLYO+Bxxbbcp6qlpfsIOf5mOnndox4Oa0Fq2B+BPrsV1mD3ygynDX0aoUTLu2dG+ON
	qZsxAs5g==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vQipJ-008BpL-41; Wed, 03 Dec 2025 10:07:09 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 0/4] EFI fbcon fixes
Date: Wed,  3 Dec 2025 09:07:02 +0000
Message-ID: <20251203090706.53778-1-tvrtko.ursulin@igalia.com>
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

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Melissa Wen <mwen@igalia.com>
Cc: linux-efi@vger.kernel.org

Tvrtko Ursulin (4):
  efi: sysfb_efi: Replace open coded swap with the macro
  efi: sysfb_efi: Fix lfb_linelength calculation when applying quirks
  efi: sysfb_efi: Convert swap width and height quirk to a callback
  efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve Steam Deck

 drivers/firmware/efi/sysfb_efi.c | 71 ++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 8 deletions(-)

-- 
2.51.1


