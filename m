Return-Path: <linux-efi+bounces-894-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B651890BF9
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 21:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A743B225C8
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B713A3EF;
	Thu, 28 Mar 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="kq/vpyOS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8945B1E3
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659083; cv=none; b=Le4cRDM6qZN+Uq3HQNL0c8yjz3mrzbt3Ym6bx7IHUDuIBIDOPpRJkOPqjsd9aUalpSIx1ThniM3ctXXGztmRNHKPydtqgbrChUZye/1FUy1rUIFPLs3r8L6eX3kLRbnWeBzE3maZjBQw5q5SWFAfnQr6SXAWea3plUle6EowFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659083; c=relaxed/simple;
	bh=lpeBQuTy/n7G1PDmBoR6r/SOsg1Hx4nhKJ7MYvcK7po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWWmTD5aXovuwU69dnXw7Zw4Ko3TVhjElO8Tbj7MeSyFrhzV+jY1nz9elbXeBCCF1BC4YCIlTPFc/MGOB4hOgtGRhWfSkN0Ybg8K2cv98MRIp0jz/ZHZr3KU4HV7QamwdH/C4+ckrIGL2jO8Iur0jbXUXJhXzZBxkm+XEcLb9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=kq/vpyOS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711659074; x=1712263874; i=timschumi@gmx.de;
	bh=ocf3r+xuAv1V4gpB+2uQ1yuwyHV5GwdmOQTUSDdBqaI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=kq/vpyOSvJ0PGqY1gWBde50Oj0UgRvZwI6oWQin/XjOo3YId941FcnKLt9pAhk6G
	 qRvzvur1NcE4nSIQR5aTk2UiSNegsbCNl9yMIxaMN8P6r+8GfIqobb9MoFe3yituC
	 L+2d64VE46X5J/EAoVcLO+Fil6YPUw0JloxJUC5NHeLOBonGlG+9yZSCS7VIzKLZr
	 v6MYHI4FBVFBQrSeeWwQyb6Sjl0E4pg7eRaiv01CsJKMHHuGrX2lzB/OtoA76Iphj
	 n7QJvWnlQfPtKN5Zl7vNMgUFfnZHeWagCIBDaN3Bj7MGeq/C9xe+fwguv0U2KvfZk
	 PghuOyhTL4/uLaGLaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6ll8-1rvybE1k5u-008NxB; Thu, 28 Mar 2024 21:51:14 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH v2 3/4] efivarfs: Remove unused internal struct members
Date: Thu, 28 Mar 2024 21:50:32 +0100
Message-ID: <20240328205041.76812-3-timschumi@gmx.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328205041.76812-1-timschumi@gmx.de>
References: <20240315002616.422802-1-timschumi@gmx.de>
 <20240328205041.76812-1-timschumi@gmx.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ItkpeyJ6Rxpa1YIZvGFi77vz8A8GeXblehSbGxbzZk+jR8gqaOG
 fpYSuUSR80inh3V1IjjqMLtWI1xOpCnpWXuIHSfknrNcC/laC/WDEP1gKslUtItsPULJKf8
 ujcfWpr0UnBhicjJTfBNffnMUGPoIFxL1USLlOKBl9uOgSxeV8zmK+CkDEFDw/+5Nt0GYPM
 g2ioDB+ifJ0QovVU3ar9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:py2i4mptt6Q=;iAieYc3rm6UfvOCBIliZDhUdZfA
 iUgAROoF2rukiswHOQciAhwNRrcCcwofFX3HVXSCkRGeP5jCg5bPwZy1y8QSGMOL3X/rvjBBu
 OKxhSy8SAXlGL0c+Ao2y5NdgbQ69zEN6ySXAGe8xYBuozC3tk5/8K5mJR7KGMCNqw5vYRPG6J
 RvFOOUjoBVyxr6cdan3x28s2DJnBPfYSC2snXBXCnEmNj+Z5n6GSKrPWIn9nIrH7jCuBgR7Ql
 3M7ORTESJJFmxmFwbeOq54grq31t/udMyYlfVsUe4iWEA6eBO66KYtnv+b/6ZtdA6TpccR8YY
 MVYg3bhZu81DrGNTrcy9oVyPH/D4gTUPl1r++NHSOmH0IE5svdoponse/NmPF1bkK8Bp+DqVJ
 s/wyLfGdE0iI4H2sZpyq/UbMbhHFUkd02h4aGJ82kYX4CWEvZ+kmJdlgCmQCtzkCWatWhHEhM
 3qkJOAJ5smFUtg1JK6N3LELB4E4g3c1Am4z+kj2T7MVunbOHjMmHiRaG3LUkVytJckCwMj9n9
 anS/fdHTlfvBHZb493fgR2NJCZ8N5mBWCkiW11GhsBNDuZwH3B0iPVo6v8K7fvGsa+CwJK1DL
 EkdLJG6OP6LMLvCFE4pXxtsddX1PSIWLSImvMTbgnUZ6H0QP6CGIH4SK/UtU1IejBsZI5OsA2
 51xo3FjAmPqu6in0w4PaitYIYoHlXYxZkhyZu98BXeYfASx/4Dhys4PKaKkaYT+4VREdi1MTz
 +e77wFFk6JZmDpTdz3hpDx2AZ9xrnsnCmuOaFuH6vfQzIB0f0orA6UZyKNcn8YQPBNN52KI+O
 vfqBqEJh2hUZKeshRXOxeNr8fwu1yS24VRWyrOtbxhwM4=

The structure was moved to the efivarfs internals in commit 2d82e6227ea1
("efi: vars: Move efivar caching layer into efivarfs") after previously
being used as the data ABI for efivars until its removal in commit
0f5b2c69a4cb ("efi: vars: Remove deprecated 'efivars' sysfs interface").

As efivarfs only uses the structure for the variable name caching layer,
the data-related members were never in use. Remove them to avoid
implying that efivarfs is bound by the same restrictions that efivars
once had. While at it, remove the packed attribute, since we no longer
have to guarantee a stable layout.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
Changes from v1:
 - Split out documentation changes into a separate patch
 - Remove the packed attribute of the struct
=2D--
 fs/efivarfs/internal.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index f7206158ee813..d71d2e08422f0 100644
=2D-- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -24,11 +24,8 @@ struct efivarfs_fs_info {
 struct efi_variable {
 	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
 	efi_guid_t    VendorGuid;
-	unsigned long DataSize;
-	__u8          Data[1024];
-	efi_status_t  Status;
 	__u32         Attributes;
-} __attribute__((packed));
+};

 struct efivar_entry {
 	struct efi_variable var;
=2D-
2.44.0


