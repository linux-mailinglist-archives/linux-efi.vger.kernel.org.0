Return-Path: <linux-efi+bounces-433-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8383DEA3
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 17:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FBC1C21066
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A391D6A5;
	Fri, 26 Jan 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="NcZxPcD9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2371E87E;
	Fri, 26 Jan 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286342; cv=none; b=LTRMlcMZK/4PCsUZug+D/lLmFcfqL0t+GLrEb+L621oedWJR1bN7EJfDfzXtLfWD4X7x2IZnl+HlmU1RuWiCUW17Y39pnuUfmLrHSbu0/iAaBXXlrSDLW2Idgstz/W7/AMYs5OrmFr35j0P1u82hBizsLgrvEWcUuwksLM+8o/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286342; c=relaxed/simple;
	bh=6z0ByeYL+pkh95bC+3RgBUcMtnqLYolkJqdVY7JSZco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4hEwgwYfcmicWue9ZDNJlB6qU/pjbCqB7+YjFPFQFu68s6nkSrm/0xuLhEH+p6l64xLdtZKARBWeo8BDO3CnYxxfXAuTTORpTrG/KOU2+eKU2XTieptnw4M3+rgrPzrjAlW897aFpBvqZaNbJ/MWVRw21gcF7ouxQRi9OQabPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=NcZxPcD9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706286328; x=1706891128; i=timschumi@gmx.de;
	bh=6z0ByeYL+pkh95bC+3RgBUcMtnqLYolkJqdVY7JSZco=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=NcZxPcD9lq45zJ7UxyHXRUGo3lEWgZuTCtILpfysjpanLsW8jCNfcN92N8Z9EkM4
	 UsiIBqmLZ48gCx7AoOekCLm7HEi324GNc56qdQbnFLOPgPCjMzzU9l5Dg9TrcrZ5D
	 xm/5FOitxD0XibtQpSeIzGZbTcS0R16q47kaHvtcBq0bh2ErLLTOBw0wXWxWUt0RP
	 tquFo2bz5sWVKLRhE2lOIi5PDoxZeeodQYKKhb32QDBiB6klpHa3FZHfT+OeBMMzQ
	 Q87dMo1biDPcTPq9aS2QcFRCs1u1a5qKS5OGdJZQMTiojg7GfC2Wavl6jSf+RZ8Ui
	 B0AGAiiSeo0umJCnGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.111.23]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mv31c-1rBb3H3LdI-00r3ow; Fri, 26 Jan 2024 17:25:27 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	jk@ozlabs.org,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	pjones@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] efivarfs: Request at most 512 bytes for variable names
Date: Fri, 26 Jan 2024 17:25:23 +0100
Message-ID: <20240126162524.52051-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123202743.1591165-1-timschumi@gmx.de>
References: <20240123202743.1591165-1-timschumi@gmx.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+aDdGtIfgG90q+Bt2+L0eHwS9QyS6tkSZK4Yxy7mc21bnBmtWSM
 wcCJzAzhxzpqY+C7vM7wlX+nIoeX51bx9k8VBagLN9xKUpRgPXL7mAmkEkepML9U4Xa+p1S
 lPDoNMziSXxccQ1RaG376qWx0n0KVGC37FqKPoV+hCk6Ytf02Dn00y6iy4AS5Ij0ugrlH1x
 Oxg52Ch4j+2wu+h4TkJ7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:exu9ofekbfU=;NkVT69E2thuvsZqDmqQowaaz6co
 fZIJYQgv36qfAakhvYI10R8Gd6L/uw4eMvp3mWfupiq3eZDdg9myJ4efttIRAAF9Vg8eat808
 2ptObyHqFQzP2GsYYNK71kGL+ppg5EeaY8VxRTtjEOpQdG1ADWmQPrExdWrn6wqaTA/1BNbdw
 dGL5miY3GLZp0ankMP6Af8no0IEUEDiNK0NxfD156GoOOnH6BUrRvi3UmZJL+KXcJCdGeLHtN
 G3hZRXnCvdid1jUUbdLupagJTHkWtSOyb4ynQ4hq2X0lshUjV5VHRZv1XeLzvS0gec2O27ZP4
 u1hG5JqLVGQ9ZZDr7Ojuq5pldDZ8i/yTG1FiFMqxDC5/vqPWEnRmCXwYaebR+7Uuy0wbj/OJb
 RhWSAA+qJtHog26hICgmZLxVX1G3Ws/Z+0+qWue/6SjUYGFfW0nF6S/MFdKonP9EI+S72fJkk
 VS6lQXV/QJBRYDBqn/CT91aHbkVdFlidPH7/x1xShq6sQ0SrtwEw3QyOLeLp66xDesvFtCHLs
 QRlWm4z57mEPDLt/ukf/oILC+lSVndhvIQLgh68WYutaAe+H7Gf584bX9SfnfBVFIfh7+X3ON
 6UT4xg3SmVg8ChO/1SY1fyt9LACN8aN0wT90GSH07u4FgacM1R1NXEaiRaehrxyemp2sBTwyR
 pRrxa882owIbq12iJykwD9UbcJL2Swr5/PyLpmDzv58cQYI/APiNDIMoI+Ecj4UJlV1jFfi3O
 3kBfhadWL/sY/WuJfyMec4Zoj1qgpfpHrSv+TCyO1OAdt4Z6D9B2uxkcAg38MaahZCtzyO3OF
 3pENs4iDt8RqmbfeNJG92heOUVmKnapxQXK26/SH5kFT1UHAQ8GEMBw6frSJfVVlE+wzpn8Tk
 97sED7aBcuTdeRTc/v6C3uFp0ePKao6WuNSBV3B6vDiYjvR9vdrFgnxsZ+HBsKtg/pnw1Q3Bl
 bsONC42BlNNJps2f6RyLXL1h9TQ=

