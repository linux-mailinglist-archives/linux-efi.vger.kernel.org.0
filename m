Return-Path: <linux-efi+bounces-814-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0F87C6C1
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 01:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777791C212A0
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 00:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E4645;
	Fri, 15 Mar 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="gwNxWpjj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5292635
	for <linux-efi@vger.kernel.org>; Fri, 15 Mar 2024 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710462443; cv=none; b=WF+RcZtfTxIVNY8d8iehzGgib/VCtlh5hK3uUmq0AgDvcGiEAD/XkobyJsNkIF0nnjZSZVxGIDWxoqVC4BSK4Dbh2P4OTZpuEaoB9rNWFliU+oXHTl9d2FxVqvswGD4Fqx3TWfqzNUydSeTFTlEbJakJb8Mk3nNRvWvuGf5dNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710462443; c=relaxed/simple;
	bh=aidqTAx+wnuLDCTfi1mZhTfziykaLGZQkb9ju0W8KSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOJtXy5l6pNimCLJK177bfU86fS5/qQQmH1S55r/30eQDHHn9+5i5XTwpeeBTgoFQDUNAAQ89NFppJy8TV5ltd8wcZFavENBaKOSemgjm9U0fdeRY0/NiNcL2PVE/LVTSMc/KnO5kxEjzKI1tqZusuQfqt+OJiWSlIoFIL3sDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=gwNxWpjj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710462434; x=1711067234; i=timschumi@gmx.de;
	bh=AJBBRb31vOFvStCu9s6nsmj4jViotlBS2393A53kynw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=gwNxWpjjdn/0kNkoLTmI1bUlbErz6j3ahdZ6uwlh+s7Qpd8AzSTv4gWm0k5f/lrj
	 FhS4ku+mTZun8Nsf7wdsrH5hwAfcoNu0TIy3XvcAzfwr96NVLsX8JZc0q6K6m5bjm
	 bu2iaFg7EehtZm2Xnl1jc+XqnuzWHIoqKNGwB9G/QV9EaW7ES8KPXGF1IWEZ5LuoT
	 JVnrCP8Fodx299RIDKdkyJo4Zcb2RZhIeUJS3GaoMsCg9MVH1vEt3r2LDLhflGQwg
	 HFWP+YUAmfzdJKsbzPqJQ2SNncB9pyYhZsGsIuEFBezZ9sw9lfQW07gKo+/fnl2Y6
	 aLrmeZnKVUV5DEDtCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N4QwW-1qlqEe1TEM-011VJv; Fri, 15 Mar 2024 01:27:14 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/3] efivarfs: Remove unused internal struct members
