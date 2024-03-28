Return-Path: <linux-efi+bounces-896-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9C890BFB
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 21:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A54B2269D
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5612F385;
	Thu, 28 Mar 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="iuys5Y7Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F713A27E
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659085; cv=none; b=bbp8bTdXJr4vPndd9S1Jm2lwvy08wJX75XLBQCwqQJHHABOqjpm5Ff4UD4oAFIYy1IUk0OFx9PEde+wL0ehmfpKit686L6epctc+5T3/bFa4cvavXKdem+dn4UGog3hfiqMt6bCuOeGHcB9o8iM2cWO/ftAWTuiaDbflz2Yqnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659085; c=relaxed/simple;
	bh=1S9JeLCHVSjVrLgAE1vonQqbGgqf78z5W9p1qhuQcaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkWhTeL3SS7M/bNzByqRFwGMbAt29twrgVLBqTyvp0Tt0N6n/9tk044Pk/p7TpYaLAExiifaeCWEQfaeXeahhVhMqu8PitUpadZLNjtFlP6wPIGVvXZSvDz7gzlpIVgUkI/HMWnURh5CavhUM7cZKAFKjH2anDghONXdjdSRqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=iuys5Y7Q; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711659074; x=1712263874; i=timschumi@gmx.de;
	bh=5+oNQ+p8GCTcBKXD9M5Ra/nvzQpHz9iGUYNbkgoiVX0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=iuys5Y7Q78F6bJO11+AgNc6ZoYiQoOZW/ccNpyX0ZiLwtfgx/opDHn8HjfjaMov2
	 MEPE8gQTe+jDT/nUE49TZF25IJAEN0mRh5oWcww+CX2JG2fVnyDRI7y8A5vQKdyZc
	 rAFXs4Q7Zj14zSJ5gDfiVcpyOZ/CwSGlWrujufKfr3mEYztIduc7DALEAPRSPrFhR
	 vGZkKNk7xQUB+DkiFENffrqu/OqQZ0PL2FvyXW1qahk6Ycmblrc3y/VMnfxwUGBYB
	 87sp285UzBFqdq8vx8/I9pvLlcoCHkksWCTzKvOsJ4rlaDdmtEM55ecZEEKYRUxVb
	 mBAkgkaX1Fb+CfgTUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MybKf-1slk0V0bkb-00yyNG; Thu, 28 Mar 2024 21:51:14 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH v2 2/4] Documentation: Mark the 'efivars' sysfs interface as removed
Date: Thu, 28 Mar 2024 21:50:31 +0100
Message-ID: <20240328205041.76812-2-timschumi@gmx.de>
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
X-Provags-ID: V03:K1:As64rDX3CpnNkHIx1BhVzW2Rm291+CFPd6FNoYGNp5qOg2n6OUy
 zOmEWvCI1Whet2q+spMeESPd6PX7Bsobud1x1vjyztwpolWWb4UrgsBdrS2/VaUEBXpMEaq
 Qzk5aDfYxypv0F1GXg7OZxFBb5tQ66Xn6lQW8LRh5NeFpAVRXc8vW5vmDA7KGi30v2AtAyf
 vLviVyBhVERuIgrkEptzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CpoGR+z7kno=;M9G9H5TKlWaofYrZ7OeGQw0ki5e
 zr7WRJW3qhjHBUQ8LzEg4JYPliJpok1Iszc/qxa8OHb+y1d0vFder1gMX9KO+8pO45CxeGesQ
 F3fVaUy4RiXvHg9aPRurCIaf+ufs0LUgE3k73QlEMrIhjL4Y/tPwbTBpUdo0QQO1wLlg2CkJl
 ZxD2n7oviaz/KRl6BJRhpFyTS7jCEeecKMLtQ+ksz9dBxUB3fIE2ifSFKxxE5qD/1Gi73yHoM
 96rQg7xJY/TjrKluXaLWXzFKZmw/kXJrMkMxPT+io2z6/Pc5fT4CX5JEQuahMzSak/lD6ZpM6
 p74zUKLOG9Nc069eibh6ICj0oeNNCQ8Je64J6+qhs9bg5WkZ9EhG2zpUaE++02oPz3G6ByvbP
 1cy7yTtO8YuePhioKXCvUT8qH3ifLFtSHi8WH7agb8HvAAIdUeD73L+EvvrahnT/zRi+qYdPS
 wNf+pBw3haLyCezdsJiJoDKQTRRwLEF4ygHe4+wISJAbLgi51F6UA17wd3IWf5bvgu0PjVmYJ
 5h6nR4yN5CMPCM7tTxWZi47ooLGBXEHA4doxLMrX0bhUbfHgxzuBy6pnZT9FGyda2MU6LIztI
 3nAS7NinOsW1H+RUBOMVCAjCRumJwJUmN5HJN1AThag4aEM2L1xKYIqFQHCIZFTzg+YfpdVLY
 PAgtSJDXGuMd5svJgvV/vDBgPBtzZkCaH34qhi5Cio/8i7B60j7NS0mIEzgFNz+d5elnoHe/j
 8ete81dGtvOO0Jrf6kJ/R6Kk/ZrGYzeiDOfyKFMM63APLRymzLcYSSLI1FXnL4fN1XvK4QS3b
 zDBPxdA2xWghkHiM8kihJjFCN7fclv1i9Jui4wDrXrZ28=