This sidesteps a quirk in a few old (2011-ish) UEFI implementations,
where a call to `GetNextVariableName` with a buffer size larger than 512
bytes will always return `EFI_INVALID_PARAMETER`.

Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
Made a patch with just the size change (and a comment / error message
for good measure) as requested. I just hope that I don't have to come
back in a month to find out that there is a machine that only accepts up
to (e.g.) 256 bytes.

One thing that I just recently noticed is that properly processing
variables above 512 bytes in size is currently meaningless anyways,
since the VFS layer only allows file name sizes of up to 255 bytes,
and 512 bytes of UCS2 will end up being at least 256 bytes of
UTF-8.

If path creation errors are decoupled from the iteration process then
one could at least skip those entries, but the efivarfs implementation
seems to be in no shape to handle that currently.
=2D--
Changes since v1 ("efivarfs: Iterate variables with increasing name buffer=
 sizes"):

- Redid the logic to start with the current limit of 1024 and continuously
  halve it until we get a successful result.
- Added a warning line in case we find anything that is bigger than the li=
mit.
- Removed an outdated (or never accurate?) comment about a specification-i=
mposed
  length limit.

Changes since v2 ("efivarfs: Halve name buffer size until first successful=
 response"):

- Removed all the complicated logic, only keeping the new limit, the
  comment change, and the error message in case a big variable is found.
=2D--
 fs/efivarfs/vars.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 9e4f47808bd5..3f6385f2a4e5 100644
=2D-- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -372,7 +372,7 @@ static void dup_variable_bug(efi_char16_t *str16, efi_=
guid_t *vendor_guid,
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, vo=
id *),
 		void *data, bool duplicates, struct list_head *head)
 {
-	unsigned long variable_name_size =3D 1024;
+	unsigned long variable_name_size =3D 512;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
@@ -389,12 +389,13 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid=
_t, unsigned long, void *),
 		goto free;

 	/*
-	 * Per EFI spec, the maximum storage allocated for both
-	 * the variable name and variable data is 1024 bytes.
+	 * A small set of old UEFI implementations reject sizes
+	 * above a certain threshold, the lowest seen in the wild
+	 * is 512.
 	 */

 	do {
-		variable_name_size =3D 1024;
+		variable_name_size =3D 512;

 		status =3D efivar_get_next_variable(&variable_name_size,
 						  variable_name,
@@ -431,6 +432,11 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_=
t, unsigned long, void *),
 			break;
 		case EFI_NOT_FOUND:
 			break;
+		case EFI_BUFFER_TOO_SMALL:
+			printk(KERN_WARNING "efivars: Assumed maximum name size to be 512, got=
 name of size %lu\n",
+			       variable_name_size);
+			status =3D EFI_NOT_FOUND;
+			break;
 		default:
 			printk(KERN_WARNING "efivars: get_next_variable: status=3D%lx\n",
 				status);
=2D-
2.43.0


