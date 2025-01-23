Return-Path: <linux-efi+bounces-2716-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C8BA19E82
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 07:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E5918896D3
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E31C5D51;
	Thu, 23 Jan 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH3Mf1ww"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8318FDAB
	for <linux-efi@vger.kernel.org>; Thu, 23 Jan 2025 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737614201; cv=none; b=LNcrNbBrO41X1GxzCLcE+mciCru2FRV6fVwjlVLgXnKnYghyQgg/IZDNTq9zD5Mr4CZDYRoLgDkPwqDcPQKC0kLTAQgIE3Aet3s6leb4E1+BJz+Bv7fIuoyHD2jar4gGK64PdbSBYVmDJVvs4/iIGpGa1jeMIThPuquI4b6hpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737614201; c=relaxed/simple;
	bh=GohUX9iX1KdYZfsFRrNlin2/Z4yhmVpAyvrZnsO3XVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qPpu6B+1A9LpH31QssDTLNQBE2oNp8REkU9d1WYZlwMjwagalsUPYyFJ7X8n/ehrPtnIhH9rF3ukSvmN6+YSVJiv2aNrzuWLHQME5C9Y+v0xpcoD1BdfMd7rTcMVCatd7GgcC2KhtWjzrCXARhJanSw20aT1f84jN9D884NWgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HH3Mf1ww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737614198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9GWnA6cQazWu1ukn6JyrCDn9phCCCsDqKbbThQSvZEM=;
	b=HH3Mf1wwb3+Syj2Afu1W4XIc4lRZzejPa8hIqKvGUl9SmbyGc4dwoMl6i2g8nO2T4rsicw
	GrrLY7OjDazm/ndsnGmKOReaUK0ny/gVZ2qp7TOvLLzo5aX4xw2dSdg/K8xVelA2VnrmDS
	bES4pNsauJWleDB5zk/ueJH/ltrw+VU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-4SHC3acIOBiWlyhUCODqXg-1; Thu,
 23 Jan 2025 01:36:32 -0500
X-MC-Unique: 4SHC3acIOBiWlyhUCODqXg-1
X-Mimecast-MFC-AGG-ID: 4SHC3acIOBiWlyhUCODqXg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E49F195396F;
	Thu, 23 Jan 2025 06:36:18 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2F89195608A;
	Thu, 23 Jan 2025 06:36:13 +0000 (UTC)
Date: Thu, 23 Jan 2025 14:36:27 +0800
From: Dave Young <dyoung@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH] x86/efi: skip memattr table on kexec boot
Message-ID: <Z5Hja30Wb94uGQ3L@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

efi_memattr_init() added a sanity check to avoid firmware caused corruption.
The check is based on efi memmap entry numbers, but kexec only takes the
runtime related memmap entries thus this caused many false warnings, see
below thread for details:

https://lore.kernel.org/all/20250108215957.3437660-2-usamaarif642@gmail.com/

Ard suggests to skip the efi memattr table in kexec, this makes sense because
those memattr fixups are not critical.

Reported-by: Breno Leitao <leitao@debian.org>
Reported-and-tested-by: Usama Arif <usamaarif642@gmail.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Dave Young <dyoung@redhat.com>

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 846bf49f2508..553f330198f2 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
 
 		if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
 			((efi_config_table_64_t *)p)->table = data->smbios;
+
+		/* Do not bother to play with mem attr table across kexec */
+		if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
+			((efi_config_table_64_t *)p)->table = EFI_INVALID_TABLE_ADDR;
+
 		p += sz;
 	}
 	early_memunmap(tablep, nr_tables * sz);