The 'efivars' sysfs interface was removed in commit 0f5b2c69a4cb ("efi:
vars: Remove deprecated 'efivars' sysfs interface"), but the ABI
documentation was not updated properly.

Strip down the documentation file for /sys/firmware/efi/vars to a very
basic description of what the interface was about, add a section about
the rough removal timeline, and inform the reader about the intended
replacement.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
Changes from v1 (semi-non-existing):
 - Removed large parts of the now unneeded description, as well as the
   contact.
 - Added a short documentation about the deprecation, removal, and
   replacement.
 - Split out into separate patch as per request, part of a patch chain.
=2D--
 .../ABI/removed/sysfs-firmware-efi-vars       | 12 +++
 .../ABI/stable/sysfs-firmware-efi-vars        | 79 -------------------
 2 files changed, 12 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-firmware-efi-vars
 delete mode 100644 Documentation/ABI/stable/sysfs-firmware-efi-vars

diff --git a/Documentation/ABI/removed/sysfs-firmware-efi-vars b/Documenta=
tion/ABI/removed/sysfs-firmware-efi-vars
new file mode 100644
index 0000000000000..8d97368b149bb
=2D-- /dev/null
+++ b/Documentation/ABI/removed/sysfs-firmware-efi-vars
@@ -0,0 +1,12 @@
+What:		/sys/firmware/efi/vars
+Date:		April 2004, removed March 2023
+Description:
+		This directory exposed interfaces for interacting with
+		EFI variables.  For more information on EFI variables,
+		see 'Variable Services' in the UEFI specification
+		(section 7.2 in specification version 2.3 Errata D).
+
+		The 'efivars' sysfs interface was removed in March of 2023,
+		after being considered deprecated no later than September
+		of 2020. Its functionality has been replaced by the
+		'efivarfs' filesystem.
diff --git a/Documentation/ABI/stable/sysfs-firmware-efi-vars b/Documentat=
ion/ABI/stable/sysfs-firmware-efi-vars
deleted file mode 100644
index 46ccd233e3594..0000000000000
=2D-- a/Documentation/ABI/stable/sysfs-firmware-efi-vars
+++ /dev/null
@@ -1,79 +0,0 @@
-What:		/sys/firmware/efi/vars
-Date:		April 2004
-Contact:	Matt Domsch <Matt_Domsch@dell.com>
-Description:
-		This directory exposes interfaces for interactive with
-		EFI variables.  For more information on EFI variables,
-		see 'Variable Services' in the UEFI specification
-		(section 7.2 in specification version 2.3 Errata D).
-
-		In summary, EFI variables are named, and are classified
-		into separate namespaces through the use of a vendor
-		GUID.  They also have an arbitrary binary value
-		associated with them.
-
-		The efivars module enumerates these variables and
-		creates a separate directory for each one found.  Each
-		directory has a name of the form "<key>-<vendor guid>"
-		and contains the following files:
-
-		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-		attributes:	A read-only text file enumerating the
-				EFI variable flags.  Potential values
-				include:
-
-				EFI_VARIABLE_NON_VOLATILE
-				EFI_VARIABLE_BOOTSERVICE_ACCESS
-				EFI_VARIABLE_RUNTIME_ACCESS
-				EFI_VARIABLE_HARDWARE_ERROR_RECORD
-				EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS
-
-				See the EFI documentation for an
-				explanation of each of these variables.
-
-		data:		A read-only binary file that can be read
-				to attain the value of the EFI variable
-
-		guid:		The vendor GUID of the variable.  This
-				should always match the GUID in the
-				variable's name.
-
-		raw_var:	A binary file that can be read to obtain
-				a structure that contains everything
-				there is to know about the variable.
-				For structure definition see "struct
-				efi_variable" in the kernel sources.
-
-				This file can also be written to in
-				order to update the value of a variable.
-				For this to work however, all fields of
-				the "struct efi_variable" passed must
-				match byte for byte with the structure
-				read out of the file, save for the value
-				portion.
-
-				**Note** the efi_variable structure
-				read/written with this file contains a
-				'long' type that may change widths
-				depending on your underlying
-				architecture.
-
-		size:		As ASCII representation of the size of
-				the variable's value.
-		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-
-
-		In addition, two other magic binary files are provided
-		in the top-level directory and are used for adding and
-		removing variables:
-
-		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-		new_var:	Takes a "struct efi_variable" and
-				instructs the EFI firmware to create a
-				new variable.
-
-		del_var:	Takes a "struct efi_variable" and
-				instructs the EFI firmware to remove any
-				variable that has a matching vendor GUID
-				and variable key name.
-		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=2D-
2.44.0


