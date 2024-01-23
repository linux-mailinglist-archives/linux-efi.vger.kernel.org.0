Return-Path: <linux-efi+bounces-426-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37F839A43
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 21:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B98B249E1
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379AB85C49;
	Tue, 23 Jan 2024 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="YSrKdN7a"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2560EE4;
	Tue, 23 Jan 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041678; cv=none; b=izdrsJRGgmMAw2pVa6GKulbycn1joZs5QLvgAPW3jnKYiuMuHhVlAmcysC5jKdsahhB27OVBGoBLpIuzG1Jy+CbaIOL6apLxASBXVczebBViKTUelF0dKA6O0oKOscz7oNs8szgaVrwnPvuS/+VcumJOVBYnl6E59zu7oWL+C30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041678; c=relaxed/simple;
	bh=H+32GRyeXkbWixqY9lEpJBznl/T64ahj0bpybN1cC/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHx6ELRiVN95DCzlr5RbMZw9blR0YBrNPJyKKM+QDnb1YvA7XtbSCtH/UCPuRVLRIlfjFpvZOA8nFGYBuA83iqKWeBVC+I+rmgRLrfVwUFhD1wA42hJam1G4Fv2pj7J++JLw1A1IShNA8Ggg3CKHvgIjN2WjjPVnpM//AMK0rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=YSrKdN7a; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706041664; x=1706646464; i=timschumi@gmx.de;
	bh=H+32GRyeXkbWixqY9lEpJBznl/T64ahj0bpybN1cC/4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=YSrKdN7avc+omAz9kjRhMhWzsJ+sOHR/P5ORiwAJt8PASLhIIe+ibup7OMREQGYb
	 LwOiWExhTMlhrfq5Jzl8XWJ4RHejyTNxINEiKbFcQDEhh0H7XGsC1tneiAE/CCMiH
	 Ad9FrWX+W8FFkdTH812+tHczCqUTJjCZdyxtHSmGqIVDlmjuzcVWk8byHY2YzPB0d
	 uSLQf0X4MYnlFI9O1LZw5QZk7teCZbUkWRasOF1+vtiB129/K3apghIHpUq+AwLJC
	 3aDTHjZsAYJNj678gC/8Yxc1TgToH6Of0PQ1X/lFogTyRFIqgIUjcXbh6oEMTSX/d
	 La+0low8iXfiQV8TvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.111.23]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Ma24s-1rXvoC2bnI-00W0bH; Tue, 23 Jan 2024 21:27:44 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	jk@ozlabs.org,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	pjones@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] efivarfs: Halve name buffer size until first successful response
Date: Tue, 23 Jan 2024 21:27:42 +0100
Message-ID: <20240123202743.1591165-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122231507.1307793-1-timschumi@gmx.de>
References: <20240122231507.1307793-1-timschumi@gmx.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Hi/IraluAOe7Qy2ruZdvjWUacVBnhWtPvh1YymH5Q/wGioza2+
 g4VcmaAc4R+wlTyxqa+fURWlt4V4D6tZB0j180JT/8GoeURxSjRpE7Bm+Sf3DHdb0OwfzRY
 52OHYob32OCjDqK18bzeMA6dXbIx2Mdh3/bcjtbYipZPdrNCuk3u4RcXlI1p/qiqa9Mh32n
 q2OyFrhRjdPRuYiaptk+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MeZWnvjB9cE=;LkzmXX391XTfK33Gk4idSUKHxVf
 YkC8t28inzrwgEHtEdu3bLweJ5EQap+bDS9S/HddfrVojOgkbNgQeUYEF2H1tmZbJecGStu66
 Crazjqj7mUhr9FeEdtF1OaEvGUCG+YTpWRZAvseGWAhrIxOxY12QW6O/Lj524cbvwZ/EO1pVU
 lV7B/+789htMi/pl5TOQyi9HOv4aACkejEQ3SyfSWrxwU+iXmpJ/Zn9Kk7nbNHo3e+GBJAxPa
 W3uNHXuTlf0Qp+GP7YAdtsUpUs3endM/5ew8q1IZ1LJZ4nCQz43+hwRU97spuHCNAWFbgY+mj
 ELjBqo20/mX8bahhdcdp0aahR5rvieAKW8n4kEz4fs6/+QY01xftWHASVNxyNE9azTOzqGsrw
 6lqFfGtOvdGhUOQ0pzDIYkfGZXPF7U+/P87zDC74iI45wzeWtpqT1n7+5mMDK+D6N/osFhE9M
 mq6CT8L/gX3ugArRXGzdAIcT9VTZZ8NYHgZo+VkvL3i8SeQpdFGAuQnNAXZsM5UE6v+llCoOW
 rfj2W8ZpZxOaBdAdP9lvDRPjR7HbH7zpn7p28khvcsXqFKLIs2ThKQb8WYivNJHWOqX+ZbVGE
 tPDRxL8FZemtM0CZijICp7wvCPajsdVRJ66zUG9/aIfQda/z/ndlkhy6DLTaPptZ3EjkLuM6V
 l0qjDtobvSot4pM+pDGqgK8cc0xTc2k7lfQkUglDsm2TDdTgnUis1K3ReS/EDdVB2ikwbXnOI
 NYfPIfNmkfH+fJmq9VmLgfhWfQuuV+YLZLfNi5fTJLnQj1faLOTkzt0QhysWofNzqjxGcm8Vb
 vAroNt/B4KI8Pnrjg7xiwN2WGlwua+wfBn4uAvVVpHO/hQhPQPlHpTLH99+eoL1qOpYrB+Uj1
 nYBCcs8zshOnRZxMLY61PgvKP2foO0g7mlpWGLdutXPzqOKBgrOgkkmGxiGyv/RDVWc40egwe
 VdPSlA==