Date: Fri, 15 Mar 2024 01:25:59 +0100
Message-ID: <20240315002616.422802-2-timschumi@gmx.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315002616.422802-1-timschumi@gmx.de>
References: <20240315002616.422802-1-timschumi@gmx.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F46oPuGkzV1NEIZxJP2XKIISH1MjQnaDkbN+w72MGh/gDVNMZqb
 RVoJmgMiqWRo9HXQbiKvDc6IqzVjl+tpj+tpgCtL5QHy9BQsbnA8nnkL/HRjGYBsqGebwM7
 6n9BRTEuK98mBNXVCcZBDkPBQVL1HS3mI4Lf5E5Fobl0e9xyAlwC9u3QJgs3X+hauzbjFGp
 WtlEXCJ5zFFvR9uGtQdww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HBtKMB95zh4=;nyUtbDWBzSR9zMxuh+9kAguMWNy
 FyLleh/8b5xjuTHo+vapc9oRvo7rxXucEIEo6KoOfuznJx9x8jXu5gxDMCBWeXzuVFhBaop0B
 OZwVrgHj8dt6yQkiCPTvebXBIeex6VFqju0L9JAnDwdgOHErmbx2ej/3U4u5dLdNmVqFVhMMG
 W3R3SG7wFv4gmyWxAldS9pLObo3diVAZLaprZI9jEUhuze2HW7p6IhfkB7guY96CyjPql+sTR
 M1g142DiUh+fILr75enifV5oiTspv3a0MyeVfk7yfpo+cgieF3qDYeHXn7uu3z6d5yxCBBXPS
 CeoJt06RjLIK95llwOchPr3pYtfVdmTjRc57cMtnRwPHfvUP9bJpB063G7ZYOcVW0CW1FaB0v
 F9q6otoEoxbLFXP/lW+LLSU7DnZNk/fQRToiIVOkjjZbMby+ekXUqUpBWRNACizQL2m8Oysdu
 e7bKK7/16V0YrAOL3YVFmewFW9Y47bXBH4dmy4tYwwQ6tVjsrwVlNCGiJF44xzNXUV0X9TkgA
 LCDNNmn4iGtLCzQHup10ulI3yDCbsQ+m1h9WzVekxaqHeLNwuiUK8Qi5uEa3kI4FhBMMEX41U
 VmiST+HSFWZ+ComsK4+Ahxyo9cnwMhdFZmkblFi70cwE8PskUx0BhDTNkrqGlHZ19R7gJFUT9
 8w3M2NtYyJfcn7R9KTrwkF+GiOBebvTQHTO2Ok+CTzX/+k69yAkctoYf3LdY0YtE0AmDgEqR9
 QUkpbU4Fi/vqFszW/lZjExOInaafYJeKY/NCQN6QM3l2Qw0aagEZ+Aj4W/1cS7rUdSh/Of5C2
 NDcgstCeq9tjevMn4cjZ+cmdvRhqxxXU9zx2PhOHQsWL4=

The structure was moved to the efivarfs internals in commit 2d82e6227ea1
("efi: vars: Move efivar caching layer into efivarfs") after previously
being used as the data ABI for efivars until its removal in commit
0f5b2c69a4cb ("efi: vars: Remove deprecated 'efivars' sysfs interface").

As efivarfs only uses the structure for the variable name caching layer,
the data-related members were never in use. Remove them to avoid
implying that efivarfs is bound by the same restrictions that efivars
once had.

Since we are changing the last copy of "struct efi_variable", document
the former layout in the ABI documentation of /sys/firmware/efi/vars
that is still left over.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
I'm unsure if this is how documentation of removed interfaces is/should
be handled, input on this would be greatly appreciated. Of course, the
alternative to what I did here is to remove the documentation
completely. If someone is running a kernel old enough to have this
interface, then the matching kernel source will still contain said
documentation.
=2D--
 Documentation/ABI/stable/sysfs-firmware-efi-vars | 12 ++++++++++--
 fs/efivarfs/internal.h                           |  3 ---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-firmware-efi-vars b/Documentat=
ion/ABI/stable/sysfs-firmware-efi-vars
index 46ccd233e359..461b9139cedb 100644
=2D-- a/Documentation/ABI/stable/sysfs-firmware-efi-vars
+++ b/Documentation/ABI/stable/sysfs-firmware-efi-vars
@@ -41,8 +41,16 @@ Description:
 		raw_var:	A binary file that can be read to obtain
 				a structure that contains everything
 				there is to know about the variable.
-				For structure definition see "struct
-				efi_variable" in the kernel sources.
+
+				The structure is defined as follows:
+				struct efi_variable {
+					efi_char16_t VariableName[512];
+					efi_guid_t VendorGuid;
+					unsigned long DataSize;
+					__u8 Data[1024];
+					efi_status_t Status;
+					__u32 Attributes;
+				} __attribute__((packed));

 				This file can also be written to in
 				order to update the value of a variable.
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index f7206158ee81..971560a01320 100644
=2D-- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -24,9 +24,6 @@ struct efivarfs_fs_info {
 struct efi_variable {
 	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
 	efi_guid_t    VendorGuid;
-	unsigned long DataSize;
-	__u8          Data[1024];
-	efi_status_t  Status;
 	__u32         Attributes;
 } __attribute__((packed));

=2D-
2.44.0


