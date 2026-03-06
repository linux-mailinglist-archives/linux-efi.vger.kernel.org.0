Return-Path: <linux-efi+bounces-6254-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG15E2/5qmmcZAEAu9opvQ
	(envelope-from <linux-efi+bounces-6254-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:57:35 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635822462C
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4316730330FB
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F33EBF09;
	Fri,  6 Mar 2026 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ww7d+PKX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1733EBF29
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812643; cv=none; b=pd3erdGPdrAYHWCarErKN/lVMDuL5/V51JtulRpC9Rl3OybqetQaL/89dZ0UyfmQ++kgcMtolzHgfaeTHg3WGhghK+1JNjZzfgFV2ec3jXke6KlD/iaR7SFzjhtPDM14Qqkb8+y7ksIuCyCjJuGo4MpsIuNPY146r/DqtBjPdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812643; c=relaxed/simple;
	bh=DAh2QfDt6t1E53RT+FSV0rNEnP55d2Z3JtOi9oMWG+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OvrHEmNrhhfTmoISX3ebyMKgvYpt+W7UlJAE1Ts0hbOvqhDaGsObbJ7rB9z+/gCluvOEWrg3CMerPCHjKDFWpUWQIjNYWJ5i4L1GZ1Z55/R3d136CAkvBXYfiFqPfYfTTuUPb5xO/u3DC08KSuH8Hx4M7Ns0AE8jFGkmVBoYY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ww7d+PKX; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66142e57280so2437535a12.1
        for <linux-efi@vger.kernel.org>; Fri, 06 Mar 2026 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772812639; x=1773417439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyUJVB6MFtFQFvl4CFebEtQPHCRh2l9RlIxPiMDk2SI=;
        b=ww7d+PKXbX11vOUk8KkBiNcrPgku1vZbCh1f7jQHZJACCau7fJondwT05bHmc+NRVr
         ++GiRm8yiPi5lOvApA0m4NkKjAbn+NsclOfaGfaIZYWV8m3NgYi2fUMQUnct11318w2z
         091ggjDIz4ol0v44Bd6c9Jref71isZebAAYoDnDzO+8Snkbxn+wVYbChMLFHdmXVD4gA
         g9GL1IDwNvms0pAq++YhsLhWG6RkEPl7cLZHCiTX8GHSx87TBJXMdrW4IUW/BdFvi8Xw
         HEtIHHGKzymu30fRu0ZnopgH2Cuayx9mJdNnZW0GcFZwSd78uOrjh0q/OJoOagbsGzlu
         EnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812639; x=1773417439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyUJVB6MFtFQFvl4CFebEtQPHCRh2l9RlIxPiMDk2SI=;
        b=bbhKbD3XXKuHM/3ldLU7DbAzA8ZPGiWiC/MZXQZ+LiE6PAJmr/zgVBnP7s8qfNnf8/
         Vdkb+2S5kdkfYLN3Nb/L8K6NOty5Q45F1s5k2znlPuWqd7382LNpMocRhIcyJt5sn/WB
         CMOjDIVBfqzHZGd3PyVn1pfTQvQHM+UkOV4t360hTDKMht9WMKXCRtxiIxJVwIJ+FSbk
         sVvA9/h9WlIFo+7IdNvHTEzktrGu3aMzrmNukNJ2JeUj3mfkWqNdHIvyT+M93Ys0sK95
         xYjLQVAybh51rvTux5EF3ukgX6WiGpm4vJ6rh618tpnwbXxnIkSF755lcPXxTnSRSbsO
         vz9w==
X-Gm-Message-State: AOJu0YzWZC3hYv+Wliq+rMMDYUHksFgCxGVf4htA+L1+oY+CtPxgBPhz
	JT+2hIAp/I1LAlpSsb8pMTriq7io1NcRGmdfI8ntGFqa2fCe45Wuse6vVcVY3ApyxhTEuN2mDQ=
	=
X-Received: from edsq5.prod.google.com ([2002:aa7:da85:0:b0:660:cd0d:914e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3491:b0:65b:ec2d:e615
 with SMTP id 4fb4d7f45d1cf-6619d49ccc9mr1313854a12.10.1772812639305; Fri, 06
 Mar 2026 07:57:19 -0800 (PST)
Date: Fri,  6 Mar 2026 16:57:05 +0100
In-Reply-To: <20260306155703.815272-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306155703.815272-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=ardb@kernel.org;
 h=from:subject; bh=I4NX+o2ZQ1RbPq3q2GfBRlvmTDgCe/3St3lTTXDwWr8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXPVzwDZU4G7L/ndDcmf2VCR7uP4onz/ycTO5etsj9Z9Z
 mfoSt3QUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyt5OR4Uxc3/Iw7/jPrVuL
 jTfqTl6z7e6DjZkz2TcmfxNon5XlOJmR4fdUhbnRnFEcfh+Lee11n51lOXKc43IUi7f1lRCRt9e 0uAA=
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306155703.815272-13-ardb+git@google.com>
Subject: [RFC PATCH 1/9] memblock: Permit existing reserved regions to be
 marked RSRV_KERN
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3635822462C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6254-lists,linux-efi=lfdr.de,git];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.933];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

Permit existing memblock reservations to be marked as RSRV_KERN. This
will be used by the EFI code on x86 to distinguish between reservations
of boot services data regions that have actual significance to the
kernel and regions that are reserved temporarily to work around buggy
firmware.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6ec5e9ac0699..9eac4f268359 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -155,6 +155,7 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
+int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
 
diff --git a/mm/memblock.c b/mm/memblock.c
index b3ddfdec7a80..2505ce8b319c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1115,6 +1115,21 @@ int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t
 				    MEMBLOCK_RSRV_NOINIT);
 }
 
+/**
+ * memblock_reserved_mark_kern - Mark a reserved memory region with flag
+ * MEMBLOCK_RSRV_KERN
+ *
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.reserved, base, size, 1,
+				    MEMBLOCK_RSRV_KERN);
+}
+
 /**
  * memblock_mark_kho_scratch - Mark a memory region as MEMBLOCK_KHO_SCRATCH.
  * @base: the base phys addr of the region
-- 
2.53.0.473.g4a7958ca14-goog