This sidesteps a quirk in a few old (2011-ish) UEFI implementations,
where a call to `GetNextVariableName` with a buffer size larger than 512
bytes will always return `EFI_INVALID_PARAMETER`.

Additionally, remove a related but outdated comment that claims the
maximum variable name size to be 1024. The default buffer size of 1024
is kept to ensure that existing setups keep working.

Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Tim Schumacher <timschumi@gmx.de>
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
=2D--
 fs/efivarfs/vars.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 9e4f47808bd5..26a10ed4a116 100644
=2D-- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -372,13 +372,14 @@ static void dup_variable_bug(efi_char16_t *str16, ef=
i_guid_t *vendor_guid,
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, vo=
id *),
 		void *data, bool duplicates, struct list_head *head)
 {
-	unsigned long variable_name_size =3D 1024;
+	unsigned long maximum_variable_name_size =3D 1024;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
 	int err =3D 0;
+	bool successful_once =3D false;

-	variable_name =3D kzalloc(variable_name_size, GFP_KERNEL);
+	variable_name =3D kzalloc(maximum_variable_name_size, GFP_KERNEL);
 	if (!variable_name) {
 		printk(KERN_ERR "efivars: Memory allocation failed.\n");
 		return -ENOMEM;
@@ -388,19 +389,16 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid=
_t, unsigned long, void *),
 	if (err)
 		goto free;

-	/*
-	 * Per EFI spec, the maximum storage allocated for both
-	 * the variable name and variable data is 1024 bytes.
-	 */
-
 	do {
-		variable_name_size =3D 1024;
+		unsigned long variable_name_size =3D maximum_variable_name_size;

 		status =3D efivar_get_next_variable(&variable_name_size,
 						  variable_name,
 						  &vendor_guid);
 		switch (status) {
 		case EFI_SUCCESS:
+			successful_once =3D true;
+
 			variable_name_size =3D var_name_strnsize(variable_name,
 							       variable_name_size);

@@ -431,6 +429,23 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_=
t, unsigned long, void *),
 			break;
 		case EFI_NOT_FOUND:
 			break;
+		case EFI_BUFFER_TOO_SMALL:
+			printk(KERN_WARNING "efivars: Assumed maximum name size to be 0x%lx, g=
ot name of size 0x%lx\n",
+			       maximum_variable_name_size, variable_name_size);
+			status =3D EFI_NOT_FOUND;
+			break;
+		case EFI_INVALID_PARAMETER:
+			if (!successful_once && maximum_variable_name_size > 1) {
+				/*
+				 * A small set of old UEFI implementations reject sizes
+				 * above a certain threshold. Halve the advertised size
+				 * until we get the first successful response.
+				 */
+				maximum_variable_name_size /=3D 2;
+				break;
+			}
+
+			fallthrough;
 		default:
 			printk(KERN_WARNING "efivars: get_next_variable: status=3D%lx\n",
 				status);
=2D-
2.43.0


